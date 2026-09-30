import 'package:Doctors_App/features/appointment/model/appointment_model.dart';
import 'package:Doctors_App/features/appointment/model/appointment_remarks_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_state.freezed.dart';

@freezed
class AppointmentState with _$AppointmentState {
  const AppointmentState._();

  const factory AppointmentState({
    @Default(false) bool isLoading,
    @Default(false) bool isActionLoading,
    String? errorMessage,
    AppointmentResponse? appointmentResp,
    AppointmentRemarksResponse? remarksResp,
  }) = _AppointmentState;
}
