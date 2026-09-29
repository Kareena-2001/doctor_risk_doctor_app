import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_support_ticket_model.freezed.dart';

part 'update_support_ticket_model.g.dart';

@freezed
class UpdateSupportTicketResponse with _$UpdateSupportTicketResponse {
  const factory UpdateSupportTicketResponse({
    required bool status,
    required int code,
    required String msg,
    required List<dynamic> data,
  }) = _UpdateSupportTicketResponse;

  factory UpdateSupportTicketResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateSupportTicketResponseFromJson(json);
}
