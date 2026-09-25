import 'package:freezed_annotation/freezed_annotation.dart';

part 'collaboration_response.freezed.dart';
part 'collaboration_response.g.dart';

@freezed
class CollaborationResponse with _$CollaborationResponse {
  const factory CollaborationResponse({
    required bool status,
    required int code,
    required String msg,
    required List<CollaborationData> data,
    int? total,
    @JsonKey(name: 'current_page') int? currentPage,
    @JsonKey(name: 'last_page') int? lastPage,
    @JsonKey(name: 'per_page') int? perPage,
  }) = _CollaborationResponse;

  factory CollaborationResponse.fromJson(Map<String, dynamic> json) =>
      _$CollaborationResponseFromJson(json);
}

@freezed
class CollaborationData with _$CollaborationData {
  const factory CollaborationData({
    required int id,
    required String title,
    required String organization,

    @JsonKey(name: 'mode_of_event')
    String? modeOfEvent,

    String? date,

    @JsonKey(name: 'prefered_time')
    String? preferedTime,

    String? state,
    String? city,
    String? area,
    String? purpose,

    required String submitted,

    @JsonKey(name: 'approve_status')
    required String approveStatus,
  }) = _CollaborationData;

  factory CollaborationData.fromJson(Map<String, dynamic> json) =>
      _$CollaborationDataFromJson(json);
}