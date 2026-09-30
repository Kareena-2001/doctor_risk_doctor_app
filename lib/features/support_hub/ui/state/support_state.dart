import 'package:Doctors_App/features/support_hub/model/legal_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/model/query_detail_model.dart';
import 'package:Doctors_App/features/support_hub/model/query_list_model.dart';
import 'package:Doctors_App/features/support_hub/model/service_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/model/support_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/model/ticket_remarks_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_state.freezed.dart';

enum LegalCategory {
  all('All Categories'),
  consultation('Legal Consultation'),
  notice('Legal Notice'),
  legalCase('Legal Case');

  const LegalCategory(this.label);

  final String label;

  bool matches(String? legalType) {
    final t = (legalType ?? '').toLowerCase();
    switch (this) {
      case LegalCategory.all:
        return true;
      case LegalCategory.consultation:
        return t.contains('consultation');
      case LegalCategory.notice:
        return t.contains('notice');
      case LegalCategory.legalCase:
        return t.contains('case');
    }
  }
}

@freezed
class SupportHubState with _$SupportHubState {
  const factory SupportHubState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? error,

    SupportTicketResponse? createdTicket,

    String? tktNumber,

    int? cancellingTicketId,

    ServiceTicketResponse? serviceTickets,
    @Default(false) bool isFetchingServiceTickets,
    String? serviceTicketsError,

    LegalTicketResponse? legalTickets,
    @Default(false) bool isFetchingLegalTickets,
    String? legalTicketsError,
    @Default(LegalCategory.all) LegalCategory legalCategory,

    TicketRemarksResponse? ticketRemarks,
    @Default(false) bool isFetchingRemarks,
    String? remarksError,

    @Default([]) List<QueryListItem> queries,
    @Default(false) bool isFetchingQueries,

    QueryDetailItem? queryDetail,
    @Default(false) bool isFetchingQueryDetail,
    String? queryDetailError,
  }) = _SupportHubState;
}
