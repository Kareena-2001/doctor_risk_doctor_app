// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueryDetailModelImpl _$$QueryDetailModelImplFromJson(
  Map<String, dynamic> json,
) => _$QueryDetailModelImpl(
  status: (json['status'] as num).toInt(),
  msg: json['msg'] as String,
  data: QueryDetailItem.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$QueryDetailModelImplToJson(
  _$QueryDetailModelImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'msg': instance.msg,
  'data': instance.data,
};

_$QueryDetailItemImpl _$$QueryDetailItemImplFromJson(
  Map<String, dynamic> json,
) => _$QueryDetailItemImpl(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  ticketNumber: json['tkt_number'] as String,
  category: json['category'] as String,
  question: json['question'] as String,
  description: json['description'] as String,
  ticketStatus: json['tkt_status'] as String,
  querySubmit: json['query_submit'] as String,
  replied: json['replied'] as String?,
  repliedDate: json['replied_date'] as String?,
  replyAttachment: json['reply_attachment'] as String?,
  userAttachment: json['user_attachment'] as String?,
);

Map<String, dynamic> _$$QueryDetailItemImplToJson(
  _$QueryDetailItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'tkt_number': instance.ticketNumber,
  'category': instance.category,
  'question': instance.question,
  'description': instance.description,
  'tkt_status': instance.ticketStatus,
  'query_submit': instance.querySubmit,
  'replied': instance.replied,
  'replied_date': instance.repliedDate,
  'reply_attachment': instance.replyAttachment,
  'user_attachment': instance.userAttachment,
};
