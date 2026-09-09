import 'package:Doctors_App/features/authentication/model/register/sign_up_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/login/login_response.dart';

part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    LoginResponse? response,
    SignUpResponse? signUpResponse,
  }) = _AuthenticationState;
}