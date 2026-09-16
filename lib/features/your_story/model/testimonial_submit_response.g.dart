// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testimonial_submit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestimonialSubmitResponseImpl _$$TestimonialSubmitResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TestimonialSubmitResponseImpl(
  status: json['status'] as bool,
  code: (json['code'] as num).toInt(),
  msg: json['msg'] as String,
  data: TestimonialSubmitData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$TestimonialSubmitResponseImplToJson(
  _$TestimonialSubmitResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'code': instance.code,
  'msg': instance.msg,
  'data': instance.data,
};

_$TestimonialSubmitDataImpl _$$TestimonialSubmitDataImplFromJson(
  Map<String, dynamic> json,
) => _$TestimonialSubmitDataImpl(
  testimonialId: (json['testimonial_id'] as num).toInt(),
  testimonialType: json['testimonial_type'] as String? ?? '',
  details: json['details'] as String? ?? '',
  file: json['file'] as String?,
  approveStatus: json['approve_status'] as String?,
);

Map<String, dynamic> _$$TestimonialSubmitDataImplToJson(
  _$TestimonialSubmitDataImpl instance,
) => <String, dynamic>{
  'testimonial_id': instance.testimonialId,
  'testimonial_type': instance.testimonialType,
  'details': instance.details,
  'file': instance.file,
  'approve_status': instance.approveStatus,
};
