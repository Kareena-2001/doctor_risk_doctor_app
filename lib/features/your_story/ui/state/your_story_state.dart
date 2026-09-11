import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/experience_response.dart';

part 'your_story_state.freezed.dart';

@freezed
class YourStoryState with _$YourStoryState {
  const factory YourStoryState({
    @Default(AsyncValue.loading())
    AsyncValue<ExperienceResponse> experienceList,
  }) = _YourStoryState;
}
