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
  String get empUid => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get mobile => throw _privateConstructorUsedError;
  String get designation => throw _privateConstructorUsedError;
  String? get profilePhoto => throw _privateConstructorUsedError;
  bool get isStaff => throw _privateConstructorUsedError;

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
    String empUid,
    String employeeId,
    String name,
    String? email,
    String mobile,
    String designation,
    String? profilePhoto,
    bool isStaff,
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
    Object? empUid = null,
    Object? employeeId = null,
    Object? name = null,
    Object? email = freezed,
    Object? mobile = null,
    Object? designation = null,
    Object? profilePhoto = freezed,
    Object? isStaff = null,
  }) {
    return _then(
      _value.copyWith(
            empUid: null == empUid
                ? _value.empUid
                : empUid // ignore: cast_nullable_to_non_nullable
                      as String,
            employeeId: null == employeeId
                ? _value.employeeId
                : employeeId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            mobile: null == mobile
                ? _value.mobile
                : mobile // ignore: cast_nullable_to_non_nullable
                      as String,
            designation: null == designation
                ? _value.designation
                : designation // ignore: cast_nullable_to_non_nullable
                      as String,
            profilePhoto: freezed == profilePhoto
                ? _value.profilePhoto
                : profilePhoto // ignore: cast_nullable_to_non_nullable
                      as String?,
            isStaff: null == isStaff
                ? _value.isStaff
                : isStaff // ignore: cast_nullable_to_non_nullable
                      as bool,
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
    String empUid,
    String employeeId,
    String name,
    String? email,
    String mobile,
    String designation,
    String? profilePhoto,
    bool isStaff,
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
    Object? empUid = null,
    Object? employeeId = null,
    Object? name = null,
    Object? email = freezed,
    Object? mobile = null,
    Object? designation = null,
    Object? profilePhoto = freezed,
    Object? isStaff = null,
  }) {
    return _then(
      _$UserDataImpl(
        empUid: null == empUid
            ? _value.empUid
            : empUid // ignore: cast_nullable_to_non_nullable
                  as String,
        employeeId: null == employeeId
            ? _value.employeeId
            : employeeId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        mobile: null == mobile
            ? _value.mobile
            : mobile // ignore: cast_nullable_to_non_nullable
                  as String,
        designation: null == designation
            ? _value.designation
            : designation // ignore: cast_nullable_to_non_nullable
                  as String,
        profilePhoto: freezed == profilePhoto
            ? _value.profilePhoto
            : profilePhoto // ignore: cast_nullable_to_non_nullable
                  as String?,
        isStaff: null == isStaff
            ? _value.isStaff
            : isStaff // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$UserDataImpl extends _UserData with DiagnosticableTreeMixin {
  const _$UserDataImpl({
    required this.empUid,
    required this.employeeId,
    required this.name,
    this.email,
    required this.mobile,
    required this.designation,
    this.profilePhoto,
    required this.isStaff,
  }) : super._();

  @override
  final String empUid;
  @override
  final String employeeId;
  @override
  final String name;
  @override
  final String? email;
  @override
  final String mobile;
  @override
  final String designation;
  @override
  final String? profilePhoto;
  @override
  final bool isStaff;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserData(empUid: $empUid, employeeId: $employeeId, name: $name, email: $email, mobile: $mobile, designation: $designation, profilePhoto: $profilePhoto, isStaff: $isStaff)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserData'))
      ..add(DiagnosticsProperty('empUid', empUid))
      ..add(DiagnosticsProperty('employeeId', employeeId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('mobile', mobile))
      ..add(DiagnosticsProperty('designation', designation))
      ..add(DiagnosticsProperty('profilePhoto', profilePhoto))
      ..add(DiagnosticsProperty('isStaff', isStaff));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataImpl &&
            (identical(other.empUid, empUid) || other.empUid == empUid) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.profilePhoto, profilePhoto) ||
                other.profilePhoto == profilePhoto) &&
            (identical(other.isStaff, isStaff) || other.isStaff == isStaff));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    empUid,
    employeeId,
    name,
    email,
    mobile,
    designation,
    profilePhoto,
    isStaff,
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
    required final String empUid,
    required final String employeeId,
    required final String name,
    final String? email,
    required final String mobile,
    required final String designation,
    final String? profilePhoto,
    required final bool isStaff,
  }) = _$UserDataImpl;
  const _UserData._() : super._();

  @override
  String get empUid;
  @override
  String get employeeId;
  @override
  String get name;
  @override
  String? get email;
  @override
  String get mobile;
  @override
  String get designation;
  @override
  String? get profilePhoto;
  @override
  bool get isStaff;

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
