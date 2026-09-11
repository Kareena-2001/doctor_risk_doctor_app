import 'package:freezed_annotation/freezed_annotation.dart';

part 'experience_submit_response.freezed.dart';

part 'experience_submit_response.g.dart';

@freezed
class ExperienceSubmitResponse with _$ExperienceSubmitResponse {
  const factory ExperienceSubmitResponse({
    required bool status,
    required int code,
    required String msg,
    required ExperienceSubmitData data,
  }) = _ExperienceSubmitResponse;

  factory ExperienceSubmitResponse.fromJson(Map<String, dynamic> json) =>
      _$ExperienceSubmitResponseFromJson(json);
}

@freezed
class ExperienceSubmitData with _$ExperienceSubmitData {
  const factory ExperienceSubmitData({
    @JsonKey(name: 'experience_id') required int experienceId,
    @Default('') String title,
    @JsonKey(name: 'experience_type') @Default('') String experienceType,
    @Default('') String details,
    String? file,
    @JsonKey(name: 'approve_status') String? approveStatus,
  }) = _ExperienceSubmitData;

  factory ExperienceSubmitData.fromJson(Map<String, dynamic> json) =>
      _$ExperienceSubmitDataFromJson(json);
}
