// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_update_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProfileUpdateResponse _$ProfileUpdateResponseFromJson(
  Map<String, dynamic> json,
) {
  return _ProfileUpdateResponse.fromJson(json);
}

/// @nodoc
mixin _$ProfileUpdateResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  ProfileUpdateData get data => throw _privateConstructorUsedError;

  /// Serializes this ProfileUpdateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileUpdateResponseCopyWith<ProfileUpdateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileUpdateResponseCopyWith<$Res> {
  factory $ProfileUpdateResponseCopyWith(
    ProfileUpdateResponse value,
    $Res Function(ProfileUpdateResponse) then,
  ) = _$ProfileUpdateResponseCopyWithImpl<$Res, ProfileUpdateResponse>;
  @useResult
  $Res call({bool status, int code, String msg, ProfileUpdateData data});

  $ProfileUpdateDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ProfileUpdateResponseCopyWithImpl<
  $Res,
  $Val extends ProfileUpdateResponse
>
    implements $ProfileUpdateResponseCopyWith<$Res> {
  _$ProfileUpdateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? msg = null,
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
            msg: null == msg
                ? _value.msg
                : msg // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as ProfileUpdateData,
          )
          as $Val,
    );
  }

  /// Create a copy of ProfileUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfileUpdateDataCopyWith<$Res> get data {
    return $ProfileUpdateDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileUpdateResponseImplCopyWith<$Res>
    implements $ProfileUpdateResponseCopyWith<$Res> {
  factory _$$ProfileUpdateResponseImplCopyWith(
    _$ProfileUpdateResponseImpl value,
    $Res Function(_$ProfileUpdateResponseImpl) then,
  ) = __$$ProfileUpdateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, int code, String msg, ProfileUpdateData data});

  @override
  $ProfileUpdateDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$ProfileUpdateResponseImplCopyWithImpl<$Res>
    extends
        _$ProfileUpdateResponseCopyWithImpl<$Res, _$ProfileUpdateResponseImpl>
    implements _$$ProfileUpdateResponseImplCopyWith<$Res> {
  __$$ProfileUpdateResponseImplCopyWithImpl(
    _$ProfileUpdateResponseImpl _value,
    $Res Function(_$ProfileUpdateResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? msg = null,
    Object? data = null,
  }) {
    return _then(
      _$ProfileUpdateResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as bool,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as int,
        msg: null == msg
            ? _value.msg
            : msg // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as ProfileUpdateData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileUpdateResponseImpl implements _ProfileUpdateResponse {
  const _$ProfileUpdateResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory _$ProfileUpdateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileUpdateResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  @override
  final ProfileUpdateData data;

  @override
  String toString() {
    return 'ProfileUpdateResponse(status: $status, code: $code, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileUpdateResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, msg, data);

  /// Create a copy of ProfileUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileUpdateResponseImplCopyWith<_$ProfileUpdateResponseImpl>
  get copyWith =>
      __$$ProfileUpdateResponseImplCopyWithImpl<_$ProfileUpdateResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileUpdateResponseImplToJson(this);
  }
}

abstract class _ProfileUpdateResponse implements ProfileUpdateResponse {
  const factory _ProfileUpdateResponse({
    required final bool status,
    required final int code,
    required final String msg,
    required final ProfileUpdateData data,
  }) = _$ProfileUpdateResponseImpl;

  factory _ProfileUpdateResponse.fromJson(Map<String, dynamic> json) =
      _$ProfileUpdateResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  ProfileUpdateData get data;

  /// Create a copy of ProfileUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileUpdateResponseImplCopyWith<_$ProfileUpdateResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ProfileUpdateData _$ProfileUpdateDataFromJson(Map<String, dynamic> json) {
  return _ProfileUpdateData.fromJson(json);
}

/// @nodoc
mixin _$ProfileUpdateData {
  ProfileUpdateProfile get profile => throw _privateConstructorUsedError;

  /// Serializes this ProfileUpdateData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileUpdateDataCopyWith<ProfileUpdateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileUpdateDataCopyWith<$Res> {
  factory $ProfileUpdateDataCopyWith(
    ProfileUpdateData value,
    $Res Function(ProfileUpdateData) then,
  ) = _$ProfileUpdateDataCopyWithImpl<$Res, ProfileUpdateData>;
  @useResult
  $Res call({ProfileUpdateProfile profile});

  $ProfileUpdateProfileCopyWith<$Res> get profile;
}

/// @nodoc
class _$ProfileUpdateDataCopyWithImpl<$Res, $Val extends ProfileUpdateData>
    implements $ProfileUpdateDataCopyWith<$Res> {
  _$ProfileUpdateDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? profile = null}) {
    return _then(
      _value.copyWith(
            profile: null == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                      as ProfileUpdateProfile,
          )
          as $Val,
    );
  }

  /// Create a copy of ProfileUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfileUpdateProfileCopyWith<$Res> get profile {
    return $ProfileUpdateProfileCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileUpdateDataImplCopyWith<$Res>
    implements $ProfileUpdateDataCopyWith<$Res> {
  factory _$$ProfileUpdateDataImplCopyWith(
    _$ProfileUpdateDataImpl value,
    $Res Function(_$ProfileUpdateDataImpl) then,
  ) = __$$ProfileUpdateDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ProfileUpdateProfile profile});

  @override
  $ProfileUpdateProfileCopyWith<$Res> get profile;
}

