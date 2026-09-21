import 'package:Doctors_App/features/community/model/doctor_no_response.dart';
import 'package:Doctors_App/features/community/model/peer_forum_response.dart';
import 'package:Doctors_App/features/community/model/refer_doctor_response.dart';
import 'package:Doctors_App/features/community/model/referred_doctors_response.dart';
import 'package:Doctors_App/features/community/model/testimonial_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../authentication/ui/state/authentication_state.dart';

part 'community_state.freezed.dart';

@freezed
class CommunityState with _$CommunityState {
  const factory CommunityState({
    @Default(AsyncLoading()) AsyncValue<TestimonialResponse> testimonialList,

    @Default(AsyncLoading()) AsyncValue<PeerForumResponse> peerForumList,

    @Default(AsyncLoading()) AsyncValue<DoctorNoResponse> referralLink,

    @Default(false) bool isCategoryLoading,
    String? categoryError,
    @Default(<IdNameOption>[]) List<IdNameOption> categories,
    IdNameOption? selectedCategory,

    @Default(false) bool isSpecialityLoading,
    String? specialityError,
    @Default(<IdNameOption>[]) List<IdNameOption> specialities,
    IdNameOption? selectedSpeciality,

    @Default(false) bool isDegreeLoading,
    String? degreeError,
    @Default(<IdNameOption>[]) List<IdNameOption> degrees,
    @Default(<IdNameOption>[]) List<IdNameOption> selectedDegrees,

    AsyncValue<ReferDoctorResponse>? addReferral,

    @Default(AsyncLoading()) AsyncValue<ReferredDoctorsResponse> referralList,
    @Default(7) int selectedPeerForumTime,
    @Default('') String peerForumSearchQuery,
  }) = _CommunityState;
}
