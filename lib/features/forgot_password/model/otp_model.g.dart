// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OtpRequestImpl _$$OtpRequestImplFromJson(Map<String, dynamic> json) =>
    _$OtpRequestImpl(otp: json['otp'] as String);

Map<String, dynamic> _$$OtpRequestImplToJson(_$OtpRequestImpl instance) =>
    <String, dynamic>{'otp': instance.otp};

_$OtpResponseImpl _$$OtpResponseImplFromJson(Map<String, dynamic> json) =>
    _$OtpResponseImpl(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: OtpData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OtpResponseImplToJson(_$OtpResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

_$OtpDataImpl _$$OtpDataImplFromJson(Map<String, dynamic> json) =>
    _$OtpDataImpl(userid: json['userid'] as String);

Map<String, dynamic> _$$OtpDataImplToJson(_$OtpDataImpl instance) =>
    <String, dynamic>{'userid': instance.userid};
