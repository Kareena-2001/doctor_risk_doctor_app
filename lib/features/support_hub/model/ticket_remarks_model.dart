import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_remarks_model.freezed.dart';
part 'ticket_remarks_model.g.dart';

@freezed
class TicketRemarksResponse with _$TicketRemarksResponse {
  const factory TicketRemarksResponse({
    required bool status,
    required int code,
    required String msg,
    required TicketRemarksData data,
  }) = _TicketRemarksResponse;

  factory TicketRemarksResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$TicketRemarksResponseFromJson(json);
}

@freezed
class TicketRemarksData with _$TicketRemarksData {
  const factory TicketRemarksData({
    required TicketRemarkTicket ticket,
    required List<TicketRemark> remarks,
  }) = _TicketRemarksData;

  factory TicketRemarksData.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$TicketRemarksDataFromJson(json);
}

@freezed
class TicketRemarkTicket with _$TicketRemarkTicket {
  const factory TicketRemarkTicket({
    required int id,

    @JsonKey(name: 'ticket_no')
    required String ticketNo,

    String? description,

    @JsonKey(name: 'tickete_status')
    required String ticketStatus,
  }) = _TicketRemarkTicket;

  factory TicketRemarkTicket.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$TicketRemarkTicketFromJson(json);
}

@freezed
class TicketRemark with _$TicketRemark {
  const factory TicketRemark({
    required int id,

    required String remark,

    @JsonKey(name: 'attachment_type')
    String? attachmentType,

    String? attachment,

    @JsonKey(name: 'tickete_status')
    required String ticketStatus,

    @JsonKey(name: 'date_time')
    required String dateTime,
  }) = _TicketRemark;

  factory TicketRemark.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$TicketRemarkFromJson(json);
}