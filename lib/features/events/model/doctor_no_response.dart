import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_no_response.freezed.dart';

part 'doctor_no_response.g.dart';

@freezed
class DoctorNoResponse with _$DoctorNoResponse {
  const factory DoctorNoResponse({
    required bool status,
    required int code,
    required String msg,
    required DoctorNoData data,
  }) = _DoctorNoResponse;

  factory DoctorNoResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorNoResponseFromJson(json);
}

@freezed
class DoctorNoData with _$DoctorNoData {
  const factory DoctorNoData({
    required int id,
    @JsonKey(name: 'doctor_no') required String doctorNo,
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    @JsonKey(name: 'mobile_no') required String mobileNo,
    @JsonKey(name: 'doctor_status') required String doctorStatus,
  }) = _DoctorNoData;

  factory DoctorNoData.fromJson(Map<String, dynamic> json) =>
      _$DoctorNoDataFromJson(json);
}
