import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../model/blog_list_response.dart';
import '../../model/blog_list_detail.dart';
import '../../model/my_submission_list_model.dart';

part 'blog_state.freezed.dart';

@freezed
class BlogState with _$BlogState {
  const factory BlogState({
    @Default(AsyncValue.data(null)) AsyncValue<void> submitStatus,

    @Default(AsyncValue.data(null))
    AsyncValue<MySubmissionListModel?> mySubmissions,

    @Default(AsyncValue.data(null)) AsyncValue<BlogListResponse?> blogList,

    @Default({}) Map<String, AsyncValue<BlogListDetail>> blogDetails,
  }) = _BlogState;
}
