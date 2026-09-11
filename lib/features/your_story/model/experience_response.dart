import 'package:freezed_annotation/freezed_annotation.dart';

part 'experience_response.freezed.dart';
part 'experience_response.g.dart';

@freezed
class ExperienceResponse with _$ExperienceResponse {
  const factory ExperienceResponse({
    required bool status,
    required int code,
    required String msg,
    @Default([]) List<ExperienceData> data,
    @Default(0) int total,
    @JsonKey(name: 'current_page') @Default(1) int currentPage,
    @JsonKey(name: 'last_page') @Default(1) int lastPage,
    @JsonKey(name: 'per_page') @Default(10) int perPage,
  }) = _ExperienceResponse;

  factory ExperienceResponse.fromJson(Map<String, dynamic> json) =>
      _$ExperienceResponseFromJson(json);
}

@freezed
class ExperienceData with _$ExperienceData {
  const factory ExperienceData({
    required int id,
    @Default('') String title,
    @JsonKey(name: 'experience_type') @Default('') String experienceType,
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
  }) = _ExperienceData;

  factory ExperienceData.fromJson(Map<String, dynamic> json) =>
      _$ExperienceDataFromJson(json);
}