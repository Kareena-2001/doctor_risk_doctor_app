// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CommunityState {
  AsyncValue<TestimonialResponse> get testimonialList =>
      throw _privateConstructorUsedError;
  AsyncValue<PeerForumResponse> get peerForumList =>
      throw _privateConstructorUsedError;
  AsyncValue<DoctorNoResponse> get referralLink =>
      throw _privateConstructorUsedError;
  AsyncValue<ReferDoctorResponse>? get addReferral =>
      throw _privateConstructorUsedError;
  AsyncValue<ReferredDoctorsResponse> get referralList =>
      throw _privateConstructorUsedError;

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityStateCopyWith<CommunityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityStateCopyWith<$Res> {
  factory $CommunityStateCopyWith(
    CommunityState value,
    $Res Function(CommunityState) then,
  ) = _$CommunityStateCopyWithImpl<$Res, CommunityState>;
  @useResult
  $Res call({
    AsyncValue<TestimonialResponse> testimonialList,
    AsyncValue<PeerForumResponse> peerForumList,
    AsyncValue<DoctorNoResponse> referralLink,
    AsyncValue<ReferDoctorResponse>? addReferral,
    AsyncValue<ReferredDoctorsResponse> referralList,
  });
}

/// @nodoc
class _$CommunityStateCopyWithImpl<$Res, $Val extends CommunityState>
    implements $CommunityStateCopyWith<$Res> {
  _$CommunityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testimonialList = null,
    Object? peerForumList = null,
    Object? referralLink = null,
    Object? addReferral = freezed,
    Object? referralList = null,
  }) {
    return _then(
      _value.copyWith(
            testimonialList: null == testimonialList
                ? _value.testimonialList
                : testimonialList // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<TestimonialResponse>,
            peerForumList: null == peerForumList
                ? _value.peerForumList
                : peerForumList // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<PeerForumResponse>,
            referralLink: null == referralLink
                ? _value.referralLink
                : referralLink // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<DoctorNoResponse>,
            addReferral: freezed == addReferral
                ? _value.addReferral
                : addReferral // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<ReferDoctorResponse>?,
            referralList: null == referralList
                ? _value.referralList
                : referralList // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<ReferredDoctorsResponse>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommunityStateImplCopyWith<$Res>
    implements $CommunityStateCopyWith<$Res> {
  factory _$$CommunityStateImplCopyWith(
    _$CommunityStateImpl value,
    $Res Function(_$CommunityStateImpl) then,
  ) = __$$CommunityStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AsyncValue<TestimonialResponse> testimonialList,
    AsyncValue<PeerForumResponse> peerForumList,
    AsyncValue<DoctorNoResponse> referralLink,
    AsyncValue<ReferDoctorResponse>? addReferral,
    AsyncValue<ReferredDoctorsResponse> referralList,
  });
}

/// @nodoc
class __$$CommunityStateImplCopyWithImpl<$Res>
    extends _$CommunityStateCopyWithImpl<$Res, _$CommunityStateImpl>
    implements _$$CommunityStateImplCopyWith<$Res> {
  __$$CommunityStateImplCopyWithImpl(
    _$CommunityStateImpl _value,
    $Res Function(_$CommunityStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testimonialList = null,
    Object? peerForumList = null,
    Object? referralLink = null,
    Object? addReferral = freezed,
    Object? referralList = null,
  }) {
    return _then(
      _$CommunityStateImpl(
        testimonialList: null == testimonialList
            ? _value.testimonialList
            : testimonialList // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<TestimonialResponse>,
        peerForumList: null == peerForumList
            ? _value.peerForumList
            : peerForumList // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<PeerForumResponse>,
        referralLink: null == referralLink
            ? _value.referralLink
            : referralLink // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<DoctorNoResponse>,
        addReferral: freezed == addReferral
            ? _value.addReferral
            : addReferral // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<ReferDoctorResponse>?,
        referralList: null == referralList
            ? _value.referralList
            : referralList // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<ReferredDoctorsResponse>,
      ),
    );
  }
}

/// @nodoc

class _$CommunityStateImpl implements _CommunityState {
  const _$CommunityStateImpl({
    this.testimonialList = const AsyncLoading(),
    this.peerForumList = const AsyncLoading(),
    this.referralLink = const AsyncLoading(),
    this.addReferral,
    this.referralList = const AsyncLoading(),
  });

  @override
  @JsonKey()
  final AsyncValue<TestimonialResponse> testimonialList;
  @override
  @JsonKey()
  final AsyncValue<PeerForumResponse> peerForumList;
  @override
  @JsonKey()
  final AsyncValue<DoctorNoResponse> referralLink;
  @override
  final AsyncValue<ReferDoctorResponse>? addReferral;
  @override
  @JsonKey()
  final AsyncValue<ReferredDoctorsResponse> referralList;

  @override
  String toString() {
    return 'CommunityState(testimonialList: $testimonialList, peerForumList: $peerForumList, referralLink: $referralLink, addReferral: $addReferral, referralList: $referralList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityStateImpl &&
            (identical(other.testimonialList, testimonialList) ||
                other.testimonialList == testimonialList) &&
            (identical(other.peerForumList, peerForumList) ||
                other.peerForumList == peerForumList) &&
            (identical(other.referralLink, referralLink) ||
                other.referralLink == referralLink) &&
            (identical(other.addReferral, addReferral) ||
                other.addReferral == addReferral) &&
            (identical(other.referralList, referralList) ||
                other.referralList == referralList));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    testimonialList,
    peerForumList,
    referralLink,
    addReferral,
    referralList,
  );

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityStateImplCopyWith<_$CommunityStateImpl> get copyWith =>
      __$$CommunityStateImplCopyWithImpl<_$CommunityStateImpl>(
        this,
        _$identity,
      );
}

abstract class _CommunityState implements CommunityState {
  const factory _CommunityState({
    final AsyncValue<TestimonialResponse> testimonialList,
    final AsyncValue<PeerForumResponse> peerForumList,
    final AsyncValue<DoctorNoResponse> referralLink,
    final AsyncValue<ReferDoctorResponse>? addReferral,
    final AsyncValue<ReferredDoctorsResponse> referralList,
  }) = _$CommunityStateImpl;

  @override
  AsyncValue<TestimonialResponse> get testimonialList;
  @override
  AsyncValue<PeerForumResponse> get peerForumList;
  @override
  AsyncValue<DoctorNoResponse> get referralLink;
  @override
  AsyncValue<ReferDoctorResponse>? get addReferral;
  @override
  AsyncValue<ReferredDoctorsResponse> get referralList;

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityStateImplCopyWith<_$CommunityStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
