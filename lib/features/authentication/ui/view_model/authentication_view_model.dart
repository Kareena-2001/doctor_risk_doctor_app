import 'package:Doctors_App/features/authentication/model/register/register_request.dart';
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

  AuthenticationState get _current =>
      state.valueOrNull ?? const AuthenticationState();

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

  Future<void> register(RegisterRequest request) async {
    // Keep the reference lists (category/speciality/degree) around while
    // the sign up request is in flight, so the form doesn't flash back to
    // "loading" state for its dropdowns while submitting.
    final current = _current;
    state = AsyncData(current);

    try {
      final repository = ref.read(authenticationRepositoryProvider);
      final response = await repository.register(request);

      state = AsyncData(_current.copyWith(signUpResponse: response));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<void> categoryList() async {
    state = AsyncData(_current.copyWith(categoryAsync: const AsyncLoading()));

    try {
      final repository = ref.read(authenticationRepositoryProvider);
      final response = await repository.categoryList();

      state = AsyncData(_current.copyWith(categoryAsync: AsyncData(response)));
    } catch (error, stackTrace) {
      state = AsyncData(
        _current.copyWith(categoryAsync: AsyncError(error, stackTrace)),
      );
    }
  }

  Future<void> specialityList({required String categoryId}) async {
    state = AsyncData(_current.copyWith(specialityAsync: const AsyncLoading()));

    try {
      final repository = ref.read(authenticationRepositoryProvider);
      final response = await repository.specialityList(categoryId: categoryId);

      state = AsyncData(
        _current.copyWith(specialityAsync: AsyncData(response)),
      );
    } catch (error, stackTrace) {
      state = AsyncData(
        _current.copyWith(specialityAsync: AsyncError(error, stackTrace)),
      );
    }
  }

  void resetSpeciality() {
    state = AsyncData(
      _current.copyWith(specialityAsync: const AsyncData(null)),
    );
  }

  Future<void> degreeList() async {
    state = AsyncData(_current.copyWith(degreeAsync: const AsyncLoading()));

    try {
      final repository = ref.read(authenticationRepositoryProvider);
      final response = await repository.degreeList();

      state = AsyncData(_current.copyWith(degreeAsync: AsyncData(response)));
    } catch (error, stackTrace) {
      state = AsyncData(
        _current.copyWith(degreeAsync: AsyncError(error, stackTrace)),
      );
    }
  }

  void resetSignUpState() {
    state = AsyncData(_current.copyWith(signUpResponse: null));
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
