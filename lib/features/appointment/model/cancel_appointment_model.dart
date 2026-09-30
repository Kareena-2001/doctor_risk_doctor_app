import 'package:freezed_annotation/freezed_annotation.dart';

part 'cancel_appointment_model.freezed.dart';

part 'cancel_appointment_model.g.dart';

@freezed
class CancelAppointmentResponse with _$CancelAppointmentResponse {
  const factory CancelAppointmentResponse({
    required bool status,
    required int code,
    required String msg,
    required List<dynamic> data,
  }) = _CancelAppointmentResponse;

  factory CancelAppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$CancelAppointmentResponseFromJson(json);
}
