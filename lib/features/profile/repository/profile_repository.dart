import 'package:Doctors_App/core/services/api_client.dart';
import 'package:Doctors_App/core/services/credentials_storage_service.dart';
import 'package:Doctors_App/features/profile/model/doctor_profile_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/credentials_storage_provider.dart';

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
}
