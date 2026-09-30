import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/appointment/model/appointment_item.dart';
import 'package:Doctors_App/features/appointment/ui/widgets/appointment_status_badge.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> showAppointmentDetailSheet(
  BuildContext context,
  AppointmentItem appointment,
) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: context.primaryBackgroundColor,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => AppointmentDetailSheet(appointment: appointment),
  );
}

class AppointmentDetailSheet extends StatelessWidget {
  final AppointmentItem appointment;

  const AppointmentDetailSheet({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final a = appointment;
    final hasAttachment = a.attachment != null && a.attachment!.isNotEmpty;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(a.appointmentNo, style: AppTheme.title16),
                width(10),
                AppointmentStatusBadge(status: a.appointmentStatus),
              ],
            ),
            height(16),
            _DetailRow(label: 'Type', value: a.appointmentType),
            _DetailRow(label: 'Mode', value: a.modeOfAppointment),
            if (a.appointmentQuery != null)
              _DetailRow(label: 'Query', value: a.appointmentQuery!),
            _DetailRow(label: 'Priority', value: a.priority),
            if (a.preferredDate != null)
              _DetailRow(label: 'Date', value: a.preferredDate!),
            if (a.preferredTime != null)
              _DetailRow(label: 'Time', value: a.preferredTime!),
            _DetailRow(label: 'Raised', value: a.createdOn),
            if (a.link != null && a.link!.isNotEmpty)
              _DetailRow(label: 'Link', value: a.link!),
            if (a.description != null) ...[
              height(10),
              Text('Description', style: AppTheme.title14),
              height(4),
              Text(a.description!, style: AppTheme.label12),
            ],
            if (hasAttachment) ...[
              height(12),
              _AttachmentRow(url: a.attachment!),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: customTextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: customTextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttachmentRow extends StatelessWidget {
  final String url;

  const _AttachmentRow({required this.url});

  Future<void> _open(BuildContext context) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      context.showErrorSnackBar('Invalid attachment URL');
      return;
    }
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      context.showErrorSnackBar('Could not open attachment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _open(context),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.attach_file_rounded,
              size: 20,
              color: AppColors.primary,
            ),
            width(8),
            Expanded(
              child: Text(
                'Attachment',
                style: customTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              'View',
              style: customTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            width(4),
            Icon(
              Icons.open_in_new_rounded,
              size: 16,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
