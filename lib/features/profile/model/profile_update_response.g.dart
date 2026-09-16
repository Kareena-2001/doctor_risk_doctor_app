// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileUpdateResponseImpl _$$ProfileUpdateResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileUpdateResponseImpl(
  status: json['status'] as bool,
  code: (json['code'] as num).toInt(),
  msg: json['msg'] as String,
  data: ProfileUpdateData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$ProfileUpdateResponseImplToJson(
  _$ProfileUpdateResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'code': instance.code,
  'msg': instance.msg,
  'data': instance.data,
};

_$ProfileUpdateDataImpl _$$ProfileUpdateDataImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileUpdateDataImpl(
  profile: ProfileUpdateProfile.fromJson(
    json['profile'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$ProfileUpdateDataImplToJson(
  _$ProfileUpdateDataImpl instance,
) => <String, dynamic>{'profile': instance.profile};

_$ProfileUpdateProfileImpl _$$ProfileUpdateProfileImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileUpdateProfileImpl(
  id: (json['id'] as num).toInt(),
  doctorNo: json['doctor_no'] as String?,
  photo: json['photo'] as String?,
  organizationName: json['organization_name'] as String?,
  prifix: json['prifix'] as String?,
  firstName: json['first_name'] as String?,
  middleName: json['middle_name'] as String?,
  lastName: json['last_name'] as String?,
  fullName: json['full_name'] as String?,
  email: json['email'] as String?,
  mobileNo: json['mobile_no'] as String?,
  alternateNo: json['alternate_no'] as String?,
  categoryId: json['category_id'] as String?,
  categoryName: json['category_name'] as String?,
  specialityId: json['speciality_id'] as String?,
  specialityName: json['speciality_name'] as String?,
  degree: json['degree'] as String?,
  establishmentName: json['establishment_name'] as String?,
  dob: json['dob'] as String?,
  gender: json['gender'] as String?,
  addresses:
      (json['addresses'] as List<dynamic>?)
          ?.map((e) => ProfileUpdateAddress.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  clinicHospitalDetails: json['clinic_hospital_details'] == null
      ? null
      : ProfileUpdateClinicHospitalDetails.fromJson(
          json['clinic_hospital_details'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$ProfileUpdateProfileImplToJson(
  _$ProfileUpdateProfileImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'doctor_no': instance.doctorNo,
  'photo': instance.photo,
  'organization_name': instance.organizationName,
  'prifix': instance.prifix,
  'first_name': instance.firstName,
  'middle_name': instance.middleName,
  'last_name': instance.lastName,
  'full_name': instance.fullName,
  'email': instance.email,
  'mobile_no': instance.mobileNo,
  'alternate_no': instance.alternateNo,
  'category_id': instance.categoryId,
  'category_name': instance.categoryName,
  'speciality_id': instance.specialityId,
  'speciality_name': instance.specialityName,
  'degree': instance.degree,
  'establishment_name': instance.establishmentName,
  'dob': instance.dob,
  'gender': instance.gender,
  'addresses': instance.addresses,
  'clinic_hospital_details': instance.clinicHospitalDetails,
};

_$ProfileUpdateAddressImpl _$$ProfileUpdateAddressImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileUpdateAddressImpl(
  id: (json['id'] as num).toInt(),
  addressType: json['address_type'] as String?,
  ownVisiting: json['own_visiting'] as String?,
  address1: json['address1'] as String?,
  address2: json['address2'] as String?,
  landmark: json['landmark'] as String?,
  area: json['area'] as String?,
  state: json['state'] as String?,
  city: json['city'] as String?,
  pincode: json['pincode'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$$ProfileUpdateAddressImplToJson(
  _$ProfileUpdateAddressImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'address_type': instance.addressType,
  'own_visiting': instance.ownVisiting,
  'address1': instance.address1,
  'address2': instance.address2,
  'landmark': instance.landmark,
  'area': instance.area,
  'state': instance.state,
  'city': instance.city,
  'pincode': instance.pincode,
  'status': instance.status,
};

_$ProfileUpdateClinicHospitalDetailsImpl
_$$ProfileUpdateClinicHospitalDetailsImplFromJson(Map<String, dynamic> json) =>
    _$ProfileUpdateClinicHospitalDetailsImpl(
      id: (json['id'] as num).toInt(),
      medicleRegState: json['medicle_reg_state'] as String?,
      medicleRegNo: json['medicle_reg_no'] as String?,
      medicleRegYear: json['medicle_reg_year'] as String?,
      hospclinRegState: json['hospclin_reg_state'] as String?,
      hospclinRegNo: json['hospclin_reg_no'] as String?,
      hospclinRegYear: json['hospclin_reg_year'] as String?,
      retroactive: json['retroactive'] as String?,
      retroactiveDate: json['retroactive_date'] as String?,
      retroactivePolicydoc: json['retroactive_policydoc'] as String?,
      worldwide: json['worldwide'] as String?,
      unqualifiedStaff: json['unqualified_staff'] as String?,
      unqualifiedStaffCount: json['unqualified_staff_count'] as String?,
      opd: json['opd'] as String?,
      ipd: json['ipd'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$ProfileUpdateClinicHospitalDetailsImplToJson(
  _$ProfileUpdateClinicHospitalDetailsImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'medicle_reg_state': instance.medicleRegState,
  'medicle_reg_no': instance.medicleRegNo,
  'medicle_reg_year': instance.medicleRegYear,
  'hospclin_reg_state': instance.hospclinRegState,
  'hospclin_reg_no': instance.hospclinRegNo,
  'hospclin_reg_year': instance.hospclinRegYear,
  'retroactive': instance.retroactive,
  'retroactive_date': instance.retroactiveDate,
  'retroactive_policydoc': instance.retroactivePolicydoc,
  'worldwide': instance.worldwide,
  'unqualified_staff': instance.unqualifiedStaff,
  'unqualified_staff_count': instance.unqualifiedStaffCount,
  'opd': instance.opd,
  'ipd': instance.ipd,
  'status': instance.status,
};
