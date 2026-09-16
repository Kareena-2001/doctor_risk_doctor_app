// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_advisory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsAdvisoryResponseImpl _$$NewsAdvisoryResponseImplFromJson(
  Map<String, dynamic> json,
) => _$NewsAdvisoryResponseImpl(
  status: json['status'] as bool,
  code: (json['code'] as num).toInt(),
  msg: json['msg'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => NewsAdvisoryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  currentPage: (json['current_page'] as num).toInt(),
  lastPage: (json['last_page'] as num).toInt(),
  perPage: (json['per_page'] as num).toInt(),
);

Map<String, dynamic> _$$NewsAdvisoryResponseImplToJson(
  _$NewsAdvisoryResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'code': instance.code,
  'msg': instance.msg,
  'data': instance.data,
  'total': instance.total,
  'current_page': instance.currentPage,
  'last_page': instance.lastPage,
  'per_page': instance.perPage,
};

_$NewsAdvisoryModelImpl _$$NewsAdvisoryModelImplFromJson(
  Map<String, dynamic> json,
) => _$NewsAdvisoryModelImpl(
  id: (json['id'] as num).toInt(),
  newsSource: json['news_source'] as String,
  sourceDate: json['source_date'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  sourceUrl: json['source_url'] as String,
  status: json['status'] as String,
  createdOn: json['created_on'] as String,
);

Map<String, dynamic> _$$NewsAdvisoryModelImplToJson(
  _$NewsAdvisoryModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'news_source': instance.newsSource,
  'source_date': instance.sourceDate,
  'title': instance.title,
  'description': instance.description,
  'source_url': instance.sourceUrl,
  'status': instance.status,
  'created_on': instance.createdOn,
};
