// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'your_story_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$YourStoryState {
  AsyncValue<ExperienceResponse?> get experienceList =>
      throw _privateConstructorUsedError;
  AsyncValue<ExperienceSubmitResponse?> get submitExperienceStatus =>
      throw _privateConstructorUsedError;
  AsyncValue<TestimonialResponse?> get testimonialList =>
      throw _privateConstructorUsedError;
  AsyncValue<TestimonialSubmitResponse?> get submitTestimonialStatus =>
      throw _privateConstructorUsedError;

  /// Create a copy of YourStoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YourStoryStateCopyWith<YourStoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YourStoryStateCopyWith<$Res> {
  factory $YourStoryStateCopyWith(
    YourStoryState value,
    $Res Function(YourStoryState) then,
  ) = _$YourStoryStateCopyWithImpl<$Res, YourStoryState>;
  @useResult
  $Res call({
    AsyncValue<ExperienceResponse?> experienceList,
    AsyncValue<ExperienceSubmitResponse?> submitExperienceStatus,
    AsyncValue<TestimonialResponse?> testimonialList,
    AsyncValue<TestimonialSubmitResponse?> submitTestimonialStatus,
  });
}

/// @nodoc
class _$YourStoryStateCopyWithImpl<$Res, $Val extends YourStoryState>
    implements $YourStoryStateCopyWith<$Res> {
  _$YourStoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YourStoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? experienceList = null,
    Object? submitExperienceStatus = null,
    Object? testimonialList = null,
    Object? submitTestimonialStatus = null,
  }) {
    return _then(
      _value.copyWith(
            experienceList: null == experienceList
                ? _value.experienceList
                : experienceList // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<ExperienceResponse?>,
            submitExperienceStatus: null == submitExperienceStatus
                ? _value.submitExperienceStatus
                : submitExperienceStatus // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<ExperienceSubmitResponse?>,
            testimonialList: null == testimonialList
                ? _value.testimonialList
                : testimonialList // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<TestimonialResponse?>,
            submitTestimonialStatus: null == submitTestimonialStatus
                ? _value.submitTestimonialStatus
                : submitTestimonialStatus // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<TestimonialSubmitResponse?>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$YourStoryStateImplCopyWith<$Res>
    implements $YourStoryStateCopyWith<$Res> {
  factory _$$YourStoryStateImplCopyWith(
    _$YourStoryStateImpl value,
    $Res Function(_$YourStoryStateImpl) then,
  ) = __$$YourStoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AsyncValue<ExperienceResponse?> experienceList,
    AsyncValue<ExperienceSubmitResponse?> submitExperienceStatus,
    AsyncValue<TestimonialResponse?> testimonialList,
    AsyncValue<TestimonialSubmitResponse?> submitTestimonialStatus,
  });
}

/// @nodoc
class __$$YourStoryStateImplCopyWithImpl<$Res>
    extends _$YourStoryStateCopyWithImpl<$Res, _$YourStoryStateImpl>
    implements _$$YourStoryStateImplCopyWith<$Res> {
  __$$YourStoryStateImplCopyWithImpl(
    _$YourStoryStateImpl _value,
    $Res Function(_$YourStoryStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of YourStoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? experienceList = null,
    Object? submitExperienceStatus = null,
    Object? testimonialList = null,
    Object? submitTestimonialStatus = null,
  }) {
    return _then(
      _$YourStoryStateImpl(
        experienceList: null == experienceList
            ? _value.experienceList
            : experienceList // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<ExperienceResponse?>,
        submitExperienceStatus: null == submitExperienceStatus
            ? _value.submitExperienceStatus
            : submitExperienceStatus // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<ExperienceSubmitResponse?>,
        testimonialList: null == testimonialList
            ? _value.testimonialList
            : testimonialList // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<TestimonialResponse?>,
        submitTestimonialStatus: null == submitTestimonialStatus
            ? _value.submitTestimonialStatus
            : submitTestimonialStatus // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<TestimonialSubmitResponse?>,
      ),
    );
  }
}

/// @nodoc

class _$YourStoryStateImpl implements _YourStoryState {
  const _$YourStoryStateImpl({
    this.experienceList = const AsyncData(null),
    this.submitExperienceStatus = const AsyncData(null),
    this.testimonialList = const AsyncData(null),
    this.submitTestimonialStatus = const AsyncData(null),
  });

  @override
  @JsonKey()
  final AsyncValue<ExperienceResponse?> experienceList;
  @override
  @JsonKey()
  final AsyncValue<ExperienceSubmitResponse?> submitExperienceStatus;
  @override
  @JsonKey()
  final AsyncValue<TestimonialResponse?> testimonialList;
  @override
  @JsonKey()
  final AsyncValue<TestimonialSubmitResponse?> submitTestimonialStatus;

  @override
  String toString() {
    return 'YourStoryState(experienceList: $experienceList, submitExperienceStatus: $submitExperienceStatus, testimonialList: $testimonialList, submitTestimonialStatus: $submitTestimonialStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YourStoryStateImpl &&
            (identical(other.experienceList, experienceList) ||
                other.experienceList == experienceList) &&
            (identical(other.submitExperienceStatus, submitExperienceStatus) ||
                other.submitExperienceStatus == submitExperienceStatus) &&
            (identical(other.testimonialList, testimonialList) ||
                other.testimonialList == testimonialList) &&
            (identical(
                  other.submitTestimonialStatus,
                  submitTestimonialStatus,
                ) ||
                other.submitTestimonialStatus == submitTestimonialStatus));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    experienceList,
    submitExperienceStatus,
    testimonialList,
    submitTestimonialStatus,
  );

  /// Create a copy of YourStoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YourStoryStateImplCopyWith<_$YourStoryStateImpl> get copyWith =>
      __$$YourStoryStateImplCopyWithImpl<_$YourStoryStateImpl>(
        this,
        _$identity,
      );
}

abstract class _YourStoryState implements YourStoryState {
  const factory _YourStoryState({
    final AsyncValue<ExperienceResponse?> experienceList,
    final AsyncValue<ExperienceSubmitResponse?> submitExperienceStatus,
    final AsyncValue<TestimonialResponse?> testimonialList,
    final AsyncValue<TestimonialSubmitResponse?> submitTestimonialStatus,
  }) = _$YourStoryStateImpl;

  @override
  AsyncValue<ExperienceResponse?> get experienceList;
  @override
  AsyncValue<ExperienceSubmitResponse?> get submitExperienceStatus;
  @override
  AsyncValue<TestimonialResponse?> get testimonialList;
  @override
  AsyncValue<TestimonialSubmitResponse?> get submitTestimonialStatus;

  /// Create a copy of YourStoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YourStoryStateImplCopyWith<_$YourStoryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
