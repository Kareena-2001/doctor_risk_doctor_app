// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BlogState {
  AsyncValue<void> get submitStatus => throw _privateConstructorUsedError;
  AsyncValue<MySubmissionListModel?> get mySubmissions =>
      throw _privateConstructorUsedError;
  AsyncValue<BlogListResponse?> get blogList =>
      throw _privateConstructorUsedError;
  Map<String, AsyncValue<BlogListDetail>> get blogDetails =>
      throw _privateConstructorUsedError;

  /// Create a copy of BlogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlogStateCopyWith<BlogState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlogStateCopyWith<$Res> {
  factory $BlogStateCopyWith(BlogState value, $Res Function(BlogState) then) =
      _$BlogStateCopyWithImpl<$Res, BlogState>;
  @useResult
  $Res call({
    AsyncValue<void> submitStatus,
    AsyncValue<MySubmissionListModel?> mySubmissions,
    AsyncValue<BlogListResponse?> blogList,
    Map<String, AsyncValue<BlogListDetail>> blogDetails,
  });
}

/// @nodoc
class _$BlogStateCopyWithImpl<$Res, $Val extends BlogState>
    implements $BlogStateCopyWith<$Res> {
  _$BlogStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? submitStatus = null,
    Object? mySubmissions = null,
    Object? blogList = null,
    Object? blogDetails = null,
  }) {
    return _then(
      _value.copyWith(
            submitStatus: null == submitStatus
                ? _value.submitStatus
                : submitStatus // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<void>,
            mySubmissions: null == mySubmissions
                ? _value.mySubmissions
                : mySubmissions // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<MySubmissionListModel?>,
            blogList: null == blogList
                ? _value.blogList
                : blogList // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<BlogListResponse?>,
            blogDetails: null == blogDetails
                ? _value.blogDetails
                : blogDetails // ignore: cast_nullable_to_non_nullable
                      as Map<String, AsyncValue<BlogListDetail>>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BlogStateImplCopyWith<$Res>
    implements $BlogStateCopyWith<$Res> {
  factory _$$BlogStateImplCopyWith(
    _$BlogStateImpl value,
    $Res Function(_$BlogStateImpl) then,
  ) = __$$BlogStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AsyncValue<void> submitStatus,
    AsyncValue<MySubmissionListModel?> mySubmissions,
    AsyncValue<BlogListResponse?> blogList,
    Map<String, AsyncValue<BlogListDetail>> blogDetails,
  });
}

/// @nodoc
class __$$BlogStateImplCopyWithImpl<$Res>
    extends _$BlogStateCopyWithImpl<$Res, _$BlogStateImpl>
    implements _$$BlogStateImplCopyWith<$Res> {
  __$$BlogStateImplCopyWithImpl(
    _$BlogStateImpl _value,
    $Res Function(_$BlogStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BlogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? submitStatus = null,
    Object? mySubmissions = null,
    Object? blogList = null,
    Object? blogDetails = null,
  }) {
    return _then(
      _$BlogStateImpl(
        submitStatus: null == submitStatus
            ? _value.submitStatus
            : submitStatus // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<void>,
        mySubmissions: null == mySubmissions
            ? _value.mySubmissions
            : mySubmissions // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<MySubmissionListModel?>,
        blogList: null == blogList
            ? _value.blogList
            : blogList // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<BlogListResponse?>,
        blogDetails: null == blogDetails
            ? _value._blogDetails
            : blogDetails // ignore: cast_nullable_to_non_nullable
                  as Map<String, AsyncValue<BlogListDetail>>,
      ),
    );
  }
}

/// @nodoc

class _$BlogStateImpl implements _BlogState {
  const _$BlogStateImpl({
    this.submitStatus = const AsyncValue.data(null),
    this.mySubmissions = const AsyncValue.data(null),
    this.blogList = const AsyncValue.data(null),
    final Map<String, AsyncValue<BlogListDetail>> blogDetails = const {},
  }) : _blogDetails = blogDetails;

  @override
  @JsonKey()
  final AsyncValue<void> submitStatus;
  @override
  @JsonKey()
  final AsyncValue<MySubmissionListModel?> mySubmissions;
  @override
  @JsonKey()
  final AsyncValue<BlogListResponse?> blogList;
  final Map<String, AsyncValue<BlogListDetail>> _blogDetails;
  @override
  @JsonKey()
  Map<String, AsyncValue<BlogListDetail>> get blogDetails {
    if (_blogDetails is EqualUnmodifiableMapView) return _blogDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_blogDetails);
  }

  @override
  String toString() {
    return 'BlogState(submitStatus: $submitStatus, mySubmissions: $mySubmissions, blogList: $blogList, blogDetails: $blogDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlogStateImpl &&
            (identical(other.submitStatus, submitStatus) ||
                other.submitStatus == submitStatus) &&
            (identical(other.mySubmissions, mySubmissions) ||
                other.mySubmissions == mySubmissions) &&
            (identical(other.blogList, blogList) ||
                other.blogList == blogList) &&
            const DeepCollectionEquality().equals(
              other._blogDetails,
              _blogDetails,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    submitStatus,
    mySubmissions,
    blogList,
    const DeepCollectionEquality().hash(_blogDetails),
  );

  /// Create a copy of BlogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlogStateImplCopyWith<_$BlogStateImpl> get copyWith =>
      __$$BlogStateImplCopyWithImpl<_$BlogStateImpl>(this, _$identity);
}

abstract class _BlogState implements BlogState {
  const factory _BlogState({
    final AsyncValue<void> submitStatus,
    final AsyncValue<MySubmissionListModel?> mySubmissions,
    final AsyncValue<BlogListResponse?> blogList,
    final Map<String, AsyncValue<BlogListDetail>> blogDetails,
  }) = _$BlogStateImpl;

  @override
  AsyncValue<void> get submitStatus;
  @override
  AsyncValue<MySubmissionListModel?> get mySubmissions;
  @override
  AsyncValue<BlogListResponse?> get blogList;
  @override
  Map<String, AsyncValue<BlogListDetail>> get blogDetails;

  /// Create a copy of BlogState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlogStateImplCopyWith<_$BlogStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
