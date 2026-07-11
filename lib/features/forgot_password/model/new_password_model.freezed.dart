// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_password_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NewPasswordRequest _$NewPasswordRequestFromJson(Map<String, dynamic> json) {
  return _NewPasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$NewPasswordRequest {
  String get id => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this NewPasswordRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewPasswordRequestCopyWith<NewPasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewPasswordRequestCopyWith<$Res> {
  factory $NewPasswordRequestCopyWith(
    NewPasswordRequest value,
    $Res Function(NewPasswordRequest) then,
  ) = _$NewPasswordRequestCopyWithImpl<$Res, NewPasswordRequest>;
  @useResult
  $Res call({String id, String password});
}

/// @nodoc
class _$NewPasswordRequestCopyWithImpl<$Res, $Val extends NewPasswordRequest>
    implements $NewPasswordRequestCopyWith<$Res> {
  _$NewPasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? password = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NewPasswordRequestImplCopyWith<$Res>
    implements $NewPasswordRequestCopyWith<$Res> {
  factory _$$NewPasswordRequestImplCopyWith(
    _$NewPasswordRequestImpl value,
    $Res Function(_$NewPasswordRequestImpl) then,
  ) = __$$NewPasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String password});
}

/// @nodoc
class __$$NewPasswordRequestImplCopyWithImpl<$Res>
    extends _$NewPasswordRequestCopyWithImpl<$Res, _$NewPasswordRequestImpl>
    implements _$$NewPasswordRequestImplCopyWith<$Res> {
  __$$NewPasswordRequestImplCopyWithImpl(
    _$NewPasswordRequestImpl _value,
    $Res Function(_$NewPasswordRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? password = null}) {
    return _then(
      _$NewPasswordRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NewPasswordRequestImpl implements _NewPasswordRequest {
  const _$NewPasswordRequestImpl({required this.id, required this.password});

  factory _$NewPasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewPasswordRequestImplFromJson(json);

  @override
  final String id;
  @override
  final String password;

  @override
  String toString() {
    return 'NewPasswordRequest(id: $id, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewPasswordRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, password);

  /// Create a copy of NewPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewPasswordRequestImplCopyWith<_$NewPasswordRequestImpl> get copyWith =>
      __$$NewPasswordRequestImplCopyWithImpl<_$NewPasswordRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NewPasswordRequestImplToJson(this);
  }
}

abstract class _NewPasswordRequest implements NewPasswordRequest {
  const factory _NewPasswordRequest({
    required final String id,
    required final String password,
  }) = _$NewPasswordRequestImpl;

  factory _NewPasswordRequest.fromJson(Map<String, dynamic> json) =
      _$NewPasswordRequestImpl.fromJson;

  @override
  String get id;
  @override
  String get password;

  /// Create a copy of NewPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewPasswordRequestImplCopyWith<_$NewPasswordRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NewPasswordResponse _$NewPasswordResponseFromJson(Map<String, dynamic> json) {
  return _NewPasswordResponse.fromJson(json);
}

/// @nodoc
mixin _$NewPasswordResponse {
  int get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<dynamic> get data => throw _privateConstructorUsedError;

  /// Serializes this NewPasswordResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewPasswordResponseCopyWith<NewPasswordResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewPasswordResponseCopyWith<$Res> {
  factory $NewPasswordResponseCopyWith(
    NewPasswordResponse value,
    $Res Function(NewPasswordResponse) then,
  ) = _$NewPasswordResponseCopyWithImpl<$Res, NewPasswordResponse>;
  @useResult
  $Res call({int status, String message, List<dynamic> data});
}

/// @nodoc
class _$NewPasswordResponseCopyWithImpl<$Res, $Val extends NewPasswordResponse>
    implements $NewPasswordResponseCopyWith<$Res> {
  _$NewPasswordResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewPasswordResponse
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
                      as List<dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NewPasswordResponseImplCopyWith<$Res>
    implements $NewPasswordResponseCopyWith<$Res> {
  factory _$$NewPasswordResponseImplCopyWith(
    _$NewPasswordResponseImpl value,
    $Res Function(_$NewPasswordResponseImpl) then,
  ) = __$$NewPasswordResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String message, List<dynamic> data});
}

/// @nodoc
class __$$NewPasswordResponseImplCopyWithImpl<$Res>
    extends _$NewPasswordResponseCopyWithImpl<$Res, _$NewPasswordResponseImpl>
    implements _$$NewPasswordResponseImplCopyWith<$Res> {
  __$$NewPasswordResponseImplCopyWithImpl(
    _$NewPasswordResponseImpl _value,
    $Res Function(_$NewPasswordResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _$NewPasswordResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NewPasswordResponseImpl implements _NewPasswordResponse {
  const _$NewPasswordResponseImpl({
    required this.status,
    required this.message,
    required final List<dynamic> data,
  }) : _data = data;

  factory _$NewPasswordResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewPasswordResponseImplFromJson(json);

  @override
  final int status;
  @override
  final String message;
  final List<dynamic> _data;
  @override
  List<dynamic> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'NewPasswordResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewPasswordResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    message,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of NewPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewPasswordResponseImplCopyWith<_$NewPasswordResponseImpl> get copyWith =>
      __$$NewPasswordResponseImplCopyWithImpl<_$NewPasswordResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NewPasswordResponseImplToJson(this);
  }
}

abstract class _NewPasswordResponse implements NewPasswordResponse {
  const factory _NewPasswordResponse({
    required final int status,
    required final String message,
    required final List<dynamic> data,
  }) = _$NewPasswordResponseImpl;

  factory _NewPasswordResponse.fromJson(Map<String, dynamic> json) =
      _$NewPasswordResponseImpl.fromJson;

  @override
  int get status;
  @override
  String get message;
  @override
  List<dynamic> get data;

  /// Create a copy of NewPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewPasswordResponseImplCopyWith<_$NewPasswordResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
