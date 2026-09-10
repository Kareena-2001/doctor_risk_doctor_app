import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_submission_list_view_response.freezed.dart';

part 'my_submission_list_view_response.g.dart';

@freezed
class MySubmissionListViewResponse with _$MySubmissionListViewResponse {
  const factory MySubmissionListViewResponse({
    required bool status,
    required int code,
    required String msg,
    required List<BlogData> data,
  }) = _MySubmissionListViewResponse;

  factory MySubmissionListViewResponse.fromJson(Map<String, dynamic> json) =>
      _$MySubmissionListViewResponseFromJson(json);
}

@freezed
class BlogData with _$BlogData {
  const factory BlogData({
    required int id,
    required String title,
    required String description,
    required String image,
    @JsonKey(name: 'i_agree_accepted') required String iAgreeAccepted,
    required List<String> keywords,
  }) = _BlogData;

  factory BlogData.fromJson(Map<String, dynamic> json) =>
      _$BlogDataFromJson(json);
}
