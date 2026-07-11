// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_docs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminDocsResponseImpl _$$AdminDocsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$AdminDocsResponseImpl(
  status: (json['status'] as num).toInt(),
  msg: json['msg'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => AdminDocsData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$AdminDocsResponseImplToJson(
  _$AdminDocsResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'msg': instance.msg,
  'data': instance.data,
};

_$AdminDocsDataImpl _$$AdminDocsDataImplFromJson(Map<String, dynamic> json) =>
    _$AdminDocsDataImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      letterType: json['letter_type'] as String,
      fileUrl: json['file'] as String,
      fileSendDate: json['file_send_date'] as String,
    );

Map<String, dynamic> _$$AdminDocsDataImplToJson(_$AdminDocsDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'letter_type': instance.letterType,
      'file': instance.fileUrl,
      'file_send_date': instance.fileSendDate,
    };
