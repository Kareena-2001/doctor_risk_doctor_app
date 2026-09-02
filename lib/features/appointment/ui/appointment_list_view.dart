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

  void _showAppointmentDetails(BuildContext context, AppointmentModel appt) {
    final statusColor = _statusColor(appt.status);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).padding.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header & Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      appt.subject,
                      style: customTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              height(16),

              // Detail Key-Value Rows
              _buildDetailRow(
                context,
                'Status',
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
                    appt.status.toUpperCase(),
                    style: customTextStyle(
                      fontSize: 11,
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _buildDetailRow(
                context,
                'Linked ticket',
                Text(
                  'LS-2026-0142',
                  // Replace with dynamic field if present: appt.ticketId
                  style: customTextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _buildDetailRow(
                context,
                'Type',
                Text(
                  'Legal', // Replace with dynamic field if present: appt.type
                  style: customTextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _buildDetailRow(
                context,
                'Date',
                Text(
                  DateFormat('dd MMM yyyy').format(appt.date),
                  style: customTextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _buildDetailRow(
                context,
                'Time',
                Text(
                  appt.time.format(context),
                  style: customTextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _buildDetailRow(
                context,
                'Mode',
                Row(
                  children: [
                    Icon(appt.mode.icon, size: 14, color: AppColors.newPri),
                    width(6),
                    Text(
                      appt.mode.label,
                      style: customTextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDetailRow(
                context,
                'Link',
                Flexible(
                  child: SelectableText(
                    'https://meet.doctorsrisk.in/dr-mathur-142',
                    // Replace with appt.meetingLink
                    style: customTextStyle(
                      fontSize: 12,
                      color: AppColors.newPri,
                      fontWeight: FontWeight.w500,
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

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    Widget valueWidget,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: customTextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(child: valueWidget),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointments = ref.watch(appointmentProvider);

    final openAppointments = appointments
        .where(
          (a) =>
              a.status.toLowerCase() == 'open' ||
              a.status.toLowerCase() == 'scheduled',
        )
        .toList();
    final completedAppointments = appointments
        .where(
          (a) =>
              a.status.toLowerCase() == 'completed' ||
              a.status.toLowerCase() == 'closed',
        )
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
        final isCancelable =
            appt.status.toLowerCase() == 'open' ||
            appt.status.toLowerCase() == 'scheduled';

        return Container(
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
              // Main Info Padding Section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Title + Status Chip
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            appt.subject,
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
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            appt.status,
                            style: customTextStyle(
                              fontSize: 11,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    height(6),

                    // Subtitle Metadata Row: Type · Ticket ID · Date & Time
                    Text(
                      'Legal · Ticket ${appt.id ?? "LS-2026-0142"} · ${DateFormat('dd MMM yyyy').format(appt.date)}, ${appt.time.format(context)}',
                      style: customTextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(
                height: 1,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),

              // Bottom Action Buttons Strip
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => _showAppointmentDetails(context, appt),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        visualDensity: VisualDensity.compact,
                      ),
                      child: Text(
                        'View Details',
                        style: customTextStyle(
                          fontSize: 12,
                          color: AppColors.newPri,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (isCancelable) ...[
                      TextButton(
                        onPressed: () {
                          // Trigger Reschedule action/modal
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: Text(
                          'Request Reschedule',
                          style: customTextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Trigger Cancel action/modal
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: Text(
                          'Cancel',
                          style: customTextStyle(
                            fontSize: 12,
                            color: Colors.red[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
