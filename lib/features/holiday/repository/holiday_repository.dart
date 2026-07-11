import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/api_client.dart';
import '../model/holiday_model.dart';

part 'holiday_repository.g.dart';

@riverpod
HolidayRepository holidayRepository(HolidayRepositoryRef ref) {
  return HolidayRepository(ref.watch(apiClientProvider));
}

class HolidayRepository {
  final ApiClient _api;

  const HolidayRepository(this._api);

  Future<HolidayResponse> getHolidayList(String designation) async {
    final response = await _api.post(
      url: 'holiday_list',
      formData: {'designation': designation},
      includeAuth: true,
    );

    if (response['status'] == 200) {
      return HolidayResponse.fromJson(response);
    }
    throw Exception(response['msg'] ?? 'Failed to fetch Holiday List');
  }
}
