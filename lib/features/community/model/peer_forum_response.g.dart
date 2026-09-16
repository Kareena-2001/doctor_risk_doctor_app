// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peer_forum_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PeerForumResponseImpl _$$PeerForumResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PeerForumResponseImpl(
  status: json['status'] as bool,
  code: (json['code'] as num).toInt(),
  msg: json['msg'] as String,
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => PeerForumModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num).toInt(),
  currentPage: (json['current_page'] as num).toInt(),
  lastPage: (json['last_page'] as num).toInt(),
  perPage: (json['per_page'] as num).toInt(),
);

Map<String, dynamic> _$$PeerForumResponseImplToJson(
  _$PeerForumResponseImpl instance,
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

_$PeerForumModelImpl _$$PeerForumModelImplFromJson(Map<String, dynamic> json) =>
    _$PeerForumModelImpl(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      typeLabel: json['type_label'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String?,
      source: json['source'] as String?,
      sourceUrl: json['source_url'] as String?,
      date: json['date'] as String?,
      createdOn: json['created_on'] as String?,
      daysAgo: (json['days_ago'] as num?)?.toInt(),
      daysAgoLabel: json['days_ago_label'] as String?,
      author: json['author'] as String?,
      degree: json['degree'] as String?,
      categoryName: json['category_name'] as String?,
      specialityName: json['speciality_name'] as String?,
    );

Map<String, dynamic> _$$PeerForumModelImplToJson(
  _$PeerForumModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'type_label': instance.typeLabel,
  'title': instance.title,
  'description': instance.description,
  'image': instance.image,
  'source': instance.source,
  'source_url': instance.sourceUrl,
  'date': instance.date,
  'created_on': instance.createdOn,
  'days_ago': instance.daysAgo,
  'days_ago_label': instance.daysAgoLabel,
  'author': instance.author,
  'degree': instance.degree,
  'category_name': instance.categoryName,
  'speciality_name': instance.specialityName,
};
