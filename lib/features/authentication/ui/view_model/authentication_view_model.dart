import 'package:Doctors_App/features/authentication/ui/view_model/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repository/authentication_repository.dart';
import '../state/authentication_state.dart';

part 'authentication_view_model.g.dart';

@Riverpod(keepAlive: true)
class AuthenticationViewModel extends _$AuthenticationViewModel {
  @override
  FutureOr<AuthenticationState> build() {
    return const AuthenticationState();
  }

  Future<void> login({
    required String login,
    required String password,
    required String deviceToken,
    required String fcmToken,
    required String deviceId,
    required String platform,
    bool rememberMe = false,
  }) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(authenticationRepositoryProvider);

      final response = await repository.login(
        login: login,
        password: password,
        deviceToken: deviceToken,
        fcmToken: fcmToken,
        deviceId: deviceId,
        platform: platform,
        rememberMe: rememberMe,
      );
      await ref.read(userProviderProvider.notifier).refreshUserData();

      state = AsyncData(AuthenticationState(response: response));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> signOut() async {
    try {
      final repository = ref.read(authenticationRepositoryProvider);

      await repository.signOut();

      ref.read(userProviderProvider.notifier).clearUserData();

      state = const AsyncData(AuthenticationState());
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);

      rethrow;
    }
  }
}
