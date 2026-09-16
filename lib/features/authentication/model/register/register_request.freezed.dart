// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) {
  return _RegisterRequest.fromJson(json);
}

/// @nodoc
mixin _$RegisterRequest {
  @JsonKey(name: 'product_type_id')
  String get productTypeId => throw _privateConstructorUsedError;
  String get prefix => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'middle_name')
  String? get middleName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'mobile_no')
  String get mobileNo => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'speciality_id')
  int? get specialityId => throw _privateConstructorUsedError;
  String? get degree => throw _privateConstructorUsedError;
  @JsonKey(name: 'organization_name')
  String? get organizationName => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'terms_privacy_accepted')
  bool get termsPrivacyAccepted => throw _privateConstructorUsedError;

  /// Serializes this RegisterRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterRequestCopyWith<RegisterRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterRequestCopyWith<$Res> {
  factory $RegisterRequestCopyWith(
    RegisterRequest value,
    $Res Function(RegisterRequest) then,
  ) = _$RegisterRequestCopyWithImpl<$Res, RegisterRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'product_type_id') String productTypeId,
    String prefix,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'middle_name') String? middleName,
    @JsonKey(name: 'last_name') String lastName,
    @JsonKey(name: 'mobile_no') String mobileNo,
    String? email,
    @JsonKey(name: 'category_id') int categoryId,
    @JsonKey(name: 'speciality_id') int? specialityId,
    String? degree,
    @JsonKey(name: 'organization_name') String? organizationName,
    String source,
    String password,
    @JsonKey(name: 'terms_privacy_accepted') bool termsPrivacyAccepted,
  });
}

/// @nodoc
class _$RegisterRequestCopyWithImpl<$Res, $Val extends RegisterRequest>
    implements $RegisterRequestCopyWith<$Res> {
  _$RegisterRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productTypeId = null,
    Object? prefix = null,
    Object? firstName = null,
    Object? middleName = freezed,
    Object? lastName = null,
    Object? mobileNo = null,
    Object? email = freezed,
    Object? categoryId = null,
    Object? specialityId = freezed,
    Object? degree = freezed,
    Object? organizationName = freezed,
    Object? source = null,
    Object? password = null,
    Object? termsPrivacyAccepted = null,
  }) {
    return _then(
      _value.copyWith(
            productTypeId: null == productTypeId
                ? _value.productTypeId
                : productTypeId // ignore: cast_nullable_to_non_nullable
                      as String,
            prefix: null == prefix
                ? _value.prefix
                : prefix // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            middleName: freezed == middleName
                ? _value.middleName
                : middleName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            mobileNo: null == mobileNo
                ? _value.mobileNo
                : mobileNo // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            specialityId: freezed == specialityId
                ? _value.specialityId
                : specialityId // ignore: cast_nullable_to_non_nullable
                      as int?,
            degree: freezed == degree
                ? _value.degree
                : degree // ignore: cast_nullable_to_non_nullable
                      as String?,
            organizationName: freezed == organizationName
                ? _value.organizationName
                : organizationName // ignore: cast_nullable_to_non_nullable
                      as String?,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
            termsPrivacyAccepted: null == termsPrivacyAccepted
                ? _value.termsPrivacyAccepted
                : termsPrivacyAccepted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RegisterRequestImplCopyWith<$Res>
    implements $RegisterRequestCopyWith<$Res> {
  factory _$$RegisterRequestImplCopyWith(
    _$RegisterRequestImpl value,
    $Res Function(_$RegisterRequestImpl) then,
  ) = __$$RegisterRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'product_type_id') String productTypeId,
    String prefix,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'middle_name') String? middleName,
    @JsonKey(name: 'last_name') String lastName,
    @JsonKey(name: 'mobile_no') String mobileNo,
    String? email,
    @JsonKey(name: 'category_id') int categoryId,
    @JsonKey(name: 'speciality_id') int? specialityId,
    String? degree,
    @JsonKey(name: 'organization_name') String? organizationName,
    String source,
    String password,
    @JsonKey(name: 'terms_privacy_accepted') bool termsPrivacyAccepted,
  });
}

