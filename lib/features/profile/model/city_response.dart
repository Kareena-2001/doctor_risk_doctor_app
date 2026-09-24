import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_response.freezed.dart';

part 'city_response.g.dart';

@freezed
class CityResponse with _$CityResponse {
  const factory CityResponse({
    required bool status,
    required int code,
    required String msg,
    required List<CityModel> data,
  }) = _CityResponse;

  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);
}

@freezed
class CityModel with _$CityModel {
  const factory CityModel({required int id, required String name}) = _CityModel;

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
}
