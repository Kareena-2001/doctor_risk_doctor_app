import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:Doctors_App/features/emergency/model/sop_response.dart';

part 'emergency_state.freezed.dart';

@freezed
class EmergencyState with _$EmergencyState {
  const factory EmergencyState({
    @Default(true) bool isSopLoading,
    @Default(<SopModel>[]) List<SopModel> sops,
    String? sopError,
  }) = _EmergencyState;
}
