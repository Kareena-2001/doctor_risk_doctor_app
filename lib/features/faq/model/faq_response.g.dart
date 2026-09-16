// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FaqResponseImpl _$$FaqResponseImplFromJson(Map<String, dynamic> json) =>
    _$FaqResponseImpl(
      status: json['status'] as bool,
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => FaqModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      currentPage: (json['current_page'] as num).toInt(),
      lastPage: (json['last_page'] as num).toInt(),
      perPage: (json['per_page'] as num).toInt(),
    );

Map<String, dynamic> _$$FaqResponseImplToJson(_$FaqResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
      'total': instance.total,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
    };

_$FaqModelImpl _$$FaqModelImplFromJson(Map<String, dynamic> json) =>
    _$FaqModelImpl(
      id: (json['id'] as num).toInt(),
      question: json['question'] as String,
      answerDescription: json['ans_description'] as String,
      status: json['status'] as String,
      addedOn: json['added_on'] as String,
    );

Map<String, dynamic> _$$FaqModelImplToJson(_$FaqModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'ans_description': instance.answerDescription,
      'status': instance.status,
      'added_on': instance.addedOn,
    };