/// @nodoc
class __$$ProfileUpdateDataImplCopyWithImpl<$Res>
    extends _$ProfileUpdateDataCopyWithImpl<$Res, _$ProfileUpdateDataImpl>
    implements _$$ProfileUpdateDataImplCopyWith<$Res> {
  __$$ProfileUpdateDataImplCopyWithImpl(
    _$ProfileUpdateDataImpl _value,
    $Res Function(_$ProfileUpdateDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? profile = null}) {
    return _then(
      _$ProfileUpdateDataImpl(
        profile: null == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as ProfileUpdateProfile,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileUpdateDataImpl implements _ProfileUpdateData {
  const _$ProfileUpdateDataImpl({required this.profile});

  factory _$ProfileUpdateDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileUpdateDataImplFromJson(json);

  @override
  final ProfileUpdateProfile profile;

  @override
  String toString() {
    return 'ProfileUpdateData(profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileUpdateDataImpl &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, profile);

  /// Create a copy of ProfileUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileUpdateDataImplCopyWith<_$ProfileUpdateDataImpl> get copyWith =>
      __$$ProfileUpdateDataImplCopyWithImpl<_$ProfileUpdateDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileUpdateDataImplToJson(this);
  }
}

abstract class _ProfileUpdateData implements ProfileUpdateData {
  const factory _ProfileUpdateData({
    required final ProfileUpdateProfile profile,
  }) = _$ProfileUpdateDataImpl;

  factory _ProfileUpdateData.fromJson(Map<String, dynamic> json) =
      _$ProfileUpdateDataImpl.fromJson;

  @override
  ProfileUpdateProfile get profile;

  /// Create a copy of ProfileUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileUpdateDataImplCopyWith<_$ProfileUpdateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileUpdateProfile _$ProfileUpdateProfileFromJson(Map<String, dynamic> json) {
  return _ProfileUpdateProfile.fromJson(json);
}

/// @nodoc
mixin _$ProfileUpdateProfile {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_no')
  String? get doctorNo => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  @JsonKey(name: 'organization_name')
  String? get organizationName => throw _privateConstructorUsedError;
  String? get prifix => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'middle_name')
  String? get middleName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String? get fullName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'mobile_no')
  String? get mobileNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'alternate_no')
  String? get alternateNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'speciality_id')
  String? get specialityId => throw _privateConstructorUsedError;
  @JsonKey(name: 'speciality_name')
  String? get specialityName => throw _privateConstructorUsedError;
  String? get degree => throw _privateConstructorUsedError;
  @JsonKey(name: 'establishment_name')
  String? get establishmentName => throw _privateConstructorUsedError;
  String? get dob => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  List<ProfileUpdateAddress> get addresses =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'clinic_hospital_details')
  ProfileUpdateClinicHospitalDetails? get clinicHospitalDetails =>
      throw _privateConstructorUsedError;

  /// Serializes this ProfileUpdateProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileUpdateProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileUpdateProfileCopyWith<ProfileUpdateProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileUpdateProfileCopyWith<$Res> {
  factory $ProfileUpdateProfileCopyWith(
    ProfileUpdateProfile value,
    $Res Function(ProfileUpdateProfile) then,
  ) = _$ProfileUpdateProfileCopyWithImpl<$Res, ProfileUpdateProfile>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'doctor_no') String? doctorNo,
    String? photo,
    @JsonKey(name: 'organization_name') String? organizationName,
    String? prifix,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'middle_name') String? middleName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'full_name') String? fullName,
    String? email,
    @JsonKey(name: 'mobile_no') String? mobileNo,
    @JsonKey(name: 'alternate_no') String? alternateNo,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'speciality_id') String? specialityId,
    @JsonKey(name: 'speciality_name') String? specialityName,
    String? degree,
    @JsonKey(name: 'establishment_name') String? establishmentName,
    String? dob,
    String? gender,
    List<ProfileUpdateAddress> addresses,
    @JsonKey(name: 'clinic_hospital_details')
    ProfileUpdateClinicHospitalDetails? clinicHospitalDetails,
  });

  $ProfileUpdateClinicHospitalDetailsCopyWith<$Res>? get clinicHospitalDetails;
}

/// @nodoc
class _$ProfileUpdateProfileCopyWithImpl<
  $Res,
  $Val extends ProfileUpdateProfile
>
    implements $ProfileUpdateProfileCopyWith<$Res> {
  _$ProfileUpdateProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileUpdateProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? doctorNo = freezed,
    Object? photo = freezed,
    Object? organizationName = freezed,
    Object? prifix = freezed,
    Object? firstName = freezed,
    Object? middleName = freezed,
    Object? lastName = freezed,
    Object? fullName = freezed,
    Object? email = freezed,
    Object? mobileNo = freezed,
    Object? alternateNo = freezed,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? specialityId = freezed,
    Object? specialityName = freezed,
    Object? degree = freezed,
    Object? establishmentName = freezed,
    Object? dob = freezed,
    Object? gender = freezed,
    Object? addresses = null,
    Object? clinicHospitalDetails = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            doctorNo: freezed == doctorNo
                ? _value.doctorNo
                : doctorNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            photo: freezed == photo
                ? _value.photo
                : photo // ignore: cast_nullable_to_non_nullable
                      as String?,
            organizationName: freezed == organizationName
                ? _value.organizationName
                : organizationName // ignore: cast_nullable_to_non_nullable
                      as String?,
            prifix: freezed == prifix
                ? _value.prifix
                : prifix // ignore: cast_nullable_to_non_nullable
                      as String?,
            firstName: freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            middleName: freezed == middleName
                ? _value.middleName
                : middleName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastName: freezed == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String?,
            fullName: freezed == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            mobileNo: freezed == mobileNo
                ? _value.mobileNo
                : mobileNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            alternateNo: freezed == alternateNo
                ? _value.alternateNo
                : alternateNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            specialityId: freezed == specialityId
                ? _value.specialityId
                : specialityId // ignore: cast_nullable_to_non_nullable
                      as String?,
            specialityName: freezed == specialityName
                ? _value.specialityName
                : specialityName // ignore: cast_nullable_to_non_nullable
                      as String?,
            degree: freezed == degree
                ? _value.degree
                : degree // ignore: cast_nullable_to_non_nullable
                      as String?,
            establishmentName: freezed == establishmentName
                ? _value.establishmentName
                : establishmentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            dob: freezed == dob
                ? _value.dob
                : dob // ignore: cast_nullable_to_non_nullable
                      as String?,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String?,
            addresses: null == addresses
                ? _value.addresses
                : addresses // ignore: cast_nullable_to_non_nullable
                      as List<ProfileUpdateAddress>,
            clinicHospitalDetails: freezed == clinicHospitalDetails
                ? _value.clinicHospitalDetails
                : clinicHospitalDetails // ignore: cast_nullable_to_non_nullable
                      as ProfileUpdateClinicHospitalDetails?,
          )
          as $Val,
    );
  }

  /// Create a copy of ProfileUpdateProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfileUpdateClinicHospitalDetailsCopyWith<$Res>? get clinicHospitalDetails {
    if (_value.clinicHospitalDetails == null) {
      return null;
    }

    return $ProfileUpdateClinicHospitalDetailsCopyWith<$Res>(
      _value.clinicHospitalDetails!,
      (value) {
        return _then(_value.copyWith(clinicHospitalDetails: value) as $Val);
      },
    );
  }
}

