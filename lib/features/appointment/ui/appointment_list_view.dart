import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/common_error_state.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/appointment/ui/state/appointment_state.dart';
import 'package:Doctors_App/features/appointment/ui/view_model/appointment_view_model.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/support_hub/model/support_ticket_enums.dart';
import 'package:Doctors_App/features/support_hub/model/ticket_item.dart';
import 'package:Doctors_App/features/support_hub/ui/widgets/legal_edit_ticket_sheet.dart';
import 'package:Doctors_App/features/support_hub/ui/widgets/legal_remarks_sheet.dart';
import 'package:Doctors_App/features/support_hub/ui/widgets/legal_status_badge.dart';
import 'package:Doctors_App/features/support_hub/ui/widgets/legal_ticket_detail_sheet.dart';
import 'package:Doctors_App/features/support_hub/ui/widgets/legal_ticket_list.dart';
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

  Future<void> _refresh() => _vm.fetchAppointments(appointmentNo: '');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refresh());
  }

  Future<void> editAppointment(TicketItem ticket) async {
    final ok = await showLegalEditTicketSheet(context, ticket);
    if (ok == null || !mounted) return;
    if (ok) {
      context.showSuccessSnackBar('Ticket updated successfully');
    } else {
      context.showErrorSnackBar('Failed to update ticket');
    }
  }

  Future<void> _cancelAppointment(TicketItem ticket) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.secondaryBackgroundColor,
        title: const Text('Cancel Ticket'),
        content: const Text('Are you sure you want to cancel this ticket?'),
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

    final ok = await _vm.cancelAppointment(ticket.id);
    if (!mounted) return;
    if (ok) {
      context.showSuccessSnackBar('Ticket cancelled successfully');
    } else {
      context.showErrorSnackBar('Failed to cancel ticket');
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(appointmentViewModelProvider);

    return Scaffold(
      appBar: CustomAppBar(title: 'Appointments'),

      body: asyncState.when(
        loading: () => Loading(),
        error: (e, _) => CommonErrorState(
          icon: Icons.error_outline,
          title: 'Failed to load appointments',
          message: e.toString(),
          onRetry: _refresh,
          buttonText: 'Retry',
        ),
        data: (state) => _buildBody(state),
      ),
    );
  }

  Widget _buildBody(AppointmentState state) {
    if (state.appointmentResp == null) {
      if (state.errorMessage != null) {
        return CommonErrorState(
          icon: Icons.error_outline,
          title: 'Failed to load appointment',
          message: state.errorMessage!,
          onRetry: _refresh,
          buttonText: 'Retry',
        );
      }
      return Loading();
    }
    return _buildContent(state);
  }

  Widget _buildContent(AppointmentState state) {
    final tickets =
        state.appointmentResp?.data.appointments
            .map(
              (t) => TicketItem(
                id: t.id,
                ticketNo: t.appointmentNo,
                queryType: t.appointmentType,
                typeLabel: 'Mode',
                typeValue: t.modeOfAppointment,
                priority: t.priority,
                description: t.description,
                attachment: t.attachment,
                ticketStatus: t.appointmentStatus,
                createdOn: t.createdOn,
                canRemark: true,
                canEdit: true,
                canCancel: true,
                commonQuery: t.appointmentQuery,
              ),
            )
            .toList() ??
        <TicketItem>[];

    final lists = [
      for (final tab in _statusTabs)
        tickets
            .where((t) => tab.$2(parseTicketStatus(t.ticketStatus)))
            .toList(),
    ];

    return DefaultTabController(
      length: _statusTabs.length,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Legal Tickets', style: AppTheme.title14),
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
                    LegalTicketList(
                      tickets: list,
                      onRefresh: _refresh,
                      onView: (t) => showLegalTicketDetailSheet(context, t),
                      onRemarks: (t) => showLegalRemarksSheet(context, ref, t),
                      onEdit: editAppointment,
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
