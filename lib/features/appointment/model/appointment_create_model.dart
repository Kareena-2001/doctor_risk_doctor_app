import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_create_model.freezed.dart';

part 'appointment_create_model.g.dart';

@freezed
class AppointmentCreateResponse with _$AppointmentCreateResponse {
  const factory AppointmentCreateResponse({
    required bool status,
    required int code,
    required String msg,
    required List<dynamic> data,
  }) = _AppointmentCreateResponse;

  factory AppointmentCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentCreateResponseFromJson(json);
}
