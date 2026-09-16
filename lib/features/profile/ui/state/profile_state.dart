import 'package:Doctors_App/features/profile/model/doctor_profile_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({DoctorProfileData? profileData}) = _ProfileState;
}
