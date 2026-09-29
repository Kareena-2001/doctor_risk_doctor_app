// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueryListModelImpl _$$QueryListModelImplFromJson(Map<String, dynamic> json) =>
    _$QueryListModelImpl(
      status: (json['status'] as num).toInt(),
      msg: json['msg'] as String,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => QueryListItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$QueryListModelImplToJson(
  _$QueryListModelImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'msg': instance.msg,
  'data': instance.data,
};

_$QueryListItemImpl _$$QueryListItemImplFromJson(Map<String, dynamic> json) =>
    _$QueryListItemImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      ticketNumber: json['tkt_number'] as String,
      category: json['category'] as String,
      question: json['question'] as String,
      description: json['description'] as String,
      ticketStatus: json['tkt_status'] as String,
      querySubmit: json['query_submit'] as String,
    );

Map<String, dynamic> _$$QueryListItemImplToJson(_$QueryListItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'tkt_number': instance.ticketNumber,
      'category': instance.category,
      'question': instance.question,
      'description': instance.description,
      'tkt_status': instance.ticketStatus,
      'query_submit': instance.querySubmit,
    };
