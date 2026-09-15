import 'dart:io';

import 'package:Doctors_App/features/your_story/repository/your_story_repository.dart';
import 'package:Doctors_App/features/your_story/ui/state/your_story_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'your_story_view_model.g.dart';

@riverpod
class YourStoryViewModel extends _$YourStoryViewModel {
  @override
  YourStoryState build() {
    return const YourStoryState();
  }

  // ==================== EXPERIENCE ====================

  Future<void> experienceList() async {
    state = state.copyWith(
      experienceList: const AsyncLoading(),
    );

    final result = await AsyncValue.guard(
          () => ref.read(yourStoryRepositoryProvider).experienceList(),
    );

    state = state.copyWith(
      experienceList: result,
    );
  }

  Future<void> refreshExperienceList() => experienceList();

  Future<bool> submitExperience({
    int? id,
    required String title,
    required String experienceType,
    required String description,
    required String iAgreeAccepted,
    File? file,
  }) async {
    state = state.copyWith(
      submitExperienceStatus: const AsyncLoading(),
    );

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
        state = state.copyWith(
          submitExperienceStatus: AsyncData(response),
        );

        return true;
      }

      state = state.copyWith(
        submitExperienceStatus: AsyncError(
          response.msg,
          StackTrace.current,
        ),
      );

      return false;
    } catch (e, st) {
      state = state.copyWith(
        submitExperienceStatus: AsyncError(e, st),
      );

      return false;
    }
  }

  // ==================== TESTIMONIAL ====================

  Future<void> testimonialList() async {
    state = state.copyWith(
      testimonialList: const AsyncLoading(),
    );

    final result = await AsyncValue.guard(
          () => ref.read(yourStoryRepositoryProvider).testimonialList(),
    );

    state = state.copyWith(
      testimonialList: result,
    );
  }

  Future<void> refreshTestimonialList() => testimonialList();

  Future<bool> submitTestimonial({
    int? id,
    required String testimonialType,
    required String description,
    required String iAgreeAccepted,
    File? file,
  }) async {
    state = state.copyWith(
      submitTestimonialStatus: const AsyncLoading(),
    );

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
        state = state.copyWith(
          submitTestimonialStatus: AsyncData(response),
        );

        return true;
      }

      state = state.copyWith(
        submitTestimonialStatus: AsyncError(
          response.msg,
          StackTrace.current,
        ),
      );

      return false;
    } catch (e, st) {
      state = state.copyWith(
        submitTestimonialStatus: AsyncError(e, st),
      );

      return false;
    }
  }
}