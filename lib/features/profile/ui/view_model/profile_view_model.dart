import 'dart:async';

import 'package:Doctors_App/features/profile/repository/profile_repository.dart';
import 'package:Doctors_App/features/profile/ui/state/profile_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_view_model.g.dart';

@Riverpod(keepAlive: true)
class ProfileViewModel extends _$ProfileViewModel {
  @override
  FutureOr<ProfileState> build() {
    return const ProfileState();
  }

  Future<void> getProfile() async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(profileRepositoryProvider);

      final response = await repository.getProfileList();

      state = AsyncData(ProfileState(profileData: response.data));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> refreshProfile() => getProfile();
}
