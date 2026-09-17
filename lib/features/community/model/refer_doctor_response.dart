import 'package:freezed_annotation/freezed_annotation.dart';

part 'refer_doctor_response.freezed.dart';
part 'refer_doctor_response.g.dart';

@freezed
class ReferDoctorResponse with _$ReferDoctorResponse {
  const factory ReferDoctorResponse({
    required bool status,
    required int code,
    required String msg,
    required List<dynamic> data,
  }) = _ReferDoctorResponse;

  factory ReferDoctorResponse.fromJson(Map<String, dynamic> json) =>
      _$ReferDoctorResponseFromJson(json);
}