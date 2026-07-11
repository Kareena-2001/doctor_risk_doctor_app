
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
    final repository = ref.read(notificationRepositoryProvider);
    final response = await repository.getNotificationList();

    final groups = <NotificationGroup>[];

    response.data.notifications.forEach((dateTitle, items) {
      if (items.isNotEmpty) {
        groups.add(
          NotificationGroup(dateTitle: dateTitle, notifications: items),
        );
      }
    });

    return groups;
  }

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
