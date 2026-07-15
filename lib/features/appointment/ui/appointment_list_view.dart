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

  Color _statusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return AppColors.newPri; // Aligned with the form's primary color scheme
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointments = ref.watch(appointmentProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'My Appointments'),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.newPri,
        // Swapped accent with the primary brand color
        onPressed: () => context.push(Routes.addAppointment),
        child: const Icon(Icons.add, color: AppColors.white, size: 25),
      ),
      body: appointments.isEmpty
          ? const CommonEmptyState(
              icon: Icons.calendar_month_outlined,
              title: 'No appointments booked yet',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: appointments.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final appt = appointments[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
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
                            size: 16,
                            color: AppColors.newPri,
                          ),
                          width(8),
                          Expanded(
                            child: Text(
                              appt.subject,
                              overflow: TextOverflow.ellipsis,
                              style: customTextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _statusColor(
                                appt.status,
                              ).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              appt.status,
                              style: customTextStyle(
                                fontSize: 10,
                                color: _statusColor(appt.status),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      height(8),
                      Text(
                        '${appt.mode.label} • ${DateFormat('dd MMM yyyy').format(appt.date)} • ${appt.time.format(context)}',
                        style: customTextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (appt.description.isNotEmpty) ...[
                        height(8),
                        Text(
                          appt.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: customTextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                      if (appt.attachments.isNotEmpty) ...[
                        height(12),
                        const Divider(height: 1),
                        height(10),
                        Text(
                          'Attached Documents (${appt.attachments.length})',
                          style: customTextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                        height(6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: appt.attachments.map((file) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.insert_drive_file_outlined,
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                  width(4),
                                  Flexible(
                                    child: Text(
                                      file.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: customTextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
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
