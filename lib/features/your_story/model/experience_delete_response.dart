import 'package:freezed_annotation/freezed_annotation.dart';

part 'experience_delete_response.freezed.dart';
part 'experience_delete_response.g.dart';

@freezed
class ExperienceDeleteResponse with _$ExperienceDeleteResponse {
  const factory ExperienceDeleteResponse({
    required bool status,
    required int code,
    required String msg,
    required List<dynamic> data,
  }) = _ExperienceDeleteResponse;

  factory ExperienceDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$ExperienceDeleteResponseFromJson(json);
}