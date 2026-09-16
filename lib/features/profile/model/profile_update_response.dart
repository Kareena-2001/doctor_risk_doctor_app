import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_update_response.freezed.dart';

part 'profile_update_response.g.dart';

@freezed
class ProfileUpdateResponse with _$ProfileUpdateResponse {
  const factory ProfileUpdateResponse({
    required bool status,
    required int code,
    required String msg,
    required ProfileUpdateData data,
  }) = _ProfileUpdateResponse;

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateResponseFromJson(json);
}

@freezed
class ProfileUpdateData with _$ProfileUpdateData {
  const factory ProfileUpdateData({required ProfileUpdateProfile profile}) =
      _ProfileUpdateData;

  factory ProfileUpdateData.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateDataFromJson(json);
}

@freezed
class ProfileUpdateProfile with _$ProfileUpdateProfile {
  const factory ProfileUpdateProfile({
    required int id,
    @JsonKey(name: 'doctor_no') String? doctorNo,
    String? photo,
    @JsonKey(name: 'organization_name') String? organizationName,
    String? prifix,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'middle_name') String? middleName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'full_name') String? fullName,
    String? email,
    @JsonKey(name: 'mobile_no') String? mobileNo,
    @JsonKey(name: 'alternate_no') String? alternateNo,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'speciality_id') String? specialityId,
    @JsonKey(name: 'speciality_name') String? specialityName,
    String? degree,
    @JsonKey(name: 'establishment_name') String? establishmentName,
    String? dob,
    String? gender,
    @Default([]) List<ProfileUpdateAddress> addresses,
    @JsonKey(name: 'clinic_hospital_details')
    ProfileUpdateClinicHospitalDetails? clinicHospitalDetails,
  }) = _ProfileUpdateProfile;

  factory ProfileUpdateProfile.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateProfileFromJson(json);
}

@freezed
class ProfileUpdateAddress with _$ProfileUpdateAddress {
  const factory ProfileUpdateAddress({
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
  }) = _ProfileUpdateAddress;

  factory ProfileUpdateAddress.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateAddressFromJson(json);
}

@freezed
class ProfileUpdateClinicHospitalDetails
    with _$ProfileUpdateClinicHospitalDetails {
  const factory ProfileUpdateClinicHospitalDetails({
    required int id,

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
  }) = _ProfileUpdateClinicHospitalDetails;

  factory ProfileUpdateClinicHospitalDetails.fromJson(
    Map<String, dynamic> json,
  ) => _$ProfileUpdateClinicHospitalDetailsFromJson(json);
}
