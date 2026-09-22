import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_list_response.freezed.dart';

part 'event_list_response.g.dart';

@freezed
class EventListResponse with _$EventListResponse {
  const factory EventListResponse({
    required bool status,
    required int code,
    required String msg,
    required List<EventModel> data,
    required int total,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'last_page') required int lastPage,
    @JsonKey(name: 'per_page') required int perPage,
  }) = _EventListResponse;

  factory EventListResponse.fromJson(Map<String, dynamic> json) =>
      _$EventListResponseFromJson(json);
}

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required int id,
    @JsonKey(name: 'event_type') required String eventType,
    required String title,
    required String description,
    required String date,
    required String time,
    String? address,
    @JsonKey(name: 'organization_type') required String organizationType,
    @JsonKey(name: 'category_type') required String categoryType,
    required String price,

    @JsonKey(name: 'price_description') String? priceDescription,

    @JsonKey(name: 'attendance_status') String? attendanceStatus,

    @JsonKey(name: 'register_button') @Default(false) bool registerButton,

    @JsonKey(name: 'watch_recording_button')
    @Default(false)
    bool watchRecordingButton,
    @JsonKey(name: 'watch_recording_disabled')
    @Default(false)
    bool watchRecordingDisabled,
    @JsonKey(name: 'watch_recording_link') String? watchRecordingLink,

    // Nullable INT — API sends a number (e.g. 1), not a string.
    @JsonKey(name: 'watch_recording_link_duration')
    int? watchRecordingLinkDuration,

    @JsonKey(name: 'recording_expiry_date') String? recordingExpiryDate,

    @JsonKey(name: 'certificate_button') @Default(false) bool certificateButton,
    @JsonKey(name: 'certificate_disabled')
    @Default(false)
    bool certificateDisabled,
    @JsonKey(name: 'certificate_url') String? certificateUrl,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}
