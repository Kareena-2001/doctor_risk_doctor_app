import 'package:Doctors_App/features/emergency/repository/emergency_repository.dart';
import 'package:Doctors_App/features/emergency/ui/state/emergency_state.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emergency_view_model.g.dart';

@Riverpod(keepAlive: true)
class EmergencyViewModel extends _$EmergencyViewModel {
  EmergencyRepository get _repo => ref.read(emergencyRepositoryProvider);

  @override
  EmergencyState build() {
    return const EmergencyState();
  }

  Future<void> loadSops() async {
    if (state.sops.isEmpty) {
      state = state.copyWith(isSopLoading: true, sopError: null);
    }

    try {
      final res = await _repo.getSopList();

      state = state.copyWith(
        sops: res.data,
        isSopLoading: false,
        sopError: null,
      );
    } catch (e, stackTrace) {
      debugPrint('SOP LOAD ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);

      state = state.copyWith(isSopLoading: false, sopError: _errorMessage(e));
    }
  }

  String _errorMessage(Object error) {
    return error.toString().replaceFirst('Exception: ', '');
  }
}
