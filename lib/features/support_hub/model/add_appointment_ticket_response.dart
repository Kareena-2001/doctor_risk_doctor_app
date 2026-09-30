import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_appointment_ticket_response.freezed.dart';

part 'add_appointment_ticket_response.g.dart';

@freezed
class AddAppointmentTicketResponse with _$AddAppointmentTicketResponse {
  const factory AddAppointmentTicketResponse({
    required bool status,
    required int code,
    required String msg,
    @Default([]) List<dynamic> data,
  }) = _AddAppointmentTicketResponse;

  factory AddAppointmentTicketResponse.fromJson(Map<String, dynamic> json) =>
      _$AddAppointmentTicketResponseFromJson(json);
}
