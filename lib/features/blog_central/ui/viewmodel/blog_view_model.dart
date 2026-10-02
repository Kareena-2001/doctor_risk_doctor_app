import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../model/blog_list_detail.dart';
import '../../model/my_submission_list_view_response.dart';
import '../../repository/blog_repository.dart';
import '../state/blog_state.dart';

part 'blog_view_model.g.dart';

@riverpod
class BlogViewModel extends _$BlogViewModel {
  Timer? _debounceTimer;
  int _blogPage = 1;
  int _blogLastPage = 1;
  int _submissionPage = 1;
  int _submissionLastPage = 1;
  bool _loadingMoreBlogs = false;
  bool _loadingMoreSubmissions = false;
  String? _blogQuery;
  String? _blogCategory;
  String? _blogSortBy;
  int _blogRequestId = 0;
  int _submissionRequestId = 0;

  bool get hasMoreBlogs => _blogPage < _blogLastPage;
  bool get hasMoreSubmissions => _submissionPage < _submissionLastPage;

  @override
  BlogState build() {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    return const BlogState();
  }

  Future<void> fetchBlogList({
    String? query,
    String? category,
    String? sortBy,
  }) async {
    final requestId = ++_blogRequestId;
    _blogQuery = query;
    _blogCategory = (category == 'All Topics' || category == null)
        ? null
        : category;
    _blogSortBy = switch (sortBy) {
      'Newest first' => 'newest',
      'Oldest first' => 'oldest',
      'Most Read' => 'most_read',
      _ => null,
    };
    _blogPage = 1;
    _blogLastPage = 1;
    _loadingMoreBlogs = false;
    state = state.copyWith(blogList: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref
          .read(blogRepositoryProvider)
          .blogsList(
            keywords: _blogQuery,
            category: _blogCategory,
            sortBy: _blogSortBy,
            page: '1',
          ),
    );
    if (requestId != _blogRequestId) return;
    final response = result.valueOrNull;
    if (response != null) {
      _blogPage = response.currentPage;
      _blogLastPage = response.lastPage;
    }
    state = state.copyWith(blogList: result);
  }

  Future<void> loadMoreBlogs() async {
    final current = state.blogList.valueOrNull;
    if (current == null || !hasMoreBlogs || _loadingMoreBlogs) return;

    _loadingMoreBlogs = true;
    final requestId = _blogRequestId;
    try {
      final next = await ref
          .read(blogRepositoryProvider)
          .blogsList(
            keywords: _blogQuery,
            category: _blogCategory,
            sortBy: _blogSortBy,
            page: (_blogPage + 1).toString(),
          );
      if (requestId != _blogRequestId) return;
      _blogPage = next.currentPage;
      _blogLastPage = next.lastPage;
      state = state.copyWith(
        blogList: AsyncData(next.copyWith(data: [...current.data, ...next.data])),
      );
    } finally {
      if (requestId == _blogRequestId) _loadingMoreBlogs = false;
    }
  }

  void onSearchChanged(String query, {String? category, String? sortBy}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      fetchBlogList(query: query, category: category, sortBy: sortBy);
    });
  }

  Future<void> refreshBlogList({
    String? query,
    String? category,
    String? sortBy,
  }) => fetchBlogList(query: query, category: category, sortBy: sortBy);

  Future<void> fetchMySubmissions() async {
    final requestId = ++_submissionRequestId;
    _submissionPage = 1;
    _submissionLastPage = 1;
    _loadingMoreSubmissions = false;
    state = state.copyWith(mySubmissions: const AsyncLoading());
    final result = await AsyncValue.guard(
      () => ref.read(blogRepositoryProvider).mySubmissionList(page: 1),
    );
    if (requestId != _submissionRequestId) return;
    final response = result.valueOrNull;
    if (response != null) {
      _submissionPage = response.currentPage;
      _submissionLastPage = response.lastPage;
    }
    state = state.copyWith(mySubmissions: result);
  }

  Future<void> loadMoreSubmissions() async {
    final current = state.mySubmissions.valueOrNull;
    if (current == null || !hasMoreSubmissions || _loadingMoreSubmissions) {
      return;
    }

    _loadingMoreSubmissions = true;
    final requestId = _submissionRequestId;
    try {
      final next = await ref
          .read(blogRepositoryProvider)
          .mySubmissionList(page: _submissionPage + 1);
      if (requestId != _submissionRequestId) return;
      _submissionPage = next.currentPage;
      _submissionLastPage = next.lastPage;
      state = state.copyWith(
        mySubmissions: AsyncData(
          next.copyWith(data: [...current.data, ...next.data]),
        ),
      );
    } finally {
      if (requestId == _submissionRequestId) {
        _loadingMoreSubmissions = false;
      }
    }
  }

  Future<MySubmissionListViewResponse?> fetchMySubmissionDetails(
    String id,
  ) async {
    try {
      return await ref.read(blogRepositoryProvider).mySubmissionView(id: id);
    } catch (e, stackTrace) {
      debugPrint('fetchMySubmissionDetails error: $e');
      debugPrintStack(stackTrace: stackTrace);
      return null;
    }
  }

  Future<void> refreshMySubmissions() => fetchMySubmissions();

  Future<void> fetchBlogDetails(String id) async {
    final updatedMap = Map<String, AsyncValue<BlogListDetail>>.from(
      state.blogDetails,
    )..[id] = const AsyncLoading();
    state = state.copyWith(blogDetails: updatedMap);

    final result = await AsyncValue.guard(
      () => ref.read(blogRepositoryProvider).blogListDetails(id: id),
    );

    final finalMap = Map<String, AsyncValue<BlogListDetail>>.from(
      state.blogDetails,
    )..[id] = result;
    state = state.copyWith(blogDetails: finalMap);
  }

  Future<bool> submitBlog({
    int? id,
    required String title,
    required String content,
    required String iAgreeAccepted,
    required List<String> keywords,
    required String approveStatus,
    File? coverImage,
  }) async {
    state = state.copyWith(submitStatus: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref
          .read(blogRepositoryProvider)
          .submitBlog(
            id: id,
            title: title,
            description: content,
            iAgreeAccepted: iAgreeAccepted,
            keywords: keywords,
            approveStatus: approveStatus,
            coverImage: coverImage,
          ),
    );

    final submitStatus = result.hasError
        ? AsyncValue<void>.error(result.error!, result.stackTrace!)
        : const AsyncValue<void>.data(null);

    state = state.copyWith(submitStatus: submitStatus);

    return !result.hasError;
  }

  Future<void> blogDelete(int id) async {
    await ref.read(blogRepositoryProvider).blogDelete(id.toString());
  }
}
