// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForgotPasswordRequestImpl _$$ForgotPasswordRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ForgotPasswordRequestImpl(email: json['email'] as String);

Map<String, dynamic> _$$ForgotPasswordRequestImplToJson(
  _$ForgotPasswordRequestImpl instance,
) => <String, dynamic>{'email': instance.email};

_$ForgotPasswordResponseImpl _$$ForgotPasswordResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ForgotPasswordResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String,
  data: json['data'] as List<dynamic>,
);

Map<String, dynamic> _$$ForgotPasswordResponseImplToJson(
  _$ForgotPasswordResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
