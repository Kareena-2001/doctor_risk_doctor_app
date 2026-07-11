// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_docs_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AdminDocsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<AdminDocsData> get docs => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of AdminDocsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminDocsStateCopyWith<AdminDocsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminDocsStateCopyWith<$Res> {
  factory $AdminDocsStateCopyWith(
    AdminDocsState value,
    $Res Function(AdminDocsState) then,
  ) = _$AdminDocsStateCopyWithImpl<$Res, AdminDocsState>;
  @useResult
  $Res call({bool isLoading, List<AdminDocsData> docs, String? error});
}

/// @nodoc
class _$AdminDocsStateCopyWithImpl<$Res, $Val extends AdminDocsState>
    implements $AdminDocsStateCopyWith<$Res> {
  _$AdminDocsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminDocsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? docs = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            docs: null == docs
                ? _value.docs
                : docs // ignore: cast_nullable_to_non_nullable
                      as List<AdminDocsData>,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminDocsStateImplCopyWith<$Res>
    implements $AdminDocsStateCopyWith<$Res> {
  factory _$$AdminDocsStateImplCopyWith(
    _$AdminDocsStateImpl value,
    $Res Function(_$AdminDocsStateImpl) then,
  ) = __$$AdminDocsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<AdminDocsData> docs, String? error});
}

/// @nodoc
class __$$AdminDocsStateImplCopyWithImpl<$Res>
    extends _$AdminDocsStateCopyWithImpl<$Res, _$AdminDocsStateImpl>
    implements _$$AdminDocsStateImplCopyWith<$Res> {
  __$$AdminDocsStateImplCopyWithImpl(
    _$AdminDocsStateImpl _value,
    $Res Function(_$AdminDocsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminDocsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? docs = null,
    Object? error = freezed,
  }) {
    return _then(
      _$AdminDocsStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        docs: null == docs
            ? _value._docs
            : docs // ignore: cast_nullable_to_non_nullable
                  as List<AdminDocsData>,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AdminDocsStateImpl implements _AdminDocsState {
  const _$AdminDocsStateImpl({
    this.isLoading = false,
    final List<AdminDocsData> docs = const [],
    this.error,
  }) : _docs = docs;

  @override
  @JsonKey()
  final bool isLoading;
  final List<AdminDocsData> _docs;
  @override
  @JsonKey()
  List<AdminDocsData> get docs {
    if (_docs is EqualUnmodifiableListView) return _docs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_docs);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'AdminDocsState(isLoading: $isLoading, docs: $docs, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminDocsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._docs, _docs) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    const DeepCollectionEquality().hash(_docs),
    error,
  );

  /// Create a copy of AdminDocsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminDocsStateImplCopyWith<_$AdminDocsStateImpl> get copyWith =>
      __$$AdminDocsStateImplCopyWithImpl<_$AdminDocsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AdminDocsState implements AdminDocsState {
  const factory _AdminDocsState({
    final bool isLoading,
    final List<AdminDocsData> docs,
    final String? error,
  }) = _$AdminDocsStateImpl;

  @override
  bool get isLoading;
  @override
  List<AdminDocsData> get docs;
  @override
  String? get error;

  /// Create a copy of AdminDocsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminDocsStateImplCopyWith<_$AdminDocsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
