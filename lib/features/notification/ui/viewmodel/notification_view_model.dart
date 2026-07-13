import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/notification_response.dart';
import '../../repository/notification_repository.dart';

part 'notification_view_model.g.dart';

@riverpod
class NotificationViewModel extends _$NotificationViewModel {
  @override
  FutureOr<List<NotificationGroup>> build() async {
    return await fetchNotifications();
  }

  Future<List<NotificationGroup>> fetchNotifications() async {
    return [
      NotificationGroup(
        dateTitle: 'Today',
        notifications: [
          NotificationItem(
            title: 'Policy Purchased Successfully',
            body:
            'Your Professional Indemnity Policy has been activated successfully.',
            datetime: '10:30 AM',
          ),
          NotificationItem(
            title: 'Premium Payment Successful',
            body:
            'We have received your premium payment. Thank you for choosing us.',
            datetime: '08:45 AM',
          ),
        ],
      ),
      NotificationGroup(
        dateTitle: 'Yesterday',
        notifications: [
          NotificationItem(
            title: 'Claim Submitted',
            body:
            'Your insurance claim has been submitted successfully. Our team will review it shortly.',
            datetime: '06:15 PM',
          ),
          NotificationItem(
            title: 'Support Ticket Updated',
            body:
            'Your support request has been updated. Please check the latest response.',
            datetime: '03:20 PM',
          ),
        ],
      ),
      NotificationGroup(
        dateTitle: 'This Week',
        notifications: [
          NotificationItem(
            title: 'Policy Renewal Reminder',
            body:
            'Your policy will expire in 15 days. Renew now to continue your coverage.',
            datetime: 'Monday • 09:00 AM',
          ),
          NotificationItem(
            title: 'Community Discussion',
            body:
            'A new discussion on Medical Negligence Awareness has been started in the community.',
            datetime: 'Sunday • 04:30 PM',
          ),
          NotificationItem(
            title: 'Upcoming Webinar',
            body:
            'Join our webinar on "Professional Liability Protection for Doctors" this Friday.',
            datetime: 'Saturday • 11:00 AM',
          ),
        ],
      ),
      NotificationGroup(
        dateTitle: 'Earlier',
        notifications: [
          NotificationItem(
            title: 'Policy Approved',
            body:
            'Congratulations! Your policy proposal has been approved successfully.',
            datetime: '05 Jul • 10:00 AM',
          ),
          NotificationItem(
            title: 'Document Verification Completed',
            body:
            'Your KYC and professional documents have been verified successfully.',
            datetime: '03 Jul • 02:45 PM',
          ),
          NotificationItem(
            title: 'Exclusive Offer',
            body:
            'Upgrade your coverage today and enjoy additional medico-legal benefits.',
            datetime: '01 Jul • 12:00 PM',
          ),
          NotificationItem(
            title: 'Health Camp Event',
            body:
            'Register now for the upcoming Doctors Health & Wellness Camp in your city.',
            datetime: '28 Jun • 09:30 AM',
          ),
        ],
      ),
    ];
  }
  // Future<List<NotificationGroup>> fetchNotifications() async {
  //   final repository = ref.read(notificationRepositoryProvider);
  //   final response = await repository.getNotificationList();
  //
  //   final groups = <NotificationGroup>[];
  //
  //   response.data.notifications.forEach((dateTitle, items) {
  //     if (items.isNotEmpty) {
  //       groups.add(
  //         NotificationGroup(dateTitle: dateTitle, notifications: items),
  //       );
  //     }
  //   });
  //
  //   return groups;
  // }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => fetchNotifications());
  }
}

class NotificationGroup {
  final String dateTitle;
  final List<NotificationItem> notifications;

  NotificationGroup({required this.dateTitle, required this.notifications});
}

@riverpod
class NotificationAlert extends _$NotificationAlert {
  @override
  FutureOr<bool> build() async {
    return await fetchAlert();
  }

  Future<bool> fetchAlert() async {
    final repository = ref.read(notificationRepositoryProvider);
    return await repository.getNotificationAlert();
  }

  Future<void> removeAlert() async {
    final repository = ref.read(notificationRepositoryProvider);
    await repository.removeNotificationAlert();
    state = const AsyncValue.data(false);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => fetchAlert());
  }

  void showAlert() {
    state = const AsyncValue.data(true);
  }
}