/// @nodoc
abstract class _$$ProfileUpdateProfileImplCopyWith<$Res>
    implements $ProfileUpdateProfileCopyWith<$Res> {
  factory _$$ProfileUpdateProfileImplCopyWith(
    _$ProfileUpdateProfileImpl value,
    $Res Function(_$ProfileUpdateProfileImpl) then,
  ) = __$$ProfileUpdateProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'doctor_no') String? doctorNo,
    String? photo,
    @JsonKey(name: 'organization_name') String? organizationName,
    String? prifix,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'middle_name') String? middleName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'full_name') String? fullName,
    String? email,
    @JsonKey(name: 'mobile_no') String? mobileNo,
    @JsonKey(name: 'alternate_no') String? alternateNo,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'speciality_id') String? specialityId,
    @JsonKey(name: 'speciality_name') String? specialityName,
    String? degree,
    @JsonKey(name: 'establishment_name') String? establishmentName,
    String? dob,
    String? gender,
    List<ProfileUpdateAddress> addresses,
    @JsonKey(name: 'clinic_hospital_details')
    ProfileUpdateClinicHospitalDetails? clinicHospitalDetails,
  });

  @override
  $ProfileUpdateClinicHospitalDetailsCopyWith<$Res>? get clinicHospitalDetails;
}

/// @nodoc
class __$$ProfileUpdateProfileImplCopyWithImpl<$Res>
    extends _$ProfileUpdateProfileCopyWithImpl<$Res, _$ProfileUpdateProfileImpl>
    implements _$$ProfileUpdateProfileImplCopyWith<$Res> {
  __$$ProfileUpdateProfileImplCopyWithImpl(
    _$ProfileUpdateProfileImpl _value,
    $Res Function(_$ProfileUpdateProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileUpdateProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? doctorNo = freezed,
    Object? photo = freezed,
    Object? organizationName = freezed,
    Object? prifix = freezed,
    Object? firstName = freezed,
    Object? middleName = freezed,
    Object? lastName = freezed,
    Object? fullName = freezed,
    Object? email = freezed,
    Object? mobileNo = freezed,
    Object? alternateNo = freezed,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? specialityId = freezed,
    Object? specialityName = freezed,
    Object? degree = freezed,
    Object? establishmentName = freezed,
    Object? dob = freezed,
    Object? gender = freezed,
    Object? addresses = null,
    Object? clinicHospitalDetails = freezed,
  }) {
    return _then(
      _$ProfileUpdateProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        doctorNo: freezed == doctorNo
            ? _value.doctorNo
            : doctorNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        photo: freezed == photo
            ? _value.photo
            : photo // ignore: cast_nullable_to_non_nullable
                  as String?,
        organizationName: freezed == organizationName
            ? _value.organizationName
            : organizationName // ignore: cast_nullable_to_non_nullable
                  as String?,
        prifix: freezed == prifix
            ? _value.prifix
            : prifix // ignore: cast_nullable_to_non_nullable
                  as String?,
        firstName: freezed == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        middleName: freezed == middleName
            ? _value.middleName
            : middleName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastName: freezed == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String?,
        fullName: freezed == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        mobileNo: freezed == mobileNo
            ? _value.mobileNo
            : mobileNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        alternateNo: freezed == alternateNo
            ? _value.alternateNo
            : alternateNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        specialityId: freezed == specialityId
            ? _value.specialityId
            : specialityId // ignore: cast_nullable_to_non_nullable
                  as String?,
        specialityName: freezed == specialityName
            ? _value.specialityName
            : specialityName // ignore: cast_nullable_to_non_nullable
                  as String?,
        degree: freezed == degree
            ? _value.degree
            : degree // ignore: cast_nullable_to_non_nullable
                  as String?,
        establishmentName: freezed == establishmentName
            ? _value.establishmentName
            : establishmentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        dob: freezed == dob
            ? _value.dob
            : dob // ignore: cast_nullable_to_non_nullable
                  as String?,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String?,
        addresses: null == addresses
            ? _value._addresses
            : addresses // ignore: cast_nullable_to_non_nullable
                  as List<ProfileUpdateAddress>,
        clinicHospitalDetails: freezed == clinicHospitalDetails
            ? _value.clinicHospitalDetails
            : clinicHospitalDetails // ignore: cast_nullable_to_non_nullable
                  as ProfileUpdateClinicHospitalDetails?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileUpdateProfileImpl implements _ProfileUpdateProfile {
  const _$ProfileUpdateProfileImpl({
    required this.id,
    @JsonKey(name: 'doctor_no') this.doctorNo,
    this.photo,
    @JsonKey(name: 'organization_name') this.organizationName,
    this.prifix,
    @JsonKey(name: 'first_name') this.firstName,
    @JsonKey(name: 'middle_name') this.middleName,
    @JsonKey(name: 'last_name') this.lastName,
    @JsonKey(name: 'full_name') this.fullName,
    this.email,
    @JsonKey(name: 'mobile_no') this.mobileNo,
    @JsonKey(name: 'alternate_no') this.alternateNo,
    @JsonKey(name: 'category_id') this.categoryId,
    @JsonKey(name: 'category_name') this.categoryName,
    @JsonKey(name: 'speciality_id') this.specialityId,
    @JsonKey(name: 'speciality_name') this.specialityName,
    this.degree,
    @JsonKey(name: 'establishment_name') this.establishmentName,
    this.dob,
    this.gender,
    final List<ProfileUpdateAddress> addresses = const [],
    @JsonKey(name: 'clinic_hospital_details') this.clinicHospitalDetails,
  }) : _addresses = addresses;

  factory _$ProfileUpdateProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileUpdateProfileImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'doctor_no')
  final String? doctorNo;
  @override
  final String? photo;
  @override
  @JsonKey(name: 'organization_name')
  final String? organizationName;
  @override
  final String? prifix;
  @override
  @JsonKey(name: 'first_name')
  final String? firstName;
  @override
  @JsonKey(name: 'middle_name')
  final String? middleName;
  @override
  @JsonKey(name: 'last_name')
  final String? lastName;
  @override
  @JsonKey(name: 'full_name')
  final String? fullName;
  @override
  final String? email;
  @override
  @JsonKey(name: 'mobile_no')
  final String? mobileNo;
  @override
  @JsonKey(name: 'alternate_no')
  final String? alternateNo;
  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'speciality_id')
  final String? specialityId;
  @override
  @JsonKey(name: 'speciality_name')
  final String? specialityName;
  @override
  final String? degree;
  @override
  @JsonKey(name: 'establishment_name')
  final String? establishmentName;
  @override
  final String? dob;
  @override
  final String? gender;
  final List<ProfileUpdateAddress> _addresses;
  @override
  @JsonKey()
  List<ProfileUpdateAddress> get addresses {
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addresses);
  }

  @override
  @JsonKey(name: 'clinic_hospital_details')
  final ProfileUpdateClinicHospitalDetails? clinicHospitalDetails;

  @override
  String toString() {
    return 'ProfileUpdateProfile(id: $id, doctorNo: $doctorNo, photo: $photo, organizationName: $organizationName, prifix: $prifix, firstName: $firstName, middleName: $middleName, lastName: $lastName, fullName: $fullName, email: $email, mobileNo: $mobileNo, alternateNo: $alternateNo, categoryId: $categoryId, categoryName: $categoryName, specialityId: $specialityId, specialityName: $specialityName, degree: $degree, establishmentName: $establishmentName, dob: $dob, gender: $gender, addresses: $addresses, clinicHospitalDetails: $clinicHospitalDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileUpdateProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.doctorNo, doctorNo) ||
                other.doctorNo == doctorNo) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.organizationName, organizationName) ||
                other.organizationName == organizationName) &&
            (identical(other.prifix, prifix) || other.prifix == prifix) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.middleName, middleName) ||
                other.middleName == middleName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.mobileNo, mobileNo) ||
                other.mobileNo == mobileNo) &&
            (identical(other.alternateNo, alternateNo) ||
                other.alternateNo == alternateNo) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.specialityId, specialityId) ||
                other.specialityId == specialityId) &&
            (identical(other.specialityName, specialityName) ||
                other.specialityName == specialityName) &&
            (identical(other.degree, degree) || other.degree == degree) &&
            (identical(other.establishmentName, establishmentName) ||
                other.establishmentName == establishmentName) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality().equals(
              other._addresses,
              _addresses,
            ) &&
            (identical(other.clinicHospitalDetails, clinicHospitalDetails) ||
                other.clinicHospitalDetails == clinicHospitalDetails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    doctorNo,
    photo,
    organizationName,
    prifix,
    firstName,
    middleName,
    lastName,
    fullName,
    email,
    mobileNo,
    alternateNo,
    categoryId,
    categoryName,
    specialityId,
    specialityName,
    degree,
    establishmentName,
    dob,
    gender,
    const DeepCollectionEquality().hash(_addresses),
    clinicHospitalDetails,
  ]);

  /// Create a copy of ProfileUpdateProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileUpdateProfileImplCopyWith<_$ProfileUpdateProfileImpl>
  get copyWith =>
      __$$ProfileUpdateProfileImplCopyWithImpl<_$ProfileUpdateProfileImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileUpdateProfileImplToJson(this);
  }
}

