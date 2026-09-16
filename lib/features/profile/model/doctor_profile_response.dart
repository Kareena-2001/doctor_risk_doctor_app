import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_profile_response.freezed.dart';

part 'doctor_profile_response.g.dart';

@freezed
class DoctorProfileResponse with _$DoctorProfileResponse {
  const factory DoctorProfileResponse({
    required bool status,
    required int code,
    required String msg,
    required DoctorProfileData data,
  }) = _DoctorProfileResponse;

  factory DoctorProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorProfileResponseFromJson(json);
}

@freezed
class DoctorProfileData with _$DoctorProfileData {
  const factory DoctorProfileData({
    required int id,

    @JsonKey(name: 'doctor_no') String? doctorNo,

    String? photo,

    @JsonKey(name: 'organization_name') String? organizationName,

    @JsonKey(name: 'prifix') String? prifix,

    @JsonKey(name: 'first_name') String? firstName,

    @JsonKey(name: 'middle_name') String? middleName,

    @JsonKey(name: 'last_name') String? lastName,

    @JsonKey(name: 'full_name') String? fullName,

    String? email,

    @JsonKey(name: 'mobile_no') String? mobileNo,

    @JsonKey(name: 'alternate_no') String? alternateNo,

    @JsonKey(name: 'category_name') String? categoryName,

    @JsonKey(name: 'speciality_name') String? specialityName,

    String? degree,

    @JsonKey(name: 'establishment_name') String? establishmentName,

    String? dob,

    String? gender,

    @Default([]) List<DoctorAddress> addresses,

    @JsonKey(name: 'clinic_hospital_details')
    DoctorClinicHospitalDetails? clinicHospitalDetails,

    @Default([]) List<DoctorDocument> documents,
  }) = _DoctorProfileData;

  factory DoctorProfileData.fromJson(Map<String, dynamic> json) =>
      _$DoctorProfileDataFromJson(json);
}

@freezed
class DoctorAddress with _$DoctorAddress {
  const factory DoctorAddress({
    required int id,

    @JsonKey(name: 'address_type') String? addressType,

    @JsonKey(name: 'own_visiting') String? ownVisiting,

    String? address1,

    String? address2,

    String? landmark,

    String? area,

    String? state,

    String? city,

    String? pincode,

    String? status,
  }) = _DoctorAddress;

  factory DoctorAddress.fromJson(Map<String, dynamic> json) =>
      _$DoctorAddressFromJson(json);
}

@freezed
class DoctorClinicHospitalDetails with _$DoctorClinicHospitalDetails {
  const factory DoctorClinicHospitalDetails({
    int? id,

    @JsonKey(name: 'medicle_reg_state') String? medicleRegState,

    @JsonKey(name: 'medicle_reg_no') String? medicleRegNo,

    @JsonKey(name: 'medicle_reg_year') String? medicleRegYear,

    @JsonKey(name: 'hospclin_reg_state') String? hospclinRegState,

    @JsonKey(name: 'hospclin_reg_no') String? hospclinRegNo,

    @JsonKey(name: 'hospclin_reg_year') String? hospclinRegYear,

    String? retroactive,

    @JsonKey(name: 'retroactive_date') String? retroactiveDate,

    @JsonKey(name: 'retroactive_policydoc') String? retroactivePolicydoc,

    String? worldwide,

    @JsonKey(name: 'unqualified_staff') String? unqualifiedStaff,

    @JsonKey(name: 'unqualified_staff_count') String? unqualifiedStaffCount,

    String? opd,
    String? ipd,
    String? status,
  }) = _DoctorClinicHospitalDetails;

  factory DoctorClinicHospitalDetails.fromJson(Map<String, dynamic> json) =>
      _$DoctorClinicHospitalDetailsFromJson(json);
}

@freezed
class DoctorDocument with _$DoctorDocument {
  const factory DoctorDocument({
    required int id,

    @JsonKey(name: 'doc_name') String? docName,

    String? documents,

    String? status,
  }) = _DoctorDocument;

  factory DoctorDocument.fromJson(Map<String, dynamic> json) =>
      _$DoctorDocumentFromJson(json);
}
