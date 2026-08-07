import 'package:Doctors_App/features/helpdesk/model/service_ticket_model.dart';
import 'package:Doctors_App/features/helpdesk/ui/add_service_ticket_screen.dart';
import 'package:Doctors_App/features/helpdesk/ui/widgets/ticket_widgets.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/common_empty_state.dart';
import '../../../../theme/app_colors.dart';
import '../../common/ui/widgets/loading.dart';

class ServiceSupportScreen extends StatefulWidget {
  const ServiceSupportScreen({super.key});

  @override
  State<ServiceSupportScreen> createState() => _ServiceSupportScreenState();
}

class _ServiceSupportScreenState extends State<ServiceSupportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _statusTabController;
  bool _isLoading = true;
  List<SupportTicket> _tickets = [];

  static const _priorities = ['Normal', 'High', 'Urgent'];

  @override
  void initState() {
    super.initState();
    _statusTabController = TabController(length: 4, vsync: this);
    _loadTickets();
  }

  @override
  void dispose() {
    _statusTabController.dispose();
    super.dispose();
  }

  Future<void> _loadTickets() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() {
      _isLoading = false;
      _tickets = [
        SupportTicket(
          ref: 'SS-2026-0101',
          typeLabel: 'Renewal — Grace Period Query',
          priority: 'Normal',
          status: TicketStatus.open,
          description: 'Need help updating my clinic address on file.',
          raisedAt: DateTime.now().subtract(const Duration(hours: 10)),
        ),
        SupportTicket(
          ref: 'SS-2026-0098',
          typeLabel: 'Renewal — Grace Period Query',
          priority: 'Normal',
          status: TicketStatus.inProgress,
          description: 'Renewal query regarding grace period surcharge.',
          raisedAt: DateTime.now().subtract(const Duration(hours: 80)),
        ),
        SupportTicket(
          ref: 'SS-2026-0055',
          typeLabel: 'Documents — Medical Reg. Certificate Update',
          priority: 'Normal',
          status: TicketStatus.closed,
          description: 'Document update request — completed.',
          raisedAt: DateTime.now().subtract(const Duration(days: 21)),
        ),
        SupportTicket(
          ref: 'SS-2026-0040',
          typeLabel: 'Payments — Refund Status',
          priority: 'High',
          status: TicketStatus.cancelled,
          description: 'Payment query — resolved outside ticket.',
          raisedAt: DateTime.now().subtract(const Duration(days: 29)),
        ),
      ];
    });
  }

  List<SupportTicket> _filtered(bool Function(TicketStatus) statusMatch) =>
      _tickets.where((t) => statusMatch(t.status)).toList();

  Future<void> _openAddTicket() async {
    final ticket = await Navigator.push<SupportTicket>(
      context,
      MaterialPageRoute(builder: (_) => const AddServiceTicketScreen()),
    );
    if (ticket != null) {
      setState(() {
        _tickets.insert(0, ticket);
        _statusTabController.animateTo(0);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Service ticket raised — reference #${ticket.ref}'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: _isLoading
          ? const Loading()
          : RefreshIndicator(
              onRefresh: _loadTickets,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Admin & customer service — renewals, documents, payments, endorsements, upgrades and membership clarifications.',
                      style: AppTheme.label12,
                    ),
                    height(20),
                    Text('My Service Tickets', style: AppTheme.title16),
                    height(12),
                    TabBar(
                      controller: _statusTabController,
                      isScrollable: true,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: AppColors.primary,
                      tabs: [
                        Tab(text: 'All (${_tickets.length})'),
                        Tab(
                          text:
                              'Open (${_filtered((s) => s.isOpenish).length})',
                        ),
                        Tab(
                          text:
                              'Closed (${_filtered((s) => s == TicketStatus.closed).length})',
                        ),
                        Tab(
                          text:
                              'Cancelled (${_filtered((s) => s == TicketStatus.cancelled).length})',
                        ),
                      ],
                    ),
                    height(12),
                    SizedBox(
                      height: 520,
                      child: TabBarView(
                        controller: _statusTabController,
                        children: [
                          _ticketList(_filtered((_) => true)),
                          _ticketList(_filtered((s) => s.isOpenish)),
                          _ticketList(
                            _filtered((s) => s == TicketStatus.closed),
                          ),
                          _ticketList(
                            _filtered((s) => s == TicketStatus.cancelled),
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

  Widget _ticketList(List<SupportTicket> tickets) {
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
        return TicketCard(
          ticket: t,
          onView: () => showTicketDetailSheet(context, t),
          onRemarks: () => showRemarksSheet(context, t, (msg) {
            setState(() {
              t.remarks.add(
                TicketRemark(
                  author: 'You',
                  isTeam: false,
                  timestamp: DateTime.now(),
                  message: msg,
                ),
              );
            });
          }),
          onEdit: !t.isEditable
              ? null
              : () => showTicketEditSheet(context, t, _priorities, (
                  priority,
                  desc,
                ) {
                  setState(() {
                    final idx = _tickets.indexOf(t);
                    _tickets[idx] = SupportTicket(
                      ref: t.ref,
                      typeLabel: t.typeLabel,
                      category: t.category,
                      priority: priority,
                      status: t.status,
                      description: desc,
                      raisedAt: t.raisedAt,
                      remarks: t.remarks,
                    );
                  });
                }),
          onCancel: !t.isEditable
              ? null
              : () => setState(() => t.status = TicketStatus.cancelled),
        );
      },
    );
  }
}
