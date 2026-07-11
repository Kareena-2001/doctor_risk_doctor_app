import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_model.freezed.dart';

part 'otp_model.g.dart';

@freezed
class OtpRequest with _$OtpRequest {
  const factory OtpRequest({required String otp}) = _OtpRequest;

  factory OtpRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpRequestFromJson(json);
}

@freezed
class OtpResponse with _$OtpResponse {
  const factory OtpResponse({
    required int status,
    required String message,
    required OtpData data,
  }) = _OtpResponse;

  factory OtpResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseFromJson(json);
}

@freezed
class OtpData with _$OtpData {
  const factory OtpData({required String userid}) = _OtpData;

  factory OtpData.fromJson(Map<String, dynamic> json) =>
      _$OtpDataFromJson(json);
}
