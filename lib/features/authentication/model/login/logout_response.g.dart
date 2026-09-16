// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LogoutResponseImpl _$$LogoutResponseImplFromJson(Map<String, dynamic> json) =>
    _$LogoutResponseImpl(
      status: json['status'] as bool,
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String,
      data: json['data'] as List<dynamic>,
    );

Map<String, dynamic> _$$LogoutResponseImplToJson(
  _$LogoutResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'code': instance.code,
  'msg': instance.msg,
  'data': instance.data,
};
