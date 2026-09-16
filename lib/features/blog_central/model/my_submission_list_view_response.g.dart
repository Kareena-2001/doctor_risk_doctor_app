// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_submission_list_view_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MySubmissionListViewResponseImpl _$$MySubmissionListViewResponseImplFromJson(
  Map<String, dynamic> json,
) => _$MySubmissionListViewResponseImpl(
  status: json['status'] as bool,
  code: (json['code'] as num).toInt(),
  msg: json['msg'] as String,
  data: BlogData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$MySubmissionListViewResponseImplToJson(
  _$MySubmissionListViewResponseImpl instance,
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
      iAgreeAccepted: json['i_agree_accepted'] as String?,
      keywords:
          (json['keywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BlogDataImplToJson(_$BlogDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'i_agree_accepted': instance.iAgreeAccepted,
      'keywords': instance.keywords,
    };
