import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_collaboration_response.freezed.dart';

part 'add_collaboration_response.g.dart';

@freezed
class AddCollaborationResponse with _$AddCollaborationResponse {
  const factory AddCollaborationResponse({
    required bool status,
    required int code,
    required String msg,
    required List<dynamic> data,
  }) = _AddCollaborationResponse;

  factory AddCollaborationResponse.fromJson(Map<String, dynamic> json) =>
      _$AddCollaborationResponseFromJson(json);
}
