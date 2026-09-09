import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/login_response.dart';

part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    String? errorMessage,
    @Default(false) bool isLoading,
    LoginResponse? response,
  }) = _AuthenticationState;
}
