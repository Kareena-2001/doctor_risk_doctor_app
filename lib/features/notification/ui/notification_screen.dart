import 'package:Doctors_App/features/notification/ui/viewmodel/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/common_empty_state.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../theme/app_colors.dart';
import '../../common/ui/widgets/loading.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationAlertProvider.notifier).removeAlert();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(notificationViewModelProvider);

    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      appBar: CustomAppBar(title: 'Notifications'),
      body: notificationsAsync.when(
        data: (groups) => _buildNotificationList(context, groups),
        loading: () => Loading(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to load notifications',
                style: customTextStyle(
                  fontSize: 16,
                  color: context.primaryTextColor,
                ),
              ),
              height(16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(notificationViewModelProvider);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationList(
    BuildContext context,
    List<NotificationGroup> groups,
  ) {
    final notificationsAsync = ref.watch(
      notificationViewModelProvider.notifier,
    );
    if (groups.isEmpty) {
      return CommonEmptyState(
        title: 'No Notifications',
        message: 'You’re all caught up 🎉',
        icon: Icons.notifications_none,
      );
    }

    return RefreshIndicator(
      onRefresh: () => notificationsAsync.refresh(),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 14.0,
          bottom: 14,
          left: 14,
          right: 14,
        ),
        child: ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            final group = groups[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 20.0,
                    top: index == 0 ? 0 : 20,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.newPri,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          group.dateTitle,
                          style: customTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        // Text(
                        //   "Mark all as read",
                        //   style: customTextStyle(
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w600,
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: group.notifications.length,
                  itemBuilder: (context, notificationIndex) {
                    final notification = group.notifications[notificationIndex];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: context.dividerColor),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2, right: 10),
                            child: Image.asset(
                              Assets.bellIcons,
                              height: 28,
                              width: 28,
                              color: context.primaryTextColor,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        notification.title,
                                        style: customTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: context.primaryTextColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      notification.datetime,
                                      style: customTextStyle(
                                        fontSize: 10,
                                        color: context.primaryTextColor
                                            .withValues(alpha: 0.6),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  notification.body,
                                  style: customTextStyle(
                                    fontSize: 11,
                                    color: context.primaryTextColor.withValues(
                                      alpha: 0.7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
