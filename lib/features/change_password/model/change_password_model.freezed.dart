// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_password_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChangePasswordRequest _$ChangePasswordRequestFromJson(
  Map<String, dynamic> json,
) {
  return _ChangePasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$ChangePasswordRequest {
  @JsonKey(name: 'old_password')
  String get oldPassword => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_password')
  String get newPassword => throw _privateConstructorUsedError;
  @JsonKey(name: 'confirm_password')
  String get confirmPassword => throw _privateConstructorUsedError;

  /// Serializes this ChangePasswordRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangePasswordRequestCopyWith<ChangePasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangePasswordRequestCopyWith<$Res> {
  factory $ChangePasswordRequestCopyWith(
    ChangePasswordRequest value,
    $Res Function(ChangePasswordRequest) then,
  ) = _$ChangePasswordRequestCopyWithImpl<$Res, ChangePasswordRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'old_password') String oldPassword,
    @JsonKey(name: 'new_password') String newPassword,
    @JsonKey(name: 'confirm_password') String confirmPassword,
  });
}

/// @nodoc
class _$ChangePasswordRequestCopyWithImpl<
  $Res,
  $Val extends ChangePasswordRequest
>
    implements $ChangePasswordRequestCopyWith<$Res> {
  _$ChangePasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldPassword = null,
    Object? newPassword = null,
    Object? confirmPassword = null,
  }) {
    return _then(
      _value.copyWith(
            oldPassword: null == oldPassword
                ? _value.oldPassword
                : oldPassword // ignore: cast_nullable_to_non_nullable
                      as String,
            newPassword: null == newPassword
                ? _value.newPassword
                : newPassword // ignore: cast_nullable_to_non_nullable
                      as String,
            confirmPassword: null == confirmPassword
                ? _value.confirmPassword
                : confirmPassword // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChangePasswordRequestImplCopyWith<$Res>
    implements $ChangePasswordRequestCopyWith<$Res> {
  factory _$$ChangePasswordRequestImplCopyWith(
    _$ChangePasswordRequestImpl value,
    $Res Function(_$ChangePasswordRequestImpl) then,
  ) = __$$ChangePasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'old_password') String oldPassword,
    @JsonKey(name: 'new_password') String newPassword,
    @JsonKey(name: 'confirm_password') String confirmPassword,
  });
}

