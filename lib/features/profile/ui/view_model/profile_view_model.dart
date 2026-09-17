import 'dart:async';

import 'package:Doctors_App/features/authentication/ui/state/authentication_state.dart';
import 'package:Doctors_App/features/profile/model/profile_address_request.dart';
import 'package:Doctors_App/features/profile/repository/profile_repository.dart';
import 'package:Doctors_App/features/profile/ui/state/profile_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_view_model.g.dart';

@Riverpod(keepAlive: true)
class ProfileViewModel extends _$ProfileViewModel {
  @override
  FutureOr<ProfileState> build() {
    Future.microtask(_loadMasterData);
    return const ProfileState();
  }

  ProfileState get _current => state.valueOrNull ?? const ProfileState();

  void _update(ProfileState Function(ProfileState s) fn) {
    state = AsyncData(fn(_current));
  }

  List<IdNameOption> _mapIdName(List<dynamic>? items) {
    if (items == null) return const [];
    return items
        .map((e) => IdNameOption(id: e.id as int, name: e.name as String))
        .toList();
  }

  Future<void> getProfile() async {
    final current = _current;
    state = AsyncData(current.copyWith(profileData: null));
    try {
      final repository = ref.read(profileRepositoryProvider);
      final response = await repository.getProfileList();
      final latest = _current;
      state = AsyncData(
        ProfileState(
          profileData: response.data,
          categories: latest.categories,
          specialities: latest.specialities,
          degrees: latest.degrees,
          states: latest.states,
          cities: latest.cities,
          selectedCategory: latest.selectedCategory,
          selectedSpeciality: latest.selectedSpeciality,
          selectedDegrees: latest.selectedDegrees,
          selectedState: latest.selectedState,
          selectedCity: latest.selectedCity,
          isCategoryLoading: latest.isCategoryLoading,
          isSpecialityLoading: latest.isSpecialityLoading,
          isDegreeLoading: latest.isDegreeLoading,
          isStateLoading: latest.isStateLoading,
          isCityLoading: latest.isCityLoading,
        ),
      );
      await _prefillFromProfile();
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> refreshProfile() => getProfile();

  Future<void> _loadMasterData() async {
    await Future.wait([_loadCategories(), _loadDegrees(), _loadStates()]);
  }

  Future<void> _loadCategories() async {
    _update((s) => s.copyWith(isCategoryLoading: true));
    try {
      final repository = ref.read(profileRepositoryProvider);
      final response = await repository.categoryList(productTypeId: '1');
      _update(
        (s) => s.copyWith(
          isCategoryLoading: false,
          categories: _mapIdName(response.data),
        ),
      );
      await _prefillFromProfile();
    } catch (_) {
      _update((s) => s.copyWith(isCategoryLoading: false));
    }
  }

  Future<void> selectCategory(IdNameOption category) async {
    _update(
      (s) => s.copyWith(
        selectedCategory: category,
        selectedSpeciality: null,
        specialities: const [],
      ),
    );
    await _loadSpecialities(category.id.toString());
  }

  Future<void> _loadSpecialities(String categoryId) async {
    _update((s) => s.copyWith(isSpecialityLoading: true));
    try {
      final repository = ref.read(profileRepositoryProvider);
      final response = await repository.specialityList(categoryId: categoryId);
      _update(
        (s) => s.copyWith(
          isSpecialityLoading: false,
          specialities: _mapIdName(response.data),
        ),
      );
      _prefillSpeciality();
    } catch (_) {
      _update((s) => s.copyWith(isSpecialityLoading: false));
    }
  }

  void selectSpeciality(IdNameOption speciality) =>
      _update((s) => s.copyWith(selectedSpeciality: speciality));

  Future<void> _loadDegrees() async {
    _update((s) => s.copyWith(isDegreeLoading: true));
    try {
      final repository = ref.read(profileRepositoryProvider);
      final response = await repository.degreeList();
      _update(
        (s) => s.copyWith(
          isDegreeLoading: false,
          degrees: _mapIdName(response.data),
        ),
      );
      await _prefillFromProfile();
    } catch (_) {
      _update((s) => s.copyWith(isDegreeLoading: false));
    }
  }

  void setSelectedDegrees(List<IdNameOption> degrees) =>
      _update((s) => s.copyWith(selectedDegrees: [...degrees]));

  Future<void> _loadStates() async {
    _update((s) => s.copyWith(isStateLoading: true));
    try {
      final repository = ref.read(profileRepositoryProvider);
      final response = await repository.stateList();
      _update(
        (s) => s.copyWith(
          isStateLoading: false,
          states: _mapIdName(response.data),
        ),
      );
      await _prefillFromProfile();
    } catch (_) {
      _update((s) => s.copyWith(isStateLoading: false));
    }
  }

  Future<void> selectState(IdNameOption state) async {
    _update(
      (s) => s.copyWith(
        selectedState: state,
        selectedCity: null,
        cities: const [],
      ),
    );
    await _loadCities(state.id.toString());
  }

  Future<void> _loadCities(String stateId) async {
    _update((s) => s.copyWith(isCityLoading: true));
    try {
      final repository = ref.read(profileRepositoryProvider);
      final response = await repository.cityList(stateId: stateId);
      _update(
        (s) =>
            s.copyWith(isCityLoading: false, cities: _mapIdName(response.data)),
      );
    } catch (_) {
      _update((s) => s.copyWith(isCityLoading: false));
    }
  }

  void selectCity(IdNameOption city) =>
      _update((s) => s.copyWith(selectedCity: city));

  Future<void> _prefillFromProfile() async {
    final data = _current.profileData;
    if (data == null) return;

    if (_current.selectedCategory == null && _current.categories.isNotEmpty) {
      final match = _findByName(_current.categories, data.categoryName);
      if (match != null) {
        _update((s) => s.copyWith(selectedCategory: match));
        await _loadSpecialities(match.id.toString());
      }
    }

    _prefillSpeciality();

    if (_current.selectedDegrees.isEmpty && _current.degrees.isNotEmpty) {
      final names = (data.degree ?? '')
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toSet();
      final matched = _current.degrees
          .where((d) => names.contains(d.name.trim()))
          .toList();
      if (matched.isNotEmpty) {
        _update((s) => s.copyWith(selectedDegrees: matched));
      }
    }
  }

  void _prefillSpeciality() {
    final data = _current.profileData;
    if (data == null) return;
    if (_current.selectedSpeciality == null &&
        _current.specialities.isNotEmpty) {
      final match = _findByName(_current.specialities, data.specialityName);
      if (match != null) {
        _update((s) => s.copyWith(selectedSpeciality: match));
      }
    }
  }

  IdNameOption? _findByName(List<IdNameOption> options, String? name) {
    if (name == null || name.trim().isEmpty) return null;
    for (final o in options) {
      if (o.name.trim().toLowerCase() == name.trim().toLowerCase()) return o;
    }
    return null;
  }

  Future<void> prefillAddressLocation({
    String? stateName,
    String? cityName,
  }) async {
    final stateMatch = _findByName(_current.states, stateName);
    if (stateMatch == null) return;
    _update((s) => s.copyWith(selectedState: stateMatch));
    await _loadCities(stateMatch.id.toString());
    final cityMatch = _findByName(_current.cities, cityName);
    if (cityMatch != null) {
      _update((s) => s.copyWith(selectedCity: cityMatch));
    }
  }

  Future<bool> updateProfile({
    required String prefix,
    required String firstName,
    String? middleName,
    required String lastName,
    required String email,
    required String mobileNo,
    String? alternateNo,
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
    final s = _current;
    if (s.selectedCategory == null) return false;

    _update((st) => st.copyWith(isSaving: true));
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
        categoryId: s.selectedCategory!.id.toString(),
        specialityId: s.selectedSpeciality?.id.toString() ?? '',
        degree: s.selectedDegrees.map((d) => d.name).join(', '),
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
      await getProfile();
      return true;
    } catch (_) {
      _update((st) => st.copyWith(isSaving: false));
      return false;
    }
  }
}
