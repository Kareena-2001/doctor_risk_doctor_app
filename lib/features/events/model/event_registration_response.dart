import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_registration_response.freezed.dart';

part 'event_registration_response.g.dart';

@freezed
class EventRegistrationResponse with _$EventRegistrationResponse {
  const factory EventRegistrationResponse({
    required bool status,
    required int code,
    required dynamic msg,
    required EventRegistrationData data,
  }) = _EventRegistrationResponse;

  factory EventRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$EventRegistrationResponseFromJson(json);
}

@freezed
class EventRegistrationData with _$EventRegistrationData {
  const factory EventRegistrationData({
    @JsonKey(name: 'registration_id') required int registrationId,
    required String message,
  }) = _EventRegistrationData;

  factory EventRegistrationData.fromJson(Map<String, dynamic> json) =>
      _$EventRegistrationDataFromJson(json);
}
