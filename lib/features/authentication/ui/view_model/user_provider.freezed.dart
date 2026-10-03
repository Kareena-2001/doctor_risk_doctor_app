// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserData {
  int get doctorId => throw _privateConstructorUsedError;
  String get doctorNo => throw _privateConstructorUsedError;
  String get prefix => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String? get middleName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get mobile => throw _privateConstructorUsedError;

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserDataCopyWith<UserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataCopyWith<$Res> {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) then) =
      _$UserDataCopyWithImpl<$Res, UserData>;
  @useResult
  $Res call({
    int doctorId,
    String doctorNo,
    String prefix,
    String firstName,
    String? middleName,
    String lastName,
    String? email,
    String mobile,
  });
}

/// @nodoc
class _$UserDataCopyWithImpl<$Res, $Val extends UserData>
    implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doctorId = null,
    Object? doctorNo = null,
    Object? prefix = null,
    Object? firstName = null,
    Object? middleName = freezed,
    Object? lastName = null,
    Object? email = freezed,
    Object? mobile = null,
  }) {
    return _then(
      _value.copyWith(
            doctorId: null == doctorId
                ? _value.doctorId
                : doctorId // ignore: cast_nullable_to_non_nullable
                      as int,
            doctorNo: null == doctorNo
                ? _value.doctorNo
                : doctorNo // ignore: cast_nullable_to_non_nullable
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
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            mobile: null == mobile
                ? _value.mobile
                : mobile // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserDataImplCopyWith<$Res>
    implements $UserDataCopyWith<$Res> {
  factory _$$UserDataImplCopyWith(
    _$UserDataImpl value,
    $Res Function(_$UserDataImpl) then,
  ) = __$$UserDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int doctorId,
    String doctorNo,
    String prefix,
    String firstName,
    String? middleName,
    String lastName,
    String? email,
    String mobile,
  });
}

/// @nodoc
class __$$UserDataImplCopyWithImpl<$Res>
    extends _$UserDataCopyWithImpl<$Res, _$UserDataImpl>
    implements _$$UserDataImplCopyWith<$Res> {
  __$$UserDataImplCopyWithImpl(
    _$UserDataImpl _value,
    $Res Function(_$UserDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doctorId = null,
    Object? doctorNo = null,
    Object? prefix = null,
    Object? firstName = null,
    Object? middleName = freezed,
    Object? lastName = null,
    Object? email = freezed,
    Object? mobile = null,
  }) {
    return _then(
      _$UserDataImpl(
        doctorId: null == doctorId
            ? _value.doctorId
            : doctorId // ignore: cast_nullable_to_non_nullable
                  as int,
        doctorNo: null == doctorNo
            ? _value.doctorNo
            : doctorNo // ignore: cast_nullable_to_non_nullable
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
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        mobile: null == mobile
            ? _value.mobile
            : mobile // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UserDataImpl extends _UserData with DiagnosticableTreeMixin {
  const _$UserDataImpl({
    required this.doctorId,
    required this.doctorNo,
    required this.prefix,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.email,
    required this.mobile,
  }) : super._();

  @override
  final int doctorId;
  @override
  final String doctorNo;
  @override
  final String prefix;
  @override
  final String firstName;
  @override
  final String? middleName;
  @override
  final String lastName;
  @override
  final String? email;
  @override
  final String mobile;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserData(doctorId: $doctorId, doctorNo: $doctorNo, prefix: $prefix, firstName: $firstName, middleName: $middleName, lastName: $lastName, email: $email, mobile: $mobile)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserData'))
      ..add(DiagnosticsProperty('doctorId', doctorId))
      ..add(DiagnosticsProperty('doctorNo', doctorNo))
      ..add(DiagnosticsProperty('prefix', prefix))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('middleName', middleName))
      ..add(DiagnosticsProperty('lastName', lastName))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('mobile', mobile));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataImpl &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.doctorNo, doctorNo) ||
                other.doctorNo == doctorNo) &&
            (identical(other.prefix, prefix) || other.prefix == prefix) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.middleName, middleName) ||
                other.middleName == middleName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.mobile, mobile) || other.mobile == mobile));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    doctorId,
    doctorNo,
    prefix,
    firstName,
    middleName,
    lastName,
    email,
    mobile,
  );

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      __$$UserDataImplCopyWithImpl<_$UserDataImpl>(this, _$identity);
}

abstract class _UserData extends UserData {
  const factory _UserData({
    required final int doctorId,
    required final String doctorNo,
    required final String prefix,
    required final String firstName,
    final String? middleName,
    required final String lastName,
    final String? email,
    required final String mobile,
  }) = _$UserDataImpl;
  const _UserData._() : super._();

  @override
  int get doctorId;
  @override
  String get doctorNo;
  @override
  String get prefix;
  @override
  String get firstName;
  @override
  String? get middleName;
  @override
  String get lastName;
  @override
  String? get email;
  @override
  String get mobile;

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
