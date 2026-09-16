// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_list_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BlogListDetailImpl _$$BlogListDetailImplFromJson(Map<String, dynamic> json) =>
    _$BlogListDetailImpl(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      msg: json['msg'] as String?,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => BlogData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BlogListDetailImplToJson(
  _$BlogListDetailImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'code': instance.code,
  'msg': instance.msg,
  'data': instance.data,
};

_$BlogDataImpl _$$BlogDataImplFromJson(Map<String, dynamic> json) =>
    _$BlogDataImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: json['image'] as String?,
      drName: json['dr_name'] as String?,
      degree: json['degree'] as String?,
      categoryId: json['category_id'],
      specialityId: json['speciality_id'],
      viewCount: json['view_count'],
      createdOn: json['created_on'] as String?,
      approveDate: json['approve_date'] as String?,
      categoryName: json['category_name'] as String?,
      specialityName: json['speciality_name'] as String?,
      keywords:
          (json['keywords'] as List<dynamic>?)
              ?.map((e) => KeywordData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BlogDataImplToJson(_$BlogDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'dr_name': instance.drName,
      'degree': instance.degree,
      'category_id': instance.categoryId,
      'speciality_id': instance.specialityId,
      'view_count': instance.viewCount,
      'created_on': instance.createdOn,
      'approve_date': instance.approveDate,
      'category_name': instance.categoryName,
      'speciality_name': instance.specialityName,
      'keywords': instance.keywords,
    };

_$KeywordDataImpl _$$KeywordDataImplFromJson(Map<String, dynamic> json) =>
    _$KeywordDataImpl(
      blogId: (json['blog_id'] as num?)?.toInt(),
      keyword: json['keyword'] as String? ?? '',
    );

Map<String, dynamic> _$$KeywordDataImplToJson(_$KeywordDataImpl instance) =>
    <String, dynamic>{'blog_id': instance.blogId, 'keyword': instance.keyword};
