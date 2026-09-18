// widgets/event_list_tab.dart
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';
import '../event_register_screen.dart';

class EventListTab extends StatelessWidget {
  final List<Map<String, String>> events;
  final String activeTab; // 'upcoming' | 'past'

  const EventListTab({
    super.key,
    required this.events,
    required this.activeTab,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) return const _EmptyState();

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        Responsive.w(16),
        0,
        Responsive.w(16),
        Responsive.h(24),
      ),
      itemCount: events.length,
      separatorBuilder: (_, __) => height(Responsive.h(18)),
      itemBuilder: (context, index) =>
          _EventCard(event: events[index], activeTab: activeTab),
    );
  }
}

class _EventCard extends StatelessWidget {
  final Map<String, String> event;
  final String activeTab;

  const _EventCard({required this.event, required this.activeTab});

  @override
  Widget build(BuildContext context) {
    final isOnline = event['type'] == 'Online';
    final isPast = event['status'] == 'past';
    final accent = isOnline ? Colors.blue : Colors.orange;

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
                color: (event['price'] ?? '').toLowerCase().startsWith('free')
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
                        builder: (context) => EventRegisterScreen(event: event),
                      ),
                    );
                  },
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
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