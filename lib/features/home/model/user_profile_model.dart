import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';

part 'user_profile_model.g.dart';

@freezed
class UserProfileResponse with _$UserProfileResponse {
  const factory UserProfileResponse({
    required int status,
    required String msg,
    required UserProfileModel data,
  }) = _UserProfileResponse;

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);
}

@freezed
class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    String? id,

    @JsonKey(name: 'full_name') String? fullName,
    String? mobile,
    String? email,
    String? dob,
    String? photo,

    @JsonKey(name: 'blood_group') String? bloodGroup,
    @JsonKey(name: 'marital_status') String? maritalStatus,
    String? religion,
    String? nationality,

    @JsonKey(name: 'father_name') String? fatherName,
    @JsonKey(name: 'emergency_name') String? emergencyName,
    @JsonKey(name: 'emergency_contact') String? emergencyContact,

    @JsonKey(name: 'physical_disability') String? physicalDisability,
    @JsonKey(name: 't_shirt_size') String? tShirtSize,
    String? password,
    @JsonKey(name: 'trouser_size') String? trouserSize,

    @JsonKey(name: 'experience_status') String? experienceStatus,
    @JsonKey(name: 'total_experience_year') String? totalExperienceYear,
    @JsonKey(name: 'total_experience_month') String? totalExperienceMonth,
    @JsonKey(name: 'currently_employed') String? currentlyEmployed,

    @JsonKey(name: 'application_status') String? applicationStatus,
    @JsonKey(name: 'company_name') String? companyName,
    @JsonKey(name: 'hrms_employee_code') String? hrmsEmployeeCode,
    @JsonKey(name: 'employee_contact_number') String? employeeContactNumber,

    @JsonKey(name: 'vendor_employee_code') String? vendorEmployeeCode,
    @JsonKey(name: 'vendor_name') String? vendorName,
    String? doj,
    String? department,

    @JsonKey(name: 'store_code') String? storeCode,
    @JsonKey(name: 'store_location') String? storeLocation,
    @JsonKey(name: 'store_city') String? storeCity,
    String? designation,

    @JsonKey(name: 'manager_email') String? managerEmail,
    String? gender,
    @JsonKey(name: 'skill_set') String? skillSet,
    String? state,

    @JsonKey(name: 'separation_date') String? separationDate,
    @JsonKey(name: 'last_working_date') String? lastWorkingDate,
    @JsonKey(name: 'separation_type') String? separationType,

    @JsonKey(name: 'ol_generate') String? olGenerate,
    @JsonKey(name: 'ol_generate_date') String? olGenerateDate,
    @JsonKey(name: 'send_ol_letter') String? sendOlLetter,

    String? status,
    @JsonKey(name: 'added_on') String? addedOn,
    @JsonKey(name: 'updated_on') String? updatedOn,

    @Default(false) bool? attendance,
    @JsonKey(name: 'attend_type') String? attendType,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
}
