import 'dart:async';

import 'package:Doctors_App/features/profile/model/profile_address_request.dart';
import 'package:Doctors_App/features/profile/repository/profile_repository.dart';
import 'package:Doctors_App/features/profile/ui/state/profile_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_view_model.g.dart';

@Riverpod(keepAlive: true)
class ProfileViewModel extends _$ProfileViewModel {
  @override
  FutureOr<ProfileState> build() {
    return const ProfileState();
  }

  Future<void> getProfile() async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(profileRepositoryProvider);
      final response = await repository.getProfileList();
      state = AsyncData(ProfileState(profileData: response.data));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> refreshProfile() => getProfile();

  /// Returns true on success, false on failure. Only flips `isSaving` on the
  /// current data (screen stays on the form the whole time) — the full
  /// AsyncLoading spinner is reserved for the initial fetch.
  Future<bool> updateProfile({
    required String prefix,
    required String firstName,
    String? middleName,
    required String lastName,
    required String email,
    required String mobileNo,
    String? alternateNo,
    required String categoryId,
    required String specialityId,
    required String degree,
    String? establishmentName,
    String? dob,
    String? gender,
    required List<ProfileAddressRequest> addresses,
    String? clinicHospitalId,
    String? medicleRegState,
    String? medicleRegNo,
    String? medicleRegYear,
    String? hospclinRegState,
    String? hospclinRegNo,
    String? hospclinRegYear,
    String? retroactive,
    String? retroactiveDate,
    String? retroactivePolicydoc,
    String? worldwide,
    String? unqualifiedStaff,
    String? unqualifiedStaffCount,
    String? opd,
    String? ipd,
  }) async {
    final current = state.valueOrNull ?? const ProfileState();
    state = AsyncData(current.copyWith(isSaving: true));

    try {
      final repository = ref.read(profileRepositoryProvider);

      await repository.updateProfile(
        prefix: prefix,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        email: email,
        mobileNo: mobileNo,
        alternateNo: alternateNo,
        categoryId: categoryId,
        specialityId: specialityId,
        degree: degree,
        establishmentName: establishmentName,
        dob: dob,
        gender: gender,
        addresses: addresses,
        clinicHospitalId: clinicHospitalId,
        medicleRegState: medicleRegState,
        medicleRegNo: medicleRegNo,
        medicleRegYear: medicleRegYear,
        hospclinRegState: hospclinRegState,
        hospclinRegNo: hospclinRegNo,
        hospclinRegYear: hospclinRegYear,
        retroactive: retroactive,
        retroactiveDate: retroactiveDate,
        retroactivePolicydoc: retroactivePolicydoc,
        worldwide: worldwide,
        unqualifiedStaff: unqualifiedStaff,
        unqualifiedStaffCount: unqualifiedStaffCount,
        opd: opd,
        ipd: ipd,
      );

      // Re-fetch instead of trying to reconcile ProfileUpdateProfile (update
      // response shape) into DoctorProfileData (get response shape) — they're
      // different freezed classes. This keeps the screen showing exactly
      // what the server now has.
      await getProfile();
      return true;
    } catch (error) {
      state = AsyncData(current.copyWith(isSaving: false));
      return false;
    }
  }
}