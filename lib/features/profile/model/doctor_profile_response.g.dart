// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoctorProfileResponseImpl _$$DoctorProfileResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DoctorProfileResponseImpl(
  status: json['status'] as bool,
  code: (json['code'] as num).toInt(),
  msg: json['msg'] as String,
  data: DoctorProfileData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$DoctorProfileResponseImplToJson(
  _$DoctorProfileResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'code': instance.code,
  'msg': instance.msg,
  'data': instance.data,
};

_$DoctorProfileDataImpl _$$DoctorProfileDataImplFromJson(
  Map<String, dynamic> json,
) => _$DoctorProfileDataImpl(
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
  categoryName: json['category_name'] as String?,
  specialityName: json['speciality_name'] as String?,
  degree: json['degree'] as String?,
  establishmentName: json['establishment_name'] as String?,
  dob: json['dob'] as String?,
  gender: json['gender'] as String?,
  addresses:
      (json['addresses'] as List<dynamic>?)
          ?.map((e) => DoctorAddress.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  clinicHospitalDetails: json['clinic_hospital_details'] == null
      ? null
      : DoctorClinicHospitalDetails.fromJson(
          json['clinic_hospital_details'] as Map<String, dynamic>,
        ),
  documents:
      (json['documents'] as List<dynamic>?)
          ?.map((e) => DoctorDocument.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DoctorProfileDataImplToJson(
  _$DoctorProfileDataImpl instance,
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
  'category_name': instance.categoryName,
  'speciality_name': instance.specialityName,
  'degree': instance.degree,
  'establishment_name': instance.establishmentName,
  'dob': instance.dob,
  'gender': instance.gender,
  'addresses': instance.addresses,
  'clinic_hospital_details': instance.clinicHospitalDetails,
  'documents': instance.documents,
};

_$DoctorAddressImpl _$$DoctorAddressImplFromJson(Map<String, dynamic> json) =>
    _$DoctorAddressImpl(
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

Map<String, dynamic> _$$DoctorAddressImplToJson(_$DoctorAddressImpl instance) =>
    <String, dynamic>{
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

_$DoctorClinicHospitalDetailsImpl _$$DoctorClinicHospitalDetailsImplFromJson(
  Map<String, dynamic> json,
) => _$DoctorClinicHospitalDetailsImpl(
  id: (json['id'] as num?)?.toInt(),
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

Map<String, dynamic> _$$DoctorClinicHospitalDetailsImplToJson(
  _$DoctorClinicHospitalDetailsImpl instance,
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

_$DoctorDocumentImpl _$$DoctorDocumentImplFromJson(Map<String, dynamic> json) =>
    _$DoctorDocumentImpl(
      id: (json['id'] as num).toInt(),
      docName: json['doc_name'] as String?,
      documents: json['documents'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$DoctorDocumentImplToJson(
  _$DoctorDocumentImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'doc_name': instance.docName,
  'documents': instance.documents,
  'status': instance.status,
};
