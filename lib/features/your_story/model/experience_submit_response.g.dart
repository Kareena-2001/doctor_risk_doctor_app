// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_submit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExperienceSubmitResponseImpl _$$ExperienceSubmitResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ExperienceSubmitResponseImpl(
  status: json['status'] as bool,
  code: (json['code'] as num).toInt(),
  msg: json['msg'] as String,
  data: ExperienceSubmitData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$ExperienceSubmitResponseImplToJson(
  _$ExperienceSubmitResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'code': instance.code,
  'msg': instance.msg,
  'data': instance.data,
};

_$ExperienceSubmitDataImpl _$$ExperienceSubmitDataImplFromJson(
  Map<String, dynamic> json,
) => _$ExperienceSubmitDataImpl(
  experienceId: (json['experience_id'] as num).toInt(),
  title: json['title'] as String? ?? '',
  experienceType: json['experience_type'] as String? ?? '',
  details: json['details'] as String? ?? '',
  file: json['file'] as String?,
  approveStatus: json['approve_status'] as String?,
);

Map<String, dynamic> _$$ExperienceSubmitDataImplToJson(
  _$ExperienceSubmitDataImpl instance,
) => <String, dynamic>{
  'experience_id': instance.experienceId,
  'title': instance.title,
  'experience_type': instance.experienceType,
  'details': instance.details,
  'file': instance.file,
  'approve_status': instance.approveStatus,
};
