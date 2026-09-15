import 'package:Doctors_App/features/community/repository/community_repository.dart';
import 'package:Doctors_App/features/community/ui/state/community_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'community_view_model.g.dart';

@riverpod
class CommunityViewModel extends _$CommunityViewModel {
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
}
