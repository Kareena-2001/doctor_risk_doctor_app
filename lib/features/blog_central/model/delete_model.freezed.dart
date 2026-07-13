// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DeleteAcResponse _$DeleteAcResponseFromJson(Map<String, dynamic> json) {
  return _DeleteAcResponse.fromJson(json);
}

/// @nodoc
mixin _$DeleteAcResponse {
  int get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;

  /// Serializes this DeleteAcResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeleteAcResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeleteAcResponseCopyWith<DeleteAcResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteAcResponseCopyWith<$Res> {
  factory $DeleteAcResponseCopyWith(
    DeleteAcResponse value,
    $Res Function(DeleteAcResponse) then,
  ) = _$DeleteAcResponseCopyWithImpl<$Res, DeleteAcResponse>;
  @useResult
  $Res call({int status, String msg});
}

/// @nodoc
class _$DeleteAcResponseCopyWithImpl<$Res, $Val extends DeleteAcResponse>
    implements $DeleteAcResponseCopyWith<$Res> {
  _$DeleteAcResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeleteAcResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? msg = null}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            msg: null == msg
                ? _value.msg
                : msg // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeleteAcResponseImplCopyWith<$Res>
    implements $DeleteAcResponseCopyWith<$Res> {
  factory _$$DeleteAcResponseImplCopyWith(
    _$DeleteAcResponseImpl value,
    $Res Function(_$DeleteAcResponseImpl) then,
  ) = __$$DeleteAcResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String msg});
}

/// @nodoc
class __$$DeleteAcResponseImplCopyWithImpl<$Res>
    extends _$DeleteAcResponseCopyWithImpl<$Res, _$DeleteAcResponseImpl>
    implements _$$DeleteAcResponseImplCopyWith<$Res> {
  __$$DeleteAcResponseImplCopyWithImpl(
    _$DeleteAcResponseImpl _value,
    $Res Function(_$DeleteAcResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeleteAcResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? msg = null}) {
    return _then(
      _$DeleteAcResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        msg: null == msg
            ? _value.msg
            : msg // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeleteAcResponseImpl implements _DeleteAcResponse {
  const _$DeleteAcResponseImpl({required this.status, required this.msg});

  factory _$DeleteAcResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeleteAcResponseImplFromJson(json);

  @override
  final int status;
  @override
  final String msg;

  @override
  String toString() {
    return 'DeleteAcResponse(status: $status, msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteAcResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, msg);

  /// Create a copy of DeleteAcResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteAcResponseImplCopyWith<_$DeleteAcResponseImpl> get copyWith =>
      __$$DeleteAcResponseImplCopyWithImpl<_$DeleteAcResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteAcResponseImplToJson(this);
  }
}

abstract class _DeleteAcResponse implements DeleteAcResponse {
  const factory _DeleteAcResponse({
    required final int status,
    required final String msg,
  }) = _$DeleteAcResponseImpl;

  factory _DeleteAcResponse.fromJson(Map<String, dynamic> json) =
      _$DeleteAcResponseImpl.fromJson;

  @override
  int get status;
  @override
  String get msg;

  /// Create a copy of DeleteAcResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteAcResponseImplCopyWith<_$DeleteAcResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
