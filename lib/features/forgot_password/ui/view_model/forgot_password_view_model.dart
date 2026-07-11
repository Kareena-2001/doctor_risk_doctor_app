import 'package:Doctors_App/features/forgot_password/repository/forgot_password_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/forgot_password_state.dart';

part 'forgot_password_view_model.g.dart';

@Riverpod(keepAlive: true)
class ForgotPasswordViewModel extends _$ForgotPasswordViewModel {
  @override
  FutureOr<ForgotPasswordState> build() {
    return const ForgotPasswordState();
  }

  Future<void> forgotPassword(String email) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(forgotPasswordRepositoryProvider);
      final result = await repo.forgotPasswordRequest(email);

      state = AsyncData(ForgotPasswordState(forgotPassResp: result));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> otpVerification(String otp) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(forgotPasswordRepositoryProvider);
      final result = await repo.otpVerification(otp);

      state = AsyncData(ForgotPasswordState(otpResp: result));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> createNewPassword(String id, String password) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(forgotPasswordRepositoryProvider);
      final result = await repo.createNewPassword(id, password);
      state = AsyncData(ForgotPasswordState(newPassResp: result));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
