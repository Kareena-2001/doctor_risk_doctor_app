import 'package:Doctors_App/core/services/api_client.dart';
import 'package:Doctors_App/core/services/credentials_storage_service.dart';
import 'package:Doctors_App/features/rewards/model/reward_points_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/credentials_storage_provider.dart';

part 'rewards_repository.g.dart';

@Riverpod(keepAlive: true)
RewardsRepository rewardsRepository(RewardsRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);

  return RewardsRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class RewardsRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const RewardsRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<RewardPointsResponse> getRewardsPoints({
    String? rewardPointType,
    String? text,
    String? startDate,
    String? endDate,
    int? page,
    int? limit,
  }) async {
    final Map<String, String> queryParams = {};

    if (rewardPointType != null && rewardPointType.isNotEmpty) {
      queryParams['reward_point_type'] = rewardPointType;
    }

    if (text != null && text.isNotEmpty) {
      queryParams['text'] = text;
    }

    if (startDate != null && startDate.isNotEmpty) {
      queryParams['start_date'] = startDate;
    }

    if (endDate != null && endDate.isNotEmpty) {
      queryParams['end_date'] = endDate;
    }

    if (page != null) {
      queryParams['page'] = page.toString();
    }

    if (limit != null) {
      queryParams['limit'] = limit.toString();
    }

    final response = await _apiClient.get(
      url: 'doctor/doctorrewardpoints',
      queryParams: queryParams,
      includeAuth: true,
    );

    return RewardPointsResponse.fromJson(response);
  }
}
