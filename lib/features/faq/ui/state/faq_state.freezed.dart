// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faq_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FaqState {
  List<FaqModel> get faqs => throw _privateConstructorUsedError;

  /// Create a copy of FaqState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FaqStateCopyWith<FaqState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaqStateCopyWith<$Res> {
  factory $FaqStateCopyWith(FaqState value, $Res Function(FaqState) then) =
      _$FaqStateCopyWithImpl<$Res, FaqState>;
  @useResult
  $Res call({List<FaqModel> faqs});
}

/// @nodoc
class _$FaqStateCopyWithImpl<$Res, $Val extends FaqState>
    implements $FaqStateCopyWith<$Res> {
  _$FaqStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FaqState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? faqs = null}) {
    return _then(
      _value.copyWith(
            faqs: null == faqs
                ? _value.faqs
                : faqs // ignore: cast_nullable_to_non_nullable
                      as List<FaqModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FaqStateImplCopyWith<$Res>
    implements $FaqStateCopyWith<$Res> {
  factory _$$FaqStateImplCopyWith(
    _$FaqStateImpl value,
    $Res Function(_$FaqStateImpl) then,
  ) = __$$FaqStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FaqModel> faqs});
}

/// @nodoc
class __$$FaqStateImplCopyWithImpl<$Res>
    extends _$FaqStateCopyWithImpl<$Res, _$FaqStateImpl>
    implements _$$FaqStateImplCopyWith<$Res> {
  __$$FaqStateImplCopyWithImpl(
    _$FaqStateImpl _value,
    $Res Function(_$FaqStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FaqState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? faqs = null}) {
    return _then(
      _$FaqStateImpl(
        faqs: null == faqs
            ? _value._faqs
            : faqs // ignore: cast_nullable_to_non_nullable
                  as List<FaqModel>,
      ),
    );
  }
}

/// @nodoc

class _$FaqStateImpl implements _FaqState {
  const _$FaqStateImpl({final List<FaqModel> faqs = const []}) : _faqs = faqs;

  final List<FaqModel> _faqs;
  @override
  @JsonKey()
  List<FaqModel> get faqs {
    if (_faqs is EqualUnmodifiableListView) return _faqs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_faqs);
  }

  @override
  String toString() {
    return 'FaqState(faqs: $faqs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaqStateImpl &&
            const DeepCollectionEquality().equals(other._faqs, _faqs));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_faqs));

  /// Create a copy of FaqState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FaqStateImplCopyWith<_$FaqStateImpl> get copyWith =>
      __$$FaqStateImplCopyWithImpl<_$FaqStateImpl>(this, _$identity);
}

abstract class _FaqState implements FaqState {
  const factory _FaqState({final List<FaqModel> faqs}) = _$FaqStateImpl;

  @override
  List<FaqModel> get faqs;

  /// Create a copy of FaqState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaqStateImplCopyWith<_$FaqStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
