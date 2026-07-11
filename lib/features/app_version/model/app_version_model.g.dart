// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppVersionResponseImpl _$$AppVersionResponseImplFromJson(
  Map<String, dynamic> json,
) => _$AppVersionResponseImpl(
  status: (json['status'] as num).toInt(),
  msg: json['msg'] as String,
  data: AppVersionData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$AppVersionResponseImplToJson(
  _$AppVersionResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'msg': instance.msg,
  'data': instance.data,
};

_$AppVersionDataImpl _$$AppVersionDataImplFromJson(Map<String, dynamic> json) =>
    _$AppVersionDataImpl(
      showUpdateModal: json['show_update_modal'] as bool,
      forceUpdate: json['force_update'] as bool,
      latestVersion: json['latest_version'] as String,
      updateTitle: json['update_title'] as String?,
      updateMessage: json['update_message'] as String?,
      whatsNew: json['whats_new'] as String?,
    );

Map<String, dynamic> _$$AppVersionDataImplToJson(
  _$AppVersionDataImpl instance,
) => <String, dynamic>{
  'show_update_modal': instance.showUpdateModal,
  'force_update': instance.forceUpdate,
  'latest_version': instance.latestVersion,
  'update_title': instance.updateTitle,
  'update_message': instance.updateMessage,
  'whats_new': instance.whatsNew,
};
