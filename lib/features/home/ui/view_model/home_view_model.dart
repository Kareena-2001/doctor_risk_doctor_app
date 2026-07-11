import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/user_profile_model.dart';
import '../../repository/home_repository.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  Future<UserProfileResponse?> build() async {
    return fetchProfileData();
  }

  Future<UserProfileResponse?> fetchProfileData() async {
    final repository = ref.read(homeRepositoryProvider);
    return await repository.fetchProfileData();
  }

  Future<void> retryFetch() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
    await build();
  }
}
