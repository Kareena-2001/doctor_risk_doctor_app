import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/common_empty_state.dart';
import 'package:Doctors_App/core/widgets/common_error_state.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/support_hub/model/service_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/ui/add_service_ticket_screen.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view_model/support_hub_view_model.dart';

class ServiceSupportScreen extends ConsumerStatefulWidget {
  const ServiceSupportScreen({super.key});

  @override
  ConsumerState<ServiceSupportScreen> createState() =>
      _ServiceSupportScreenState();
}

class _ServiceSupportScreenState extends ConsumerState<ServiceSupportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _statusTabController;

  @override
  void initState() {
    super.initState();
    _statusTabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(supportHubViewModelProvider.notifier).fetchServiceTickets();
    });
  }

  @override
  void dispose() {
    _statusTabController.dispose();
    super.dispose();
  }

  // ── helpers ──────────────────────────────────────────────────────────────

  TicketStatus _parseStatus(String raw) {
    switch (raw.toLowerCase().replaceAll(' ', '')) {
      case 'open':
        return TicketStatus.open;
      case 'inprogress':
        return TicketStatus.inProgress;
      case 'escalated':
        return TicketStatus.escalated;
      case 'closed':
        return TicketStatus.closed;
      case 'cancelled':
        return TicketStatus.cancelled;
      default:
        return TicketStatus.open;
    }
  }

  List<ServiceTicket> _filterByStatus(
    List<ServiceTicket> all,
    bool Function(TicketStatus) match,
  ) =>
      all.where((t) => match(_parseStatus(t.ticketStatus))).toList();

  // ── actions ───────────────────────────────────────────────────────────────

  Future<void> _openAddTicket() async {
    final submitted = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const AddServiceTicketScreen()),
    );
    if (submitted == true) {
      ref.read(supportHubViewModelProvider.notifier).fetchServiceTickets();
    }
  }

  Future<void> _cancelTicket(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Ticket'),
        content:
            const Text('Are you sure you want to cancel this support ticket?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Yes, Cancel',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      final ok = await ref
          .read(supportHubViewModelProvider.notifier)
          .cancelTicket(id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ok ? 'Ticket cancelled' : 'Failed to cancel ticket'),
          ),
        );
      }
    }
  }

  Future<void> _editTicket(ServiceTicket ticket) async {
    final descCtrl =
        TextEditingController(text: ticket.description ?? '');
    String priority = ticket.priority;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit Ticket · ${ticket.ticketNo}',
                  style: AppTheme.title16),
              height(16),
              DropdownButtonFormField<String>(
                initialValue: priority,
                decoration: const InputDecoration(labelText: 'Priority'),
                items: ['Low', 'Medium', 'High', 'Urgent']
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (v) => setSheet(() => priority = v ?? priority),
              ),
              height(12),
              TextField(
                controller: descCtrl,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              height(20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(ctx);
                    await ref
                        .read(supportHubViewModelProvider.notifier)
                        .updateTicket(
                          id: ticket.id.toString(),
                          description: descCtrl.text.trim(),
                          priority: priority,
                        );
                  },
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRemarks(ServiceTicket ticket) {
    final remarksState =
        ref.read(supportHubViewModelProvider).ticketRemarks;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _RemarksSheet(
        ticket: ticket,
        initialRemarks: remarksState?.data.remarks ?? [],
        onLoad: () async {
          await ref
              .read(supportHubViewModelProvider.notifier)
              .fetchRemarks(id: ticket.id.toString());
          return ref
                  .read(supportHubViewModelProvider)
                  .ticketRemarks
                  ?.data
                  .remarks ??
              [];
        },
        onSend: (text) async {
          await ref
              .read(supportHubViewModelProvider.notifier)
              .addRemark(
                ticketId: ticket.id.toString(),
                remark: text,
              );
        },
      ),
    );
  }

  // ── build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(supportHubViewModelProvider);

    if (state.isFetchingServiceTickets) {
      return Scaffold(
        appBar: CustomAppBar(title: 'Service Support'),
        body: const Loading(),
      );
    }

    if (state.serviceTicketsError != null && state.serviceTickets == null) {
      return Scaffold(
        appBar: CustomAppBar(title: 'Service Support'),
        body: CommonErrorState(
          icon: Icons.error_outline,
          title: 'Failed to load tickets',
          message: state.serviceTicketsError!,
          onRetry: () =>
              ref
                  .read(supportHubViewModelProvider.notifier)
                  .fetchServiceTickets(),
          buttonText: 'Retry',
        ),
      );
    }

    final tickets = state.serviceTickets?.data.tickets ?? [];

    return Scaffold(
      appBar: CustomAppBar(title: 'Service Support'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddTicket,
        backgroundColor: AppColors.newPri,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Raise Ticket',
          style: customTextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref
                .read(supportHubViewModelProvider.notifier)
                .fetchServiceTickets(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                controller: _statusTabController,
                isScrollable: true,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.primary,
                tabs: [
                  Tab(text: 'All (${tickets.length})'),
                  Tab(
                    text:
                        'Open (${_filterByStatus(tickets, (s) => s.isOpenish).length})',
                  ),
                  Tab(
                    text:
                        'Closed (${_filterByStatus(tickets, (s) => s == TicketStatus.closed).length})',
                  ),
                  Tab(
                    text:
                        'Cancelled (${_filterByStatus(tickets, (s) => s == TicketStatus.cancelled).length})',
                  ),
                ],
              ),
              height(12),
              Expanded(
                child: TabBarView(
                  controller: _statusTabController,
                  children: [
                    _ticketList(tickets),
                    _ticketList(
                      _filterByStatus(tickets, (s) => s.isOpenish),
                    ),
                    _ticketList(
                      _filterByStatus(
                          tickets, (s) => s == TicketStatus.closed),
                    ),
                    _ticketList(
                      _filterByStatus(
                          tickets, (s) => s == TicketStatus.cancelled),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ticketList(List<ServiceTicket> tickets) {
    if (tickets.isEmpty) {
      return const CommonEmptyState(
        icon: Icons.inbox_rounded,
        title: 'No tickets found',
        message: 'Raise a ticket to get started',
      );
    }
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (context, i) {
        final t = tickets[i];
        final tStatus = _parseStatus(t.ticketStatus);
        final isEditable = t.actions.edit;
        final isCancellable = t.actions.cancel;

        return _ServiceTicketCard(
          ticket: t,
          ticketStatus: tStatus,
          onView: () => _showTicketDetail(t),
          onRemarks: t.actions.remark ? () => _showRemarks(t) : null,
          onEdit: isEditable ? () => _editTicket(t) : null,
          onCancel: isCancellable ? () => _cancelTicket(t.id) : null,
        );
      },
    );
  }

  void _showTicketDetail(ServiceTicket t) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(t.ticketNo, style: AppTheme.title16),
                width(10),
                _StatusBadge(ticketStatus: t.ticketStatus),
              ],
            ),
            height(16),
            _detailRow('Type', t.queryType),
            if (t.commonQuery != null) _detailRow('Query', t.commonQuery!),
            _detailRow('Priority', t.priority),
            _detailRow('Raised', t.createdOn),
            if (t.description != null) ...[ 
              height(10),
              Text('Description', style: AppTheme.title14),
              height(4),
              Text(t.description!, style: AppTheme.label12),
            ],
            height(20),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 90,
              child: Text(label,
                  style: customTextStyle(fontSize: 12, color: Colors.grey)),
            ),
            Expanded(
              child: Text(value,
                  style: customTextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );
}

// ── ticket card ─────────────────────────────────────────────────────────────

class _ServiceTicketCard extends StatelessWidget {
  final ServiceTicket ticket;
  final TicketStatus ticketStatus;
  final VoidCallback onView;
  final VoidCallback? onRemarks;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;

  const _ServiceTicketCard({
    required this.ticket,
    required this.ticketStatus,
    required this.onView,
    this.onRemarks,
    this.onEdit,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ticketStatus.color.withValues(alpha: 0.3),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color:
                (isDark ? Colors.black : Colors.grey.shade300).withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _StatusBadge(ticketStatus: ticket.ticketStatus),
              const Spacer(),
              Text(
                ticket.ticketNo,
                style: customTextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? Colors.grey.shade500
                      : Colors.grey.shade600,
                ),
              ),
            ],
          ),
          height(10),
          Text(
            ticket.queryType,
            style: customTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (ticket.commonQuery != null) ...[
            height(2),
            Text(
              ticket.commonQuery!,
              style: customTextStyle(
                fontSize: 11,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
          ],
          height(4),
          Text(
            '${ticket.priority} Priority',
            style: customTextStyle(
              fontSize: 11,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          if (ticket.description != null) ...[
            height(6),
            Text(
              ticket.description!,
              style: customTextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          height(5),
          Divider(
              color:
                  isDark ? Colors.grey.shade800 : Colors.grey.shade200),
          Wrap(
            spacing: 10,
            runSpacing: 4,
            children: [
              _actionBtn('View', onView),
              if (onRemarks != null) _actionBtn('Remarks', onRemarks!),
              if (onEdit != null) _actionBtn('Edit', onEdit!),
              if (onCancel != null)
                _actionBtn('Cancel', onCancel!,
                    color: Colors.red.shade400),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(String label, VoidCallback onPressed,
      {Color? color}) =>
      TextButton(
        style: TextButton.styleFrom(
          side: BorderSide(
              color: AppColors.fieldGrey.withValues(alpha: 0.6)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
        onPressed: onPressed,
        child: Text(label,
            style: customTextStyle(color: color)),
      );
}

// ── status badge ─────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String ticketStatus;
  const _StatusBadge({required this.ticketStatus});

  TicketStatus get _status {
    switch (ticketStatus.toLowerCase().replaceAll(' ', '')) {
      case 'open':
        return TicketStatus.open;
      case 'inprogress':
        return TicketStatus.inProgress;
      case 'escalated':
        return TicketStatus.escalated;
      case 'closed':
        return TicketStatus.closed;
      case 'cancelled':
        return TicketStatus.cancelled;
      default:
        return TicketStatus.open;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _status;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: s.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(s.icon, size: 14, color: s.color),
          width(6),
          Text(
            s.label,
            style: customTextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: s.color),
          ),
        ],
      ),
    );
  }
}

// ── remarks sheet ─────────────────────────────────────────────────────────────

class _RemarksSheet extends StatefulWidget {
  final ServiceTicket ticket;
  final List initialRemarks;
  final Future<List> Function() onLoad;
  final Future<void> Function(String) onSend;

  const _RemarksSheet({
    required this.ticket,
    required this.initialRemarks,
    required this.onLoad,
    required this.onSend,
  });

  @override
  State<_RemarksSheet> createState() => _RemarksSheetState();
}

class _RemarksSheetState extends State<_RemarksSheet> {
  final _ctrl = TextEditingController();
  List _remarks = [];
  bool _loading = true;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final result = await widget.onLoad();
    if (mounted) setState(() { _remarks = result; _loading = false; });
  }

  Future<void> _send() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() => _sending = true);
    await widget.onSend(text);
    _ctrl.clear();
    final result = await widget.onLoad();
    if (mounted) setState(() { _remarks = result; _sending = false; });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16, right: 16, top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${widget.ticket.ticketNo} · Remarks',
                    style: AppTheme.title16,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _remarks.isEmpty
                      ? Center(
                          child: Text(
                            'No remarks yet — start the conversation below.',
                            style: AppTheme.label12,
                          ),
                        )
                      : ListView.builder(
                          itemCount: _remarks.length,
                          itemBuilder: (_, i) {
                            final r = _remarks[i];
                            // r is a TicketRemark freezed object
                            final isTeam = r.ticketStatus != 'open';
                            return Align(
                              alignment: isTeam
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.all(12),
                                constraints:
                                    const BoxConstraints(maxWidth: 280),
                                decoration: BoxDecoration(
                                  color: isTeam
                                      ? Colors.grey.shade100
                                      : AppColors.primary
                                          .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isTeam ? 'Support Team' : 'You',
                                      style: customTextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    height(4),
                                    Text(r.remark,
                                        style: AppTheme.label12),
                                    Text(r.dateTime,
                                        style: customTextStyle(
                                            fontSize: 10,
                                            color: Colors.grey)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
            height(8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: const InputDecoration(
                      hintText: 'Write a remark…',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                width(8),
                _sending
                    ? const SizedBox(
                        width: 36,
                        height: 36,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : IconButton(
                        onPressed: _send,
                        icon: Icon(Icons.send_rounded,
                            color: AppColors.newPri),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
