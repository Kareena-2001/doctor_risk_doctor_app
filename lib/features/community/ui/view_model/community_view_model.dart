import 'package:Doctors_App/features/community/repository/community_repository.dart';
import 'package:Doctors_App/features/community/ui/state/community_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'community_view_model.g.dart';

@riverpod
class CommunityViewModel extends _$CommunityViewModel {
  String? _currentTab;

  @override
  CommunityState build() {
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

  Future<void> allPeerForumList({String? tab}) async {
    _currentTab = tab;
    state = state.copyWith(peerForumList: const AsyncLoading());

    final result = await AsyncValue.guard(
          () => ref.read(communityRepositoryProvider).getAllPeerForumList(tab: tab),
    );

    state = state.copyWith(peerForumList: result);
  }

  Future<void> refreshPeerForumList() => allPeerForumList(tab: _currentTab);

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
    required int categoryId,
    required int specialityId,
    required String degree,
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
        degree: degree,
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
}