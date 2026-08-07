import 'package:Doctors_App/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/common_empty_state.dart';
import '../../../theme/app_colors.dart';
import '../../common/ui/widgets/loading.dart';
import '../model/service_ticket_model.dart';
import 'add_legal_ticket_screen.dart';
import 'widgets/ticket_widgets.dart';

const _medicoLegalCallNumber = '+911234567890';
const _legalCallNumber = '+911234567891';

class LegalSupportScreen extends StatefulWidget {
  const LegalSupportScreen({super.key});

  @override
  State<LegalSupportScreen> createState() => _LegalSupportScreenState();
}

class _LegalSupportScreenState extends State<LegalSupportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _statusTabController;
  String _categoryFilter = 'All Categories';
  bool _isLoading = true;
  List<SupportTicket> _tickets = [];

  static const _priorities = ['Normal', 'High', 'Urgent'];
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
          ref: 'LS-2026-0146',
          typeLabel:
              'Register / Request a Query — Query on Consent Form Wording',
          category: 'Consultation',
          priority: 'Normal',
          status: TicketStatus.open,
          description:
              'Need clarification on consent wording for a new procedure.',
          raisedAt: DateTime.now().subtract(const Duration(hours: 5)),
        ),
        SupportTicket(
          ref: 'LS-2026-0142',
          typeLabel: 'Book Appointment — Case Discussion',
          category: 'Case',
          priority: 'High',
          status: TicketStatus.inProgress,
          description: 'Appointment booked to discuss an ongoing case.',
          raisedAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        SupportTicket(
          ref: 'LS-2026-0139',
          typeLabel:
              'On‑Call Support — Emergency — Police at Clinic / Hospital',
          category: 'Consultation',
          priority: 'Urgent',
          status: TicketStatus.escalated,
          description:
              'Immediate guidance needed — police visited the clinic today.',
          raisedAt: DateTime.now().subtract(const Duration(hours: 20)),
        ),
        SupportTicket(
          ref: 'LS-2026-0151',
          typeLabel:
              'Register / Request a Query — Notice Received — Need to Reply',
          category: 'Notice',
          priority: 'High',
          status: TicketStatus.open,
          description: "Legal notice received from patient's family.",
          raisedAt: DateTime.now().subtract(const Duration(hours: 15)),
        ),
        SupportTicket(
          ref: 'LS-2026-0098',
          typeLabel: 'Register / Request a Query — Documentation Request',
          category: 'Consultation',
          priority: 'Normal',
          status: TicketStatus.closed,
          description: 'Query on medical record audit process — resolved.',
          raisedAt: DateTime.now().subtract(const Duration(days: 17)),
        ),
        SupportTicket(
          ref: 'LS-2026-0071',
          typeLabel: 'Book Appointment — Document Review',
          category: 'Case',
          priority: 'High',
          status: TicketStatus.cancelled,
          description: 'Appointment request — no longer needed.',
          raisedAt: DateTime.now().subtract(const Duration(days: 25)),
        ),
      ];
    });
  }

  List<SupportTicket> _filtered(bool Function(TicketStatus) statusMatch) {
    return _tickets.where((t) {
      final catOk =
          _categoryFilter == 'All Categories' ||
          (_categoryFilter == 'Legal Consultation' &&
              t.category == 'Consultation') ||
          (_categoryFilter == 'Legal Notice' && t.category == 'Notice') ||
          (_categoryFilter == 'Legal Case' && t.category == 'Case');
      return catOk && statusMatch(t.status);
    }).toList();
  }

  Future<void> _callNow(bool isMedicoLegal) async {
    final uri = Uri.parse(
      'tel:${isMedicoLegal ? _medicoLegalCallNumber : _legalCallNumber}',
    );
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _openAddTicket() async {
    final ticket = await Navigator.push<SupportTicket>(
      context,
      MaterialPageRoute(builder: (_) => const AddLegalTicketScreen()),
    );
    if (ticket != null) {
      setState(() {
        _tickets.insert(0, ticket);
        _categoryFilter = 'All Categories';
        _statusTabController.animateTo(0);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Legal ticket raised — reference #${ticket.ref}'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Legal Support'),

      body: _isLoading
          ? const Loading()
          : Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Medico‑legal queries, notices, negligence allegations, consultations and appointment booking.',
                  //   style: AppTheme.label12,
                  // ),
                  // height(14),
                  // _infoBanner(
                  //   'Support is included with your membership — Legal Support is non‑payable, based on your plan type.',
                  // ),
                  // height(16),
                  // _quickCallCard(),
                  // height(24),
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
                      Tab(text: 'All (${_tickets.length})'),
                      Tab(
                        text: 'Open (${_filtered((s) => s.isOpenish).length})',
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
                  Expanded(
                    child: TabBarView(
                      controller: _statusTabController,
                      children: [
                        _ticketList(_filtered((_) => true)),
                        _ticketList(_filtered((s) => s.isOpenish)),
                        _ticketList(_filtered((s) => s == TicketStatus.closed)),
                        _ticketList(
                          _filtered((s) => s == TicketStatus.cancelled),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
    );
  }

  Widget _infoBanner(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 20),
          width(10),
          Expanded(child: Text(text, style: AppTheme.label12)),
        ],
      ),
    );
  }

  Widget _quickCallCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.support_agent_rounded, color: AppColors.newPri),
          ),
          width(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Need to talk right now?', style: AppTheme.title14),
                height(2),
                Text(
                  'Emergency? Call our on-call line directly.',
                  style: AppTheme.label12,
                ),
              ],
            ),
          ),
          PopupMenuButton<bool>(
            onSelected: _callNow,
            itemBuilder: (_) => const [
              PopupMenuItem(value: true, child: Text('Medico‑Legal Line')),
              PopupMenuItem(value: false, child: Text('Legal Line')),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.newPri,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Call Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
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
              label: Text(o, style: customTextStyle(fontSize: 12)),
              selected: isSelected,
              selectedColor: AppColors.primary.withValues(alpha: 0.15),
              onSelected: (_) => onSelected(o),
            ),
          );
        }).toList(),
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
