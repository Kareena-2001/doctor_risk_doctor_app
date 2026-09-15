import 'package:freezed_annotation/freezed_annotation.dart';

part 'testimonial_submit_response.freezed.dart';

part 'testimonial_submit_response.g.dart';

@freezed
class TestimonialSubmitResponse with _$TestimonialSubmitResponse {
  const factory TestimonialSubmitResponse({
    required bool status,
    required int code,
    required String msg,
    required TestimonialSubmitData data,
  }) = _TestimonialSubmitResponse;

  factory TestimonialSubmitResponse.fromJson(Map<String, dynamic> json) =>
      _$TestimonialSubmitResponseFromJson(json);
}

@freezed
class TestimonialSubmitData with _$TestimonialSubmitData {
  const factory TestimonialSubmitData({
    @JsonKey(name: 'testimonial_id') required int testimonialId,

    @JsonKey(name: 'testimonial_type') @Default('') String testimonialType,

    @Default('') String details,

    String? file,

    @JsonKey(name: 'approve_status') String? approveStatus,
  }) = _TestimonialSubmitData;

  factory TestimonialSubmitData.fromJson(Map<String, dynamic> json) =>
      _$TestimonialSubmitDataFromJson(json);
}
