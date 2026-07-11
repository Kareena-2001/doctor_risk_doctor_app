import 'package:freezed_annotation/freezed_annotation.dart';

part 'holiday_model.freezed.dart';

part 'holiday_model.g.dart';

@freezed
class HolidayResponse with _$HolidayResponse {
  const factory HolidayResponse({
    required int status,
    @JsonKey(name: 'msg') required String message,
    required List<HolidayData> data,
  }) = _HolidayResponse;

  factory HolidayResponse.fromJson(Map<String, dynamic> json) =>
      _$HolidayResponseFromJson(json);
}

@freezed
class HolidayData with _$HolidayData {
  const factory HolidayData({
    required String title,
    @JsonKey(name: 'holiday_date') required String holidayDate,
  }) = _HolidayData;

  factory HolidayData.fromJson(Map<String, dynamic> json) =>
      _$HolidayDataFromJson(json);
}
