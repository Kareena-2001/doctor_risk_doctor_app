import 'package:freezed_annotation/freezed_annotation.dart';

part 'cancel_support_ticket_model.freezed.dart';

part 'cancel_support_ticket_model.g.dart';

@freezed
class CancelSupportTicketResponse with _$CancelSupportTicketResponse {
  const factory CancelSupportTicketResponse({
    required bool status,
    required int code,
    required String msg,
    required List<dynamic> data,
  }) = _CancelSupportTicketResponse;

  factory CancelSupportTicketResponse.fromJson(Map<String, dynamic> json) =>
      _$CancelSupportTicketResponseFromJson(json);
}
