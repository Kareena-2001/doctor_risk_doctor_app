import 'package:Doctors_App/features/your_story/model/experience_response.dart';
import 'package:Doctors_App/features/your_story/model/testimonial_response.dart';
import 'package:Doctors_App/features/your_story/model/testimonial_submit_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/experience_submit_response.dart';

part 'your_story_state.freezed.dart';

@freezed
class YourStoryState with _$YourStoryState {
  const factory YourStoryState({
    @Default(AsyncData(null))
    AsyncValue<ExperienceResponse?> experienceList,

    @Default(AsyncData(null))
    AsyncValue<ExperienceSubmitResponse?> submitExperienceStatus,

    @Default(AsyncData(null))
    AsyncValue<TestimonialResponse?> testimonialList,

    @Default(AsyncData(null))
    AsyncValue<TestimonialSubmitResponse?> submitTestimonialStatus,

  }) = _YourStoryState;
}
