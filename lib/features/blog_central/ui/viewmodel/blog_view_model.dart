import 'dart:async';
import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../model/blog_list_detail.dart';
import '../../repository/blog_repository.dart';
import '../state/blog_state.dart';

part 'blog_view_model.g.dart';

@riverpod
class BlogViewModel extends _$BlogViewModel {
  Timer? _debounceTimer;

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
    state = state.copyWith(blogList: const AsyncLoading());

    // Map drop-down values to API sort parameters
    String? mappedSortBy;
    if (sortBy == 'Newest first') {
      mappedSortBy = 'newest';
    } else if (sortBy == 'Oldest first') {
      mappedSortBy = 'oldest';
    } else if (sortBy == 'Most Read') {
      mappedSortBy = 'most_read';
    }

    final result = await AsyncValue.guard(
      () => ref
          .read(blogRepositoryProvider)
          .blogsList(
            keywords: query,
            category: (category == 'All Topics' || category == null)
                ? null
                : category,
            sortBy: mappedSortBy,
          ),
    );
    state = state.copyWith(blogList: result);
  }

  /// Debounced search implementation to prevent spamming API requests on typing
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
    state = state.copyWith(mySubmissions: const AsyncLoading());
    final result = await AsyncValue.guard(
      () => ref.read(blogRepositoryProvider).mySubmissionList(),
    );
    state = state.copyWith(mySubmissions: result);
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
    required String title,
    required String content,
    File? coverImage,
  }) async {
    state = state.copyWith(submitStatus: const AsyncLoading());
    final result = await AsyncValue.guard(
      () => ref
          .read(blogRepositoryProvider)
          .submitBlog(title: title, content: content, coverImage: coverImage),
    );
    final asyncVoid = result.hasError
        ? AsyncValue<void>.error(result.error!, result.stackTrace!)
        : const AsyncValue<void>.data(null);
    state = state.copyWith(submitStatus: asyncVoid);
    return !result.hasError;
  }
}