/// @nodoc
class __$$ChangePasswordRequestImplCopyWithImpl<$Res>
    extends
        _$ChangePasswordRequestCopyWithImpl<$Res, _$ChangePasswordRequestImpl>
    implements _$$ChangePasswordRequestImplCopyWith<$Res> {
  __$$ChangePasswordRequestImplCopyWithImpl(
    _$ChangePasswordRequestImpl _value,
    $Res Function(_$ChangePasswordRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldPassword = null,
    Object? newPassword = null,
    Object? confirmPassword = null,
  }) {
    return _then(
      _$ChangePasswordRequestImpl(
        oldPassword: null == oldPassword
            ? _value.oldPassword
            : oldPassword // ignore: cast_nullable_to_non_nullable
                  as String,
        newPassword: null == newPassword
            ? _value.newPassword
            : newPassword // ignore: cast_nullable_to_non_nullable
                  as String,
        confirmPassword: null == confirmPassword
            ? _value.confirmPassword
            : confirmPassword // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangePasswordRequestImpl implements _ChangePasswordRequest {
  const _$ChangePasswordRequestImpl({
    @JsonKey(name: 'old_password') required this.oldPassword,
    @JsonKey(name: 'new_password') required this.newPassword,
    @JsonKey(name: 'confirm_password') required this.confirmPassword,
  });

  factory _$ChangePasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangePasswordRequestImplFromJson(json);

  @override
  @JsonKey(name: 'old_password')
  final String oldPassword;
  @override
  @JsonKey(name: 'new_password')
  final String newPassword;
  @override
  @JsonKey(name: 'confirm_password')
  final String confirmPassword;

  @override
  String toString() {
    return 'ChangePasswordRequest(oldPassword: $oldPassword, newPassword: $newPassword, confirmPassword: $confirmPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordRequestImpl &&
            (identical(other.oldPassword, oldPassword) ||
                other.oldPassword == oldPassword) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, oldPassword, newPassword, confirmPassword);

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePasswordRequestImplCopyWith<_$ChangePasswordRequestImpl>
  get copyWith =>
      __$$ChangePasswordRequestImplCopyWithImpl<_$ChangePasswordRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangePasswordRequestImplToJson(this);
  }
}

abstract class _ChangePasswordRequest implements ChangePasswordRequest {
  const factory _ChangePasswordRequest({
    @JsonKey(name: 'old_password') required final String oldPassword,
    @JsonKey(name: 'new_password') required final String newPassword,
    @JsonKey(name: 'confirm_password') required final String confirmPassword,
  }) = _$ChangePasswordRequestImpl;

  factory _ChangePasswordRequest.fromJson(Map<String, dynamic> json) =
      _$ChangePasswordRequestImpl.fromJson;

  @override
  @JsonKey(name: 'old_password')
  String get oldPassword;
  @override
  @JsonKey(name: 'new_password')
  String get newPassword;
  @override
  @JsonKey(name: 'confirm_password')
  String get confirmPassword;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePasswordRequestImplCopyWith<_$ChangePasswordRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ChangePasswordResponse _$ChangePasswordResponseFromJson(
  Map<String, dynamic> json,
) {
  return _ChangePasswordResponse.fromJson(json);
}

/// @nodoc
mixin _$ChangePasswordResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String? get msg => throw _privateConstructorUsedError;
  List<dynamic> get data => throw _privateConstructorUsedError;

  /// Serializes this ChangePasswordResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangePasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangePasswordResponseCopyWith<ChangePasswordResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangePasswordResponseCopyWith<$Res> {
  factory $ChangePasswordResponseCopyWith(
    ChangePasswordResponse value,
    $Res Function(ChangePasswordResponse) then,
  ) = _$ChangePasswordResponseCopyWithImpl<$Res, ChangePasswordResponse>;
  @useResult
  $Res call({bool status, int code, String? msg, List<dynamic> data});
}

/// @nodoc
class _$ChangePasswordResponseCopyWithImpl<
  $Res,
  $Val extends ChangePasswordResponse
>
    implements $ChangePasswordResponseCopyWith<$Res> {
  _$ChangePasswordResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangePasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? msg = freezed,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as bool,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as int,
            msg: freezed == msg
                ? _value.msg
                : msg // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$ChangePasswordResponseImplCopyWith<$Res>
    implements $ChangePasswordResponseCopyWith<$Res> {
  factory _$$ChangePasswordResponseImplCopyWith(
    _$ChangePasswordResponseImpl value,
    $Res Function(_$ChangePasswordResponseImpl) then,
  ) = __$$ChangePasswordResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, int code, String? msg, List<dynamic> data});
}

/// @nodoc
class __$$ChangePasswordResponseImplCopyWithImpl<$Res>
    extends
        _$ChangePasswordResponseCopyWithImpl<$Res, _$ChangePasswordResponseImpl>
    implements _$$ChangePasswordResponseImplCopyWith<$Res> {
  __$$ChangePasswordResponseImplCopyWithImpl(
    _$ChangePasswordResponseImpl _value,
    $Res Function(_$ChangePasswordResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChangePasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? msg = freezed,
    Object? data = null,
  }) {
    return _then(
      _$ChangePasswordResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as bool,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as int,
        msg: freezed == msg
            ? _value.msg
            : msg // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$ChangePasswordResponseImpl implements _ChangePasswordResponse {
  const _$ChangePasswordResponseImpl({
    required this.status,
    required this.code,
    this.msg,
    final List<dynamic> data = const [],
  }) : _data = data;

  factory _$ChangePasswordResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangePasswordResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String? msg;
  final List<dynamic> _data;
  @override
  @JsonKey()
  List<dynamic> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'ChangePasswordResponse(status: $status, code: $code, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    code,
    msg,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of ChangePasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePasswordResponseImplCopyWith<_$ChangePasswordResponseImpl>
  get copyWith =>
      __$$ChangePasswordResponseImplCopyWithImpl<_$ChangePasswordResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangePasswordResponseImplToJson(this);
  }
}

abstract class _ChangePasswordResponse implements ChangePasswordResponse {
  const factory _ChangePasswordResponse({
    required final bool status,
    required final int code,
    final String? msg,
    final List<dynamic> data,
  }) = _$ChangePasswordResponseImpl;

  factory _ChangePasswordResponse.fromJson(Map<String, dynamic> json) =
      _$ChangePasswordResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String? get msg;
  @override
  List<dynamic> get data;

  /// Create a copy of ChangePasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePasswordResponseImplCopyWith<_$ChangePasswordResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
