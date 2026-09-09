import 'package:freezed_annotation/freezed_annotation.dart';

part 'degree_response.freezed.dart';

part 'degree_response.g.dart';

@freezed
class DegreeResponse with _$DegreeResponse {
  const factory DegreeResponse({
    required bool status,
    required int code,
    required String msg,
    required List<DegreeModel> data,
  }) = _DegreeResponse;

  factory DegreeResponse.fromJson(Map<String, dynamic> json) =>
      _$DegreeResponseFromJson(json);
}

@freezed
class DegreeModel with _$DegreeModel {
  const factory DegreeModel({required int id, required String name}) =
      _DegreeModel;

  factory DegreeModel.fromJson(Map<String, dynamic> json) =>
      _$DegreeModelFromJson(json);
}
