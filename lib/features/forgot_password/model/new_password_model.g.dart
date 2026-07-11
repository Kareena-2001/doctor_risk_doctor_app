// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewPasswordRequestImpl _$$NewPasswordRequestImplFromJson(
  Map<String, dynamic> json,
) => _$NewPasswordRequestImpl(
  id: json['id'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$$NewPasswordRequestImplToJson(
  _$NewPasswordRequestImpl instance,
) => <String, dynamic>{'id': instance.id, 'password': instance.password};

_$NewPasswordResponseImpl _$$NewPasswordResponseImplFromJson(
  Map<String, dynamic> json,
) => _$NewPasswordResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String,
  data: json['data'] as List<dynamic>,
);

Map<String, dynamic> _$$NewPasswordResponseImplToJson(
  _$NewPasswordResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
