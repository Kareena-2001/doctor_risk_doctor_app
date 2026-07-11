// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationResponseImpl _$$NotificationResponseImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationResponseImpl(
  status: (json['status'] as num).toInt(),
  msg: json['msg'] as String,
  data: NotificationData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$NotificationResponseImplToJson(
  _$NotificationResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'msg': instance.msg,
  'data': instance.data,
};

_$NotificationDataImpl _$$NotificationDataImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationDataImpl(
  notifications: (json['notifications'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      k,
      (e as List<dynamic>)
          .map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  ),
);

Map<String, dynamic> _$$NotificationDataImplToJson(
  _$NotificationDataImpl instance,
) => <String, dynamic>{'notifications': instance.notifications};

_$NotificationItemImpl _$$NotificationItemImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationItemImpl(
  title: json['title'] as String,
  body: json['body'] as String,
  datetime: json['datetime'] as String,
);

Map<String, dynamic> _$$NotificationItemImplToJson(
  _$NotificationItemImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'body': instance.body,
  'datetime': instance.datetime,
};
