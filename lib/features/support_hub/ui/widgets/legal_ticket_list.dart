import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/widgets/common_empty_state.dart';
import 'package:Doctors_App/features/support_hub/model/ticket_item.dart';
import 'package:Doctors_App/features/support_hub/ui/widgets/legal_ticket_card.dart';
import 'package:flutter/material.dart';

class LegalTicketList extends StatefulWidget {
  final List<TicketItem> tickets;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoadMore;
  final bool hasMore;
  final bool isLoadingMore;
  final String? paginationError;
  final void Function(TicketItem) onView;
  final void Function(TicketItem) onRemarks;
  final void Function(TicketItem) onEdit;
  final void Function(TicketItem) onCancel;

  const LegalTicketList({
    super.key,
    required this.tickets,
    required this.onRefresh,
    required this.onLoadMore,
    required this.hasMore,
    required this.isLoadingMore,
    this.paginationError,
    required this.onView,
    required this.onRemarks,
    required this.onEdit,
    required this.onCancel,
  });

  @override
  State<LegalTicketList> createState() => _LegalTicketListState();
}

class _LegalTicketListState extends State<LegalTicketList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkForMore);
    _scheduleCheck();
  }

  @override
  void didUpdateWidget(covariant LegalTicketList oldWidget) {
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
        itemCount: widget.tickets.isEmpty
            ? 1 + _footerCount
            : widget.tickets.length + _footerCount,
        itemBuilder: (_, i) {
          if (widget.tickets.isEmpty && i == 0) {
            return SizedBox(
              height: Responsive.h(180),
              child: const CommonEmptyState(
                icon: Icons.confirmation_number_outlined,
                title: 'No tickets found',
                message: 'Raise a ticket to get started',
              ),
            );
          }
          if (widget.tickets.isEmpty) return _buildFooter();
          if (i == widget.tickets.length) return _buildFooter();

          final ticket = widget.tickets[i];
          return LegalTicketCard(
            ticket: ticket,
            onView: () => widget.onView(ticket),
            onRemarks: ticket.canRemark ? () => widget.onRemarks(ticket) : null,
            onEdit: ticket.canEdit ? () => widget.onEdit(ticket) : null,
            onCancel: ticket.canCancel ? () => widget.onCancel(ticket) : null,
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
          child: Text('Could not load more tickets. Tap to retry.'),
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