abstract class _ProfileUpdateProfile implements ProfileUpdateProfile {
  const factory _ProfileUpdateProfile({
    required final int id,
    @JsonKey(name: 'doctor_no') final String? doctorNo,
    final String? photo,
    @JsonKey(name: 'organization_name') final String? organizationName,
    final String? prifix,
    @JsonKey(name: 'first_name') final String? firstName,
    @JsonKey(name: 'middle_name') final String? middleName,
    @JsonKey(name: 'last_name') final String? lastName,
    @JsonKey(name: 'full_name') final String? fullName,
    final String? email,
    @JsonKey(name: 'mobile_no') final String? mobileNo,
    @JsonKey(name: 'alternate_no') final String? alternateNo,
    @JsonKey(name: 'category_id') final String? categoryId,
    @JsonKey(name: 'category_name') final String? categoryName,
    @JsonKey(name: 'speciality_id') final String? specialityId,
    @JsonKey(name: 'speciality_name') final String? specialityName,
    final String? degree,
    @JsonKey(name: 'establishment_name') final String? establishmentName,
    final String? dob,
    final String? gender,
    final List<ProfileUpdateAddress> addresses,
    @JsonKey(name: 'clinic_hospital_details')
    final ProfileUpdateClinicHospitalDetails? clinicHospitalDetails,
  }) = _$ProfileUpdateProfileImpl;

  factory _ProfileUpdateProfile.fromJson(Map<String, dynamic> json) =
      _$ProfileUpdateProfileImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'doctor_no')
  String? get doctorNo;
  @override
  String? get photo;
  @override
  @JsonKey(name: 'organization_name')
  String? get organizationName;
  @override
  String? get prifix;
  @override
  @JsonKey(name: 'first_name')
  String? get firstName;
  @override
  @JsonKey(name: 'middle_name')
  String? get middleName;
  @override
  @JsonKey(name: 'last_name')
  String? get lastName;
  @override
  @JsonKey(name: 'full_name')
  String? get fullName;
  @override
  String? get email;
  @override
  @JsonKey(name: 'mobile_no')
  String? get mobileNo;
  @override
  @JsonKey(name: 'alternate_no')
  String? get alternateNo;
  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'speciality_id')
  String? get specialityId;
  @override
  @JsonKey(name: 'speciality_name')
  String? get specialityName;
  @override
  String? get degree;
  @override
  @JsonKey(name: 'establishment_name')
  String? get establishmentName;
  @override
  String? get dob;
  @override
  String? get gender;
  @override
  List<ProfileUpdateAddress> get addresses;
  @override
  @JsonKey(name: 'clinic_hospital_details')
  ProfileUpdateClinicHospitalDetails? get clinicHospitalDetails;

  /// Create a copy of ProfileUpdateProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileUpdateProfileImplCopyWith<_$ProfileUpdateProfileImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ProfileUpdateAddress _$ProfileUpdateAddressFromJson(Map<String, dynamic> json) {
  return _ProfileUpdateAddress.fromJson(json);
}

/// @nodoc
mixin _$ProfileUpdateAddress {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_type')
  String? get addressType => throw _privateConstructorUsedError;
  @JsonKey(name: 'own_visiting')
  String? get ownVisiting => throw _privateConstructorUsedError;
  String? get address1 => throw _privateConstructorUsedError;
  String? get address2 => throw _privateConstructorUsedError;
  String? get landmark => throw _privateConstructorUsedError;
  String? get area => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get pincode => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this ProfileUpdateAddress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileUpdateAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileUpdateAddressCopyWith<ProfileUpdateAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileUpdateAddressCopyWith<$Res> {
  factory $ProfileUpdateAddressCopyWith(
    ProfileUpdateAddress value,
    $Res Function(ProfileUpdateAddress) then,
  ) = _$ProfileUpdateAddressCopyWithImpl<$Res, ProfileUpdateAddress>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'address_type') String? addressType,
    @JsonKey(name: 'own_visiting') String? ownVisiting,
    String? address1,
    String? address2,
    String? landmark,
    String? area,
    String? state,
    String? city,
    String? pincode,
    String? status,
  });
}

