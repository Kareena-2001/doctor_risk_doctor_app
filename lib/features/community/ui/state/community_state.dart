import 'package:Doctors_App/features/community/model/doctor_no_response.dart';
import 'package:Doctors_App/features/community/model/peer_forum_response.dart';
import 'package:Doctors_App/features/community/model/refer_doctor_response.dart';
import 'package:Doctors_App/features/community/model/referred_doctors_response.dart';
import 'package:Doctors_App/features/community/model/testimonial_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_state.freezed.dart';

@freezed
class CommunityState with _$CommunityState {
  const factory CommunityState({
    @Default(AsyncLoading()) AsyncValue<TestimonialResponse> testimonialList,

    @Default(AsyncLoading()) AsyncValue<PeerForumResponse> peerForumList,

    @Default(AsyncLoading()) AsyncValue<DoctorNoResponse> referralLink,

    AsyncValue<ReferDoctorResponse>? addReferral,

    @Default(AsyncLoading()) AsyncValue<ReferredDoctorsResponse> referralList,
  }) = _CommunityState;
}
