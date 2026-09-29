import 'package:freezed_annotation/freezed_annotation.dart';

part 'reschedule_appointment_model.freezed.dart';
part 'reschedule_appointment_model.g.dart';

@freezed
class RescheduleAppointmentResponse
    with _$RescheduleAppointmentResponse {
  const factory RescheduleAppointmentResponse({
    required bool status,
    required int code,
    required String msg,
    required RescheduleAppointmentData data,
  }) = _RescheduleAppointmentResponse;

  factory RescheduleAppointmentResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$RescheduleAppointmentResponseFromJson(json);
}

@freezed
class RescheduleAppointmentData with _$RescheduleAppointmentData {
  const factory RescheduleAppointmentData({
    @JsonKey(name: 'appointment_id')
    required int appointmentId,

    @JsonKey(name: 'appointment_no')
    required String appointmentNo,

    @JsonKey(name: 'schedule_request')
    required String scheduleRequest,
  }) = _RescheduleAppointmentData;

  factory RescheduleAppointmentData.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$RescheduleAppointmentDataFromJson(json);
}