/// @nodoc
class _$ProfileUpdateAddressCopyWithImpl<
  $Res,
  $Val extends ProfileUpdateAddress
>
    implements $ProfileUpdateAddressCopyWith<$Res> {
  _$ProfileUpdateAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileUpdateAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? addressType = freezed,
    Object? ownVisiting = freezed,
    Object? address1 = freezed,
    Object? address2 = freezed,
    Object? landmark = freezed,
    Object? area = freezed,
    Object? state = freezed,
    Object? city = freezed,
    Object? pincode = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            addressType: freezed == addressType
                ? _value.addressType
                : addressType // ignore: cast_nullable_to_non_nullable
                      as String?,
            ownVisiting: freezed == ownVisiting
                ? _value.ownVisiting
                : ownVisiting // ignore: cast_nullable_to_non_nullable
                      as String?,
            address1: freezed == address1
                ? _value.address1
                : address1 // ignore: cast_nullable_to_non_nullable
                      as String?,
            address2: freezed == address2
                ? _value.address2
                : address2 // ignore: cast_nullable_to_non_nullable
                      as String?,
            landmark: freezed == landmark
                ? _value.landmark
                : landmark // ignore: cast_nullable_to_non_nullable
                      as String?,
            area: freezed == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                      as String?,
            state: freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            pincode: freezed == pincode
                ? _value.pincode
                : pincode // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileUpdateAddressImplCopyWith<$Res>
    implements $ProfileUpdateAddressCopyWith<$Res> {
  factory _$$ProfileUpdateAddressImplCopyWith(
    _$ProfileUpdateAddressImpl value,
    $Res Function(_$ProfileUpdateAddressImpl) then,
  ) = __$$ProfileUpdateAddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'address_type') String? addressType,
    @JsonKey(name: 'own_visiting') String? ownVisiting,
    String? address1,
    String? address2,
    String? landmark,
    String? area,
    String? state,
    String? city,
    String? pincode,
    String? status,
  });
}

/// @nodoc
class __$$ProfileUpdateAddressImplCopyWithImpl<$Res>
    extends _$ProfileUpdateAddressCopyWithImpl<$Res, _$ProfileUpdateAddressImpl>
    implements _$$ProfileUpdateAddressImplCopyWith<$Res> {
  __$$ProfileUpdateAddressImplCopyWithImpl(
    _$ProfileUpdateAddressImpl _value,
    $Res Function(_$ProfileUpdateAddressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileUpdateAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? addressType = freezed,
    Object? ownVisiting = freezed,
    Object? address1 = freezed,
    Object? address2 = freezed,
    Object? landmark = freezed,
    Object? area = freezed,
    Object? state = freezed,
    Object? city = freezed,
    Object? pincode = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$ProfileUpdateAddressImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        addressType: freezed == addressType
            ? _value.addressType
            : addressType // ignore: cast_nullable_to_non_nullable
                  as String?,
        ownVisiting: freezed == ownVisiting
            ? _value.ownVisiting
            : ownVisiting // ignore: cast_nullable_to_non_nullable
                  as String?,
        address1: freezed == address1
            ? _value.address1
            : address1 // ignore: cast_nullable_to_non_nullable
                  as String?,
        address2: freezed == address2
            ? _value.address2
            : address2 // ignore: cast_nullable_to_non_nullable
                  as String?,
        landmark: freezed == landmark
            ? _value.landmark
            : landmark // ignore: cast_nullable_to_non_nullable
                  as String?,
        area: freezed == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as String?,
        state: freezed == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        pincode: freezed == pincode
            ? _value.pincode
            : pincode // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileUpdateAddressImpl implements _ProfileUpdateAddress {
  const _$ProfileUpdateAddressImpl({
    required this.id,
    @JsonKey(name: 'address_type') this.addressType,
    @JsonKey(name: 'own_visiting') this.ownVisiting,
    this.address1,
    this.address2,
    this.landmark,
    this.area,
    this.state,
    this.city,
    this.pincode,
    this.status,
  });

  factory _$ProfileUpdateAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileUpdateAddressImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'address_type')
  final String? addressType;
  @override
  @JsonKey(name: 'own_visiting')
  final String? ownVisiting;
  @override
  final String? address1;
  @override
  final String? address2;
  @override
  final String? landmark;
  @override
  final String? area;
  @override
  final String? state;
  @override
  final String? city;
  @override
  final String? pincode;
  @override
  final String? status;

  @override
  String toString() {
    return 'ProfileUpdateAddress(id: $id, addressType: $addressType, ownVisiting: $ownVisiting, address1: $address1, address2: $address2, landmark: $landmark, area: $area, state: $state, city: $city, pincode: $pincode, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileUpdateAddressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.addressType, addressType) ||
                other.addressType == addressType) &&
            (identical(other.ownVisiting, ownVisiting) ||
                other.ownVisiting == ownVisiting) &&
            (identical(other.address1, address1) ||
                other.address1 == address1) &&
            (identical(other.address2, address2) ||
                other.address2 == address2) &&
            (identical(other.landmark, landmark) ||
                other.landmark == landmark) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.pincode, pincode) || other.pincode == pincode) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    addressType,
    ownVisiting,
    address1,
    address2,
    landmark,
    area,
    state,
    city,
    pincode,
    status,
  );

  /// Create a copy of ProfileUpdateAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileUpdateAddressImplCopyWith<_$ProfileUpdateAddressImpl>
  get copyWith =>
      __$$ProfileUpdateAddressImplCopyWithImpl<_$ProfileUpdateAddressImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileUpdateAddressImplToJson(this);
  }
}

abstract class _ProfileUpdateAddress implements ProfileUpdateAddress {
  const factory _ProfileUpdateAddress({
    required final int id,
    @JsonKey(name: 'address_type') final String? addressType,
    @JsonKey(name: 'own_visiting') final String? ownVisiting,
    final String? address1,
    final String? address2,
    final String? landmark,
    final String? area,
    final String? state,
    final String? city,
    final String? pincode,
    final String? status,
  }) = _$ProfileUpdateAddressImpl;

