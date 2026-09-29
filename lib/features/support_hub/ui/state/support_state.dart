import 'package:Doctors_App/features/support_hub/model/legal_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/model/query_detail_model.dart';
import 'package:Doctors_App/features/support_hub/model/query_list_model.dart';
import 'package:Doctors_App/features/support_hub/model/service_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/model/support_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/model/ticket_remarks_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_state.freezed.dart';

@freezed
class SupportHubState with _$SupportHubState {
  const factory SupportHubState({
    // ── Mutations: create ticket / add remark / update / cancel ──────────
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? error,

    /// Response of the last created ticket (read ticket number etc. from it).
    SupportTicketResponse? createdTicket,

    /// Ticket number of the last created ticket — used by SuccessView.
    String? tktNumber,

    /// Id of the ticket currently being cancelled (for per-item spinner).
    int? cancellingTicketId,

    // ── Service tickets list ─────────────────────────────────────────────
    ServiceTicketResponse? serviceTickets,
    @Default(false) bool isFetchingServiceTickets,
    String? serviceTicketsError,

    // ── Legal tickets list ───────────────────────────────────────────────
    LegalTicketResponse? legalTickets,
    @Default(false) bool isFetchingLegalTickets,
    String? legalTicketsError,

    // ── Ticket remarks (conversation) ────────────────────────────────────
    TicketRemarksResponse? ticketRemarks,
    @Default(false) bool isFetchingRemarks,
    String? remarksError,

    // ── Legacy "queries" list (MyQueriesScreen) ───────────────────────────
    @Default([]) List<QueryListItem> queries,
    @Default(false) bool isFetchingQueries,

    // ── Legacy "query detail" (QueryDetailsScreen) ────────────────────────
    QueryDetailItem? queryDetail,
    @Default(false) bool isFetchingQueryDetail,
    String? queryDetailError,
  }) = _SupportHubState;
}

/// Alias kept for backward-compatibility with screens that import HelpState.
typedef HelpState = SupportHubState;
