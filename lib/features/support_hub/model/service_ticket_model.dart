import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_ticket_model.freezed.dart';

part 'service_ticket_model.g.dart';


@freezed
class ServiceTicketResponse with _$ServiceTicketResponse {
  const factory ServiceTicketResponse({
    required bool status,
    required int code,
    required String msg,
    required ServiceTicketData data,
  }) = _ServiceTicketResponse;

  factory ServiceTicketResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceTicketResponseFromJson(json);
}

@freezed
class ServiceTicketData with _$ServiceTicketData {
  const factory ServiceTicketData({
    required ServiceTicketCounts counts,

    @JsonKey(name: 'data') required List<ServiceTicket> tickets,

    required int total,

    @JsonKey(name: 'current_page') required int currentPage,

    @JsonKey(name: 'last_page') required int lastPage,

    @JsonKey(name: 'per_page') required int perPage,
  }) = _ServiceTicketData;

  factory ServiceTicketData.fromJson(Map<String, dynamic> json) =>
      _$ServiceTicketDataFromJson(json);
}

@freezed
class ServiceTicketCounts with _$ServiceTicketCounts {
  const factory ServiceTicketCounts({
    required int all,
    required int open,
    required int closed,
    required int cancelled,
  }) = _ServiceTicketCounts;

  factory ServiceTicketCounts.fromJson(Map<String, dynamic> json) =>
      _$ServiceTicketCountsFromJson(json);
}

@freezed
class ServiceTicket with _$ServiceTicket {
  const factory ServiceTicket({
    required int id,

    @JsonKey(name: 'ticket_no') required String ticketNo,

    @JsonKey(name: 'query_type') required String queryType,

    @JsonKey(name: 'common_query') String? commonQuery,

    @JsonKey(name: 'preferred_contact') String? preferredContact,

    required String priority,

    String? description,

    String? attachment,

    @JsonKey(name: 'tickete_status') required String ticketStatus,

    @JsonKey(name: 'created_on') required String createdOn,

    required ServiceTicketActions actions,
  }) = _ServiceTicket;

  factory ServiceTicket.fromJson(Map<String, dynamic> json) =>
      _$ServiceTicketFromJson(json);
}

@freezed
class ServiceTicketActions with _$ServiceTicketActions {
  const factory ServiceTicketActions({
    required bool view,
    required bool remark,
    required bool edit,
    required bool cancel,

    @JsonKey(name: 'edit_label') String? editLabel,
  }) = _ServiceTicketActions;

  factory ServiceTicketActions.fromJson(Map<String, dynamic> json) =>
      _$ServiceTicketActionsFromJson(json);
}
