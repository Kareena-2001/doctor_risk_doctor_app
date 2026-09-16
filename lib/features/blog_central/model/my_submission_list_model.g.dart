// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_submission_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MySubmissionListModelImpl _$$MySubmissionListModelImplFromJson(
  Map<String, dynamic> json,
) => _$MySubmissionListModelImpl(
  status: json['status'] as bool,
  code: (json['code'] as num).toInt(),
  msg: json['msg'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => SubmissionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  currentPage: (json['current_page'] as num).toInt(),
  lastPage: (json['last_page'] as num).toInt(),
  perPage: (json['per_page'] as num).toInt(),
);

Map<String, dynamic> _$$MySubmissionListModelImplToJson(
  _$MySubmissionListModelImpl instance,
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

_$SubmissionModelImpl _$$SubmissionModelImplFromJson(
  Map<String, dynamic> json,
) => _$SubmissionModelImpl(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  image: json['image'] as String?,
  description: json['description'] as String,
  approveStatus: json['approve_status'] as String?,
  viewCount: json['view_count'] as String,
  iAgreeAccepted: json['i_agree_accepted'] as String,
  createdOn: json['created_on'] as String,
  updatedOn: json['updated_on'] as String,
  keywords:
      (json['keywords'] as List<dynamic>?)
          ?.map((e) => KeywordModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <KeywordModel>[],
);

Map<String, dynamic> _$$SubmissionModelImplToJson(
  _$SubmissionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'image': instance.image,
  'description': instance.description,
  'approve_status': instance.approveStatus,
  'view_count': instance.viewCount,
  'i_agree_accepted': instance.iAgreeAccepted,
  'created_on': instance.createdOn,
  'updated_on': instance.updatedOn,
  'keywords': instance.keywords,
};

_$KeywordModelImpl _$$KeywordModelImplFromJson(Map<String, dynamic> json) =>
    _$KeywordModelImpl(
      blogId: (json['blog_id'] as num).toInt(),
      keyword: json['keyword'] as String,
    );

Map<String, dynamic> _$$KeywordModelImplToJson(_$KeywordModelImpl instance) =>
    <String, dynamic>{'blog_id': instance.blogId, 'keyword': instance.keyword};
