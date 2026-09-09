// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthenticationState {
  LoginResponse? get response => throw _privateConstructorUsedError;
  SignUpResponse? get signUpResponse => throw _privateConstructorUsedError;
  AsyncValue<CategoryResponse> get categoryAsync =>
      throw _privateConstructorUsedError;
  AsyncValue<SpecialityResponse?> get specialityAsync =>
      throw _privateConstructorUsedError;
  AsyncValue<DegreeResponse> get degreeAsync =>
      throw _privateConstructorUsedError;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthenticationStateCopyWith<AuthenticationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationStateCopyWith(
    AuthenticationState value,
    $Res Function(AuthenticationState) then,
  ) = _$AuthenticationStateCopyWithImpl<$Res, AuthenticationState>;
  @useResult
  $Res call({
    LoginResponse? response,
    SignUpResponse? signUpResponse,
    AsyncValue<CategoryResponse> categoryAsync,
    AsyncValue<SpecialityResponse?> specialityAsync,
    AsyncValue<DegreeResponse> degreeAsync,
  });

  $LoginResponseCopyWith<$Res>? get response;
  $SignUpResponseCopyWith<$Res>? get signUpResponse;
}

/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res, $Val extends AuthenticationState>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = freezed,
    Object? signUpResponse = freezed,
    Object? categoryAsync = null,
    Object? specialityAsync = null,
    Object? degreeAsync = null,
  }) {
    return _then(
      _value.copyWith(
            response: freezed == response
                ? _value.response
                : response // ignore: cast_nullable_to_non_nullable
                      as LoginResponse?,
            signUpResponse: freezed == signUpResponse
                ? _value.signUpResponse
                : signUpResponse // ignore: cast_nullable_to_non_nullable
                      as SignUpResponse?,
            categoryAsync: null == categoryAsync
                ? _value.categoryAsync
                : categoryAsync // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<CategoryResponse>,
            specialityAsync: null == specialityAsync
                ? _value.specialityAsync
                : specialityAsync // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<SpecialityResponse?>,
            degreeAsync: null == degreeAsync
                ? _value.degreeAsync
                : degreeAsync // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<DegreeResponse>,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoginResponseCopyWith<$Res>? get response {
    if (_value.response == null) {
      return null;
    }

    return $LoginResponseCopyWith<$Res>(_value.response!, (value) {
      return _then(_value.copyWith(response: value) as $Val);
    });
  }

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SignUpResponseCopyWith<$Res>? get signUpResponse {
    if (_value.signUpResponse == null) {
      return null;
    }

    return $SignUpResponseCopyWith<$Res>(_value.signUpResponse!, (value) {
      return _then(_value.copyWith(signUpResponse: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthenticationStateImplCopyWith<$Res>
    implements $AuthenticationStateCopyWith<$Res> {
  factory _$$AuthenticationStateImplCopyWith(
    _$AuthenticationStateImpl value,
    $Res Function(_$AuthenticationStateImpl) then,
  ) = __$$AuthenticationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LoginResponse? response,
    SignUpResponse? signUpResponse,
    AsyncValue<CategoryResponse> categoryAsync,
    AsyncValue<SpecialityResponse?> specialityAsync,
    AsyncValue<DegreeResponse> degreeAsync,
  });

  @override
  $LoginResponseCopyWith<$Res>? get response;
  @override
  $SignUpResponseCopyWith<$Res>? get signUpResponse;
}

/// @nodoc
class __$$AuthenticationStateImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationStateImpl>
    implements _$$AuthenticationStateImplCopyWith<$Res> {
  __$$AuthenticationStateImplCopyWithImpl(
    _$AuthenticationStateImpl _value,
    $Res Function(_$AuthenticationStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = freezed,
    Object? signUpResponse = freezed,
    Object? categoryAsync = null,
    Object? specialityAsync = null,
    Object? degreeAsync = null,
  }) {
    return _then(
      _$AuthenticationStateImpl(
        response: freezed == response
            ? _value.response
            : response // ignore: cast_nullable_to_non_nullable
                  as LoginResponse?,
        signUpResponse: freezed == signUpResponse
            ? _value.signUpResponse
            : signUpResponse // ignore: cast_nullable_to_non_nullable
                  as SignUpResponse?,
        categoryAsync: null == categoryAsync
            ? _value.categoryAsync
            : categoryAsync // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<CategoryResponse>,
        specialityAsync: null == specialityAsync
            ? _value.specialityAsync
            : specialityAsync // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<SpecialityResponse?>,
        degreeAsync: null == degreeAsync
            ? _value.degreeAsync
            : degreeAsync // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<DegreeResponse>,
      ),
    );
  }
}

/// @nodoc

class _$AuthenticationStateImpl implements _AuthenticationState {
  const _$AuthenticationStateImpl({
    this.response,
    this.signUpResponse,
    this.categoryAsync = const AsyncLoading<CategoryResponse>(),
    this.specialityAsync = const AsyncData<SpecialityResponse?>(null),
    this.degreeAsync = const AsyncLoading<DegreeResponse>(),
  });

  @override
  final LoginResponse? response;
  @override
  final SignUpResponse? signUpResponse;
  @override
  @JsonKey()
  final AsyncValue<CategoryResponse> categoryAsync;
  @override
  @JsonKey()
  final AsyncValue<SpecialityResponse?> specialityAsync;
  @override
  @JsonKey()
  final AsyncValue<DegreeResponse> degreeAsync;

  @override
  String toString() {
    return 'AuthenticationState(response: $response, signUpResponse: $signUpResponse, categoryAsync: $categoryAsync, specialityAsync: $specialityAsync, degreeAsync: $degreeAsync)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationStateImpl &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.signUpResponse, signUpResponse) ||
                other.signUpResponse == signUpResponse) &&
            (identical(other.categoryAsync, categoryAsync) ||
                other.categoryAsync == categoryAsync) &&
            (identical(other.specialityAsync, specialityAsync) ||
                other.specialityAsync == specialityAsync) &&
            (identical(other.degreeAsync, degreeAsync) ||
                other.degreeAsync == degreeAsync));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    response,
    signUpResponse,
    categoryAsync,
    specialityAsync,
    degreeAsync,
  );

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationStateImplCopyWith<_$AuthenticationStateImpl> get copyWith =>
      __$$AuthenticationStateImplCopyWithImpl<_$AuthenticationStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AuthenticationState implements AuthenticationState {
  const factory _AuthenticationState({
    final LoginResponse? response,
    final SignUpResponse? signUpResponse,
    final AsyncValue<CategoryResponse> categoryAsync,
    final AsyncValue<SpecialityResponse?> specialityAsync,
    final AsyncValue<DegreeResponse> degreeAsync,
  }) = _$AuthenticationStateImpl;

  @override
  LoginResponse? get response;
  @override
  SignUpResponse? get signUpResponse;
  @override
  AsyncValue<CategoryResponse> get categoryAsync;
  @override
  AsyncValue<SpecialityResponse?> get specialityAsync;
  @override
  AsyncValue<DegreeResponse> get degreeAsync;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationStateImplCopyWith<_$AuthenticationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
