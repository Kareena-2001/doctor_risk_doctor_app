import 'package:freezed_annotation/freezed_annotation.dart';

part 'state_response.freezed.dart';
part 'state_response.g.dart';

@freezed
class StateResponse with _$StateResponse {
  const factory StateResponse({
    required bool status,
    required int code,
    required String msg,
    required List<StateModel> data,
  }) = _StateResponse;

  factory StateResponse.fromJson(Map<String, dynamic> json) =>
      _$StateResponseFromJson(json);
}

@freezed
class StateModel with _$StateModel {
  const factory StateModel({
    required int id,
    required String name,
  }) = _StateModel;

  factory StateModel.fromJson(Map<String, dynamic> json) =>
      _$StateModelFromJson(json);
}