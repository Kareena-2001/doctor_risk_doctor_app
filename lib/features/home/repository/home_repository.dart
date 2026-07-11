import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/values/app_constants.dart';
import '../../../core/services/api_client.dart';
import '../model/user_profile_model.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository(ref.watch(apiClientProvider));
}

class HomeRepository {
  final ApiClient _api;

  const HomeRepository(this._api);

  Future<UserProfileResponse> fetchProfileData() async {
    final response = await _api.get(url: 'user_profile');

    if (response['status'] == 200) {
      return UserProfileResponse.fromJson(response);
    }
    throw Exception(response['msg'] ?? 'Failed to submit');
  }
}
