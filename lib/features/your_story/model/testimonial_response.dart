import 'package:freezed_annotation/freezed_annotation.dart';

part 'testimonial_response.freezed.dart';
part 'testimonial_response.g.dart';

@freezed
class TestimonialResponse with _$TestimonialResponse {
  const factory TestimonialResponse({
    required bool status,
    required int code,
    required String msg,
    @Default([]) List<TestimonialData> data,
    @Default(0) int total,
    @JsonKey(name: 'current_page') @Default(1) int currentPage,
    @JsonKey(name: 'last_page') @Default(1) int lastPage,
    @JsonKey(name: 'per_page') @Default(10) int perPage,
  }) = _TestimonialResponse;

  factory TestimonialResponse.fromJson(Map<String, dynamic> json) =>
      _$TestimonialResponseFromJson(json);
}

@freezed
class TestimonialData with _$TestimonialData {
  const factory TestimonialData({
    required int id,
    @JsonKey(name: 'testimonial_type')
    @Default('')
    String testimonialType,
    @Default('') String details,
    String? file,
    @JsonKey(name: 'dr_name') String? drName,
    String? degree,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'speciality_name') String? specialityName,
    @JsonKey(name: 'i_agree_accepted') String? iAgreeAccepted,
    @JsonKey(name: 'approve_status') String? approveStatus,
    @JsonKey(name: 'approved_by') String? approvedBy,
    @JsonKey(name: 'approve_date') String? approveDate,
    String? status,
    @JsonKey(name: 'created_on') String? createdOn,
    @JsonKey(name: 'updated_on') String? updatedOn,
  }) = _TestimonialData;

  factory TestimonialData.fromJson(Map<String, dynamic> json) =>
      _$TestimonialDataFromJson(json);
}