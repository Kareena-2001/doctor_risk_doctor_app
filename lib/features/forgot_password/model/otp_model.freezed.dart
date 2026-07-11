// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OtpRequest _$OtpRequestFromJson(Map<String, dynamic> json) {
  return _OtpRequest.fromJson(json);
}

/// @nodoc
mixin _$OtpRequest {
  String get otp => throw _privateConstructorUsedError;

  /// Serializes this OtpRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpRequestCopyWith<OtpRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpRequestCopyWith<$Res> {
  factory $OtpRequestCopyWith(
    OtpRequest value,
    $Res Function(OtpRequest) then,
  ) = _$OtpRequestCopyWithImpl<$Res, OtpRequest>;
  @useResult
  $Res call({String otp});
}

/// @nodoc
class _$OtpRequestCopyWithImpl<$Res, $Val extends OtpRequest>
    implements $OtpRequestCopyWith<$Res> {
  _$OtpRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? otp = null}) {
    return _then(
      _value.copyWith(
            otp: null == otp
                ? _value.otp
                : otp // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OtpRequestImplCopyWith<$Res>
    implements $OtpRequestCopyWith<$Res> {
  factory _$$OtpRequestImplCopyWith(
    _$OtpRequestImpl value,
    $Res Function(_$OtpRequestImpl) then,
  ) = __$$OtpRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String otp});
}

/// @nodoc
class __$$OtpRequestImplCopyWithImpl<$Res>
    extends _$OtpRequestCopyWithImpl<$Res, _$OtpRequestImpl>
    implements _$$OtpRequestImplCopyWith<$Res> {
  __$$OtpRequestImplCopyWithImpl(
    _$OtpRequestImpl _value,
    $Res Function(_$OtpRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? otp = null}) {
    return _then(
      _$OtpRequestImpl(
        otp: null == otp
            ? _value.otp
            : otp // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpRequestImpl implements _OtpRequest {
  const _$OtpRequestImpl({required this.otp});

  factory _$OtpRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpRequestImplFromJson(json);

  @override
  final String otp;

  @override
  String toString() {
    return 'OtpRequest(otp: $otp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpRequestImpl &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, otp);

  /// Create a copy of OtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpRequestImplCopyWith<_$OtpRequestImpl> get copyWith =>
      __$$OtpRequestImplCopyWithImpl<_$OtpRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpRequestImplToJson(this);
  }
}

abstract class _OtpRequest implements OtpRequest {
  const factory _OtpRequest({required final String otp}) = _$OtpRequestImpl;

  factory _OtpRequest.fromJson(Map<String, dynamic> json) =
      _$OtpRequestImpl.fromJson;

  @override
  String get otp;

  /// Create a copy of OtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpRequestImplCopyWith<_$OtpRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtpResponse _$OtpResponseFromJson(Map<String, dynamic> json) {
  return _OtpResponse.fromJson(json);
}

/// @nodoc
mixin _$OtpResponse {
  int get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  OtpData get data => throw _privateConstructorUsedError;

  /// Serializes this OtpResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpResponseCopyWith<OtpResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpResponseCopyWith<$Res> {
  factory $OtpResponseCopyWith(
    OtpResponse value,
    $Res Function(OtpResponse) then,
  ) = _$OtpResponseCopyWithImpl<$Res, OtpResponse>;
  @useResult
  $Res call({int status, String message, OtpData data});

  $OtpDataCopyWith<$Res> get data;
}

/// @nodoc
class _$OtpResponseCopyWithImpl<$Res, $Val extends OtpResponse>
    implements $OtpResponseCopyWith<$Res> {
  _$OtpResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as OtpData,
          )
          as $Val,
    );
  }

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OtpDataCopyWith<$Res> get data {
    return $OtpDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OtpResponseImplCopyWith<$Res>
    implements $OtpResponseCopyWith<$Res> {
  factory _$$OtpResponseImplCopyWith(
    _$OtpResponseImpl value,
    $Res Function(_$OtpResponseImpl) then,
  ) = __$$OtpResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String message, OtpData data});

  @override
  $OtpDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$OtpResponseImplCopyWithImpl<$Res>
    extends _$OtpResponseCopyWithImpl<$Res, _$OtpResponseImpl>
    implements _$$OtpResponseImplCopyWith<$Res> {
  __$$OtpResponseImplCopyWithImpl(
    _$OtpResponseImpl _value,
    $Res Function(_$OtpResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _$OtpResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as OtpData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpResponseImpl implements _OtpResponse {
  const _$OtpResponseImpl({
    required this.status,
    required this.message,
    required this.data,
  });

  factory _$OtpResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpResponseImplFromJson(json);

  @override
  final int status;
  @override
  final String message;
  @override
  final OtpData data;

  @override
  String toString() {
    return 'OtpResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, data);

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpResponseImplCopyWith<_$OtpResponseImpl> get copyWith =>
      __$$OtpResponseImplCopyWithImpl<_$OtpResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpResponseImplToJson(this);
  }
}

abstract class _OtpResponse implements OtpResponse {
  const factory _OtpResponse({
    required final int status,
    required final String message,
    required final OtpData data,
  }) = _$OtpResponseImpl;

  factory _OtpResponse.fromJson(Map<String, dynamic> json) =
      _$OtpResponseImpl.fromJson;

  @override
  int get status;
  @override
  String get message;
  @override
  OtpData get data;

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpResponseImplCopyWith<_$OtpResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtpData _$OtpDataFromJson(Map<String, dynamic> json) {
  return _OtpData.fromJson(json);
}

/// @nodoc
mixin _$OtpData {
  String get userid => throw _privateConstructorUsedError;

  /// Serializes this OtpData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpDataCopyWith<OtpData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpDataCopyWith<$Res> {
  factory $OtpDataCopyWith(OtpData value, $Res Function(OtpData) then) =
      _$OtpDataCopyWithImpl<$Res, OtpData>;
  @useResult
  $Res call({String userid});
}

/// @nodoc
class _$OtpDataCopyWithImpl<$Res, $Val extends OtpData>
    implements $OtpDataCopyWith<$Res> {
  _$OtpDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userid = null}) {
    return _then(
      _value.copyWith(
            userid: null == userid
                ? _value.userid
                : userid // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OtpDataImplCopyWith<$Res> implements $OtpDataCopyWith<$Res> {
  factory _$$OtpDataImplCopyWith(
    _$OtpDataImpl value,
    $Res Function(_$OtpDataImpl) then,
  ) = __$$OtpDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userid});
}

/// @nodoc
class __$$OtpDataImplCopyWithImpl<$Res>
    extends _$OtpDataCopyWithImpl<$Res, _$OtpDataImpl>
    implements _$$OtpDataImplCopyWith<$Res> {
  __$$OtpDataImplCopyWithImpl(
    _$OtpDataImpl _value,
    $Res Function(_$OtpDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userid = null}) {
    return _then(
      _$OtpDataImpl(
        userid: null == userid
            ? _value.userid
            : userid // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpDataImpl implements _OtpData {
  const _$OtpDataImpl({required this.userid});

  factory _$OtpDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpDataImplFromJson(json);

  @override
  final String userid;

  @override
  String toString() {
    return 'OtpData(userid: $userid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpDataImpl &&
            (identical(other.userid, userid) || other.userid == userid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userid);

  /// Create a copy of OtpData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpDataImplCopyWith<_$OtpDataImpl> get copyWith =>
      __$$OtpDataImplCopyWithImpl<_$OtpDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpDataImplToJson(this);
  }
}

abstract class _OtpData implements OtpData {
  const factory _OtpData({required final String userid}) = _$OtpDataImpl;

  factory _OtpData.fromJson(Map<String, dynamic> json) = _$OtpDataImpl.fromJson;

  @override
  String get userid;

  /// Create a copy of OtpData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpDataImplCopyWith<_$OtpDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
