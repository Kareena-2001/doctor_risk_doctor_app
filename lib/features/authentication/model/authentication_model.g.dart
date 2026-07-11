// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthenticationModelImpl _$$AuthenticationModelImplFromJson(
  Map<String, dynamic> json,
) => _$AuthenticationModelImpl(
  status: (json['status'] as num).toInt(),
  msg: json['msg'] as String,
  data: LoginData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$AuthenticationModelImplToJson(
  _$AuthenticationModelImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'msg': instance.msg,
  'data': instance.data,
};

_$LoginDataImpl _$$LoginDataImplFromJson(Map<String, dynamic> json) =>
    _$LoginDataImpl(
      token: json['token'] as String,
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LoginDataImplToJson(_$LoginDataImpl instance) =>
    <String, dynamic>{'token': instance.token, 'customer': instance.customer};

_$CustomerImpl _$$CustomerImplFromJson(Map<String, dynamic> json) =>
    _$CustomerImpl(
      id: json['id'] as String,
      vendor_employee_code: json['vendor_employee_code'] as String?,
      full_name: json['full_name'] as String,
      email: json['email'] as String?,
      mobile: json['mobile'] as String,
      application_status: json['application_status'] as String?,
      ol_generate: json['ol_generate'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$$CustomerImplToJson(_$CustomerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vendor_employee_code': instance.vendor_employee_code,
      'full_name': instance.full_name,
      'email': instance.email,
      'mobile': instance.mobile,
      'application_status': instance.application_status,
      'ol_generate': instance.ol_generate,
      'photo': instance.photo,
    };
