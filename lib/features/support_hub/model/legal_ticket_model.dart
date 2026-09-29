import 'package:freezed_annotation/freezed_annotation.dart';

part 'legal_ticket_model.freezed.dart';

part 'legal_ticket_model.g.dart';

@freezed
class LegalTicketResponse with _$LegalTicketResponse {
  const factory LegalTicketResponse({
    required bool status,
    required int code,
    required String msg,
    required LegalTicketData data,
  }) = _LegalTicketResponse;

  factory LegalTicketResponse.fromJson(Map<String, dynamic> json) =>
      _$LegalTicketResponseFromJson(json);
}

@freezed
class LegalTicketData with _$LegalTicketData {
  const factory LegalTicketData({
    required LegalTicketCounts counts,

    @JsonKey(name: 'data') required List<LegalTicket> tickets,

    required int total,

    @JsonKey(name: 'current_page') required int currentPage,

    @JsonKey(name: 'last_page') required int lastPage,

    @JsonKey(name: 'per_page') required int perPage,
  }) = _LegalTicketData;

  factory LegalTicketData.fromJson(Map<String, dynamic> json) =>
      _$LegalTicketDataFromJson(json);
}

@freezed
class LegalTicketCounts with _$LegalTicketCounts {
  const factory LegalTicketCounts({
    required int all,
    required int open,
    required int closed,
    required int cancelled,
  }) = _LegalTicketCounts;

  factory LegalTicketCounts.fromJson(Map<String, dynamic> json) =>
      _$LegalTicketCountsFromJson(json);
}

@freezed
class LegalTicket with _$LegalTicket {
  const factory LegalTicket({
    required int id,

    @JsonKey(name: 'ticket_no') required String ticketNo,

    @JsonKey(name: 'query_type') required String queryType,

    @JsonKey(name: 'common_query') String? commonQuery,

    @JsonKey(name: 'legal_type') String? legalType,

    required String priority,

    String? description,

    String? attachment,

    @JsonKey(name: 'tickete_status') required String ticketStatus,

    @JsonKey(name: 'created_on') required String createdOn,

    required LegalTicketActions actions,
  }) = _LegalTicket;

  factory LegalTicket.fromJson(Map<String, dynamic> json) =>
      _$LegalTicketFromJson(json);
}

@freezed
class LegalTicketActions with _$LegalTicketActions {
  const factory LegalTicketActions({
    required bool view,
    required bool remark,
    required bool edit,
    required bool cancel,

    @JsonKey(name: 'edit_label') String? editLabel,
  }) = _LegalTicketActions;

  factory LegalTicketActions.fromJson(Map<String, dynamic> json) =>
      _$LegalTicketActionsFromJson(json);
}
