import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_response.freezed.dart';

part 'notification_response.g.dart';

@freezed
class NotificationResponse with _$NotificationResponse {
  const factory NotificationResponse({
    required int status,
    required String msg,
    required NotificationData data,
  }) = _NotificationResponse;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
}

@freezed
class NotificationData with _$NotificationData {
  const factory NotificationData({
    required Map<String, List<NotificationItem>> notifications,
  }) = _NotificationData;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
}

@freezed
class NotificationItem with _$NotificationItem {
  const factory NotificationItem({
    required String title,
    required String body,
    required String datetime,
  }) = _NotificationItem;

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);
}
