import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/support_hub/model/service_ticket_model.dart';
import 'package:flutter/material.dart';

TicketStatus parseTicketStatus(String raw) {
  switch (raw.toLowerCase().replaceAll(' ', '')) {
    case 'inprogress':
      return TicketStatus.inProgress;
    case 'escalated':
      return TicketStatus.escalated;
    case 'closed':
      return TicketStatus.closed;
    case 'cancelled':
      return TicketStatus.cancelled;
    case 'open':
    default:
      return TicketStatus.open;
  }
}

class LegalStatusBadge extends StatelessWidget {
  final String status;

  const LegalStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final s = parseTicketStatus(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: s.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(s.icon, size: 14, color: s.color),
          width(6),
          Text(
            s.label,
            style: customTextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: s.color,
            ),
          ),
        ],
      ),
    );
  }
}