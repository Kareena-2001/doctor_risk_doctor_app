import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_model.freezed.dart';

part 'change_password_model.g.dart';

@freezed
class ChangePasswordRequest with _$ChangePasswordRequest {
  const factory ChangePasswordRequest({
    @JsonKey(name: 'old_password') required String oldPassword,
    @JsonKey(name: 'new_password') required String newPassword,
    @JsonKey(name: 'confirm_password') required String confirmPassword,
  }) = _ChangePasswordRequest;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);
}

@freezed
class ChangePasswordResponse with _$ChangePasswordResponse {
  const factory ChangePasswordResponse({
    required bool status,
    required int code,
    String? msg,
    @Default([]) List<dynamic> data,
  }) = _ChangePasswordResponse;

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);
}
