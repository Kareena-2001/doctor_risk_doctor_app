import 'package:freezed_annotation/freezed_annotation.dart';

part 'referred_doctors_response.freezed.dart';
part 'referred_doctors_response.g.dart';

@freezed
class ReferredDoctorsResponse with _$ReferredDoctorsResponse {
  const factory ReferredDoctorsResponse({
    required bool status,
    required int code,
    required String msg,
    @Default([]) List<ReferredDoctor> data,
    required int total,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'last_page') required int lastPage,
    @JsonKey(name: 'per_page') required int perPage,
  }) = _ReferredDoctorsResponse;

  factory ReferredDoctorsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReferredDoctorsResponseFromJson(json);
}

@freezed
class ReferredDoctor with _$ReferredDoctor {
  const factory ReferredDoctor({
    @JsonKey(name: 'created_on') required String createdOn,
    @JsonKey(name: 'full_name') required String fullName,
    required String status,
  }) = _ReferredDoctor;

  factory ReferredDoctor.fromJson(Map<String, dynamic> json) =>
      _$ReferredDoctorFromJson(json);
}