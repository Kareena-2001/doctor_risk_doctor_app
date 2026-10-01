import 'package:Doctors_App/core/widgets/common_empty_state.dart';
import 'package:Doctors_App/features/appointment/model/appointment_item.dart';
import 'package:Doctors_App/features/appointment/ui/widgets/appointment_card.dart';
import 'package:flutter/material.dart';

class AppointmentListWidget extends StatefulWidget {
  final List<AppointmentItem> appointments;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoadMore;
  final bool hasMore;
  final bool isLoadingMore;
  final String? paginationError;
  final void Function(AppointmentItem) onView;
  final void Function(AppointmentItem) onRemarks;
  final void Function(AppointmentItem) onEdit;
  final void Function(AppointmentItem) onReschedule;
  final void Function(AppointmentItem) onCancel;

  const AppointmentListWidget({
    super.key,
    required this.appointments,
    required this.onRefresh,
    required this.onLoadMore,
    required this.hasMore,
    required this.isLoadingMore,
    this.paginationError,
    required this.onView,
    required this.onRemarks,
    required this.onEdit,
    required this.onReschedule,
    required this.onCancel,
  });

  @override
  State<AppointmentListWidget> createState() => _AppointmentListWidgetState();
}

class _AppointmentListWidgetState extends State<AppointmentListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkForMore);
    _scheduleCheck();
  }

  @override
  void didUpdateWidget(covariant AppointmentListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scheduleCheck();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_checkForMore)
      ..dispose();
    super.dispose();
  }

  void _scheduleCheck() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _checkForMore();
    });
  }

  void _checkForMore() {
    if (!_scrollController.hasClients ||
        !widget.hasMore ||
        widget.isLoadingMore ||
        widget.paginationError != null) {
      return;
    }
    if (_scrollController.position.extentAfter < 200) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.appointments.isEmpty
            ? 1 + _footerCount
            : widget.appointments.length + _footerCount,
        itemBuilder: (_, i) {
          if (widget.appointments.isEmpty && i == 0) {
            return const SizedBox(
              height: 180,
              child: CommonEmptyState(
                icon: Icons.event_busy_rounded,
                title: 'No appointments found',
                message: 'Raise an appointment to get started',
              ),
            );
          }
          if (widget.appointments.isEmpty) return _buildFooter();
          if (i == widget.appointments.length) return _buildFooter();

          final appointment = widget.appointments[i];
          return AppointmentCard(
            appointment: appointment,
            onView: () => widget.onView(appointment),
            onRemarks: appointment.canRemark
                ? () => widget.onRemarks(appointment)
                : null,
            onReschedule: appointment.canReschedule
                ? () => widget.onReschedule(appointment)
                : null,
            onCancel: appointment.canCancel
                ? () => widget.onCancel(appointment)
                : null,
          );
        },
      ),
    );
  }

  int get _footerCount =>
      (widget.hasMore || widget.paginationError != null) ? 1 : 0;

  Widget _buildFooter() {
    if (widget.paginationError != null) {
      return Center(
        child: TextButton(
          onPressed: widget.onLoadMore,
          child: const Text('Could not load more appointments. Tap to retry.'),
        ),
      );
    }
    if (widget.hasMore && widget.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return const SizedBox.shrink();
  }
}
