import 'package:Doctors_App/features/notification/ui/viewmodel/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: group.notifications.length,
                  itemBuilder: (context, notificationIndex) {
                    final notification = group.notifications[notificationIndex];

                    return Card(
                      elevation: 0,
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(color: context.dividerColor),
                      ),
                      margin: const EdgeInsets.only(bottom: 14),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: .1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.notifications_active_outlined,
                                color: AppColors.primary,
                                size: 18,
                              ),
                            ),
                            width(14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          notification.title,
                                          style: customTextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: context.primaryTextColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: context.dividerColor
                                              .withValues(alpha: .3),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          notification.datetime,
                                          style: customTextStyle(
                                            fontSize: 10,
                                            color: context.primaryTextColor
                                                .withValues(alpha: .7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height(5),
                                  Text(
                                    notification.body,
                                    style: customTextStyle(
                                      fontSize: 11,
                                      color: context.primaryTextColor
                                          .withValues(alpha: .75),
                                    ).copyWith(height: 1.5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
