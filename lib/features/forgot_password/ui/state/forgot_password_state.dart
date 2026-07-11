import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/forgot_password_request.dart';
import '../../model/new_password_model.dart';
import '../../model/otp_model.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    ForgotPasswordResponse? forgotPassResp,
    OtpResponse? otpResp,
    NewPasswordResponse? newPassResp,
  }) = _ForgotPasswordState;
}
