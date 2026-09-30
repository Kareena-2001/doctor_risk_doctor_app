import 'package:Doctors_App/core/widgets/common_empty_state.dart';
import 'package:Doctors_App/features/appointment/model/appointment_item.dart';
import 'package:Doctors_App/features/appointment/ui/widgets/appointment_card.dart';
import 'package:flutter/material.dart';

class AppointmentListWidget extends StatelessWidget {
  final List<AppointmentItem> appointments;
  final Future<void> Function() onRefresh;
  final void Function(AppointmentItem) onView;
  final void Function(AppointmentItem) onRemarks;
  final void Function(AppointmentItem) onEdit;
  final void Function(AppointmentItem) onReschedule;
  final void Function(AppointmentItem) onCancel;

  const AppointmentListWidget({
    super.key,
    required this.appointments,
    required this.onRefresh,
    required this.onView,
    required this.onRemarks,
    required this.onEdit,
    required this.onReschedule,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: appointments.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 180),
                CommonEmptyState(
                  icon: Icons.event_busy_rounded,
                  title: 'No appointments found',
                  message: 'Raise an appointment to get started',
                ),
              ],
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: appointments.length,
              itemBuilder: (_, i) {
                final a = appointments[i];
                return AppointmentCard(
                  appointment: a,
                  onView: () => onView(a),
                  // Remarks always visible (canRemark is always true)
                  onRemarks: a.canRemark ? () => onRemarks(a) : null,
                  // Reschedule shown only when canReschedule is true
                  onReschedule: a.canReschedule ? () => onReschedule(a) : null,
                  // Cancel shown only when canCancel is true
                  onCancel: a.canCancel ? () => onCancel(a) : null,
                );
              },
            ),
    );
  }
}
