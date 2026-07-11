
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../home/ui/view_model/home_view_model.dart';
import '../../repository/holiday_repository.dart';
import '../state/holiday_state.dart';

part 'holiday_view_model.g.dart';

@riverpod
class HolidayViewModel extends _$HolidayViewModel {
  @override
  Future<HolidayState> build() async {
    final homeState = ref.watch(homeViewModelProvider);
    final designation = homeState.value?.data.designation;
    if (designation == null) {
      return const HolidayState();
    }

    final response = await ref
        .read(holidayRepositoryProvider)
        .getHolidayList(designation);

    return HolidayState(holidayList: response.data);
  }

  Future<void> holidayList(String designation) async {
    state = const AsyncLoading();

    try {
      final response = await ref
          .read(holidayRepositoryProvider)
          .getHolidayList(designation);

      state = AsyncData(HolidayState(holidayList: response.data));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
