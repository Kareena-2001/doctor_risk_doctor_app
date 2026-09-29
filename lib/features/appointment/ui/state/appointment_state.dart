import 'package:Doctors_App/features/appointment/model/appointment_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_state.freezed.dart';

@freezed
class AppointmentState with _$AppointmentState{
  const factory AppointmentState({
    @Default(false) bool isLoading,
    String? errorMessage,
    AppointmentResponse? resp,
  }) = _AppointmentState;
}
