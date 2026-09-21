import 'dart:async';

import 'package:Doctors_App/features/community/repository/community_repository.dart';
import 'package:Doctors_App/features/community/ui/state/community_state.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../authentication/ui/state/authentication_state.dart'
    show IdNameOption;

part 'community_view_model.g.dart';

@riverpod
class CommunityViewModel extends _$CommunityViewModel {
  String? _currentTab;
  String? _currentSearch;
  int? _currentTime; // null = All
  Timer? _searchDebounce;

  @override
  CommunityState build() {
    ref.onDispose(() => _searchDebounce?.cancel());
    return const CommunityState();
  }

  Future<void> allTestimonialList() async {
    state = state.copyWith(testimonialList: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref.read(communityRepositoryProvider).getAllTestimonialList(),
    );

    state = state.copyWith(testimonialList: result);
  }

  Future<void> refreshTestimonialList() => allTestimonialList();

  Future<void> allPeerForumList({
    String? tab,
    String? search,
    int? time,
    bool timeExplicit = false,
  }) async {
    _currentTab = tab ?? _currentTab;
    _currentSearch = search ?? _currentSearch;
    _currentTime = timeExplicit ? time : (time ?? _currentTime);

    state = state.copyWith(peerForumList: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref
          .read(communityRepositoryProvider)
          .getAllPeerForumList(
            tab: _currentTab,
            search: _currentSearch,
            time: _currentTime,
          ),
    );

    state = state.copyWith(peerForumList: result);
  }

  Future<void> refreshPeerForumList() => allPeerForumList();

  void setPeerForumTime(int? time) {
    if (_currentTime == time) return;
    state = state.copyWith(selectedPeerForumTime: time);
    allPeerForumList(time: time, timeExplicit: true);
  }

  void setPeerForumSearch(String query) {
    state = state.copyWith(peerForumSearchQuery: query);
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 450), () {
      allPeerForumList(search: query.trim().isEmpty ? null : query.trim());
    });
  }

  void clearPeerForumSearch() {
    _searchDebounce?.cancel();
    state = state.copyWith(peerForumSearchQuery: '');
    allPeerForumList(search: null);
  }

  Future<void> getDoctorNo() async {
    state = state.copyWith(referralLink: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref.read(communityRepositoryProvider).referralCode(),
    );

    state = state.copyWith(referralLink: result);
  }

  Future<void> addReferral({
    required String firstName,
    String? middleName,
    required String lastName,
    required String mobileNo,
    String? email,
    int? categoryId,
    int? specialityId,
    List<String>? degrees,
    String? remark,
  }) async {
    state = state.copyWith(addReferral: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref
          .read(communityRepositoryProvider)
          .addReferral(
            firstName: firstName,
            middleName: middleName,
            lastName: lastName,
            mobileNo: mobileNo,
            email: email,
            categoryId: categoryId,
            specialityId: specialityId,
            degrees: degrees,
            remark: remark,
          ),
    );

    state = state.copyWith(addReferral: result);
  }

  Future<void> referDoctorList() async {
    state = state.copyWith(referralList: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref.read(communityRepositoryProvider).referDoctorList(),
    );

    state = state.copyWith(referralList: result);
  }

  Future<void> refreshReferDoctorList() => referDoctorList();

  List<IdNameOption> _mapIdName(List<dynamic> items) => items
      .map((e) => IdNameOption(id: e.id as int, name: e.name as String))
      .toList();

  Future<void> categoryList() async {
    state = state.copyWith(isCategoryLoading: true, categoryError: null);
    try {
      final repository = ref.read(communityRepositoryProvider);
      final response = await repository.categoryList(productTypeId: '1');
      state = state.copyWith(
        isCategoryLoading: false,
        categories: _mapIdName(response.data),
      );
    } catch (error) {
      state = state.copyWith(
        isCategoryLoading: false,
        categoryError: error.toString(),
      );
    }
  }

  void selectCategory(IdNameOption category) {
    state = state.copyWith(
      selectedCategory: category,
      selectedSpeciality: null,
      specialities: const [],
    );
    specialityList(categoryId: category.id.toString());
  }

  Future<void> specialityList({required String categoryId}) async {
    state = state.copyWith(isSpecialityLoading: true, specialityError: null);
    try {
      final repository = ref.read(communityRepositoryProvider);
      final response = await repository.specialityList(categoryId: categoryId);
      state = state.copyWith(
        isSpecialityLoading: false,
        specialities: _mapIdName(response.data),
      );
    } catch (error) {
      state = state.copyWith(
        isSpecialityLoading: false,
        specialityError: error.toString(),
      );
    }
  }

  void selectSpeciality(IdNameOption speciality) =>
      state = state.copyWith(selectedSpeciality: speciality);

  Future<void> degreeList() async {
    state = state.copyWith(isDegreeLoading: true, degreeError: null);
    try {
      final repository = ref.read(communityRepositoryProvider);
      final response = await repository.degreeList();
      state = state.copyWith(
        isDegreeLoading: false,
        degrees: _mapIdName(response.data),
      );
    } catch (error) {
      state = state.copyWith(
        isDegreeLoading: false,
        degreeError: error.toString(),
      );
    }
  }

  void setSelectedDegrees(List<IdNameOption> degrees) {
    debugPrint(
      'Selected degrees: ${degrees.map((e) => '${e.id}:${e.name}').join(', ')}',
    );

    state = state.copyWith(selectedDegrees: [...degrees]);
  }

  void clearCategorySpecialityDegree() {
    state = state.copyWith(
      selectedCategory: null,
      selectedSpeciality: null,
      specialities: const [],
      selectedDegrees: const [],
      categoryError: null,
      specialityError: null,
      degreeError: null,
    );
  }
}
