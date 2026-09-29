// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_request_resp.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AddRequestResp _$AddRequestRespFromJson(Map<String, dynamic> json) {
  return _AddRequestResp.fromJson(json);
}

/// @nodoc
mixin _$AddRequestResp {
  int get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  AddRequestData? get data => throw _privateConstructorUsedError;

  /// Serializes this AddRequestResp to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddRequestResp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddRequestRespCopyWith<AddRequestResp> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddRequestRespCopyWith<$Res> {
  factory $AddRequestRespCopyWith(
    AddRequestResp value,
    $Res Function(AddRequestResp) then,
  ) = _$AddRequestRespCopyWithImpl<$Res, AddRequestResp>;
  @useResult
  $Res call({int status, String msg, AddRequestData? data});

  $AddRequestDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$AddRequestRespCopyWithImpl<$Res, $Val extends AddRequestResp>
    implements $AddRequestRespCopyWith<$Res> {
  _$AddRequestRespCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddRequestResp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = null,
    Object? data = freezed,
  }) {
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
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as AddRequestData?,
          )
          as $Val,
    );
  }

  /// Create a copy of AddRequestResp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddRequestDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $AddRequestDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddRequestRespImplCopyWith<$Res>
    implements $AddRequestRespCopyWith<$Res> {
  factory _$$AddRequestRespImplCopyWith(
    _$AddRequestRespImpl value,
    $Res Function(_$AddRequestRespImpl) then,
  ) = __$$AddRequestRespImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String msg, AddRequestData? data});

  @override
  $AddRequestDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$AddRequestRespImplCopyWithImpl<$Res>
    extends _$AddRequestRespCopyWithImpl<$Res, _$AddRequestRespImpl>
    implements _$$AddRequestRespImplCopyWith<$Res> {
  __$$AddRequestRespImplCopyWithImpl(
    _$AddRequestRespImpl _value,
    $Res Function(_$AddRequestRespImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddRequestResp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? msg = null,
    Object? data = freezed,
  }) {
    return _then(
      _$AddRequestRespImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        msg: null == msg
            ? _value.msg
            : msg // ignore: cast_nullable_to_non_nullable
                  as String,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as AddRequestData?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AddRequestRespImpl implements _AddRequestResp {
  const _$AddRequestRespImpl({
    required this.status,
    required this.msg,
    this.data,
  });

  factory _$AddRequestRespImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddRequestRespImplFromJson(json);

  @override
  final int status;
  @override
  final String msg;
  @override
  final AddRequestData? data;

  @override
  String toString() {
    return 'AddRequestResp(status: $status, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddRequestRespImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, msg, data);

  /// Create a copy of AddRequestResp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddRequestRespImplCopyWith<_$AddRequestRespImpl> get copyWith =>
      __$$AddRequestRespImplCopyWithImpl<_$AddRequestRespImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AddRequestRespImplToJson(this);
  }
}

abstract class _AddRequestResp implements AddRequestResp {
  const factory _AddRequestResp({
    required final int status,
    required final String msg,
    final AddRequestData? data,
  }) = _$AddRequestRespImpl;

  factory _AddRequestResp.fromJson(Map<String, dynamic> json) =
      _$AddRequestRespImpl.fromJson;

  @override
  int get status;
  @override
  String get msg;
  @override
  AddRequestData? get data;

  /// Create a copy of AddRequestResp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddRequestRespImplCopyWith<_$AddRequestRespImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddRequestData _$AddRequestDataFromJson(Map<String, dynamic> json) {
  return _AddRequestData.fromJson(json);
}

/// @nodoc
mixin _$AddRequestData {
  @JsonKey(name: 'tkt_number')
  String get ticketNumber => throw _privateConstructorUsedError;

  /// Serializes this AddRequestData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddRequestDataCopyWith<AddRequestData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddRequestDataCopyWith<$Res> {
  factory $AddRequestDataCopyWith(
    AddRequestData value,
    $Res Function(AddRequestData) then,
  ) = _$AddRequestDataCopyWithImpl<$Res, AddRequestData>;
  @useResult
  $Res call({@JsonKey(name: 'tkt_number') String ticketNumber});
}

/// @nodoc
class _$AddRequestDataCopyWithImpl<$Res, $Val extends AddRequestData>
    implements $AddRequestDataCopyWith<$Res> {
  _$AddRequestDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ticketNumber = null}) {
    return _then(
      _value.copyWith(
            ticketNumber: null == ticketNumber
                ? _value.ticketNumber
                : ticketNumber // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddRequestDataImplCopyWith<$Res>
    implements $AddRequestDataCopyWith<$Res> {
  factory _$$AddRequestDataImplCopyWith(
    _$AddRequestDataImpl value,
    $Res Function(_$AddRequestDataImpl) then,
  ) = __$$AddRequestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'tkt_number') String ticketNumber});
}

/// @nodoc
class __$$AddRequestDataImplCopyWithImpl<$Res>
    extends _$AddRequestDataCopyWithImpl<$Res, _$AddRequestDataImpl>
    implements _$$AddRequestDataImplCopyWith<$Res> {
  __$$AddRequestDataImplCopyWithImpl(
    _$AddRequestDataImpl _value,
    $Res Function(_$AddRequestDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ticketNumber = null}) {
    return _then(
      _$AddRequestDataImpl(
        ticketNumber: null == ticketNumber
            ? _value.ticketNumber
            : ticketNumber // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AddRequestDataImpl implements _AddRequestData {
  const _$AddRequestDataImpl({
    @JsonKey(name: 'tkt_number') required this.ticketNumber,
  });

  factory _$AddRequestDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddRequestDataImplFromJson(json);

  @override
  @JsonKey(name: 'tkt_number')
  final String ticketNumber;

  @override
  String toString() {
    return 'AddRequestData(ticketNumber: $ticketNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddRequestDataImpl &&
            (identical(other.ticketNumber, ticketNumber) ||
                other.ticketNumber == ticketNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ticketNumber);

  /// Create a copy of AddRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddRequestDataImplCopyWith<_$AddRequestDataImpl> get copyWith =>
      __$$AddRequestDataImplCopyWithImpl<_$AddRequestDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AddRequestDataImplToJson(this);
  }
}

abstract class _AddRequestData implements AddRequestData {
  const factory _AddRequestData({
    @JsonKey(name: 'tkt_number') required final String ticketNumber,
  }) = _$AddRequestDataImpl;

  factory _AddRequestData.fromJson(Map<String, dynamic> json) =
      _$AddRequestDataImpl.fromJson;

  @override
  @JsonKey(name: 'tkt_number')
  String get ticketNumber;

  /// Create a copy of AddRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddRequestDataImplCopyWith<_$AddRequestDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
