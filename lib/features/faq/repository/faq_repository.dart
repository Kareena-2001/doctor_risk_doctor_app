import 'package:Doctors_App/core/services/api_client.dart';
import 'package:Doctors_App/core/services/credentials_storage_service.dart';
import 'package:Doctors_App/features/faq/model/faq_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/credentials_storage_provider.dart';

part 'faq_repository.g.dart';

@Riverpod(keepAlive: true)
FaqRepository faqRepository(FaqRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
  return FaqRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}


class FaqRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const FaqRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<FaqResponse> faqList({int page = 1, int limit = 10}) async {
    final response = await _apiClient.get(
      url: 'doctor/faqdoctor',
      queryParams: {'page': page.toString(), 'limit': limit.toString()},
      includeAuth: true,
    );

    return FaqResponse.fromJson(response);
  }
}
