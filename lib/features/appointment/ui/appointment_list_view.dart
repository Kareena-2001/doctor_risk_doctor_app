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
    switch (status.toLowerCase()) {
      case 'completed':
      case 'closed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'open':
      case 'scheduled':
        return AppColors.newPri;
      default:
        return AppColors.newPri;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointments = ref.watch(appointmentProvider);

    final openAppointments = appointments
        .where((a) =>
    a.status.toLowerCase() == 'open' ||
        a.status.toLowerCase() == 'scheduled')
        .toList();
    final completedAppointments = appointments
        .where((a) =>
    a.status.toLowerCase() == 'completed' ||
        a.status.toLowerCase() == 'closed')
        .toList();
    final cancelledAppointments = appointments
        .where((a) => a.status.toLowerCase() == 'cancelled')
        .toList();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Appointments'),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppColors.newPri,
          onPressed: () => context.push(Routes.addAppointment),
          child: const Icon(Icons.add, color: AppColors.white, size: 25),
        ),
        body: Column(
          children: [
            // Sub-header Banner
            // Container(
            //   color: AppColors.white,
            //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            //   width: double.infinity,
            //   child: Text(
            //     'Scheduled by our team once a Book Appointment ticket is processed. '
            //         'You can request a reschedule or cancellation here.',
            //     style: customTextStyle(
            //       fontSize: 12,
            //       color: Colors.grey[600],
            //       fontWeight: FontWeight.w400,
            //     ),
            //   ),
            // ),

            // Tab Filters Bar
            Container(
              color: AppColors.white,
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: AppColors.newPri,
                unselectedLabelColor: Colors.grey[600],
                indicatorColor: AppColors.newPri,
                indicatorWeight: 2.5,
                labelStyle: customTextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: customTextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                tabs: [
                  Tab(text: 'All (${appointments.length})'),
                  Tab(text: 'Open (${openAppointments.length})'),
                  Tab(text: 'Closed (${completedAppointments.length})'),
                  Tab(text: 'Cancelled (${cancelledAppointments.length})'),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),

            // Tab Content List
            Expanded(
              child: TabBarView(
                children: [
                  _buildAppointmentList(context, appointments),
                  _buildAppointmentList(context, openAppointments),
                  _buildAppointmentList(context, completedAppointments),
                  _buildAppointmentList(context, cancelledAppointments),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentList(
      BuildContext context,
      List<AppointmentModel> items,
      ) {
    if (items.isEmpty) {
      return const CommonEmptyState(
        icon: Icons.calendar_month_outlined,
        title: 'No appointments found',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => height(12),
      itemBuilder: (context, index) {
        final appt = items[index];
        final statusColor = _statusColor(appt.status);

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
              // Header: Subject + Status Chip
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  width(8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      appt.status,
                      style: customTextStyle(
                        fontSize: 10,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              height(8),

              // Mode, Date, Time Metadata
              Text(
                '${appt.mode.label} • ${DateFormat('dd MMM yyyy').format(appt.date)} • ${appt.time.format(context)}',
                style: customTextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),

              // Description
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

              // Attachment Documents Section
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

              // Action Link
              height(12),
              const Divider(height: 1),
              height(8),
              InkWell(
                onTap: () {
                  // Navigate or view appointment details
                },
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    'View Details',
                    style: customTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.newPri,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}