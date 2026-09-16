// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testimonial_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestimonialResponseImpl _$$TestimonialResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TestimonialResponseImpl(
  status: json['status'] as bool,
  code: (json['code'] as num).toInt(),
  msg: json['msg'] as String,
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => TestimonialData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
  currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
  lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
  perPage: (json['per_page'] as num?)?.toInt() ?? 10,
);

Map<String, dynamic> _$$TestimonialResponseImplToJson(
  _$TestimonialResponseImpl instance,
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

_$TestimonialDataImpl _$$TestimonialDataImplFromJson(
  Map<String, dynamic> json,
) => _$TestimonialDataImpl(
  id: (json['id'] as num).toInt(),
  testimonialType: json['testimonial_type'] as String? ?? '',
  details: json['details'] as String? ?? '',
  file: json['file'] as String?,
  drName: json['dr_name'] as String?,
  degree: json['degree'] as String?,
  categoryName: json['category_name'] as String?,
  specialityName: json['speciality_name'] as String?,
  iAgreeAccepted: json['i_agree_accepted'] as String?,
  approveStatus: json['approve_status'] as String?,
  approvedBy: json['approved_by'] as String?,
  approveDate: json['approve_date'] as String?,
  status: json['status'] as String?,
  createdOn: json['created_on'] as String?,
  updatedOn: json['updated_on'] as String?,
);

Map<String, dynamic> _$$TestimonialDataImplToJson(
  _$TestimonialDataImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'testimonial_type': instance.testimonialType,
  'details': instance.details,
  'file': instance.file,
  'dr_name': instance.drName,
  'degree': instance.degree,
  'category_name': instance.categoryName,
  'speciality_name': instance.specialityName,
  'i_agree_accepted': instance.iAgreeAccepted,
  'approve_status': instance.approveStatus,
  'approved_by': instance.approvedBy,
  'approve_date': instance.approveDate,
  'status': instance.status,
  'created_on': instance.createdOn,
  'updated_on': instance.updatedOn,
};
