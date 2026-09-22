import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_registration_response.freezed.dart';

part 'event_registration_response.g.dart';

@freezed
class EventRegistrationResponse with _$EventRegistrationResponse {
  const factory EventRegistrationResponse({
    required bool status,
    required int code,
    dynamic msg,
    required String data,
  }) = _EventRegistrationResponse;

  factory EventRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$EventRegistrationResponseFromJson(json);
}
