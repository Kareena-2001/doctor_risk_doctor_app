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

  factory AppointmentRemarksResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentRemarksResponseFromJson(json);
}

@freezed
class AppointmentRemarksData with _$AppointmentRemarksData {
  const factory AppointmentRemarksData({
    required AppointmentRemarkAppointment appointment,
    required List<AppointmentRemark> remarks,
  }) = _AppointmentRemarksData;

  factory AppointmentRemarksData.fromJson(Map<String, dynamic> json) =>
      _$AppointmentRemarksDataFromJson(json);
}

@freezed
class AppointmentRemarkAppointment with _$AppointmentRemarkAppointment {
  const factory AppointmentRemarkAppointment({
    required int id,

    @JsonKey(name: 'appointment_type') required String appointmentType,

    String? description,

    @JsonKey(name: 'appointment_status') required String appointmentStatus,
  }) = _AppointmentRemarkAppointment;

  factory AppointmentRemarkAppointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentRemarkAppointmentFromJson(json);
}

@freezed
class AppointmentRemark with _$AppointmentRemark {
  const factory AppointmentRemark({
    required int id,

    @JsonKey(name: 'sender_type') required String senderType,

    @JsonKey(name: 'sender_department') required String senderDepartment,

    @JsonKey(name: 'sender_id') required String senderId,

    required String remark,

    @JsonKey(name: 'attachment_type') String? attachmentType,

    String? attachment,

    @JsonKey(name: 'appointment_status') required String appointmentStatus,

    @JsonKey(name: 'date_time') required String dateTime,

    @JsonKey(name: 'sender_name') required String senderName,
  }) = _AppointmentRemark;

  factory AppointmentRemark.fromJson(Map<String, dynamic> json) =>
      _$AppointmentRemarkFromJson(json);
}
