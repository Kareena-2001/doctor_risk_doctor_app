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

    @JsonKey(name: 'event_type')
    required String eventType,

    required String title,

    required String description,

    required String date,

    required String time,

    required String address,

    @JsonKey(name: 'organization_type')
    required String organizationType,

    @JsonKey(name: 'category_type')
    required String categoryType,

    /// API returns "0.00" / "1499.00"
    required String price,

    @JsonKey(name: 'price_description')
    required String priceDescription,

    @JsonKey(name: 'attendance_status')
    String? attendanceStatus,

    @JsonKey(name: 'your_registered')
    required bool yourRegistered,

    @JsonKey(name: 'register_button')
    required bool registerButton,

    @JsonKey(name: 'watch_recording_button')
    required bool watchRecordingButton,

    @JsonKey(name: 'watch_recording_disabled')
    required bool watchRecordingDisabled,

    @JsonKey(name: 'watch_recording_link')
    String? watchRecordingLink,

    @JsonKey(name: 'watch_recording_link_duration')
    String? watchRecordingLinkDuration,

    @JsonKey(name: 'recording_expiry_date')
    String? recordingExpiryDate,

    @JsonKey(name: 'certificate_button')
    required bool certificateButton,

    @JsonKey(name: 'certificate_disabled')
    required bool certificateDisabled,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}