import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/events/ui/widget/collaborate_tab.dart';
import 'package:Doctors_App/features/events/ui/widget/event_list_tab.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';

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
      backgroundColor: context.primaryBackgroundColor,
      appBar: CustomAppBar(title: "Events Hub"),
      floatingActionButton: _tabController.index == 2
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.newPri, AppColors.primary],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    context.push(Routes.addCollaboration);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.w(16),
                      vertical: Responsive.h(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add, color: Colors.white),
                        width(Responsive.w(8)),
                        Text(
                          "Add Collaboration",
                          style: customTextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : null,
      body: Column(
        children: [
          Container(
            color: context.secondaryBackgroundColor,
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
              tabs: const [
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
                EventListTab(
                  events: _getFilteredEvents('upcoming'),
                  activeTab: 'upcoming',
                ),
                EventListTab(
                  events: _getFilteredEvents('past'),
                  activeTab: 'past',
                ),
                const CollaborateTab(),
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
                  color: selected ? null : context.secondaryWidgetColor,
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
}
