import 'package:Doctors_App/features/support_hub/model/legal_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/model/service_ticket_model.dart';

/// Common UI model shared by Legal and Service ticket screens/widgets.
class TicketItem {
  final int id;
  final String ticketNo;
  final String queryType;
  final String? commonQuery;

  final String typeLabel;
  final String? typeValue;

  final String priority;
  final String? description;
  final String? attachment;
  final String ticketStatus;
  final String createdOn;

  final bool canRemark;
  final bool canEdit;
  final bool canCancel;
  final String? editLabel;

  const TicketItem({
    required this.id,
    required this.ticketNo,
    required this.queryType,
    required this.typeLabel,
    required this.priority,
    required this.ticketStatus,
    required this.createdOn,
    required this.canRemark,
    required this.canEdit,
    required this.canCancel,
    this.commonQuery,
    this.typeValue,
    this.description,
    this.attachment,
    this.editLabel,
  });
}

extension LegalTicketToItem on LegalTicket {
  TicketItem toItem() => TicketItem(
    id: id,
    ticketNo: ticketNo,
    queryType: queryType,
    commonQuery: commonQuery,
    typeLabel: 'Legal Type',
    typeValue: legalType,
    priority: priority,
    description: description,
    attachment: attachment,
    ticketStatus: ticketStatus,
    createdOn: createdOn,
    canRemark: actions.remark,
    canEdit: actions.edit,
    canCancel: actions.cancel,
    editLabel: actions.editLabel,
  );
}

extension ServiceTicketToItem on ServiceTicket {
  TicketItem toItem() => TicketItem(
    id: id,
    ticketNo: ticketNo,
    queryType: queryType,
    commonQuery: commonQuery,
    typeLabel: 'Preferred Contact',
    typeValue: preferredContact,
    priority: priority,
    description: description,
    attachment: attachment,
    ticketStatus: ticketStatus,
    createdOn: createdOn,
    canRemark: actions.remark,
    canEdit: actions.edit,
    canCancel: actions.cancel,
    editLabel: actions.editLabel,
  );
}