// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BlogListResponseImpl _$$BlogListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$BlogListResponseImpl(
  status: json['status'] as bool,
  code: (json['code'] as num).toInt(),
  msg: json['msg'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => BlogData.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  currentPage: (json['current_page'] as num).toInt(),
  lastPage: (json['last_page'] as num).toInt(),
  perPage: (json['per_page'] as num).toInt(),
);

Map<String, dynamic> _$$BlogListResponseImplToJson(
  _$BlogListResponseImpl instance,
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

_$BlogDataImpl _$$BlogDataImplFromJson(Map<String, dynamic> json) =>
    _$BlogDataImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      drName: json['dr_name'] as String,
      categoryName: json['category_name'] as String,
      specialityName: json['speciality_name'] as String,
      degree: json['degree'] as String,
      viewCount: json['view_count'] as String,
      date: json['date'] as String?,
      keywords: (json['keywords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$BlogDataImplToJson(_$BlogDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'dr_name': instance.drName,
      'category_name': instance.categoryName,
      'speciality_name': instance.specialityName,
      'degree': instance.degree,
      'view_count': instance.viewCount,
      'date': instance.date,
      'keywords': instance.keywords,
    };
