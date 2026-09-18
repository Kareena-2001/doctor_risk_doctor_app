// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChangePasswordRequestImpl _$$ChangePasswordRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ChangePasswordRequestImpl(
  oldPassword: json['old_password'] as String,
  newPassword: json['new_password'] as String,
  confirmPassword: json['confirm_password'] as String,
);

Map<String, dynamic> _$$ChangePasswordRequestImplToJson(
  _$ChangePasswordRequestImpl instance,
) => <String, dynamic>{
  'old_password': instance.oldPassword,
  'new_password': instance.newPassword,
  'confirm_password': instance.confirmPassword,
};

_$ChangePasswordResponseImpl _$$ChangePasswordResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ChangePasswordResponseImpl(
  status: (json['status'] as num).toInt(),
  msg: json['msg'] as String?,
);

Map<String, dynamic> _$$ChangePasswordResponseImplToJson(
  _$ChangePasswordResponseImpl instance,
) => <String, dynamic>{'status': instance.status, 'msg': instance.msg};
