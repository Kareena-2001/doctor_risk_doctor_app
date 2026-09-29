import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_request_resp.freezed.dart';

part 'add_request_resp.g.dart';

@freezed
class AddRequestResp with _$AddRequestResp {
  const factory AddRequestResp({
    required int status,
    required String msg,
    AddRequestData? data,
  }) = _AddRequestResp;

  factory AddRequestResp.fromJson(Map<String, dynamic> json) =>
      _$AddRequestRespFromJson(json);
}

@freezed
class AddRequestData with _$AddRequestData {
  const factory AddRequestData({
    @JsonKey(name: 'tkt_number') required String ticketNumber,
  }) = _AddRequestData;

  factory AddRequestData.fromJson(Map<String, dynamic> json) =>
      _$AddRequestDataFromJson(json);
}