  factory _ProfileUpdateAddress.fromJson(Map<String, dynamic> json) =
      _$ProfileUpdateAddressImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'address_type')
  String? get addressType;
  @override
  @JsonKey(name: 'own_visiting')
  String? get ownVisiting;
  @override
  String? get address1;
  @override
  String? get address2;
  @override
  String? get landmark;
  @override
  String? get area;
  @override
  String? get state;
  @override
  String? get city;
  @override
  String? get pincode;
  @override
  String? get status;

  /// Create a copy of ProfileUpdateAddress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileUpdateAddressImplCopyWith<_$ProfileUpdateAddressImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ProfileUpdateClinicHospitalDetails _$ProfileUpdateClinicHospitalDetailsFromJson(
  Map<String, dynamic> json,
) {
  return _ProfileUpdateClinicHospitalDetails.fromJson(json);
}

/// @nodoc
mixin _$ProfileUpdateClinicHospitalDetails {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'medicle_reg_state')
  String? get medicleRegState => throw _privateConstructorUsedError;
  @JsonKey(name: 'medicle_reg_no')
  String? get medicleRegNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'medicle_reg_year')
  String? get medicleRegYear => throw _privateConstructorUsedError;
  @JsonKey(name: 'hospclin_reg_state')
  String? get hospclinRegState => throw _privateConstructorUsedError;
  @JsonKey(name: 'hospclin_reg_no')
  String? get hospclinRegNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'hospclin_reg_year')
  String? get hospclinRegYear => throw _privateConstructorUsedError;
  String? get retroactive => throw _privateConstructorUsedError;
  @JsonKey(name: 'retroactive_date')
  String? get retroactiveDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'retroactive_policydoc')
  String? get retroactivePolicydoc => throw _privateConstructorUsedError;
  String? get worldwide => throw _privateConstructorUsedError;
  @JsonKey(name: 'unqualified_staff')
  String? get unqualifiedStaff => throw _privateConstructorUsedError;
  @JsonKey(name: 'unqualified_staff_count')
  String? get unqualifiedStaffCount => throw _privateConstructorUsedError;
  String? get opd => throw _privateConstructorUsedError;
  String? get ipd => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this ProfileUpdateClinicHospitalDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileUpdateClinicHospitalDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileUpdateClinicHospitalDetailsCopyWith<
    ProfileUpdateClinicHospitalDetails
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileUpdateClinicHospitalDetailsCopyWith<$Res> {
  factory $ProfileUpdateClinicHospitalDetailsCopyWith(
    ProfileUpdateClinicHospitalDetails value,
    $Res Function(ProfileUpdateClinicHospitalDetails) then,
  ) =
      _$ProfileUpdateClinicHospitalDetailsCopyWithImpl<
        $Res,
        ProfileUpdateClinicHospitalDetails
      >;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'medicle_reg_state') String? medicleRegState,
    @JsonKey(name: 'medicle_reg_no') String? medicleRegNo,
    @JsonKey(name: 'medicle_reg_year') String? medicleRegYear,
    @JsonKey(name: 'hospclin_reg_state') String? hospclinRegState,
    @JsonKey(name: 'hospclin_reg_no') String? hospclinRegNo,
    @JsonKey(name: 'hospclin_reg_year') String? hospclinRegYear,
    String? retroactive,
    @JsonKey(name: 'retroactive_date') String? retroactiveDate,
    @JsonKey(name: 'retroactive_policydoc') String? retroactivePolicydoc,
    String? worldwide,
    @JsonKey(name: 'unqualified_staff') String? unqualifiedStaff,
    @JsonKey(name: 'unqualified_staff_count') String? unqualifiedStaffCount,
    String? opd,
    String? ipd,
    String? status,
  });
}

/// @nodoc
class _$ProfileUpdateClinicHospitalDetailsCopyWithImpl<
  $Res,
  $Val extends ProfileUpdateClinicHospitalDetails
>
    implements $ProfileUpdateClinicHospitalDetailsCopyWith<$Res> {
  _$ProfileUpdateClinicHospitalDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileUpdateClinicHospitalDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? medicleRegState = freezed,
    Object? medicleRegNo = freezed,
    Object? medicleRegYear = freezed,
    Object? hospclinRegState = freezed,
    Object? hospclinRegNo = freezed,
    Object? hospclinRegYear = freezed,
    Object? retroactive = freezed,
    Object? retroactiveDate = freezed,
    Object? retroactivePolicydoc = freezed,
    Object? worldwide = freezed,
    Object? unqualifiedStaff = freezed,
    Object? unqualifiedStaffCount = freezed,
    Object? opd = freezed,
    Object? ipd = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            medicleRegState: freezed == medicleRegState
                ? _value.medicleRegState
                : medicleRegState // ignore: cast_nullable_to_non_nullable
                      as String?,
            medicleRegNo: freezed == medicleRegNo
                ? _value.medicleRegNo
                : medicleRegNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            medicleRegYear: freezed == medicleRegYear
                ? _value.medicleRegYear
                : medicleRegYear // ignore: cast_nullable_to_non_nullable
                      as String?,
            hospclinRegState: freezed == hospclinRegState
                ? _value.hospclinRegState
                : hospclinRegState // ignore: cast_nullable_to_non_nullable
                      as String?,
            hospclinRegNo: freezed == hospclinRegNo
                ? _value.hospclinRegNo
                : hospclinRegNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            hospclinRegYear: freezed == hospclinRegYear
                ? _value.hospclinRegYear
                : hospclinRegYear // ignore: cast_nullable_to_non_nullable
                      as String?,
            retroactive: freezed == retroactive
                ? _value.retroactive
                : retroactive // ignore: cast_nullable_to_non_nullable
                      as String?,
            retroactiveDate: freezed == retroactiveDate
                ? _value.retroactiveDate
                : retroactiveDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            retroactivePolicydoc: freezed == retroactivePolicydoc
                ? _value.retroactivePolicydoc
                : retroactivePolicydoc // ignore: cast_nullable_to_non_nullable
                      as String?,
            worldwide: freezed == worldwide
                ? _value.worldwide
                : worldwide // ignore: cast_nullable_to_non_nullable
                      as String?,
            unqualifiedStaff: freezed == unqualifiedStaff
                ? _value.unqualifiedStaff
                : unqualifiedStaff // ignore: cast_nullable_to_non_nullable
                      as String?,
            unqualifiedStaffCount: freezed == unqualifiedStaffCount
                ? _value.unqualifiedStaffCount
                : unqualifiedStaffCount // ignore: cast_nullable_to_non_nullable
                      as String?,
            opd: freezed == opd
                ? _value.opd
                : opd // ignore: cast_nullable_to_non_nullable
                      as String?,
            ipd: freezed == ipd
                ? _value.ipd
                : ipd // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileUpdateClinicHospitalDetailsImplCopyWith<$Res>
    implements $ProfileUpdateClinicHospitalDetailsCopyWith<$Res> {
  factory _$$ProfileUpdateClinicHospitalDetailsImplCopyWith(
    _$ProfileUpdateClinicHospitalDetailsImpl value,
    $Res Function(_$ProfileUpdateClinicHospitalDetailsImpl) then,
  ) = __$$ProfileUpdateClinicHospitalDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'medicle_reg_state') String? medicleRegState,
    @JsonKey(name: 'medicle_reg_no') String? medicleRegNo,
    @JsonKey(name: 'medicle_reg_year') String? medicleRegYear,
    @JsonKey(name: 'hospclin_reg_state') String? hospclinRegState,
    @JsonKey(name: 'hospclin_reg_no') String? hospclinRegNo,
    @JsonKey(name: 'hospclin_reg_year') String? hospclinRegYear,
    String? retroactive,
    @JsonKey(name: 'retroactive_date') String? retroactiveDate,
    @JsonKey(name: 'retroactive_policydoc') String? retroactivePolicydoc,
    String? worldwide,
    @JsonKey(name: 'unqualified_staff') String? unqualifiedStaff,
    @JsonKey(name: 'unqualified_staff_count') String? unqualifiedStaffCount,
    String? opd,
    String? ipd,
    String? status,
  });
}

