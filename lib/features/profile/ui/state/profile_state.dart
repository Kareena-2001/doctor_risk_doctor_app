import 'package:Doctors_App/features/authentication/ui/state/authentication_state.dart';
import 'package:Doctors_App/features/profile/model/doctor_profile_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    DoctorProfileData? profileData,
    @Default(false) bool isSaving,

    // Master lists
    @Default([]) List<IdNameOption> categories,
    @Default([]) List<IdNameOption> specialities,
    @Default([]) List<IdNameOption> degrees,
    @Default([]) List<IdNameOption> states,
    @Default([]) List<IdNameOption> cities,

    // Selected values (drives the dropdowns)
    IdNameOption? selectedCategory,
    IdNameOption? selectedSpeciality,
    @Default([]) List<IdNameOption> selectedDegrees,
    IdNameOption? selectedState,
    IdNameOption? selectedCity,

    @Default(false) bool isCategoryLoading,
    @Default(false) bool isSpecialityLoading,
    @Default(false) bool isDegreeLoading,
    @Default(false) bool isStateLoading,
    @Default(false) bool isCityLoading,
  }) = _ProfileState;
}