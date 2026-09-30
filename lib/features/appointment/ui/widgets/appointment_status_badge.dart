import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/support_hub/model/support_ticket_enums.dart';
import 'package:Doctors_App/features/support_hub/ui/widgets/legal_status_badge.dart';
import 'package:flutter/material.dart';

export 'package:Doctors_App/features/support_hub/ui/widgets/legal_status_badge.dart'
    show parseTicketStatus;

/// Status badge for appointments — reuses the shared [TicketStatus] enum
/// and [parseTicketStatus] parser from support_hub.
class AppointmentStatusBadge extends StatelessWidget {
  final String status;

  const AppointmentStatusBadge({super.key, required this.status});

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
