import 'package:Doctors_App/core/widgets/common_empty_state.dart';
import 'package:Doctors_App/features/support_hub/model/legal_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/ui/widgets/legal_ticket_card.dart';
import 'package:flutter/material.dart';

class LegalTicketList extends StatelessWidget {
  final List<LegalTicket> tickets;
  final Future<void> Function() onRefresh;
  final void Function(LegalTicket) onView;
  final void Function(LegalTicket) onRemarks;
  final void Function(LegalTicket) onEdit;
  final void Function(LegalTicket) onCancel;

  const LegalTicketList({
    super.key,
    required this.tickets,
    required this.onRefresh,
    required this.onView,
    required this.onRemarks,
    required this.onEdit,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: tickets.isEmpty
          ? ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 180),
          CommonEmptyState(
            icon: Icons.inbox_rounded,
            title: 'No tickets found',
            message: 'Raise a ticket to get started',
          ),
        ],
      )
          : ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: tickets.length,
        itemBuilder: (_, i) {
          final t = tickets[i];
          return LegalTicketCard(
            ticket: t,
            onView: () => onView(t),
            onRemarks: t.actions.remark ? () => onRemarks(t) : null,
            onEdit: t.actions.edit ? () => onEdit(t) : null,
            onCancel: t.actions.cancel ? () => onCancel(t) : null,
          );
        },
      ),
    );
  }
}