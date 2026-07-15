import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/common_empty_state.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../model/appointment_model.dart';
import '../provider/appointment_provider.dart';

class AppointmentListView extends ConsumerWidget {
  const AppointmentListView({super.key});

  Color _statusColor(String status, BuildContext context) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointments = ref.watch(appointmentProvider);

    return Scaffold(
      appBar: CustomAppBar(title: 'My Appointments'),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.accent,
        onPressed: () => context.push(Routes.addAppointment),
        child: Icon(Icons.add, color: AppColors.white, size: 25),
      ),
      body: appointments.isEmpty
          ? CommonEmptyState(
              icon: Icons.dashboard_customize,
              title: 'No appointments booked yet',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: appointments.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final appt = appointments[index];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            appt.mode.icon,
                            size: 15,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          width(8),
                          Expanded(
                            child: Text(
                              appt.subject,
                              overflow: TextOverflow.ellipsis,
                              style: customTextStyle(fontSize: 14),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _statusColor(
                                appt.status,
                                context,
                              ).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              appt.status,
                              style: customTextStyle(
                                fontSize: 10,
                                color: _statusColor(appt.status, context),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      height(8),
                      Text(
                        '${appt.mode.label} • ${DateFormat('dd MMM yyyy').format(appt.date)} • ${appt.time.format(context)}',
                        style: customTextStyle(fontSize: 12),
                      ),
                      if (appt.description.isNotEmpty) ...[
                        height(6),
                        Text(
                          appt.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: customTextStyle(fontSize: 12),
                        ),
                      ],
                      if (appt.attachments.isNotEmpty) ...[
                        height(6),
                        Text(
                          '${appt.attachments.length} attachment(s)',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
    );
  }
}
