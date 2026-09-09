import 'package:freezed_annotation/freezed_annotation.dart';

part 'speciality_response.freezed.dart';

part 'speciality_response.g.dart';

@freezed
class SpecialityResponse with _$SpecialityResponse {
  const factory SpecialityResponse({
    required bool status,
    required int code,
    required String msg,
    required List<SpecialityModel> data,
  }) = _SpecialityResponse;

  factory SpecialityResponse.fromJson(Map<String, dynamic> json) =>
      _$SpecialityResponseFromJson(json);
}

@freezed
class SpecialityModel with _$SpecialityModel {
  const factory SpecialityModel({required int id, required String name}) =
      _SpecialityModel;

  factory SpecialityModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialityModelFromJson(json);
}
