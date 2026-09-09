import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_response.freezed.dart';

part 'sign_up_response.g.dart';

@freezed
class SignUpResponse with _$SignUpResponse {
  const factory SignUpResponse({
    required bool status,
    required int code,
    required String msg,
    required List<dynamic> data,
  }) = _SignUpResponse;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);
}
