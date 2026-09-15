import 'package:Doctors_App/features/community/model/testimonial_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_state.freezed.dart';

@freezed
class CommunityState with _$CommunityState {
  const factory CommunityState({
    @Default(AsyncLoading())
    AsyncValue<TestimonialResponse> testimonialList,
  }) = _CommunityState;
}