/// @nodoc
class __$$ProfileUpdateClinicHospitalDetailsImplCopyWithImpl<$Res>
    extends
        _$ProfileUpdateClinicHospitalDetailsCopyWithImpl<
          $Res,
          _$ProfileUpdateClinicHospitalDetailsImpl
        >
    implements _$$ProfileUpdateClinicHospitalDetailsImplCopyWith<$Res> {
  __$$ProfileUpdateClinicHospitalDetailsImplCopyWithImpl(
    _$ProfileUpdateClinicHospitalDetailsImpl _value,
    $Res Function(_$ProfileUpdateClinicHospitalDetailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileUpdateClinicHospitalDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? medicleRegState = freezed,
    Object? medicleRegNo = freezed,
    Object? medicleRegYear = freezed,
    Object? hospclinRegState = freezed,
    Object? hospclinRegNo = freezed,
    Object? hospclinRegYear = freezed,
    Object? retroactive = freezed,
    Object? retroactiveDate = freezed,
    Object? retroactivePolicydoc = freezed,
    Object? worldwide = freezed,
    Object? unqualifiedStaff = freezed,
    Object? unqualifiedStaffCount = freezed,
    Object? opd = freezed,
    Object? ipd = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$ProfileUpdateClinicHospitalDetailsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        medicleRegState: freezed == medicleRegState
            ? _value.medicleRegState
            : medicleRegState // ignore: cast_nullable_to_non_nullable
                  as String?,
        medicleRegNo: freezed == medicleRegNo
            ? _value.medicleRegNo
            : medicleRegNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        medicleRegYear: freezed == medicleRegYear
            ? _value.medicleRegYear
            : medicleRegYear // ignore: cast_nullable_to_non_nullable
                  as String?,
        hospclinRegState: freezed == hospclinRegState
            ? _value.hospclinRegState
            : hospclinRegState // ignore: cast_nullable_to_non_nullable
                  as String?,
        hospclinRegNo: freezed == hospclinRegNo
            ? _value.hospclinRegNo
            : hospclinRegNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        hospclinRegYear: freezed == hospclinRegYear
            ? _value.hospclinRegYear
            : hospclinRegYear // ignore: cast_nullable_to_non_nullable
                  as String?,
        retroactive: freezed == retroactive
            ? _value.retroactive
            : retroactive // ignore: cast_nullable_to_non_nullable
                  as String?,
        retroactiveDate: freezed == retroactiveDate
            ? _value.retroactiveDate
            : retroactiveDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        retroactivePolicydoc: freezed == retroactivePolicydoc
            ? _value.retroactivePolicydoc
            : retroactivePolicydoc // ignore: cast_nullable_to_non_nullable
                  as String?,
        worldwide: freezed == worldwide
            ? _value.worldwide
            : worldwide // ignore: cast_nullable_to_non_nullable
                  as String?,
        unqualifiedStaff: freezed == unqualifiedStaff
            ? _value.unqualifiedStaff
            : unqualifiedStaff // ignore: cast_nullable_to_non_nullable
                  as String?,
        unqualifiedStaffCount: freezed == unqualifiedStaffCount
            ? _value.unqualifiedStaffCount
            : unqualifiedStaffCount // ignore: cast_nullable_to_non_nullable
                  as String?,
        opd: freezed == opd
            ? _value.opd
            : opd // ignore: cast_nullable_to_non_nullable
                  as String?,
        ipd: freezed == ipd
            ? _value.ipd
            : ipd // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileUpdateClinicHospitalDetailsImpl
    implements _ProfileUpdateClinicHospitalDetails {
  const _$ProfileUpdateClinicHospitalDetailsImpl({
    required this.id,
    @JsonKey(name: 'medicle_reg_state') this.medicleRegState,
    @JsonKey(name: 'medicle_reg_no') this.medicleRegNo,
    @JsonKey(name: 'medicle_reg_year') this.medicleRegYear,
    @JsonKey(name: 'hospclin_reg_state') this.hospclinRegState,
    @JsonKey(name: 'hospclin_reg_no') this.hospclinRegNo,
    @JsonKey(name: 'hospclin_reg_year') this.hospclinRegYear,
    this.retroactive,
    @JsonKey(name: 'retroactive_date') this.retroactiveDate,
    @JsonKey(name: 'retroactive_policydoc') this.retroactivePolicydoc,
    this.worldwide,
    @JsonKey(name: 'unqualified_staff') this.unqualifiedStaff,
    @JsonKey(name: 'unqualified_staff_count') this.unqualifiedStaffCount,
    this.opd,
    this.ipd,
    this.status,
  });

  factory _$ProfileUpdateClinicHospitalDetailsImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$ProfileUpdateClinicHospitalDetailsImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'medicle_reg_state')
  final String? medicleRegState;
  @override
  @JsonKey(name: 'medicle_reg_no')
  final String? medicleRegNo;
  @override
  @JsonKey(name: 'medicle_reg_year')
  final String? medicleRegYear;
  @override
  @JsonKey(name: 'hospclin_reg_state')
  final String? hospclinRegState;
  @override
  @JsonKey(name: 'hospclin_reg_no')
  final String? hospclinRegNo;
  @override
  @JsonKey(name: 'hospclin_reg_year')
  final String? hospclinRegYear;
  @override
  final String? retroactive;
  @override
  @JsonKey(name: 'retroactive_date')
  final String? retroactiveDate;
  @override
  @JsonKey(name: 'retroactive_policydoc')
  final String? retroactivePolicydoc;
  @override
  final String? worldwide;
  @override
  @JsonKey(name: 'unqualified_staff')
  final String? unqualifiedStaff;
  @override
  @JsonKey(name: 'unqualified_staff_count')
  final String? unqualifiedStaffCount;
  @override
  final String? opd;
  @override
  final String? ipd;
  @override
  final String? status;

  @override
  String toString() {
    return 'ProfileUpdateClinicHospitalDetails(id: $id, medicleRegState: $medicleRegState, medicleRegNo: $medicleRegNo, medicleRegYear: $medicleRegYear, hospclinRegState: $hospclinRegState, hospclinRegNo: $hospclinRegNo, hospclinRegYear: $hospclinRegYear, retroactive: $retroactive, retroactiveDate: $retroactiveDate, retroactivePolicydoc: $retroactivePolicydoc, worldwide: $worldwide, unqualifiedStaff: $unqualifiedStaff, unqualifiedStaffCount: $unqualifiedStaffCount, opd: $opd, ipd: $ipd, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileUpdateClinicHospitalDetailsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.medicleRegState, medicleRegState) ||
                other.medicleRegState == medicleRegState) &&
            (identical(other.medicleRegNo, medicleRegNo) ||
                other.medicleRegNo == medicleRegNo) &&
            (identical(other.medicleRegYear, medicleRegYear) ||
                other.medicleRegYear == medicleRegYear) &&
            (identical(other.hospclinRegState, hospclinRegState) ||
                other.hospclinRegState == hospclinRegState) &&
            (identical(other.hospclinRegNo, hospclinRegNo) ||
                other.hospclinRegNo == hospclinRegNo) &&
            (identical(other.hospclinRegYear, hospclinRegYear) ||
                other.hospclinRegYear == hospclinRegYear) &&
            (identical(other.retroactive, retroactive) ||
                other.retroactive == retroactive) &&
            (identical(other.retroactiveDate, retroactiveDate) ||
                other.retroactiveDate == retroactiveDate) &&
            (identical(other.retroactivePolicydoc, retroactivePolicydoc) ||
                other.retroactivePolicydoc == retroactivePolicydoc) &&
            (identical(other.worldwide, worldwide) ||
                other.worldwide == worldwide) &&
            (identical(other.unqualifiedStaff, unqualifiedStaff) ||
                other.unqualifiedStaff == unqualifiedStaff) &&
            (identical(other.unqualifiedStaffCount, unqualifiedStaffCount) ||
                other.unqualifiedStaffCount == unqualifiedStaffCount) &&
            (identical(other.opd, opd) || other.opd == opd) &&
            (identical(other.ipd, ipd) || other.ipd == ipd) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    medicleRegState,
    medicleRegNo,
    medicleRegYear,
    hospclinRegState,
    hospclinRegNo,
    hospclinRegYear,
    retroactive,
    retroactiveDate,
    retroactivePolicydoc,
    worldwide,
    unqualifiedStaff,
    unqualifiedStaffCount,
    opd,
    ipd,
    status,
  );

  /// Create a copy of ProfileUpdateClinicHospitalDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileUpdateClinicHospitalDetailsImplCopyWith<
    _$ProfileUpdateClinicHospitalDetailsImpl
  >
  get copyWith =>
      __$$ProfileUpdateClinicHospitalDetailsImplCopyWithImpl<
        _$ProfileUpdateClinicHospitalDetailsImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileUpdateClinicHospitalDetailsImplToJson(this);
  }
}

