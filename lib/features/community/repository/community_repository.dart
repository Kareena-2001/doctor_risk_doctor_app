import 'package:Doctors_App/core/services/api_client.dart';
import 'package:Doctors_App/core/services/credentials_storage_provider.dart';
import 'package:Doctors_App/core/services/credentials_storage_service.dart';
import 'package:Doctors_App/features/authentication/model/register/category_response.dart';
import 'package:Doctors_App/features/authentication/model/register/degree_response.dart';
import 'package:Doctors_App/features/authentication/model/register/speciality_response.dart';
import 'package:Doctors_App/features/community/model/doctor_no_response.dart';
import 'package:Doctors_App/features/community/model/peer_forum_response.dart';
import 'package:Doctors_App/features/community/model/referred_doctors_response.dart';
import 'package:Doctors_App/features/community/model/testimonial_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/refer_doctor_response.dart';

part 'community_repository.g.dart';

@Riverpod(keepAlive: true)
CommunityRepository communityRepository(CommunityRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
  return CommunityRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class CommunityRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const CommunityRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<PeerForumResponse> getAllPeerForumList({
    String? tab,
    String? title,
    String? search,
    String? sortBy,
    int page = 1,
    int limit = 10,
    int? time,
  }) async {
    if (time != null && ![7, 30, 90].contains(time)) {
      throw ArgumentError('time must be 7, 30, 90 or null (all)');
    }

    final response = await _apiClient.get(
      url: 'doctor/peerforumlist',
      includeAuth: true,
      queryParams: {
        if (tab != null && tab.isNotEmpty) 'tab': tab,
        if (title != null && title.isNotEmpty) 'title': title,
        if (search != null && search.isNotEmpty) 'search': search,
        if (sortBy != null && sortBy.isNotEmpty) 'sort_by': sortBy,
        'page': page.toString(),
        'limit': limit.toString(),
        if (time != null) 'time': time.toString(),
      },
    );

    return PeerForumResponse.fromJson(response);
  }

  Future<TestimonialResponse> getAllTestimonialList() async {
    final response = await _apiClient.get(
      url: 'doctor/testimoniallist',
      includeAuth: true,
    );

    return TestimonialResponse.fromJson(response);
  }

  Future<DoctorNoResponse> referralCode() async {
    final response = await _apiClient.get(
      url: 'doctor/doctorno',
      includeAuth: true,
    );

    return DoctorNoResponse.fromJson(response);
  }

  Future<ReferDoctorResponse> addReferral({
    required String firstName,
    String? middleName,
    required String lastName,
    required String mobileNo,
    String? email,
    int? categoryId,
    int? specialityId,
    List<String>? degrees,
    String? remark,
  }) async {
    final formData = <String, String>{
      'first_name': firstName,
      'middle_name': middleName ?? '',
      'last_name': lastName,
      'mobile_no': mobileNo,
      'email': email ?? '',
      'category_id': categoryId?.toString() ?? '',
      'speciality_id': specialityId?.toString() ?? '',
      'remark': remark ?? '',
    };

    if (degrees != null && degrees.isNotEmpty) {
      for (var i = 0; i < degrees.length; i++) {
        formData['degree[$i]'] = degrees[i];
      }
    } else {
      formData['degree'] = '';
    }

    final response = await _apiClient.post(
      url: 'doctor/referdoctor',
      formData: formData,
      includeAuth: true,
    );

    return ReferDoctorResponse.fromJson(response);
  }

  Future<ReferredDoctorsResponse> referDoctorList() async {
    final response = await _apiClient.get(
      url: 'doctor/referdoctorlist',
      includeAuth: true,
    );

    return ReferredDoctorsResponse.fromJson(response);
  }

  Future<CategoryResponse> categoryList({required String productTypeId}) async {
    final response = await _apiClient.get(
      url: 'doctor/allcategorylist',
      includeAuth: true,
    );

    return CategoryResponse.fromJson(response);
  }

  Future<SpecialityResponse> specialityList({
    required String categoryId,
  }) async {
    final response = await _apiClient.get(
      url: 'doctor/specialitylist',
      queryParams: {'category_id': categoryId},
      includeAuth: true,
    );

    return SpecialityResponse.fromJson(response);
  }

  Future<DegreeResponse> degreeList() async {
    final response = await _apiClient.get(
      url: 'doctor/degree',
      includeAuth: true,
    );

    return DegreeResponse.fromJson(response);
  }
}
