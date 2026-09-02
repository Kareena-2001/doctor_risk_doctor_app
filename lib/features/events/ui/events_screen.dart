import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';
import 'event_collaborate_form.dart';
import 'event_register_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _typeFilter = 'All';

  final List<Map<String, String>> _events = const [
    {
      'title': 'Managing Consent Disputes in Elective Surgery',
      'day': '14',
      'month': 'AUG',
      'date': '14 Aug 2026',
      'time': '5:00 PM IST',
      'type': 'Online',
      'category': 'Informed Consent',
      'price': 'Free — Included in Membership',
      'status': 'registered',
      'eventStatus': 'upcoming',
    },
    {
      'title': 'Telemedicine & the New NMC Circular: What Changes for You',
      'day': '22',
      'month': 'AUG',
      'date': '22 Aug 2026',
      'time': '6:30 PM IST',
      'type': 'Online',
      'category': 'Regulatory',
      'price': 'Free — Included in Membership',
      'status': 'register',
      'eventStatus': 'upcoming',
    },
    {
      'title': 'Advanced Workshop: Defensive Documentation for Surgeons',
      'day': '05',
      'month': 'SEP',
      'date': '05 Sep 2026',
      'time': '10:00 AM IST',
      'type': 'Offline',
      'category': 'Documentation',
      'price': '₹1,499 (Members: 20% off)',
      'status': 'register',
      'eventStatus': 'upcoming',
    },
    {
      'title': 'Annual Medico-Legal Conclave 2026',
      'day': '19',
      'month': 'SEP',
      'date': '19 Sep 2026',
      'time': '9:00 AM IST',
      'type': 'Offline',
      'category': 'Conclave',
      'price': '₹2,999',
      'status': 'register',
      'eventStatus': 'upcoming',
    },
  ];

  final List<Map<String, String>> _pastEvents = const [
    {
      'title': 'Handling Police Visits: A Practical Walkthrough',
      'day': '10',
      'month': 'JUN',
      'date': '10 Jun 2026',
      'time': '',
      'type': 'Online',
      'category': 'Emergency Response',
      'status': 'past',
      'eventStatus': 'past',
      'recording': 'true',
      'certificate': 'true',
    },
    {
      'title': "Bail Cost Coverage — What's Actually Included",
      'day': '22',
      'month': 'MAY',
      'date': '22 May 2026',
      'time': '',
      'type': 'Online',
      'category': 'Coverage',
      'status': 'past',
      'eventStatus': 'past',
      'recording': 'true',
      'certificate': 'true',
    },
    {
      'title': 'Regional Workshop: Clinical Establishment Act Compliance',
      'day': '02',
      'month': 'APR',
      'date': '02 Apr 2026',
      'time': '',
      'type': 'Offline',
      'category': 'Compliance',
      'status': 'past',
      'eventStatus': 'past',
      'recording': 'true',
      'certificate': 'false',
    },
  ];
  final List<Map<String, String>> _collaborationProposals = const [
    {
      'title': 'Joint CME on Surgical Consent — with Apex Hospitals Group',
      'organisation': 'Apex Hospitals Group',
      'date': '18 Jul 2026',
      'status': 'Completed',
    },
    {
      'title': 'Speaker Exchange Proposal — Regional Medical Association',
      'organisation': 'Regional Medical Association',
      'date': 'Submitted 02 Aug 2026',
      'status': 'Under Review',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _getFilteredEvents(String activeTab) {
    final source = activeTab == 'past' ? _pastEvents : _events;

    return source.where((event) {
      final matchesType = _typeFilter == 'All' || event['type'] == _typeFilter;

      if (activeTab == 'upcoming') {
        return event['eventStatus'] == 'upcoming' && matchesType;
      }

      if (activeTab == 'past') {
        return event['eventStatus'] == 'past' && matchesType;
      }

      return event['eventStatus'] == 'collaborate' && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F7FB),
      appBar: CustomAppBar(title: "Events Hub"),
      floatingActionButton: _tabController.index == 2
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventCollaborateScreen(
                      event: {"title": "General Proposition"},
                    ),
                  ),
                );
              },
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                "Add Collaboration",
                style: customTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,

      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.newPri,
              unselectedLabelColor: AppColors.homeTextMuted,
              indicatorColor: AppColors.newPri,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: customTextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Responsive.sp(12),
              ),
              tabs: [
                Tab(text: "Upcoming"),
                Tab(text: "Past Events"),
                Tab(text: "Collaborate"),
              ],
            ),
          ),
          height(Responsive.h(14)),
          if (_tabController.index != 2) ...[
            _buildFilterChips(),
            height(Responsive.h(14)),
          ],
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildEventList('upcoming'),
                _buildEventList('past'),
                _buildCollaborateWorkspace(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final options = ['All', 'Online', 'Offline'];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      child: Row(
        children: options.map((option) {
          final selected = _typeFilter == option;
          return Padding(
            padding: EdgeInsets.only(right: Responsive.w(10)),
            child: GestureDetector(
              onTap: () => setState(() => _typeFilter = option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(16),
                  vertical: Responsive.h(6),
                ),
                decoration: BoxDecoration(
                  gradient: selected
                      ? LinearGradient(
                          colors: [AppColors.newPri, AppColors.primary],
                        )
                      : null,
                  color: selected ? null : Colors.white,
                  borderRadius: BorderRadius.circular(Responsive.w(30)),
                  border: Border.all(
                    color: selected ? Colors.transparent : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  option,
                  style: customTextStyle(
                    fontSize: Responsive.sp(11),
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : AppColors.textColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEventList(String status) {
    final list = _getFilteredEvents(status);
    if (list.isEmpty) return _buildEmptyState();

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        Responsive.w(16),
        0,
        Responsive.w(16),
        Responsive.h(24),
      ),
      itemCount: list.length,
      separatorBuilder: (_, __) => height(Responsive.h(18)),
      itemBuilder: (_, index) => _buildEventCard(list[index], status),
    );
  }

  Widget _buildCollaborateWorkspace() {
    return ListView(
      padding: EdgeInsets.fromLTRB(
        Responsive.w(16),
        0,
        Responsive.w(16),
        Responsive.h(24),
      ),
      children: [
        Container(
          padding: EdgeInsets.all(Responsive.w(16)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Responsive.w(16)),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Want to organise a session with DoctorsRisk — a joint CME, "
                "workshop, or speaker exchange? Propose it below. "
                "You'll earn reward points once the collaboration is confirmed "
                "and successfully completed — even if you're not yet a "
                "DoctorsRisk member.",
                style: customTextStyle(
                  fontSize: Responsive.sp(11),
                  fontWeight: FontWeight.w600,
                  color: AppColors.newPri,
                ),
              ),
            ],
          ),
        ),

        height(Responsive.h(18)),

        ..._collaborationProposals.map(
          (proposal) => Padding(
            padding: EdgeInsets.only(bottom: Responsive.h(14)),
            child: _buildCollaborationCard(proposal),
          ),
        ),
      ],
    );
  }

  Widget _buildCollaborationCard(Map<String, String> proposal) {
    final status = proposal['status'] ?? '';

    final bool isCompleted = status == 'Completed';

    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            proposal['title'] ?? '',
            style: customTextStyle(
              fontSize: Responsive.sp(13),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),

          height(Responsive.h(7)),

          Row(
            children: [
              Icon(
                Icons.business_outlined,
                size: Responsive.sp(14),
                color: AppColors.homeTextMuted,
              ),
              width(Responsive.w(5)),
              Expanded(
                child: Text(
                  '${proposal['organisation']} · ${proposal['date']}',
                  style: customTextStyle(
                    fontSize: Responsive.sp(11),
                    color: AppColors.homeTextMuted,
                  ),
                ),
              ),
            ],
          ),

          height(Responsive.h(10)),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(9),
              vertical: Responsive.h(5),
            ),
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Responsive.w(8)),
            ),
            child: Text(
              status,
              style: customTextStyle(
                fontSize: Responsive.sp(10),
                fontWeight: FontWeight.bold,
                color: isCompleted ? Colors.green : Colors.orange.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, String> event, String activeTab) {
    final isOnline = event['type'] == 'Online';
    final isPast = event['status'] == 'past';

    Color accent = (isOnline ? Colors.blue : Colors.orange);
    String buttonText = "Register";
    Color buttonColor = AppColors.newPri;
    VoidCallback onPressedAction = () {};

    if (isPast) {
      buttonText = "Know More";
      buttonColor = Colors.blueGrey;
      onPressedAction = () => _showEventDetailsDialog(event);
    } else {
      buttonText = "Register";
      buttonColor = AppColors.newPri;
      onPressedAction = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventRegisterScreen(event: event),
          ),
        );
      };
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(22)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Responsive.w(16)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.w(10),
                          vertical: Responsive.h(4),
                        ),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(Responsive.w(20)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isOnline
                                  ? Icons.videocam_rounded
                                  : Icons.location_city_rounded,
                              size: Responsive.sp(12),
                              color: accent,
                            ),
                            width(Responsive.w(4)),
                            Text(
                              event['type']!,
                              style: customTextStyle(
                                color: accent,
                                fontSize: Responsive.sp(10),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      width(Responsive.w(8)),
                      Expanded(
                        child: Text(
                          event['speciality'] ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: customTextStyle(
                            fontSize: Responsive.sp(11),
                            color: AppColors.homeTextMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  height(Responsive.h(10)),
                  Text(
                    event['title']!,
                    style: customTextStyle(
                      fontSize: Responsive.sp(13),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  height(Responsive.h(8)),
                  Wrap(
                    spacing: Responsive.w(6),
                    runSpacing: Responsive.h(4),
                    children: [
                      Text(
                        event['date'] ?? '',
                        style: customTextStyle(
                          fontSize: Responsive.sp(11),
                          color: AppColors.grey,
                        ),
                      ),
                      const Text('·'),
                      Text(
                        event['time'] ?? '',
                        style: customTextStyle(
                          fontSize: Responsive.sp(11),
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  height(Responsive.h(6)),
                  Text(
                    event['category'] ?? '',
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  height(Responsive.h(8)),
                  Text(
                    event['price'] ?? '',
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      fontWeight: FontWeight.bold,
                      color:
                          (event['price'] ?? '').toLowerCase().startsWith(
                            'free',
                          )
                          ? Colors.green
                          : AppColors.textColor,
                    ),
                  ),
                  height(Responsive.h(16)),
                  if (isPast) ...[
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            text: 'Watch Recording',
                            height: 40,
                            borderRadius: 25,
                            fontSize: 12,
                            borderColor: AppColors.grey,
                            backgroundColor: AppColors.white,
                            textColor: AppColors.textColor,
                            onPressed: () {},
                          ),
                        ),

                        if (event['certificate'] == 'true') ...[
                          width(Responsive.w(10)),
                          Expanded(
                            child: PrimaryButton(
                              height: 40,
                              borderRadius: 25,
                              fontSize: 12,
                              borderColor: AppColors.grey,
                              backgroundColor: AppColors.white,
                              textColor: AppColors.textColor,
                              onPressed: () {},
                              text: 'Certificate',
                            ),
                          ),
                        ],
                      ],
                    ),
                  ] else if (activeTab != 'collaborate') ...[
                    if (event['status'] == 'registered') ...[
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: Responsive.sp(16),
                            color: Colors.green,
                          ),
                          width(Responsive.w(5)),
                          Text(
                            "You're registered",
                            style: customTextStyle(
                              fontSize: Responsive.sp(11),
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      PrimaryButton(
                        text: 'Register',
                        backgroundColor: AppColors.newPri,
                        fontSize: 12,
                        height: 40,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EventRegisterScreen(event: event),
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                  // if (activeTab != 'collaborate')
                  //   Row(
                  //     children: [
                  //       Expanded(
                  //         child: PrimaryButton(
                  //           text: buttonText,
                  //           backgroundColor: buttonColor,
                  //           fontSize: 12,
                  //           height: 40,
                  //           onPressed: onPressedAction,
                  //         ),
                  //       ),
                  //       width(Responsive.w(10)),
                  //       InkWell(
                  //         onTap: () =>
                  //             Share.share('Join initiative: ${event['title']}'),
                  //         borderRadius: BorderRadius.circular(Responsive.w(12)),
                  //         child: Container(
                  //           width: Responsive.w(40),
                  //           height: Responsive.h(40),
                  //           decoration: BoxDecoration(
                  //             color: Colors.grey.shade50,
                  //             borderRadius: BorderRadius.circular(
                  //               Responsive.w(12),
                  //             ),
                  //             border: Border.all(
                  //               color: Colors.grey.shade200,
                  //             ),
                  //           ),
                  //           child: Icon(
                  //             Icons.share_outlined,
                  //             size: Responsive.sp(16),
                  //             color: AppColors.textColor,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEventDetailsDialog(Map<String, String> event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          event['title']!,
          style: customTextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Dismiss"),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.layers_clear_outlined,
            size: Responsive.sp(44),
            color: Colors.grey.shade300,
          ),
          height(Responsive.h(12)),
          Text(
            'No items found here.',
            style: customTextStyle(
              fontSize: Responsive.sp(13),
              color: AppColors.homeTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}
