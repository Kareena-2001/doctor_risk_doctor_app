// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_submit_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BlogSubmitResponseImpl _$$BlogSubmitResponseImplFromJson(
  Map<String, dynamic> json,
) => _$BlogSubmitResponseImpl(
  status: json['status'] as bool,
  code: (json['code'] as num).toInt(),
  msg: json['msg'] as String,
  data: BlogSubmitData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$BlogSubmitResponseImplToJson(
  _$BlogSubmitResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'code': instance.code,
  'msg': instance.msg,
  'data': instance.data,
};

_$BlogSubmitDataImpl _$$BlogSubmitDataImplFromJson(Map<String, dynamic> json) =>
    _$BlogSubmitDataImpl(
      blogId: (json['blog_id'] as num).toInt(),
      approveStatus: json['approve_status'] as String,
      keywords: (json['keywords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$BlogSubmitDataImplToJson(
  _$BlogSubmitDataImpl instance,
) => <String, dynamic>{
  'blog_id': instance.blogId,
  'approve_status': instance.approveStatus,
  'keywords': instance.keywords,
};
