import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_appointment_remark_model.freezed.dart';

part 'add_appointment_remark_model.g.dart';

@freezed
class AddAppointmentRemarkResponse with _$AddAppointmentRemarkResponse {
  const factory AddAppointmentRemarkResponse({
    required bool status,
    required int code,
    required String msg,
    required List<dynamic> data,
  }) = _AddAppointmentRemarkResponse;

  factory AddAppointmentRemarkResponse.fromJson(Map<String, dynamic> json) =>
      _$AddAppointmentRemarkResponseFromJson(json);
}
