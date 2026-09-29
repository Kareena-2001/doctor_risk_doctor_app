import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_remark_model.freezed.dart';

part 'add_remark_model.g.dart';

@freezed
class AddRemarkResponse with _$AddRemarkResponse {
  const factory AddRemarkResponse({
    required bool status,
    required int code,
    required String msg,
    required List<dynamic> data,
  }) = _AddRemarkResponse;

  factory AddRemarkResponse.fromJson(Map<String, dynamic> json) =>
      _$AddRemarkResponseFromJson(json);
}
