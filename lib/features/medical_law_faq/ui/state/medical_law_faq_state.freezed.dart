// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medical_law_faq_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MedicalLawFaqState {
  List<MedicalLawFaqModel> get faqs => throw _privateConstructorUsedError;

  /// Create a copy of MedicalLawFaqState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicalLawFaqStateCopyWith<MedicalLawFaqState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicalLawFaqStateCopyWith<$Res> {
  factory $MedicalLawFaqStateCopyWith(
    MedicalLawFaqState value,
    $Res Function(MedicalLawFaqState) then,
  ) = _$MedicalLawFaqStateCopyWithImpl<$Res, MedicalLawFaqState>;
  @useResult
  $Res call({List<MedicalLawFaqModel> faqs});
}

/// @nodoc
class _$MedicalLawFaqStateCopyWithImpl<$Res, $Val extends MedicalLawFaqState>
    implements $MedicalLawFaqStateCopyWith<$Res> {
  _$MedicalLawFaqStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicalLawFaqState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? faqs = null}) {
    return _then(
      _value.copyWith(
            faqs: null == faqs
                ? _value.faqs
                : faqs // ignore: cast_nullable_to_non_nullable
                      as List<MedicalLawFaqModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MedicalLawFaqStateImplCopyWith<$Res>
    implements $MedicalLawFaqStateCopyWith<$Res> {
  factory _$$MedicalLawFaqStateImplCopyWith(
    _$MedicalLawFaqStateImpl value,
    $Res Function(_$MedicalLawFaqStateImpl) then,
  ) = __$$MedicalLawFaqStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MedicalLawFaqModel> faqs});
}

/// @nodoc
class __$$MedicalLawFaqStateImplCopyWithImpl<$Res>
    extends _$MedicalLawFaqStateCopyWithImpl<$Res, _$MedicalLawFaqStateImpl>
    implements _$$MedicalLawFaqStateImplCopyWith<$Res> {
  __$$MedicalLawFaqStateImplCopyWithImpl(
    _$MedicalLawFaqStateImpl _value,
    $Res Function(_$MedicalLawFaqStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MedicalLawFaqState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? faqs = null}) {
    return _then(
      _$MedicalLawFaqStateImpl(
        faqs: null == faqs
            ? _value._faqs
            : faqs // ignore: cast_nullable_to_non_nullable
                  as List<MedicalLawFaqModel>,
      ),
    );
  }
}

/// @nodoc

class _$MedicalLawFaqStateImpl implements _MedicalLawFaqState {
  const _$MedicalLawFaqStateImpl({
    final List<MedicalLawFaqModel> faqs = const [],
  }) : _faqs = faqs;

  final List<MedicalLawFaqModel> _faqs;
  @override
  @JsonKey()
  List<MedicalLawFaqModel> get faqs {
    if (_faqs is EqualUnmodifiableListView) return _faqs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_faqs);
  }

  @override
  String toString() {
    return 'MedicalLawFaqState(faqs: $faqs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicalLawFaqStateImpl &&
            const DeepCollectionEquality().equals(other._faqs, _faqs));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_faqs));

  /// Create a copy of MedicalLawFaqState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicalLawFaqStateImplCopyWith<_$MedicalLawFaqStateImpl> get copyWith =>
      __$$MedicalLawFaqStateImplCopyWithImpl<_$MedicalLawFaqStateImpl>(
        this,
        _$identity,
      );
}

abstract class _MedicalLawFaqState implements MedicalLawFaqState {
  const factory _MedicalLawFaqState({final List<MedicalLawFaqModel> faqs}) =
      _$MedicalLawFaqStateImpl;

  @override
  List<MedicalLawFaqModel> get faqs;

  /// Create a copy of MedicalLawFaqState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicalLawFaqStateImplCopyWith<_$MedicalLawFaqStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
