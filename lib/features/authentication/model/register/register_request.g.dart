// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RegisterRequestImpl(
  productTypeId: json['product_type_id'] as String,
  prefix: json['prefix'] as String,
  firstName: json['first_name'] as String,
  middleName: json['middle_name'] as String?,
  lastName: json['last_name'] as String,
  mobileNo: json['mobile_no'] as String,
  email: json['email'] as String?,
  categoryId: (json['category_id'] as num).toInt(),
  specialityId: (json['speciality_id'] as num?)?.toInt(),
  degree: json['degree'] as String?,
  organizationName: json['organization_name'] as String?,
  source: json['source'] as String,
  password: json['password'] as String,
  termsPrivacyAccepted: json['terms_privacy_accepted'] as bool,
);

Map<String, dynamic> _$$RegisterRequestImplToJson(
  _$RegisterRequestImpl instance,
) => <String, dynamic>{
  'product_type_id': instance.productTypeId,
  'prefix': instance.prefix,
  'first_name': instance.firstName,
  'middle_name': instance.middleName,
  'last_name': instance.lastName,
  'mobile_no': instance.mobileNo,
  'email': instance.email,
  'category_id': instance.categoryId,
  'speciality_id': instance.specialityId,
  'degree': instance.degree,
  'organization_name': instance.organizationName,
  'source': instance.source,
  'password': instance.password,
  'terms_privacy_accepted': instance.termsPrivacyAccepted,
};
