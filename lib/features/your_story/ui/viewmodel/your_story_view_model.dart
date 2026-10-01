import 'dart:io';

import 'package:Doctors_App/features/your_story/repository/your_story_repository.dart';
import 'package:Doctors_App/features/your_story/ui/state/your_story_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'your_story_view_model.g.dart';

@riverpod
class YourStoryViewModel extends _$YourStoryViewModel {
  bool _loadingMoreExperiences = false;
  bool _loadingMoreTestimonials = false;

  @override
  YourStoryState build() {
    return const YourStoryState();
  }

  Future<void> experienceList() async {
    _loadingMoreExperiences = false;
    state = state.copyWith(experienceList: AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref.read(yourStoryRepositoryProvider).experienceList(),
    );

    state = state.copyWith(experienceList: result);
  }

  Future<void> refreshExperienceList() => experienceList();

  Future<void> loadMoreExperiences() async {
    final current = state.experienceList.valueOrNull;
    if (current == null ||
        _loadingMoreExperiences ||
        current.currentPage >= current.lastPage) {
      return;
    }

    _loadingMoreExperiences = true;
    try {
      final next = await ref
          .read(yourStoryRepositoryProvider)
          .experienceList(page: current.currentPage + 1);
      state = state.copyWith(
        experienceList: AsyncData(
          next.copyWith(data: [...current.data, ...next.data]),
        ),
      );
    } finally {
      _loadingMoreExperiences = false;
    }
  }

  Future<void> deleteExperience(int id) async {
    await ref.read(yourStoryRepositoryProvider).experienceDelete(id.toString());
  }

  Future<bool> submitExperience({
    int? id,
    required String title,
    required String experienceType,
    required String description,
    required String iAgreeAccepted,
    File? file,
  }) async {
    state = state.copyWith(submitExperienceStatus: const AsyncLoading());

    try {
      final response = await ref
          .read(yourStoryRepositoryProvider)
          .addOrEditExperience(
            id: id,
            title: title,
            experienceType: experienceType,
            description: description,
            iAgreeAccepted: iAgreeAccepted,
            coverImage: file,
          );

      if (response.status) {
        state = state.copyWith(submitExperienceStatus: AsyncData(response));
        return true;
      }

      state = state.copyWith(
        submitExperienceStatus: AsyncError(response.msg, StackTrace.current),
      );

      return false;
    } catch (e, st) {
      state = state.copyWith(submitExperienceStatus: AsyncError(e, st));

      return false;
    }
  }

  Future<void> testimonialList() async {
    _loadingMoreTestimonials = false;
    state = state.copyWith(testimonialList: AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref.read(yourStoryRepositoryProvider).testimonialList(),
    );

    state = state.copyWith(testimonialList: result);
  }

  Future<void> refreshTestimonialList() => testimonialList();

  Future<void> loadMoreTestimonials() async {
    final current = state.testimonialList.valueOrNull;
    if (current == null ||
        _loadingMoreTestimonials ||
        current.currentPage >= current.lastPage) {
      return;
    }

    _loadingMoreTestimonials = true;
    try {
      final next = await ref
          .read(yourStoryRepositoryProvider)
          .testimonialList(page: current.currentPage + 1);
      state = state.copyWith(
        testimonialList: AsyncData(
          next.copyWith(data: [...current.data, ...next.data]),
        ),
      );
    } finally {
      _loadingMoreTestimonials = false;
    }
  }

  Future<bool> submitTestimonial({
    int? id,
    required String testimonialType,
    required String description,
    required String iAgreeAccepted,
    File? file,
  }) async {
    state = state.copyWith(submitTestimonialStatus: const AsyncLoading());

    try {
      final response = await ref
          .read(yourStoryRepositoryProvider)
          .addOrEditTestimonial(
            id: id,
            testimonialType: testimonialType,
            description: description,
            iAgreeAccepted: iAgreeAccepted,
            file: file,
          );

      if (response.status) {
        state = state.copyWith(submitTestimonialStatus: AsyncData(response));

        return true;
      }

      state = state.copyWith(
        submitTestimonialStatus: AsyncError(response.msg, StackTrace.current),
      );

      return false;
    } catch (e, st) {
      state = state.copyWith(submitTestimonialStatus: AsyncError(e, st));

      return false;
    }
  }
}
