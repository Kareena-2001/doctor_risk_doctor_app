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

      // Token has already been saved by the repository.
      // Now decode the latest token and update UserProvider.
      await ref.read(userProviderProvider.notifier).refreshUserData();

      // FIX: logout bumps the epoch, which immediately reruns
      // ProfileViewModel.build() — but that happens while we're still
      // on the login screen with no token yet, so it caches a "Token
      // not found" error. Bumping again here, after the new token is
      // saved, forces ProfileViewModel to rebuild once more — this
      // time with a valid token — instead of getting stuck showing
      // that stale error after login.
      // ref.read(sessionEpochProvider.notifier).bump();

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

      // FIX: forces keepAlive providers (e.g. ProfileViewModel) to
      // refetch on next login instead of serving stale/errored state.
      // ref.read(sessionEpochProvider.notifier).bump();

      state = const AsyncData(AuthenticationState());
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);

      rethrow;
    }
  }

  // Future<void> login({
  //   required String login,
  //   required String password,
  //   required String deviceToken,
  //   required String fcmToken,
  //   required String deviceId,
  //   required String platform,
  //   bool rememberMe = false,
  // }) async {
  //   state = const AsyncLoading();
  //   try {
  //     final repo = ref.read(authenticationRepositoryProvider);
  //     final result = await repo.login(
  //       login: login,
  //       password: password,
  //       deviceToken: deviceToken,
  //       fcmToken: fcmToken,
  //       deviceId: deviceId,
  //       platform: platform,
  //       rememberMe: rememberMe,
  //     );
  //     state = AsyncData(AuthenticationState(model: result));
  //   } catch (e, st) {
  //     state = AsyncError(e, st);
  //   }
  // }
  //
  // Future<void> signOut() async {
  //   try {
  //     final repo = ref.read(authenticationRepositoryProvider);
  //     await repo.signOut();
  //   } catch (e, st) {
  //     state = AsyncError(e, st);
  //     rethrow;
  //   }
  // }
}
