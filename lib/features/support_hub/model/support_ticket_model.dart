import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_ticket_model.freezed.dart';
part 'support_ticket_model.g.dart';

@freezed
class SupportTicketResponse with _$SupportTicketResponse {
  const factory SupportTicketResponse({
    required bool status,
    required int code,
    required String msg,
    required List<dynamic> data,
  }) = _SupportTicketResponse;

  factory SupportTicketResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$SupportTicketResponseFromJson(json);
}