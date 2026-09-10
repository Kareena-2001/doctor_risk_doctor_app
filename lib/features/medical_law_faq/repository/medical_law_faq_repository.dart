import 'package:Doctors_App/core/services/api_client.dart';
import 'package:Doctors_App/core/services/credentials_storage_service.dart';
import 'package:Doctors_App/features/medical_law_faq/model/medical_law_faq_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/credentials_storage_provider.dart';

part 'medical_law_faq_repository.g.dart';

@Riverpod(keepAlive: true)
MedicalLawFaqRepository medicalLawFaqRepository(
  MedicalLawFaqRepositoryRef ref,
) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
  return MedicalLawFaqRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class MedicalLawFaqRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const MedicalLawFaqRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<MedicalLawFaqResponse> medicalFaqList() async {
    final response = await _apiClient.get(
      url: 'doctor/medicallawdoctor',
      includeAuth: true,
    );

    return MedicalLawFaqResponse.fromJson(response);
  }
}
