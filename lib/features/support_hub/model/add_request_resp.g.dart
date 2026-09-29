// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_request_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddRequestRespImpl _$$AddRequestRespImplFromJson(Map<String, dynamic> json) =>
    _$AddRequestRespImpl(
      status: (json['status'] as num).toInt(),
      msg: json['msg'] as String,
      data: json['data'] == null
          ? null
          : AddRequestData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AddRequestRespImplToJson(
  _$AddRequestRespImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'msg': instance.msg,
  'data': instance.data,
};

_$AddRequestDataImpl _$$AddRequestDataImplFromJson(Map<String, dynamic> json) =>
    _$AddRequestDataImpl(ticketNumber: json['tkt_number'] as String);

Map<String, dynamic> _$$AddRequestDataImplToJson(
  _$AddRequestDataImpl instance,
) => <String, dynamic>{'tkt_number': instance.ticketNumber};
