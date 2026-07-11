// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthenticationModel _$AuthenticationModelFromJson(Map<String, dynamic> json) {
  return _AuthenticationModel.fromJson(json);
}

/// @nodoc
mixin _$AuthenticationModel {
  int get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  LoginData get data => throw _privateConstructorUsedError;

  /// Serializes this AuthenticationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthenticationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthenticationModelCopyWith<AuthenticationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationModelCopyWith<$Res> {
  factory $AuthenticationModelCopyWith(
    AuthenticationModel value,
    $Res Function(AuthenticationModel) then,
  ) = _$AuthenticationModelCopyWithImpl<$Res, AuthenticationModel>;
  @useResult
  $Res call({int status, String msg, LoginData data});

  $LoginDataCopyWith<$Res> get data;
}

/// @nodoc
class _$AuthenticationModelCopyWithImpl<$Res, $Val extends AuthenticationModel>
    implements $AuthenticationModelCopyWith<$Res> {
  _$AuthenticationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthenticationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? msg = null, Object? data = null}) {
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
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as LoginData,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthenticationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoginDataCopyWith<$Res> get data {
    return $LoginDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthenticationModelImplCopyWith<$Res>
    implements $AuthenticationModelCopyWith<$Res> {
  factory _$$AuthenticationModelImplCopyWith(
    _$AuthenticationModelImpl value,
    $Res Function(_$AuthenticationModelImpl) then,
  ) = __$$AuthenticationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String msg, LoginData data});

  @override
  $LoginDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$AuthenticationModelImplCopyWithImpl<$Res>
    extends _$AuthenticationModelCopyWithImpl<$Res, _$AuthenticationModelImpl>
    implements _$$AuthenticationModelImplCopyWith<$Res> {
  __$$AuthenticationModelImplCopyWithImpl(
    _$AuthenticationModelImpl _value,
    $Res Function(_$AuthenticationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthenticationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? msg = null, Object? data = null}) {
    return _then(
      _$AuthenticationModelImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        msg: null == msg
            ? _value.msg
            : msg // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as LoginData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthenticationModelImpl implements _AuthenticationModel {
  const _$AuthenticationModelImpl({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory _$AuthenticationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthenticationModelImplFromJson(json);

  @override
  final int status;
  @override
  final String msg;
  @override
  final LoginData data;

  @override
  String toString() {
    return 'AuthenticationModel(status: $status, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, msg, data);

  /// Create a copy of AuthenticationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationModelImplCopyWith<_$AuthenticationModelImpl> get copyWith =>
      __$$AuthenticationModelImplCopyWithImpl<_$AuthenticationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthenticationModelImplToJson(this);
  }
}

abstract class _AuthenticationModel implements AuthenticationModel {
  const factory _AuthenticationModel({
    required final int status,
    required final String msg,
    required final LoginData data,
  }) = _$AuthenticationModelImpl;

  factory _AuthenticationModel.fromJson(Map<String, dynamic> json) =
      _$AuthenticationModelImpl.fromJson;

  @override
  int get status;
  @override
  String get msg;
  @override
  LoginData get data;

  /// Create a copy of AuthenticationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationModelImplCopyWith<_$AuthenticationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginData _$LoginDataFromJson(Map<String, dynamic> json) {
  return _LoginData.fromJson(json);
}

/// @nodoc
mixin _$LoginData {
  String get token => throw _privateConstructorUsedError;
  Customer get customer => throw _privateConstructorUsedError;

  /// Serializes this LoginData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginDataCopyWith<LoginData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginDataCopyWith<$Res> {
  factory $LoginDataCopyWith(LoginData value, $Res Function(LoginData) then) =
      _$LoginDataCopyWithImpl<$Res, LoginData>;
  @useResult
  $Res call({String token, Customer customer});

  $CustomerCopyWith<$Res> get customer;
}

/// @nodoc
class _$LoginDataCopyWithImpl<$Res, $Val extends LoginData>
    implements $LoginDataCopyWith<$Res> {
  _$LoginDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null, Object? customer = null}) {
    return _then(
      _value.copyWith(
            token: null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String,
            customer: null == customer
                ? _value.customer
                : customer // ignore: cast_nullable_to_non_nullable
                      as Customer,
          )
          as $Val,
    );
  }

  /// Create a copy of LoginData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerCopyWith<$Res> get customer {
    return $CustomerCopyWith<$Res>(_value.customer, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginDataImplCopyWith<$Res>
    implements $LoginDataCopyWith<$Res> {
  factory _$$LoginDataImplCopyWith(
    _$LoginDataImpl value,
    $Res Function(_$LoginDataImpl) then,
  ) = __$$LoginDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token, Customer customer});

  @override
  $CustomerCopyWith<$Res> get customer;
}

/// @nodoc
class __$$LoginDataImplCopyWithImpl<$Res>
    extends _$LoginDataCopyWithImpl<$Res, _$LoginDataImpl>
    implements _$$LoginDataImplCopyWith<$Res> {
  __$$LoginDataImplCopyWithImpl(
    _$LoginDataImpl _value,
    $Res Function(_$LoginDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null, Object? customer = null}) {
    return _then(
      _$LoginDataImpl(
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
        customer: null == customer
            ? _value.customer
            : customer // ignore: cast_nullable_to_non_nullable
                  as Customer,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginDataImpl implements _LoginData {
  const _$LoginDataImpl({required this.token, required this.customer});

  factory _$LoginDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginDataImplFromJson(json);

  @override
  final String token;
  @override
  final Customer customer;

  @override
  String toString() {
    return 'LoginData(token: $token, customer: $customer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginDataImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.customer, customer) ||
                other.customer == customer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, customer);

  /// Create a copy of LoginData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginDataImplCopyWith<_$LoginDataImpl> get copyWith =>
      __$$LoginDataImplCopyWithImpl<_$LoginDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginDataImplToJson(this);
  }
}

abstract class _LoginData implements LoginData {
  const factory _LoginData({
    required final String token,
    required final Customer customer,
  }) = _$LoginDataImpl;

  factory _LoginData.fromJson(Map<String, dynamic> json) =
      _$LoginDataImpl.fromJson;

  @override
  String get token;
  @override
  Customer get customer;

  /// Create a copy of LoginData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginDataImplCopyWith<_$LoginDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return _Customer.fromJson(json);
}

/// @nodoc
mixin _$Customer {
  String get id => throw _privateConstructorUsedError;
  String? get vendor_employee_code => throw _privateConstructorUsedError;
  String get full_name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get mobile => throw _privateConstructorUsedError;
  String? get application_status => throw _privateConstructorUsedError;
  String? get ol_generate => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;

  /// Serializes this Customer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerCopyWith<Customer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCopyWith<$Res> {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) then) =
      _$CustomerCopyWithImpl<$Res, Customer>;
  @useResult
  $Res call({
    String id,
    String? vendor_employee_code,
    String full_name,
    String? email,
    String mobile,
    String? application_status,
    String? ol_generate,
    String? photo,
  });
}

/// @nodoc
class _$CustomerCopyWithImpl<$Res, $Val extends Customer>
    implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vendor_employee_code = freezed,
    Object? full_name = null,
    Object? email = freezed,
    Object? mobile = null,
    Object? application_status = freezed,
    Object? ol_generate = freezed,
    Object? photo = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            vendor_employee_code: freezed == vendor_employee_code
                ? _value.vendor_employee_code
                : vendor_employee_code // ignore: cast_nullable_to_non_nullable
                      as String?,
            full_name: null == full_name
                ? _value.full_name
                : full_name // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            mobile: null == mobile
                ? _value.mobile
                : mobile // ignore: cast_nullable_to_non_nullable
                      as String,
            application_status: freezed == application_status
                ? _value.application_status
                : application_status // ignore: cast_nullable_to_non_nullable
                      as String?,
            ol_generate: freezed == ol_generate
                ? _value.ol_generate
                : ol_generate // ignore: cast_nullable_to_non_nullable
                      as String?,
            photo: freezed == photo
                ? _value.photo
                : photo // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CustomerImplCopyWith<$Res>
    implements $CustomerCopyWith<$Res> {
  factory _$$CustomerImplCopyWith(
    _$CustomerImpl value,
    $Res Function(_$CustomerImpl) then,
  ) = __$$CustomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? vendor_employee_code,
    String full_name,
    String? email,
    String mobile,
    String? application_status,
    String? ol_generate,
    String? photo,
  });
}

/// @nodoc
class __$$CustomerImplCopyWithImpl<$Res>
    extends _$CustomerCopyWithImpl<$Res, _$CustomerImpl>
    implements _$$CustomerImplCopyWith<$Res> {
  __$$CustomerImplCopyWithImpl(
    _$CustomerImpl _value,
    $Res Function(_$CustomerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vendor_employee_code = freezed,
    Object? full_name = null,
    Object? email = freezed,
    Object? mobile = null,
    Object? application_status = freezed,
    Object? ol_generate = freezed,
    Object? photo = freezed,
  }) {
    return _then(
      _$CustomerImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        vendor_employee_code: freezed == vendor_employee_code
            ? _value.vendor_employee_code
            : vendor_employee_code // ignore: cast_nullable_to_non_nullable
                  as String?,
        full_name: null == full_name
            ? _value.full_name
            : full_name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        mobile: null == mobile
            ? _value.mobile
            : mobile // ignore: cast_nullable_to_non_nullable
                  as String,
        application_status: freezed == application_status
            ? _value.application_status
            : application_status // ignore: cast_nullable_to_non_nullable
                  as String?,
        ol_generate: freezed == ol_generate
            ? _value.ol_generate
            : ol_generate // ignore: cast_nullable_to_non_nullable
                  as String?,
        photo: freezed == photo
            ? _value.photo
            : photo // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerImpl implements _Customer {
  const _$CustomerImpl({
    required this.id,
    this.vendor_employee_code,
    required this.full_name,
    this.email,
    required this.mobile,
    this.application_status,
    this.ol_generate,
    this.photo,
  });

  factory _$CustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerImplFromJson(json);

  @override
  final String id;
  @override
  final String? vendor_employee_code;
  @override
  final String full_name;
  @override
  final String? email;
  @override
  final String mobile;
  @override
  final String? application_status;
  @override
  final String? ol_generate;
  @override
  final String? photo;

  @override
  String toString() {
    return 'Customer(id: $id, vendor_employee_code: $vendor_employee_code, full_name: $full_name, email: $email, mobile: $mobile, application_status: $application_status, ol_generate: $ol_generate, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.vendor_employee_code, vendor_employee_code) ||
                other.vendor_employee_code == vendor_employee_code) &&
            (identical(other.full_name, full_name) ||
                other.full_name == full_name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.application_status, application_status) ||
                other.application_status == application_status) &&
            (identical(other.ol_generate, ol_generate) ||
                other.ol_generate == ol_generate) &&
            (identical(other.photo, photo) || other.photo == photo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    vendor_employee_code,
    full_name,
    email,
    mobile,
    application_status,
    ol_generate,
    photo,
  );

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      __$$CustomerImplCopyWithImpl<_$CustomerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerImplToJson(this);
  }
}

abstract class _Customer implements Customer {
  const factory _Customer({
    required final String id,
    final String? vendor_employee_code,
    required final String full_name,
    final String? email,
    required final String mobile,
    final String? application_status,
    final String? ol_generate,
    final String? photo,
  }) = _$CustomerImpl;

  factory _Customer.fromJson(Map<String, dynamic> json) =
      _$CustomerImpl.fromJson;

  @override
  String get id;
  @override
  String? get vendor_employee_code;
  @override
  String get full_name;
  @override
  String? get email;
  @override
  String get mobile;
  @override
  String? get application_status;
  @override
  String? get ol_generate;
  @override
  String? get photo;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
