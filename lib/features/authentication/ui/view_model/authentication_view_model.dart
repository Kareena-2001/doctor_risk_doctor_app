import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repository/authentication_repository.dart';
import '../state/authentication_state.dart';

part 'authentication_view_model.g.dart';

@Riverpod(keepAlive: true)
class AuthenticationViewModel extends _$AuthenticationViewModel {
  @override
  FutureOr<AuthenticationState> build() {
    return const AuthenticationState(); //sync
  }

  Future<void> login({
    required String mobile,
    required String password,
    required String fcmToken,
    required String deviceId,
    required String platform,
    bool rememberMe = false,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(authenticationRepositoryProvider);
      final result = await repo.login(
        mobile: mobile,
        password: password,
        fcmToken: fcmToken,
        deviceToken: deviceId,
        platform: platform,
        rememberMe: rememberMe,
      );
      state = AsyncData(AuthenticationState(model: result));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signOut() async {
    try {
      final repo = ref.read(authenticationRepositoryProvider);
      await repo.signOut();
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
