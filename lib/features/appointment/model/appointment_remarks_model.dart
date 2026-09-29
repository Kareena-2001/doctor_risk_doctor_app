import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_remarks_model.freezed.dart';
part 'appointment_remarks_model.g.dart';

@freezed
class AppointmentRemarksResponse with _$AppointmentRemarksResponse {
  const factory AppointmentRemarksResponse({
    required bool status,
    required int code,
    required String msg,
    required AppointmentRemarksData data,
  }) = _AppointmentRemarksResponse;

  factory AppointmentRemarksResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$AppointmentRemarksResponseFromJson(json);
}

@freezed
class AppointmentRemarksData with _$AppointmentRemarksData {
  const factory AppointmentRemarksData({
    required AppointmentRemarkAppointment appointment,
    required List<AppointmentRemark> remarks,
  }) = _AppointmentRemarksData;

  factory AppointmentRemarksData.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$AppointmentRemarksDataFromJson(json);
}

@freezed
class AppointmentRemarkAppointment
    with _$AppointmentRemarkAppointment {
  const factory AppointmentRemarkAppointment({
    required int id,
    @JsonKey(name: 'appointment_type')
    required String appointmentType,
    String? description,
    @JsonKey(name: 'appointment_status')
    required String appointmentStatus,
  }) = _AppointmentRemarkAppointment;

  factory AppointmentRemarkAppointment.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$AppointmentRemarkAppointmentFromJson(json);
}

@freezed
class AppointmentRemark with _$AppointmentRemark {
  const factory AppointmentRemark() = _AppointmentRemark;

  factory AppointmentRemark.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$AppointmentRemarkFromJson(json);
}