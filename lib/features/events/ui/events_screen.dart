import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

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

class _EventsScreenState extends State<EventsScreen> {
  String _filter = 'All';

  final List<Map<String, String>> _events = const [
    {
      "title": "Medico-Legal Awareness Workshop",
      "day": "18",
      "month": "AUG",
      "time": "10:00 AM",
      "location": "Mumbai",
      "type": "Offline",
      "speciality": "General Practice",
    },
    {
      "title": "Professional Indemnity Insurance Webinar",
      "day": "25",
      "month": "AUG",
      "time": "4:00 PM",
      "location": "Zoom Meeting",
      "type": "Online",
      "speciality": "All Specialities",
    },
    {
      "title": "Medical Documentation Best Practices",
      "day": "02",
      "month": "SEP",
      "time": "11:30 AM",
      "location": "Delhi",
      "type": "Offline",
      "speciality": "Surgery",
    },
    {
      "title": "Managing Patient Complaints Effectively",
      "day": "10",
      "month": "SEP",
      "time": "3:00 PM",
      "location": "Google Meet",
      "type": "Online",
      "speciality": "General Practice",
    },
  ];

  List<Map<String, String>> get _filteredEvents {
    if (_filter == 'All') return _events;
    return _events.where((e) => e['type'] == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredEvents;

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: const CustomAppBar(title: "Events & Learning"),
      body: Column(
        children: [
          height(Responsive.h(16)),
          _buildFilterChips(),
          height(Responsive.h(16)),
          Expanded(
            child: filtered.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: EdgeInsets.fromLTRB(
                      Responsive.w(16),
                      0,
                      Responsive.w(16),
                      Responsive.h(24),
                    ),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => height(Responsive.h(18)),
                    itemBuilder: (_, index) => _buildEventCard(filtered[index]),
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
          final selected = _filter == option;
          return Padding(
            padding: EdgeInsets.only(right: Responsive.w(10)),
            child: GestureDetector(
              onTap: () => setState(() => _filter = option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(18),
                  vertical: Responsive.h(10),
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
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: AppColors.newPri.withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  option,
                  style: customTextStyle(
                    fontSize: Responsive.sp(13),
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

  Widget _buildEventCard(Map<String, String> event) {
    final isOnline = event['type'] == 'Online';
    final accent = isOnline ? Colors.green : Colors.orange;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(22)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
              padding: EdgeInsets.symmetric(vertical: Responsive.h(10)),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.newPri, AppColors.primary],
                ),
                borderRadius: BorderRadius.circular(Responsive.w(14)),
              ),
              child: Column(
                children: [
                  Text(
                    event['day']!,
                    style: customTextStyle(
                      color: Colors.white,
                      fontSize: Responsive.sp(12),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    event['month']!,
                    style: customTextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: Responsive.sp(11),
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
                      color: AppColors.textColor,
                    ),
                  ),
                  height(Responsive.h(10)),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: Responsive.sp(14),
                        color: AppColors.homeTextMuted,
                      ),
                      width(Responsive.w(4)),
                      Text(
                        event['time']!,
                        style: customTextStyle(
                          fontSize: Responsive.sp(12),
                          color: AppColors.homeTextMuted,
                        ),
                      ),
                      width(Responsive.w(12)),
                      Icon(
                        Icons.place_rounded,
                        size: Responsive.sp(14),
                        color: AppColors.homeTextMuted,
                      ),
                      width(Responsive.w(4)),
                      Expanded(
                        child: Text(
                          event['location']!,
                          overflow: TextOverflow.ellipsis,
                          style: customTextStyle(
                            fontSize: Responsive.sp(12),
                            color: AppColors.homeTextMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                  height(Responsive.h(16)),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: Responsive.h(42),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.newPri,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Responsive.w(12),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            icon: Icon(
                              Icons.event_available_rounded,
                              size: Responsive.sp(16),
                            ),
                            label: Text(
                              'Register',
                              style: customTextStyle(
                                fontSize: Responsive.sp(12.5),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      width(Responsive.w(10)),
                      InkWell(
                        onTap: () => Share.share(
                          'Check out this event: ${event['title']} on '
                          '${event['day']} ${event['month']}, ${event['time']}',
                        ),
                        borderRadius: BorderRadius.circular(Responsive.w(12)),
                        child: Container(
                          width: Responsive.w(42),
                          height: Responsive.h(42),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(
                              Responsive.w(12),
                            ),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Icon(
                            Icons.share_outlined,
                            size: Responsive.sp(18),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event_busy_rounded,
            size: Responsive.sp(48),
            color: Colors.grey.shade300,
          ),
          height(Responsive.h(12)),
          Text(
            'No ${_filter == 'All' ? '' : '$_filter '}events scheduled',
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              color: AppColors.homeTextMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
