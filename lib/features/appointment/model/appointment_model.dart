import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_model.freezed.dart';
part 'appointment_model.g.dart';

@freezed
class AppointmentResponse with _$AppointmentResponse {
  const factory AppointmentResponse({
    required bool status,
    required int code,
    required String msg,
    required AppointmentData data,
  }) = _AppointmentResponse;

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentResponseFromJson(json);
}

@freezed
class AppointmentData with _$AppointmentData {
  const factory AppointmentData({
    required AppointmentCounts counts,

    @JsonKey(name: 'data')
    required List<Appointment> appointments,

    required int total,

    @JsonKey(name: 'current_page')
    required int currentPage,

    @JsonKey(name: 'last_page')
    required int lastPage,

    @JsonKey(name: 'per_page')
    required int perPage,
  }) = _AppointmentData;

  factory AppointmentData.fromJson(Map<String, dynamic> json) =>
      _$AppointmentDataFromJson(json);
}

@freezed
class AppointmentCounts with _$AppointmentCounts {
  const factory AppointmentCounts({
    required int all,
    required int open,
    required int closed,
    required int cancelled,
  }) = _AppointmentCounts;

  factory AppointmentCounts.fromJson(Map<String, dynamic> json) =>
      _$AppointmentCountsFromJson(json);
}

@freezed
class Appointment with _$Appointment {
  const factory Appointment({
    required int id,

    @JsonKey(name: 'appointment_no')
    required String appointmentNo,

    @JsonKey(name: 'appointment_type')
    required String appointmentType,

    @JsonKey(name: 'appointment_query')
    String? appointmentQuery,

    @JsonKey(name: 'mode_of_appointment')
    required String modeOfAppointment,

    String? link,

    @JsonKey(name: 'preferred_date')
    String? preferredDate,

    @JsonKey(name: 'preferred_time')
    String? preferredTime,

    required String priority,

    String? description,

    String? attachment,

    @JsonKey(name: 'schedule_request')
    String? scheduleRequest,

    @JsonKey(name: 'appointment_status')
    required String appointmentStatus,

    @JsonKey(name: 'created_on')
    required String createdOn,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
}