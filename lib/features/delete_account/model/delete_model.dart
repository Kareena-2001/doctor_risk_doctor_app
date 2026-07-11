import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_model.freezed.dart';

part 'delete_model.g.dart';

@freezed
class DeleteAcResponse with _$DeleteAcResponse {
  const factory DeleteAcResponse({required int status, required String msg}) =
      _DeleteAcResponse;

  factory DeleteAcResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteAcResponseFromJson(json);
}
