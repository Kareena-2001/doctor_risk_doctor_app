import 'package:Doctors_App/core/exceptions/exception_extension.dart';
import 'package:Doctors_App/features/emergency/repository/emergency_repository.dart';
import 'package:Doctors_App/features/emergency/ui/state/emergency_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emergency_view_model.g.dart';

@Riverpod(keepAlive: true)
class EmergencyViewModel extends _$EmergencyViewModel {
  static const int _limit = 10;
  bool _isFetching = false;

  EmergencyRepository get _repo => ref.read(emergencyRepositoryProvider);

  @override
  EmergencyState build() {
    return const EmergencyState();
  }

  Future<void> loadSops() async {
    if (_isFetching) return;
    _isFetching = true;

    if (state.sops.isEmpty) {
      state = state.copyWith(isSopLoading: true, sopError: null);
    }

    try {
      final res = await _repo.getSopList(page: 1, limit: _limit);

      state = state.copyWith(
        sops: res.data,
        sopPage: 1,
        hasMoreSops: res.data.length >= _limit,
        isSopLoading: false,
        isSopLoadingMore: false,
        sopError: null,
      );
    } catch (e) {
      state = state.copyWith(isSopLoading: false, sopError: e.readableMessage);
    } finally {
      _isFetching = false;
    }
  }

  Future<void> loadMoreSops() async {
    if (_isFetching || !state.hasMoreSops || state.isSopLoading) return;
    _isFetching = true;

    state = state.copyWith(isSopLoadingMore: true);

    final nextPage = state.sopPage + 1;

    try {
      final res = await _repo.getSopList(page: nextPage, limit: _limit);

      state = state.copyWith(
        sops: [...state.sops, ...res.data],
        sopPage: nextPage,
        hasMoreSops: res.data.length >= _limit,
        isSopLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isSopLoadingMore: false);
    } finally {
      _isFetching = false;
    }
  }
}
