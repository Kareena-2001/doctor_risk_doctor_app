import 'dart:io';

import 'package:Doctors_App/core/services/api_client.dart';
import 'package:Doctors_App/core/services/credentials_storage_service.dart';
import 'package:Doctors_App/features/authentication/model/register/category_response.dart';
import 'package:Doctors_App/features/authentication/model/register/degree_response.dart';
import 'package:Doctors_App/features/authentication/model/register/speciality_response.dart';
import 'package:Doctors_App/features/profile/model/city_response.dart';
import 'package:Doctors_App/features/profile/model/doctor_profile_response.dart';
import 'package:Doctors_App/features/profile/model/profile_update_response.dart';
import 'package:Doctors_App/features/profile/model/state_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/services/credentials_storage_provider.dart';
import '../model/profile_address_request.dart';

part 'profile_repository.g.dart';

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
  return ProfileRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class ProfileRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const ProfileRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<DoctorProfileResponse> getProfileList() async {
    final response = await _apiClient.get(
      url: 'doctor/doctorprofile',
      includeAuth: true,
    );

    return DoctorProfileResponse.fromJson(response);
  }

  Future<ProfileUpdateResponse> updateProfile({
    File? photo,
    required String prefix,
    required String firstName,
    String? middleName,
    required String lastName,
    required String email,
    required String mobileNo,
    String? alternateNo,
    required String categoryId,
    required String specialityId,
    required String degree,
    String? establishmentName,
    String? dob,
    String? gender,

    required List<ProfileAddressRequest> addresses,

    String? clinicHospitalId,
    String? medicleRegState,
    String? medicleRegNo,
    String? medicleRegYear,
    String? hospclinRegState,
    String? hospclinRegNo,
    String? hospclinRegYear,
    String? retroactive,
    String? retroactiveDate,
    String? retroactivePolicydoc,
    String? worldwide,
    String? unqualifiedStaff,
    String? unqualifiedStaffCount,
    String? opd,
    String? ipd,
  }) async {
    try {
      final Map<String, String> fields = {
        'prifix': prefix,
        'first_name': firstName,
        'middle_name': middleName ?? '',
        'last_name': lastName,
        'email': email,
        'mobile_no': mobileNo,
        'alternate_no': alternateNo ?? '',
        'category_id': categoryId,
        'speciality_id': specialityId,
        'degree': degree,
        'establishment_name': establishmentName ?? '',
        'dob': dob ?? '',
        'gender': gender ?? '',
      };

      for (int i = 0; i < addresses.length; i++) {
        fields.addAll(addresses[i].toMultipartFields(i));
      }

      fields.addAll({
        'clinic_hospital_details[id]': clinicHospitalId ?? '',
        'clinic_hospital_details[medicle_reg_state]': medicleRegState ?? '',
        'clinic_hospital_details[medicle_reg_no]': medicleRegNo ?? '',
        'clinic_hospital_details[medicle_reg_year]': medicleRegYear ?? '',
        'clinic_hospital_details[hospclin_reg_state]': hospclinRegState ?? '',
        'clinic_hospital_details[hospclin_reg_no]': hospclinRegNo ?? '',
        'clinic_hospital_details[hospclin_reg_year]': hospclinRegYear ?? '',
        'clinic_hospital_details[retroactive]': retroactive ?? '',
        'clinic_hospital_details[retroactive_date]': retroactiveDate ?? '',
        'clinic_hospital_details[retroactive_policydoc]':
            retroactivePolicydoc ?? '',
        'clinic_hospital_details[worldwide]': worldwide ?? '',
        'clinic_hospital_details[unqualified_staff]': unqualifiedStaff ?? '',
        'clinic_hospital_details[unqualified_staff_count]':
            unqualifiedStaffCount ?? '',
        'clinic_hospital_details[opd]': opd ?? '',
        'clinic_hospital_details[ipd]': ipd ?? '',
      });

      final Map<String, File> files = {};

      if (photo != null) {
        files['photo'] = photo;
      }
      debugPrint('🟦 PROFILE UPDATE FIELDS');

      fields.forEach((key, value) {
        debugPrint('$key : $value');
      });

      debugPrint('🟦 PROFILE UPDATE FILES');

      files.forEach((key, file) {
        debugPrint('$key : ${file.path}');
      });

      final response = await _apiClient.postMultipart(
        url: 'doctor/profileupdate',
        includeAuth: true,
        fields: fields,
        files: files,
      );

      debugPrint('🟦 Profile Update Response: $response');

      if (response['status'] == true) {
        return ProfileUpdateResponse.fromJson(response);
      }

      throw Exception(response['msg'] ?? 'Profile update failed');
    } catch (e) {
      debugPrint('Profile Update Error: $e');

      if (e is ApiException) {
        throw Exception(e.message);
      }

      throw Exception('Profile update error: ${e.toString()}');
    }
  }

  Future<StateResponse> stateList() async {
    final response = await _apiClient.get(url: 'statelist', includeAuth: true);

    if (response['status'] == true) {
      return StateResponse.fromJson(response);
    }

    throw Exception(response['msg'] ?? 'Failed to fetch states');
  }

  Future<CityResponse> cityList({required String stateId}) async {
    final response = await _apiClient.get(
      url: 'citieslist',
      includeAuth: true,
      queryParams: {'state_id': stateId},
    );

    if (response['status'] == true) {
      return CityResponse.fromJson(response);
    }

    throw Exception(response['msg'] ?? 'Failed to fetch states');
  }

  Future<CategoryResponse> categoryList({required String productTypeId}) async {
    final response = await _apiClient.get(
      url: 'categorylist',
      includeAuth: true,
      queryParams: {'product_type_id': productTypeId},
    );
    if (response['status'] == true) return CategoryResponse.fromJson(response);
    throw Exception(response['msg'] ?? 'Failed to fetch categories');
  }

  Future<SpecialityResponse> specialityList({required String categoryId}) async {
    final response = await _apiClient.get(
      url: 'specialitylist',
      includeAuth: true,
      queryParams: {'category_id': categoryId},
    );
    if (response['status'] == true) return SpecialityResponse.fromJson(response);
    throw Exception(response['msg'] ?? 'Failed to fetch specialities');
  }

  Future<DegreeResponse> degreeList() async {
    final response = await _apiClient.get(url: 'degreelist', includeAuth: true);
    if (response['status'] == true) return DegreeResponse.fromJson(response);
    throw Exception(response['msg'] ?? 'Failed to fetch degrees');
  }

}
