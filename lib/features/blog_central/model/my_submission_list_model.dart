import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_submission_list_model.freezed.dart';

part 'my_submission_list_model.g.dart';

@freezed
class MySubmissionListModel with _$MySubmissionListModel {
  const factory MySubmissionListModel({
    required bool status,
    required int code,
    required String msg,
    required List<SubmissionModel> data,
    required int total,

    @JsonKey(name: 'current_page') required int currentPage,

    @JsonKey(name: 'last_page') required int lastPage,

    @JsonKey(name: 'per_page') required int perPage,
  }) = _MySubmissionListModel;

  factory MySubmissionListModel.fromJson(Map<String, dynamic> json) =>
      _$MySubmissionListModelFromJson(json);
}

@freezed
class SubmissionModel with _$SubmissionModel {
  const factory SubmissionModel({
    required int id,
    required String title,

    String? image,

    required String description,

    @JsonKey(name: 'approve_status') String? approveStatus,

    @JsonKey(name: 'view_count') required String viewCount,

    @JsonKey(name: 'i_agree_accepted') required String iAgreeAccepted,

    @JsonKey(name: 'created_on') required String createdOn,

    @JsonKey(name: 'updated_on') required String updatedOn,

    @Default(<KeywordModel>[]) List<KeywordModel> keywords,
  }) = _SubmissionModel;

  factory SubmissionModel.fromJson(Map<String, dynamic> json) =>
      _$SubmissionModelFromJson(json);
}

@freezed
class KeywordModel with _$KeywordModel {
  const factory KeywordModel({
    @JsonKey(name: 'blog_id') required int blogId,

    required String keyword,
  }) = _KeywordModel;

  factory KeywordModel.fromJson(Map<String, dynamic> json) =>
      _$KeywordModelFromJson(json);
}