/// @nodoc
class __$$RegisterRequestImplCopyWithImpl<$Res>
    extends _$RegisterRequestCopyWithImpl<$Res, _$RegisterRequestImpl>
    implements _$$RegisterRequestImplCopyWith<$Res> {
  __$$RegisterRequestImplCopyWithImpl(
    _$RegisterRequestImpl _value,
    $Res Function(_$RegisterRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productTypeId = null,
    Object? prefix = null,
    Object? firstName = null,
    Object? middleName = freezed,
    Object? lastName = null,
    Object? mobileNo = null,
    Object? email = freezed,
    Object? categoryId = null,
    Object? specialityId = freezed,
    Object? degree = freezed,
    Object? organizationName = freezed,
    Object? source = null,
    Object? password = null,
    Object? termsPrivacyAccepted = null,
  }) {
    return _then(
      _$RegisterRequestImpl(
        productTypeId: null == productTypeId
            ? _value.productTypeId
            : productTypeId // ignore: cast_nullable_to_non_nullable
                  as String,
        prefix: null == prefix
            ? _value.prefix
            : prefix // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        middleName: freezed == middleName
            ? _value.middleName
            : middleName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        mobileNo: null == mobileNo
            ? _value.mobileNo
            : mobileNo // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        specialityId: freezed == specialityId
            ? _value.specialityId
            : specialityId // ignore: cast_nullable_to_non_nullable
                  as int?,
        degree: freezed == degree
            ? _value.degree
            : degree // ignore: cast_nullable_to_non_nullable
                  as String?,
        organizationName: freezed == organizationName
            ? _value.organizationName
            : organizationName // ignore: cast_nullable_to_non_nullable
                  as String?,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        termsPrivacyAccepted: null == termsPrivacyAccepted
            ? _value.termsPrivacyAccepted
            : termsPrivacyAccepted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterRequestImpl implements _RegisterRequest {
  const _$RegisterRequestImpl({
    @JsonKey(name: 'product_type_id') required this.productTypeId,
    required this.prefix,
    @JsonKey(name: 'first_name') required this.firstName,
    @JsonKey(name: 'middle_name') this.middleName,
    @JsonKey(name: 'last_name') required this.lastName,
    @JsonKey(name: 'mobile_no') required this.mobileNo,
    this.email,
    @JsonKey(name: 'category_id') required this.categoryId,
    @JsonKey(name: 'speciality_id') this.specialityId,
    this.degree,
    @JsonKey(name: 'organization_name') this.organizationName,
    required this.source,
    required this.password,
    @JsonKey(name: 'terms_privacy_accepted') required this.termsPrivacyAccepted,
  });

  factory _$RegisterRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterRequestImplFromJson(json);

  @override
  @JsonKey(name: 'product_type_id')
  final String productTypeId;
  @override
  final String prefix;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'middle_name')
  final String? middleName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;
  @override
  @JsonKey(name: 'mobile_no')
  final String mobileNo;
  @override
  final String? email;
  @override
  @JsonKey(name: 'category_id')
  final int categoryId;
  @override
  @JsonKey(name: 'speciality_id')
  final int? specialityId;
  @override
  final String? degree;
  @override
  @JsonKey(name: 'organization_name')
  final String? organizationName;
  @override
  final String source;
  @override
  final String password;
  @override
  @JsonKey(name: 'terms_privacy_accepted')
  final bool termsPrivacyAccepted;

  @override
  String toString() {
    return 'RegisterRequest(productTypeId: $productTypeId, prefix: $prefix, firstName: $firstName, middleName: $middleName, lastName: $lastName, mobileNo: $mobileNo, email: $email, categoryId: $categoryId, specialityId: $specialityId, degree: $degree, organizationName: $organizationName, source: $source, password: $password, termsPrivacyAccepted: $termsPrivacyAccepted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterRequestImpl &&
            (identical(other.productTypeId, productTypeId) ||
                other.productTypeId == productTypeId) &&
            (identical(other.prefix, prefix) || other.prefix == prefix) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.middleName, middleName) ||
                other.middleName == middleName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.mobileNo, mobileNo) ||
                other.mobileNo == mobileNo) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.specialityId, specialityId) ||
                other.specialityId == specialityId) &&
            (identical(other.degree, degree) || other.degree == degree) &&
            (identical(other.organizationName, organizationName) ||
                other.organizationName == organizationName) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.termsPrivacyAccepted, termsPrivacyAccepted) ||
                other.termsPrivacyAccepted == termsPrivacyAccepted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    productTypeId,
    prefix,
    firstName,
    middleName,
    lastName,
    mobileNo,
    email,
    categoryId,
    specialityId,
    degree,
    organizationName,
    source,
    password,
    termsPrivacyAccepted,
  );

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterRequestImplCopyWith<_$RegisterRequestImpl> get copyWith =>
      __$$RegisterRequestImplCopyWithImpl<_$RegisterRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterRequestImplToJson(this);
  }
}

abstract class _RegisterRequest implements RegisterRequest {
  const factory _RegisterRequest({
    @JsonKey(name: 'product_type_id') required final String productTypeId,
    required final String prefix,
    @JsonKey(name: 'first_name') required final String firstName,
    @JsonKey(name: 'middle_name') final String? middleName,
    @JsonKey(name: 'last_name') required final String lastName,
    @JsonKey(name: 'mobile_no') required final String mobileNo,
    final String? email,
    @JsonKey(name: 'category_id') required final int categoryId,
    @JsonKey(name: 'speciality_id') final int? specialityId,
    final String? degree,
    @JsonKey(name: 'organization_name') final String? organizationName,
    required final String source,
    required final String password,
    @JsonKey(name: 'terms_privacy_accepted')
    required final bool termsPrivacyAccepted,
  }) = _$RegisterRequestImpl;

  factory _RegisterRequest.fromJson(Map<String, dynamic> json) =
      _$RegisterRequestImpl.fromJson;

  @override
  @JsonKey(name: 'product_type_id')
  String get productTypeId;
  @override
  String get prefix;
  @override
  @JsonKey(name: 'first_name')
  String get firstName;
  @override
  @JsonKey(name: 'middle_name')
  String? get middleName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;
  @override
  @JsonKey(name: 'mobile_no')
  String get mobileNo;
  @override
  String? get email;
  @override
  @JsonKey(name: 'category_id')
  int get categoryId;
  @override
  @JsonKey(name: 'speciality_id')
  int? get specialityId;
  @override
  String? get degree;
  @override
  @JsonKey(name: 'organization_name')
  String? get organizationName;
  @override
  String get source;
  @override
  String get password;
  @override
  @JsonKey(name: 'terms_privacy_accepted')
  bool get termsPrivacyAccepted;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterRequestImplCopyWith<_$RegisterRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
