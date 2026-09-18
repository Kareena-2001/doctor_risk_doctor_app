import 'dart:async';
import 'package:Doctors_App/features/change_password/model/change_password_model.dart';
import 'package:Doctors_App/features/change_password/repository/change_password_repository.dart';
import 'package:Doctors_App/features/change_password/ui/state/change_password_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'change_password_view_model.g.dart';

@Riverpod(keepAlive: true)
class ChangePasswordViewModel extends _$ChangePasswordViewModel {
  @override
  FutureOr<ChangePasswordState> build() async {
    return const ChangePasswordState();
  }

  Future<bool> changePassword(ChangePasswordRequest request) async {
    try {
      state = AsyncData(state.value!.copyWith(isLoading: true));

      final repo = ref.read(changePasswordRepositoryProvider);

      final result = await repo.changePassword(
        oldPassword: request.oldPassword,
        newPassword: request.newPassword,
      );

      state = AsyncData(state.value!.copyWith(isLoading: false, resp: result));

      return true;
    } catch (e) {
      state = AsyncData(
        state.value!.copyWith(isLoading: false, errorMessage: e.toString()),
      );
      return false;
    }
  }
}
