import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/widgets/common_empty_state.dart';
import 'package:Doctors_App/features/support_hub/model/ticket_item.dart';
import 'package:Doctors_App/features/support_hub/ui/widgets/legal_ticket_card.dart';
import 'package:flutter/material.dart';

class LegalTicketList extends StatelessWidget {
  final List<TicketItem> tickets;
  final Future<void> Function() onRefresh;
  final void Function(TicketItem) onView;
  final void Function(TicketItem) onRemarks;
  final void Function(TicketItem) onEdit;
  final void Function(TicketItem) onCancel;

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
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: Responsive.h(180)),
                const CommonEmptyState(
                  icon: Icons.confirmation_number_outlined,
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
                  onRemarks: t.canRemark ? () => onRemarks(t) : null,
                  onEdit: t.canEdit ? () => onEdit(t) : null,
                  onCancel: t.canCancel ? () => onCancel(t) : null,
                );
              },
            ),
    );
  }
}
