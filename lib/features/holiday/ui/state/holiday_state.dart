import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/holiday_model.dart';

part 'holiday_state.freezed.dart';

part 'holiday_state.g.dart';

@freezed
class HolidayState with _$HolidayState {
  const factory HolidayState({
    String? errorListMessage,
    @Default(false) bool isLoadingList,
    @Default([]) List<HolidayData> holidayList,
  }) = _HolidayState;

  factory HolidayState.fromJson(Map<String, dynamic> json) =>
      _$HolidayStateFromJson(json);
}
