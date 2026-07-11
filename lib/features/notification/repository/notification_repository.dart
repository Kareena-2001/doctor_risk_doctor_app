import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/api_client.dart';

import '../model/notification_response.dart';

part 'notification_repository.g.dart';

@riverpod
NotificationRepository notificationRepository(NotificationRepositoryRef ref) {
  return NotificationRepository(ref.watch(apiClientProvider));
}

class NotificationRepository {
  final ApiClient _api;

  const NotificationRepository(this._api);

  Future<NotificationResponse> getNotificationList() async {
    final response = await _api.get(
      url: 'notification_list',
      includeAuth: true,
    );

    if (response['status'] == 200) {
      return NotificationResponse.fromJson(response);
    }
    throw Exception(response['msg'] ?? 'Failed to check version');
  }

  Future<bool> getNotificationAlert() async {
    try {
      final response = await _api.get(
        url: 'notification_alert',
        includeAuth: true,
      );
      if (response['status'] == 200 || response['status'] == '200') {
        final data = response['data'];
        if (data is Map<String, dynamic>) {
          return data['notification_alert'] == true;
        }
        return false;
      }

      return false;
    } catch (e, stack) {
      debugPrint('Notification alert call failed gracefully: $e');
      debugPrint('Stack: $stack');

      return false;
    }
  }

  Future<void> removeNotificationAlert() async {
    try {
      await _api.get(url: 'notification_remove_alert', includeAuth: true);
    } catch (e) {
      if (e.toString().contains('Failed to parse response')) {
        return;
      }
      throw Exception('Failed to remove notification alert: ${e.toString()}');
    }
  }
}
