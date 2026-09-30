import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/appointment/model/appointment_item.dart';
import 'package:Doctors_App/features/appointment/ui/widgets/appointment_status_badge.dart';
import 'package:Doctors_App/features/support_hub/model/support_ticket_enums.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentItem appointment;
  final VoidCallback onView;
  final VoidCallback? onRemarks;
  final VoidCallback? onReschedule;
  final VoidCallback? onCancel;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onView,
    this.onRemarks,
    this.onReschedule,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final status = parseTicketStatus(appointment.appointmentStatus);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: status.color.withValues(alpha: 0.3),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : Colors.grey.shade300).withValues(
              alpha: 0.25,
            ),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppointmentStatusBadge(status: appointment.appointmentStatus),
              const Spacer(),
              Text(
                appointment.appointmentNo,
                style: customTextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: context.secondaryTextColor,
                ),
              ),
            ],
          ),
          height(10),
          if (appointment.modeOfAppointment.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                appointment.modeOfAppointment,
                style: customTextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          height(4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  appointment.appointmentQuery ?? '',
                  style: customTextStyle(
                    fontSize: 12,
                    color: context.secondaryTextColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  '•',
                  style: customTextStyle(
                    fontSize: 12,
                    color: context.secondaryTextColor,
                  ),
                ),
              ),
              Text(
                '${appointment.priority} Priority',
                style: customTextStyle(
                  fontSize: 11,
                  color: context.secondaryTextColor,
                ),
              ),
            ],
          ),
          height(8),
          if (appointment.preferredDate != null ||
              appointment.preferredTime != null) ...[
            Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 13,
                  color: context.secondaryTextColor,
                ),
                width(4),
                Text(
                  [
                    appointment.preferredDate,
                    appointment.preferredTime,
                  ].whereType<String>().join(' • '),
                  style: customTextStyle(
                    fontSize: 11,
                    color: context.secondaryTextColor,
                  ),
                ),
              ],
            ),
            height(8),
          ],
          if (appointment.isRescheduleRequested) ...[
            height(4),
            Text(
              'Reschedule requested',
              style: customTextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.red.shade400,
              ),
            ),
          ],
          // Action buttons
          Wrap(
            spacing: 10,
            runSpacing: 4,
            children: [
              _ActionButton(label: 'View', onPressed: onView),
              // Remarks button is always visible (canRemark is always true)
              if (onRemarks != null)
                _ActionButton(label: 'Remarks', onPressed: onRemarks!),
              // Reschedule button — hidden when canReschedule is false (e.g. cancelled)
              if (onReschedule != null)
                _ActionButton(
                  label: 'Reschedule',
                  onPressed: onReschedule!,
                  color: Colors.orange.shade700,
                ),
              // Cancel button — hidden when canCancel is false (e.g. cancelled)
              if (onCancel != null)
                _ActionButton(
                  label: 'Cancel',
                  onPressed: onCancel!,
                  color: Colors.red.shade400,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  const _ActionButton({
    required this.label,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        side: BorderSide(color: AppColors.fieldGrey.withValues(alpha: 0.6)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      onPressed: onPressed,
      child: Text(label, style: customTextStyle(color: color)),
    );
  }
}
