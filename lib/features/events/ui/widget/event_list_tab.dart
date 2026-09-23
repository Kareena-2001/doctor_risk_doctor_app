import 'package:Doctors_App/core/widgets/app_dialog.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/events/model/event_list_response.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../core/widgets/common_empty_state.dart';
import '../../../../extensions/build_context_extension.dart';
import '../../../../extensions/date_time_extension.dart';
import '../../../../theme/app_colors.dart';

class EventListTab extends ConsumerStatefulWidget {
  final List<EventModel> events;
  final String activeTab;

  const EventListTab({
    super.key,
    required this.events,
    required this.activeTab,
  });

  @override
  ConsumerState<EventListTab> createState() => _EventListTabState();
}

class _EventListTabState extends ConsumerState<EventListTab> {
  late List<EventModel> _events;

  @override
  void initState() {
    super.initState();
    _events = List<EventModel>.from(widget.events);
  }

  @override
  void didUpdateWidget(covariant EventListTab oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.events != widget.events) {
      _events = List<EventModel>.from(widget.events);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_events.isEmpty) {
      return CommonEmptyState(icon: Icons.info, title: 'No items found here.');
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        Responsive.w(16),
        0,
        Responsive.w(16),
        Responsive.h(24),
      ),
      itemCount: _events.length,
      separatorBuilder: (_, __) => height(Responsive.h(18)),
      itemBuilder: (context, index) => _EventCard(
        event: _events[index],
        activeTab: widget.activeTab,
        onRegistrationSuccess: () {
          setState(() {
            _events[index] = _events[index].copyWith(registerButton: false);
          });
        },
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final EventModel event;
  final String activeTab;
  final VoidCallback? onRegistrationSuccess;

  const _EventCard({
    required this.event,
    required this.activeTab,
    this.onRegistrationSuccess,
  });

  String _formatEventDateTime() {
    final date = DateFormat('yyyy-MM-dd').parse(event.date.trim());

    final normalizedTime = event.time.trim().replaceAll(RegExp(r'\s+'), ' ');

    DateTime time;

    try {
      time = DateFormat('hh:mm:ss a').parse(normalizedTime);
    } catch (_) {
      time = DateFormat('hh:mm a').parse(normalizedTime);
    }

    return '${date.toEventDate()} · ${time.toEventTime()} IST';
  }

  void _showNotApplicableDialog(BuildContext context, String label) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(label),
        content: const Text('Not applicable for this event.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showDescriptionDialog(BuildContext context) {
    final isOnline = event.eventType == 'Online';

    AppDialog.customBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            Responsive.w(20),
            Responsive.h(16),
            Responsive.w(20),
            Responsive.h(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Event Details',
                        style: customTextStyle(
                          fontSize: Responsive.sp(17),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        size: Responsive.sp(20),
                        color: AppColors.homeTextMuted,
                      ),
                    ),
                  ],
                ),
                height(Responsive.h(8)),
                Text(
                  event.title,
                  style: customTextStyle(
                    fontSize: Responsive.sp(14),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                height(Responsive.h(14)),
                _buildDetailRow(
                  icon: Icons.calendar_month_outlined,
                  title: 'Date & Time',
                  value: _formatEventDateTime(),
                ),
                height(Responsive.h(12)),
                _buildDetailRow(
                  icon: isOnline
                      ? Icons.videocam_rounded
                      : Icons.location_city_rounded,
                  title: 'Event Type',
                  value: event.eventType,
                ),
                if (!isOnline &&
                    event.address != null &&
                    event.address!.isNotEmpty) ...[
                  height(Responsive.h(12)),
                  _buildDetailRow(
                    icon: Icons.location_on_outlined,
                    title: 'Venue',
                    value: event.address!,
                  ),
                ],
                height(Responsive.h(12)),
                _buildDetailRow(
                  icon: Icons.currency_rupee_rounded,
                  title: 'Price',
                  value: event.price == '0.00' ? 'Free' : '₹${event.price}',
                ),
                if (event.priceDescription != null &&
                    event.priceDescription!.isNotEmpty) ...[
                  height(Responsive.h(12)),
                  _buildDetailRow(
                    icon: Icons.info_outline_rounded,
                    title: 'Price Details',
                    value: event.priceDescription!,
                  ),
                ],
                height(Responsive.h(12)),
                Text(
                  'Description',
                  style: customTextStyle(
                    fontSize: Responsive.sp(12),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                height(Responsive.h(5)),
                Text(
                  event.description.isNotEmpty
                      ? event.description
                      : 'No description available.',
                  style: customTextStyle(
                    fontSize: Responsive.sp(12),
                    color: AppColors.homeTextMuted,
                  ),
                ),
                height(Responsive.h(20)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: Responsive.h(12)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: customTextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(Responsive.w(8)),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: Responsive.sp(16), color: AppColors.primary),
        ),
        width(Responsive.w(10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: customTextStyle(
                  fontSize: Responsive.sp(10),
                  color: AppColors.homeTextMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
              height(Responsive.h(3)),
              Text(
                value,
                style: customTextStyle(
                  fontSize: Responsive.sp(12),
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceStatus() {
    final status = event.attendanceStatus;
    final attended = status != null && status.toLowerCase() == 'attended';
    final label = status ?? 'Not attended';
    final color = attended ? Colors.green : AppColors.homeTextMuted;
    final icon = attended ? Icons.check_circle : Icons.remove_circle_outline;

    return Row(
      children: [
        Icon(icon, size: Responsive.sp(16), color: color),
        width(Responsive.w(5)),
        Text(
          label,
          style: customTextStyle(
            fontSize: Responsive.sp(11),
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = event.eventType == 'Online';
    final isPast = activeTab == 'past';
    final accent = isOnline ? Colors.blue : Colors.orange;

    return Container(
      decoration: BoxDecoration(
        color: context.secondaryWidgetColor,
        borderRadius: BorderRadius.circular(Responsive.w(22)),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: Offset(0, 8),
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
                        event.eventType,
                        style: customTextStyle(
                          color: accent,
                          fontSize: Responsive.sp(10),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            height(Responsive.h(10)),
            Text(
              event.title,
              style: customTextStyle(
                fontSize: Responsive.sp(13),
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            height(Responsive.h(8)),
            Text(
              _formatEventDateTime(),
              style: customTextStyle(
                fontSize: Responsive.sp(11),
                color: AppColors.grey,
              ),
            ),
            height(Responsive.h(6)),
            if (!isOnline &&
                event.address != null &&
                event.address!.isNotEmpty) ...[
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: Responsive.sp(12),
                    color: AppColors.grey,
                  ),
                  width(Responsive.w(4)),
                  Expanded(
                    child: Text(
                      event.address!,
                      style: customTextStyle(
                        fontSize: Responsive.sp(11),
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              height(Responsive.h(8)),
            ],

            GestureDetector(
              onTap: () => _showDescriptionDialog(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: Responsive.sp(13),
                    color: AppColors.newPri,
                  ),
                  width(Responsive.w(5)),
                  Text(
                    'View event details',
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: AppColors.newPri,
                      fontWeight: FontWeight.w600,
                    ).copyWith(decoration: TextDecoration.underline),
                  ),
                  width(Responsive.w(3)),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: Responsive.sp(10),
                    color: AppColors.newPri,
                  ),
                ],
              ),
            ),
            height(Responsive.h(8)),

            Text(
              event.priceDescription != null &&
                      event.priceDescription!.isNotEmpty
                  ? '${event.price == '0.00' ? 'Free' : '₹${event.price}'} (${event.priceDescription})'
                  : (event.price == '0.00' ? 'Free' : '₹${event.price}'),
              style: customTextStyle(
                fontSize: Responsive.sp(11),
                fontWeight: FontWeight.bold,
                color: event.price == '0.00'
                    ? Colors.green
                    : AppColors.textColor,
              ),
            ),

            if (isPast) ...[
              height(Responsive.h(10)),
              _buildAttendanceStatus(),
              if (event.watchRecordingButton || event.certificateButton) ...[
                height(Responsive.h(10)),
                Row(
                  children: [
                    if (event.watchRecordingButton)
                      Expanded(
                        child: PrimaryButton(
                          text: 'Watch Recording',
                          height: 40,
                          borderRadius: 25,
                          fontSize: 12,
                          borderColor: AppColors.greyLight,
                          backgroundColor: event.watchRecordingDisabled
                              ? AppColors.greyLight
                              : AppColors.white,
                          textColor: event.watchRecordingDisabled
                              ? AppColors.homeTextMuted
                              : AppColors.textColor,
                          onPressed: () {
                            if (event.watchRecordingDisabled ||
                                event.watchRecordingLink == null) {
                              _showNotApplicableDialog(context, 'Recording');
                              return;
                            }
                            // TODO: launch event.watchRecordingLink
                          },
                        ),
                      ),
                    if (event.watchRecordingButton && event.certificateButton)
                      width(Responsive.w(10)),
                    if (event.certificateButton)
                      Expanded(
                        child: PrimaryButton(
                          height: 40,
                          borderRadius: 25,
                          fontSize: 12,
                          borderColor: AppColors.greyLight,
                          backgroundColor: event.certificateDisabled
                              ? AppColors.greyLight
                              : AppColors.white,
                          textColor: event.certificateDisabled
                              ? AppColors.homeTextMuted
                              : AppColors.textColor,
                          onPressed: () {
                            if (event.certificateDisabled ||
                                event.certificateUrl == null) {
                              _showNotApplicableDialog(context, 'Certificate');
                              return;
                            }
                            // TODO: open event.certificateUrl
                          },
                          text: 'Certificate',
                        ),
                      ),
                  ],
                ),
              ],
            ] else if (activeTab != 'collaborate') ...[
              if (event.registerButton == false) ...[
                height(Responsive.h(16)),
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
              ] else if (event.registerButton) ...[
                height(Responsive.h(16)),
                PrimaryButton(
                  borderRadius: 25,
                  text: 'Register',
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.newPri],
                  ),
                  fontSize: 14,
                  height: 45,
                  onPressed: () async {
                    final registered = await context.push<bool>(
                      Routes.eventRegister,
                      extra: event,
                    );

                    if (registered == true) {
                      onRegistrationSuccess?.call();
                    }
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
