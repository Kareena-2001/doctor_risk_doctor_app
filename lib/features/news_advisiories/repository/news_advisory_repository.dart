import 'package:Doctors_App/core/services/api_client.dart';
import 'package:Doctors_App/core/services/credentials_storage_service.dart';
import 'package:Doctors_App/features/news_advisiories/model/news_advisory_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/credentials_storage_provider.dart';

part 'news_advisory_repository.g.dart';

@Riverpod(keepAlive: true)
NewsAdvisoryRepository newsAdvisoryRepository(NewsAdvisoryRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
  return NewsAdvisoryRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class NewsAdvisoryRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const NewsAdvisoryRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<NewsAdvisoryResponse> newsList({int page = 1, int limit = 10}) async {
    final response = await _apiClient.get(
      url: 'doctor/newsadvisoriesdoctor',
      queryParams: {'page': page.toString(), 'limit': limit.toString()},
      includeAuth: true,
    );

    return NewsAdvisoryResponse.fromJson(response);
  }
}
