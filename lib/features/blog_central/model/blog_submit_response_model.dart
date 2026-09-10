import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_submit_response_model.freezed.dart';
part 'blog_submit_response_model.g.dart';

@freezed
class BlogSubmitResponse with _$BlogSubmitResponse {
  const factory BlogSubmitResponse({
    required bool status,
    required int code,
    required String msg,
    required BlogSubmitData data,
  }) = _BlogSubmitResponse;

  factory BlogSubmitResponse.fromJson(Map<String, dynamic> json) =>
      _$BlogSubmitResponseFromJson(json);
}

@freezed
class BlogSubmitData with _$BlogSubmitData {
  const factory BlogSubmitData({
    @JsonKey(name: 'blog_id') required int blogId,
    @JsonKey(name: 'approve_status') required String approveStatus,
    required List<String> keywords,
  }) = _BlogSubmitData;

  factory BlogSubmitData.fromJson(Map<String, dynamic> json) =>
      _$BlogSubmitDataFromJson(json);
}