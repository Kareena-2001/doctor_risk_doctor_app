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
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  AuthenticationModel? get model => throw _privateConstructorUsedError;

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
  $Res call({String? errorMessage, bool isLoading, AuthenticationModel? model});

  $AuthenticationModelCopyWith<$Res>? get model;
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
    Object? errorMessage = freezed,
    Object? isLoading = null,
    Object? model = freezed,
  }) {
    return _then(
      _value.copyWith(
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            model: freezed == model
                ? _value.model
                : model // ignore: cast_nullable_to_non_nullable
                      as AuthenticationModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthenticationModelCopyWith<$Res>? get model {
    if (_value.model == null) {
      return null;
    }

    return $AuthenticationModelCopyWith<$Res>(_value.model!, (value) {
      return _then(_value.copyWith(model: value) as $Val);
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
  $Res call({String? errorMessage, bool isLoading, AuthenticationModel? model});

  @override
  $AuthenticationModelCopyWith<$Res>? get model;
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
    Object? errorMessage = freezed,
    Object? isLoading = null,
    Object? model = freezed,
  }) {
    return _then(
      _$AuthenticationStateImpl(
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        model: freezed == model
            ? _value.model
            : model // ignore: cast_nullable_to_non_nullable
                  as AuthenticationModel?,
      ),
    );
  }
}

/// @nodoc

class _$AuthenticationStateImpl implements _AuthenticationState {
  const _$AuthenticationStateImpl({
    this.errorMessage,
    this.isLoading = false,
    this.model,
  });

  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final AuthenticationModel? model;

  @override
  String toString() {
    return 'AuthenticationState(errorMessage: $errorMessage, isLoading: $isLoading, model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationStateImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage, isLoading, model);

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
    final String? errorMessage,
    final bool isLoading,
    final AuthenticationModel? model,
  }) = _$AuthenticationStateImpl;

  @override
  String? get errorMessage;
  @override
  bool get isLoading;
  @override
  AuthenticationModel? get model;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationStateImplCopyWith<_$AuthenticationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
