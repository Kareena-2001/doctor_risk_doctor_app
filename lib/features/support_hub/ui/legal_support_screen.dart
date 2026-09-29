import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/support_hub/model/legal_ticket_model.dart';
import 'package:Doctors_App/features/support_hub/model/service_ticket_model.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/common_empty_state.dart';
import '../../../core/widgets/common_error_state.dart';
import 'view_model/support_hub_view_model.dart';
import 'add_legal_ticket_screen.dart';
import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_attachment_field.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/support_hub//model/suppport_enums.dart';
import 'package:Doctors_App/features/support_hub/model/support_ticket_enums.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

const _medicoLegalCallNumber = '+911234567890';
const _legalCallNumber = '+911234567891';

class LegalSupportScreen extends ConsumerStatefulWidget {
  const LegalSupportScreen({super.key});

  @override
  ConsumerState<LegalSupportScreen> createState() => _LegalSupportScreenState();
}

class _LegalSupportScreenState extends ConsumerState<LegalSupportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _statusTabController;
  String _categoryFilter = 'All Categories';

  static const _categories = [
    'All Categories',
    'Legal Consultation',
    'Legal Notice',
    'Legal Case',
  ];

  @override
  void initState() {
    super.initState();
    _statusTabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Legal ticket list needs a doctor id; pass empty for now —
      // the repository call uses the authenticated doctor's id from the token.
      ref
          .read(supportHubViewModelProvider.notifier)
          .fetchLegalTickets(id: '');
    });
  }

  @override
  void dispose() {
    _statusTabController.dispose();
    super.dispose();
  }

  // ── helpers ───────────────────────────────────────────────────────────────

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

  bool _categoryMatches(LegalTicket t) {
    final legalType = (t.legalType ?? '').toLowerCase();
    switch (_categoryFilter) {
      case 'Legal Consultation':
        return legalType.contains('consultation');
      case 'Legal Notice':
        return legalType.contains('notice');
      case 'Legal Case':
        return legalType.contains('case');
      default:
        return true;
    }
  }

  List<LegalTicket> _filtered(
    List<LegalTicket> all,
    bool Function(TicketStatus) match,
  ) =>
      all
          .where(
              (t) => _categoryMatches(t) && match(_parseStatus(t.ticketStatus)))
          .toList();

  // ── actions ───────────────────────────────────────────────────────────────

  Future<void> _callNow(bool isMedicoLegal) async {
    final uri = Uri.parse(
        'tel:${isMedicoLegal ? _medicoLegalCallNumber : _legalCallNumber}');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _openAddTicket() async {
    final submitted = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const AddLegalTicketScreen()),
    );
    if (submitted == true) {
      ref
          .read(supportHubViewModelProvider.notifier)
          .fetchLegalTickets(id: '');
    }
  }

  Future<void> _cancelTicket(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Ticket'),
        content: const Text(
            'Are you sure you want to cancel this legal support ticket?'),
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
        if (ok) {
          context.showSuccessSnackBar('Ticket cancelled successfully');
        } else {
          context.showErrorSnackBar('Failed to cancel ticket');
        }
      }
    }
  }

  Future<void> _editTicket(LegalTicket ticket) async {
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

  void _showRemarks(LegalTicket ticket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _LegalRemarksSheet(
        ticket: ticket,
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

    if (state.isFetchingLegalTickets) {
      return Scaffold(
        appBar: CustomAppBar(title: 'Legal Support'),
        body: const Loading(),
      );
    }

    if (state.legalTicketsError != null && state.legalTickets == null) {
      return Scaffold(
        appBar: CustomAppBar(title: 'Legal Support'),
        body: CommonErrorState(
          icon: Icons.error_outline,
          title: 'Failed to load tickets',
          message: state.legalTicketsError!,
          onRetry: () => ref
              .read(supportHubViewModelProvider.notifier)
              .fetchLegalTickets(id: ''),
          buttonText: 'Retry',
        ),
      );
    }

    final tickets = state.legalTickets?.data.tickets ?? [];

    return Scaffold(
      appBar: CustomAppBar(title: 'Legal Support'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddTicket,
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Raise Ticket',
          style: customTextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref
            .read(supportHubViewModelProvider.notifier)
            .fetchLegalTickets(id: ''),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Legal Tickets', style: AppTheme.title14),
              height(12),
              _chipRow(
                options: _categories,
                selected: _categoryFilter,
                onSelected: (v) => setState(() => _categoryFilter = v),
              ),
              height(8),
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
                        'Open (${_filtered(tickets, (s) => s.isOpenish).length})',
                  ),
                  Tab(
                    text:
                        'Closed (${_filtered(tickets, (s) => s == TicketStatus.closed).length})',
                  ),
                  Tab(
                    text:
                        'Cancelled (${_filtered(tickets, (s) => s == TicketStatus.cancelled).length})',
                  ),
                ],
              ),
              height(12),
              Expanded(
                child: TabBarView(
                  controller: _statusTabController,
                  children: [
                    _ticketList(tickets),
                    _ticketList(_filtered(tickets, (s) => s.isOpenish)),
                    _ticketList(
                        _filtered(tickets, (s) => s == TicketStatus.closed)),
                    _ticketList(_filtered(
                        tickets, (s) => s == TicketStatus.cancelled)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chipRow({
    required List<String> options,
    required String selected,
    required void Function(String) onSelected,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((o) {
          final isSelected = o == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(o),
              selected: isSelected,
              backgroundColor: Colors.white,
              selectedColor: AppColors.primary.withValues(alpha: 0.9),
              labelStyle: customTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.textColor,
              ),
              side: BorderSide(
                color:
                    isSelected ? AppColors.primary : Colors.grey.shade300,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 0,
              pressElevation: 0,
              onSelected: (_) => onSelected(o),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _ticketList(List<LegalTicket> tickets) {
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
        return _LegalTicketCard(
          ticket: t,
          ticketStatus: _parseStatus(t.ticketStatus),
          onView: () => _showTicketDetail(t),
          onRemarks: t.actions.remark ? () => _showRemarks(t) : null,
          onEdit: t.actions.edit ? () => _editTicket(t) : null,
          onCancel: t.actions.cancel ? () => _cancelTicket(t.id) : null,
        );
      },
    );
  }

  void _showTicketDetail(LegalTicket t) {
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
                _LegalStatusBadge(ticketStatus: t.ticketStatus),
              ],
            ),
            height(16),
            _dr('Type', t.queryType),
            if (t.commonQuery != null) _dr('Query', t.commonQuery!),
            if (t.legalType != null) _dr('Legal Type', t.legalType!),
            _dr('Priority', t.priority),
            _dr('Raised', t.createdOn),
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

  Widget _dr(String label, String value) => Padding(
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

// ── legal ticket card ─────────────────────────────────────────────────────────

class _LegalTicketCard extends StatelessWidget {
  final LegalTicket ticket;
  final TicketStatus ticketStatus;
  final VoidCallback onView;
  final VoidCallback? onRemarks;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;

  const _LegalTicketCard({
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
            color: (isDark ? Colors.black : Colors.grey.shade300)
                .withValues(alpha: 0.25),
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
              _LegalStatusBadge(ticketStatus: ticket.ticketStatus),
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
          if (ticket.legalType != null) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                ticket.legalType!,
                style: customTextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
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
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
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

  Widget _actionBtn(String label, VoidCallback onPressed, {Color? color}) =>
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
        child: Text(label, style: customTextStyle(color: color)),
      );
}

// ── legal status badge ────────────────────────────────────────────────────────

class _LegalStatusBadge extends StatelessWidget {
  final String ticketStatus;
  const _LegalStatusBadge({required this.ticketStatus});

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
          Text(s.label,
              style: customTextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: s.color)),
        ],
      ),
    );
  }
}

// ── legal remarks sheet ───────────────────────────────────────────────────────

class _LegalRemarksSheet extends StatefulWidget {
  final LegalTicket ticket;
  final Future<List> Function() onLoad;
  final Future<void> Function(String) onSend;

  const _LegalRemarksSheet({
    required this.ticket,
    required this.onLoad,
    required this.onSend,
  });

  @override
  State<_LegalRemarksSheet> createState() => _LegalRemarksSheetState();
}

class _LegalRemarksSheetState extends State<_LegalRemarksSheet> {
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
        left: 16,
        right: 16,
        top: 16,
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
