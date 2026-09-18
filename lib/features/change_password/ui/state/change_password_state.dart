import 'package:Doctors_App/features/change_password/model/change_password_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_state.freezed.dart';

@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState({
    @Default(false) bool isLoading,
    String? errorMessage,
    ChangePasswordResponse? resp,
  }) = _ChangePasswordState;
}
