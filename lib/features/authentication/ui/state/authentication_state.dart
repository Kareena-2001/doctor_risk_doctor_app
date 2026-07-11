import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/authentication_model.dart';

part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    String? errorMessage,
    @Default(false) bool isLoading,
    AuthenticationModel? model,
  }) = _AuthenticationState;
}