abstract class _ProfileUpdateClinicHospitalDetails
    implements ProfileUpdateClinicHospitalDetails {
  const factory _ProfileUpdateClinicHospitalDetails({
    required final int id,
    @JsonKey(name: 'medicle_reg_state') final String? medicleRegState,
    @JsonKey(name: 'medicle_reg_no') final String? medicleRegNo,
    @JsonKey(name: 'medicle_reg_year') final String? medicleRegYear,
    @JsonKey(name: 'hospclin_reg_state') final String? hospclinRegState,
    @JsonKey(name: 'hospclin_reg_no') final String? hospclinRegNo,
    @JsonKey(name: 'hospclin_reg_year') final String? hospclinRegYear,
    final String? retroactive,
    @JsonKey(name: 'retroactive_date') final String? retroactiveDate,
    @JsonKey(name: 'retroactive_policydoc') final String? retroactivePolicydoc,
    final String? worldwide,
    @JsonKey(name: 'unqualified_staff') final String? unqualifiedStaff,
    @JsonKey(name: 'unqualified_staff_count')
    final String? unqualifiedStaffCount,
    final String? opd,
    final String? ipd,
    final String? status,
  }) = _$ProfileUpdateClinicHospitalDetailsImpl;

  factory _ProfileUpdateClinicHospitalDetails.fromJson(
    Map<String, dynamic> json,
  ) = _$ProfileUpdateClinicHospitalDetailsImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'medicle_reg_state')
  String? get medicleRegState;
  @override
  @JsonKey(name: 'medicle_reg_no')
  String? get medicleRegNo;
  @override
  @JsonKey(name: 'medicle_reg_year')
  String? get medicleRegYear;
  @override
  @JsonKey(name: 'hospclin_reg_state')
  String? get hospclinRegState;
  @override
  @JsonKey(name: 'hospclin_reg_no')
  String? get hospclinRegNo;
  @override
  @JsonKey(name: 'hospclin_reg_year')
  String? get hospclinRegYear;
  @override
  String? get retroactive;
  @override
  @JsonKey(name: 'retroactive_date')
  String? get retroactiveDate;
  @override
  @JsonKey(name: 'retroactive_policydoc')
  String? get retroactivePolicydoc;
  @override
  String? get worldwide;
  @override
  @JsonKey(name: 'unqualified_staff')
  String? get unqualifiedStaff;
  @override
  @JsonKey(name: 'unqualified_staff_count')
  String? get unqualifiedStaffCount;
  @override
  String? get opd;
  @override
  String? get ipd;
  @override
  String? get status;

  /// Create a copy of ProfileUpdateClinicHospitalDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileUpdateClinicHospitalDetailsImplCopyWith<
    _$ProfileUpdateClinicHospitalDetailsImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
