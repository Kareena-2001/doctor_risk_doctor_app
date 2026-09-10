// viewmodel/blog_view_model.dart — single view model, all screens use this
import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../model/blog_list_detail.dart';
import '../../repository/blog_repository.dart';
import '../state/blog_state.dart';

part 'blog_view_model.g.dart';

@riverpod
class BlogViewModel extends _$BlogViewModel {
  @override
  BlogState build() => const BlogState();

  Future<void> fetchBlogList() async {
    state = state.copyWith(blogList: const AsyncLoading());
    final result = await AsyncValue.guard(
      () => ref.read(blogRepositoryProvider).blogsList(),
    );
    state = state.copyWith(blogList: result);
  }

  Future<void> refreshBlogList() => fetchBlogList();

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
