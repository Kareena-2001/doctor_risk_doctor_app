import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

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
  String _collabSubView =
      'Opportunities'; // Track toggle within Collaborate Tab

  // Base Dataset containing both events and custom user proposals
  final List<Map<String, String>> _events = const [
    {
      "title": "Medico-Legal Awareness Workshop",
      "day": "18",
      "month": "AUG",
      "time": "10:00 AM",
      "location": "Mumbai",
      "type": "Offline",
      "speciality": "General Practice",
      "status": "upcoming",
      "actionType": "register",
    },
    {
      "title": "National Health Summit Partnership",
      "day": "28",
      "month": "AUG",
      "time": "2:00 PM",
      "location": "Delhi Hub",
      "type": "Offline",
      "speciality": "Healthcare Management",
      "status": "collaborate",
      "actionType": "collaborate",
      "collabStatus": "approved", // Moves to Upcoming because it is approved!
    },
    {
      "title": "Regional Rural Clinic Initiative",
      "day": "14",
      "month": "SEP",
      "time": "09:00 AM",
      "location": "Pune Medical Center",
      "type": "Offline",
      "speciality": "Public Health",
      "status": "collaborate",
      "actionType": "collaborate",
      "collabStatus": "pending",
    },
    {
      "title": "Medical Documentation Best Practices",
      "day": "02",
      "month": "JAN",
      "time": "11:30 AM",
      "location": "Delhi Auditorium",
      "type": "Offline",
      "speciality": "Surgery",
      "status": "past",
      "actionType": "know_more",
    },
  ];

  // User's submitted proposals (Simulating historical forms submitted)
  final List<Map<String, String>> _myProposals = const [
    {
      "title": "Community Health Drive Proposal",
      "purpose":
          "To organize free blood pressure checks across local municipal schools.",
      "city": "Mumbai",
      "state": "Maharashtra",
      "status": "pending",
      "date": "14 July 2026",
    },
    {
      "title": "Rural Telemedicine Collaboration",
      "purpose":
          "Setup remote terminal access for specialized pediatric care consults.",
      "city": "Nagpur",
      "state": "Maharashtra",
      "status": "approved",
      "date": "10 July 2026",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Refresh FAB state when switching between structural tabs
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _getFilteredEvents(String activeTab) {
    return _events.where((e) {
      final matchesType = _typeFilter == 'All' || e['type'] == _typeFilter;

      if (activeTab == 'upcoming') {
        return (e['status'] == 'upcoming' ||
                (e['status'] == 'collaborate' &&
                    e['collabStatus'] == 'approved')) &&
            matchesType;
      } else if (activeTab == 'past') {
        return e['status'] == 'past' && matchesType;
      } else {
        return e['status'] == 'collaborate' && matchesType;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: const CustomAppBar(title: "Events Hub"),

      // Floating Action Button rendered strictly when viewing the Collaborate Tab (index == 2)
      floatingActionButton: _tabController.index == 2
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EventCollaborateScreen(
                      event: {"title": "General Proposition"},
                    ),
                  ),
                );
              },
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                "Add Collab",
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

  // Segment View specifically inside the Collaborate Area to separate view / action streams
  Widget _buildCollaborateWorkspace() {
    return Column(
      children: [
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
        //   child: Row(
        //     children: [
        //       _buildSubToggleChip("Opportunities"),
        //       width(Responsive.w(10)),
        //       _buildSubToggleChip("View My Forms"),
        //     ],
        //   ),
        // ),
        // height(Responsive.h(14)),
        Expanded(
          child: _collabSubView == 'Opportunities'
              ? _buildEventList('collaborate')
              : _buildUserProposalsList(),
        ),
      ],
    );
  }

  Widget _buildSubToggleChip(String label) {
    final bool isSelected = _collabSubView == label;
    return GestureDetector(
      onTap: () => setState(() => _collabSubView = label),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.w(14),
          vertical: Responsive.h(8),
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber.shade800 : Colors.white,
          borderRadius: BorderRadius.circular(Responsive.w(12)),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: customTextStyle(
            fontSize: Responsive.sp(12),
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : AppColors.textColor,
          ),
        ),
      ),
    );
  }

  // Renders the list of custom forms sent by the log-in doctor
  Widget _buildUserProposalsList() {
    if (_myProposals.isEmpty) return _buildEmptyState();

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        Responsive.w(16),
        0,
        Responsive.w(16),
        Responsive.h(80),
      ),
      itemCount: _myProposals.length,
      separatorBuilder: (_, __) => height(Responsive.h(14)),
      itemBuilder: (context, index) {
        final form = _myProposals[index];
        final bool isApproved = form['status'] == 'approved';

        return Container(
          padding: EdgeInsets.all(Responsive.w(16)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Responsive.w(16)),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    form['date']!,
                    style: customTextStyle(
                      fontSize: 11,
                      color: AppColors.homeTextMuted,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isApproved
                          ? Colors.green.withValues(alpha: 0.1)
                          : Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      form['status']!.toUpperCase(),
                      style: customTextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isApproved ? Colors.green : Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              height(Responsive.h(8)),
              Text(
                form['title']!,
                style: customTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              height(Responsive.h(4)),
              Text(
                form['purpose']!,
                style: customTextStyle(
                  fontSize: 12,
                  color: AppColors.textColor,
                ),
              ),
              height(Responsive.h(8)),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: AppColors.homeTextMuted,
                  ),
                  width(4),
                  Text(
                    "${form['city']}, ${form['state']}",
                    style: customTextStyle(
                      fontSize: 11,
                      color: AppColors.homeTextMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEventCard(Map<String, String> event, String activeTab) {
    final isOnline = event['type'] == 'Online';
    final isPast = event['status'] == 'past';

    Color accent = isPast
        ? Colors.grey
        : (isOnline ? Colors.green : Colors.blue);
    String buttonText = "Register";
    Color buttonColor = AppColors.newPri;
    VoidCallback onPressedAction = () {};

    if (isPast) {
      buttonText = "Know More";
      buttonColor = Colors.blueGrey;
      onPressedAction = () => _showEventDetailsDialog(event);
    }
    // else if (activeTab == 'collaborate') {
    //   buttonText = "Propose Collaboration";
    //   buttonColor = Colors.amber.shade800;
    //   onPressedAction = () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => EventCollaborateScreen(event: event)),
    //     );
    //   };
    // }
    else {
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
            Container(
              width: Responsive.w(50),
              padding: EdgeInsets.symmetric(vertical: Responsive.h(8)),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isPast
                      ? [Colors.grey.shade400, Colors.grey.shade600]
                      : [AppColors.newPri, AppColors.primary],
                ),
                borderRadius: BorderRadius.circular(Responsive.w(14)),
              ),
              child: Column(
                children: [
                  Text(
                    event['day']!,
                    style: customTextStyle(
                      color: Colors.white,
                      fontSize: Responsive.sp(11),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    event['month']!,
                    style: customTextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: Responsive.sp(10),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            width(Responsive.w(14)),
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
                          event['speciality']!,
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
                      color: isPast ? Colors.grey : AppColors.textColor,
                    ),
                  ),
                  height(Responsive.h(8)),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: Responsive.sp(13),
                        color: AppColors.homeTextMuted,
                      ),
                      width(Responsive.w(4)),
                      Text(
                        event['time']!,
                        style: customTextStyle(
                          fontSize: Responsive.sp(11),
                          color: AppColors.homeTextMuted,
                        ),
                      ),
                      width(Responsive.w(12)),
                      Icon(
                        Icons.place_rounded,
                        size: Responsive.sp(13),
                        color: AppColors.homeTextMuted,
                      ),
                      width(Responsive.w(4)),
                      Expanded(
                        child: Text(
                          event['location']!,
                          overflow: TextOverflow.ellipsis,
                          style: customTextStyle(
                            fontSize: Responsive.sp(11),
                            color: AppColors.homeTextMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                  height(Responsive.h(16)),
                  if (activeTab != 'collaborate')
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            text: buttonText,
                            backgroundColor: buttonColor,
                            fontSize: 12,
                            height: 38,
                            onPressed: onPressedAction,
                          ),
                        ),
                        width(Responsive.w(10)),
                        InkWell(
                          onTap: () =>
                              Share.share('Join initiative: ${event['title']}'),
                          borderRadius: BorderRadius.circular(Responsive.w(12)),
                          child: Container(
                            width: Responsive.w(40),
                            height: Responsive.h(38),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(
                                Responsive.w(12),
                              ),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Icon(
                              Icons.share_outlined,
                              size: Responsive.sp(16),
                              color: AppColors.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
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
