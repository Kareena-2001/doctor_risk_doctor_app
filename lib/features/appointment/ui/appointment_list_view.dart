import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/common_error_state.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/appointment/model/appointment_item.dart';
import 'package:Doctors_App/features/appointment/ui/state/appointment_state.dart';
import 'package:Doctors_App/features/appointment/ui/view_model/appointment_view_model.dart';
import 'package:Doctors_App/features/appointment/ui/widgets/appointment_detail_sheet.dart';
import 'package:Doctors_App/features/appointment/ui/widgets/appointment_edit_sheet.dart';
import 'package:Doctors_App/features/appointment/ui/widgets/appointment_list_widget.dart';
import 'package:Doctors_App/features/appointment/ui/widgets/appointment_remarks_sheet.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/support_hub/model/support_ticket_enums.dart';
import 'package:Doctors_App/features/support_hub/ui/widgets/legal_status_badge.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _statusTabs = <(String, bool Function(TicketStatus))>[
  ('All', (_) => true),
  ('Open', (s) => s.isOpenish),
  ('Closed', (s) => s == TicketStatus.closed),
  ('Cancelled', (s) => s == TicketStatus.cancelled),
];

class AppointmentListView extends ConsumerStatefulWidget {
  const AppointmentListView({super.key});

  @override
  ConsumerState<AppointmentListView> createState() =>
      _AppointmentListViewState();
}

class _AppointmentListViewState extends ConsumerState<AppointmentListView> {
  AppointmentViewModel get _vm =>
      ref.read(appointmentViewModelProvider.notifier);

  Future<void> _refresh() => _vm.fetchAppointments();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refresh());
  }

  Future<void> _editAppointment(AppointmentItem appointment) async {
    final ok = await showAppointmentEditSheet(context, appointment);
    if (ok == null || !mounted) return;
    if (ok) {
      context.showSuccessSnackBar('Appointment updated successfully');
    } else {
      context.showErrorSnackBar('Failed to update appointment');
    }
  }

  Future<void> _rescheduleAppointment(AppointmentItem appointment) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.secondaryBackgroundColor,
        title: const Text('Request Reschedule'),
        content: const Text(
          'Are you sure you want to request a reschedule for this appointment?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'Yes, Reschedule',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final ok = await _vm.rescheduleAppointment(appointment.id.toString());
    if (!mounted) return;
    if (ok) {
      context.showSuccessSnackBar('Reschedule request sent successfully');
    } else {
      context.showErrorSnackBar(
        ref.read(appointmentViewModelProvider).error ??
            'Failed to request reschedule',
      );
    }
  }

  Future<void> _cancelAppointment(AppointmentItem appointment) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.secondaryBackgroundColor,
        title: const Text('Cancel Appointment'),
        content: const Text(
          'Are you sure you want to cancel this appointment?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final ok = await _vm.cancelAppointment(appointment.id);
    if (!mounted) return;
    if (ok) {
      context.showSuccessSnackBar('Appointment cancelled successfully');
    } else {
      context.showErrorSnackBar('Failed to cancel appointment');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appointmentViewModelProvider);

    return Scaffold(
      appBar: CustomAppBar(title: 'My Appointments'),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(AppointmentState state) {
    if (state.appointments == null) {
      if (state.appointmentsError != null) {
        return CommonErrorState(
          icon: Icons.error_outline,
          title: 'Failed to load appointments',
          message: state.appointmentsError!,
          onRetry: _refresh,
          buttonText: 'Retry',
        );
      }
      return Loading();
    }
    return _buildContent(state);
  }

  Widget _buildContent(AppointmentState state) {
    final appointments =
        state.appointments?.data.appointments.map((a) => a.toItem()).toList() ??
        <AppointmentItem>[];

    final lists = [
      for (final tab in _statusTabs)
        appointments
            .where((a) => tab.$2(parseTicketStatus(a.appointmentStatus)))
            .toList(),
    ];

    return DefaultTabController(
      length: _statusTabs.length,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Appointments', style: AppTheme.title14),
            height(12),
            TabBar(
              isScrollable: true,
              padding: EdgeInsets.zero,
              tabAlignment: TabAlignment.start,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.primary,
              tabs: [
                for (var i = 0; i < _statusTabs.length; i++)
                  Tab(text: '${_statusTabs[i].$1} (${lists[i].length})'),
              ],
            ),
            height(12),
            Expanded(
              child: TabBarView(
                children: [
                  for (final list in lists)
                    AppointmentListWidget(
                      appointments: list,
                      onRefresh: _refresh,
                      onView: (a) => showAppointmentDetailSheet(context, a),
                      onRemarks: (a) =>
                          showAppointmentRemarksSheet(context, ref, a),
                      onEdit: _editAppointment,
                      onReschedule: _rescheduleAppointment,
                      onCancel: _cancelAppointment,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
