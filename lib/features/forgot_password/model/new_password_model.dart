import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_password_model.freezed.dart';

part 'new_password_model.g.dart';

@freezed
class NewPasswordRequest with _$NewPasswordRequest {
  const factory NewPasswordRequest({
    required String id,
    required String password,
  }) = _NewPasswordRequest;

  factory NewPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$NewPasswordRequestFromJson(json);
}

@freezed
class NewPasswordResponse with _$NewPasswordResponse {
  const factory NewPasswordResponse({
    required int status,
    required String message,
    required List<dynamic> data,
  }) = _NewPasswordResponse;

  factory NewPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$NewPasswordResponseFromJson(json);
}
