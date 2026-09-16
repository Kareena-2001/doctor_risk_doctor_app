// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_profile_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DoctorProfileResponse _$DoctorProfileResponseFromJson(
  Map<String, dynamic> json,
) {
  return _DoctorProfileResponse.fromJson(json);
}

/// @nodoc
mixin _$DoctorProfileResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  DoctorProfileData get data => throw _privateConstructorUsedError;

  /// Serializes this DoctorProfileResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DoctorProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoctorProfileResponseCopyWith<DoctorProfileResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorProfileResponseCopyWith<$Res> {
  factory $DoctorProfileResponseCopyWith(
    DoctorProfileResponse value,
    $Res Function(DoctorProfileResponse) then,
  ) = _$DoctorProfileResponseCopyWithImpl<$Res, DoctorProfileResponse>;
  @useResult
  $Res call({bool status, int code, String msg, DoctorProfileData data});

  $DoctorProfileDataCopyWith<$Res> get data;
}

/// @nodoc
class _$DoctorProfileResponseCopyWithImpl<
  $Res,
  $Val extends DoctorProfileResponse
>
    implements $DoctorProfileResponseCopyWith<$Res> {
  _$DoctorProfileResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoctorProfileResponse
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
                      as DoctorProfileData,
          )
          as $Val,
    );
  }

  /// Create a copy of DoctorProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DoctorProfileDataCopyWith<$Res> get data {
    return $DoctorProfileDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DoctorProfileResponseImplCopyWith<$Res>
    implements $DoctorProfileResponseCopyWith<$Res> {
  factory _$$DoctorProfileResponseImplCopyWith(
    _$DoctorProfileResponseImpl value,
    $Res Function(_$DoctorProfileResponseImpl) then,
  ) = __$$DoctorProfileResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, int code, String msg, DoctorProfileData data});

  @override
  $DoctorProfileDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$DoctorProfileResponseImplCopyWithImpl<$Res>
    extends
        _$DoctorProfileResponseCopyWithImpl<$Res, _$DoctorProfileResponseImpl>
    implements _$$DoctorProfileResponseImplCopyWith<$Res> {
  __$$DoctorProfileResponseImplCopyWithImpl(
    _$DoctorProfileResponseImpl _value,
    $Res Function(_$DoctorProfileResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DoctorProfileResponse
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
      _$DoctorProfileResponseImpl(
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
                  as DoctorProfileData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorProfileResponseImpl implements _DoctorProfileResponse {
  const _$DoctorProfileResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory _$DoctorProfileResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoctorProfileResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  @override
  final DoctorProfileData data;

  @override
  String toString() {
    return 'DoctorProfileResponse(status: $status, code: $code, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorProfileResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, msg, data);

  /// Create a copy of DoctorProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorProfileResponseImplCopyWith<_$DoctorProfileResponseImpl>
  get copyWith =>
      __$$DoctorProfileResponseImplCopyWithImpl<_$DoctorProfileResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorProfileResponseImplToJson(this);
  }
}

abstract class _DoctorProfileResponse implements DoctorProfileResponse {
  const factory _DoctorProfileResponse({
    required final bool status,
    required final int code,
    required final String msg,
    required final DoctorProfileData data,
  }) = _$DoctorProfileResponseImpl;

  factory _DoctorProfileResponse.fromJson(Map<String, dynamic> json) =
      _$DoctorProfileResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  DoctorProfileData get data;

  /// Create a copy of DoctorProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoctorProfileResponseImplCopyWith<_$DoctorProfileResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DoctorProfileData _$DoctorProfileDataFromJson(Map<String, dynamic> json) {
  return _DoctorProfileData.fromJson(json);
}

/// @nodoc
mixin _$DoctorProfileData {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_no')
  String? get doctorNo => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  @JsonKey(name: 'organization_name')
  String? get organizationName => throw _privateConstructorUsedError;
  @JsonKey(name: 'prifix')
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
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'speciality_name')
  String? get specialityName => throw _privateConstructorUsedError;
  String? get degree => throw _privateConstructorUsedError;
  @JsonKey(name: 'establishment_name')
  String? get establishmentName => throw _privateConstructorUsedError;
  String? get dob => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  List<DoctorAddress> get addresses => throw _privateConstructorUsedError;
  @JsonKey(name: 'clinic_hospital_details')
  DoctorClinicHospitalDetails? get clinicHospitalDetails =>
      throw _privateConstructorUsedError;
  List<DoctorDocument> get documents => throw _privateConstructorUsedError;

  /// Serializes this DoctorProfileData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DoctorProfileData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoctorProfileDataCopyWith<DoctorProfileData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorProfileDataCopyWith<$Res> {
  factory $DoctorProfileDataCopyWith(
    DoctorProfileData value,
    $Res Function(DoctorProfileData) then,
  ) = _$DoctorProfileDataCopyWithImpl<$Res, DoctorProfileData>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'doctor_no') String? doctorNo,
    String? photo,
    @JsonKey(name: 'organization_name') String? organizationName,
    @JsonKey(name: 'prifix') String? prifix,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'middle_name') String? middleName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'full_name') String? fullName,
    String? email,
    @JsonKey(name: 'mobile_no') String? mobileNo,
    @JsonKey(name: 'alternate_no') String? alternateNo,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'speciality_name') String? specialityName,
    String? degree,
    @JsonKey(name: 'establishment_name') String? establishmentName,
    String? dob,
    String? gender,
    List<DoctorAddress> addresses,
    @JsonKey(name: 'clinic_hospital_details')
    DoctorClinicHospitalDetails? clinicHospitalDetails,
    List<DoctorDocument> documents,
  });

  $DoctorClinicHospitalDetailsCopyWith<$Res>? get clinicHospitalDetails;
}

/// @nodoc
class _$DoctorProfileDataCopyWithImpl<$Res, $Val extends DoctorProfileData>
    implements $DoctorProfileDataCopyWith<$Res> {
  _$DoctorProfileDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoctorProfileData
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
    Object? categoryName = freezed,
    Object? specialityName = freezed,
    Object? degree = freezed,
    Object? establishmentName = freezed,
    Object? dob = freezed,
    Object? gender = freezed,
    Object? addresses = null,
    Object? clinicHospitalDetails = freezed,
    Object? documents = null,
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
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
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
                      as List<DoctorAddress>,
            clinicHospitalDetails: freezed == clinicHospitalDetails
                ? _value.clinicHospitalDetails
                : clinicHospitalDetails // ignore: cast_nullable_to_non_nullable
                      as DoctorClinicHospitalDetails?,
            documents: null == documents
                ? _value.documents
                : documents // ignore: cast_nullable_to_non_nullable
                      as List<DoctorDocument>,
          )
          as $Val,
    );
  }

  /// Create a copy of DoctorProfileData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DoctorClinicHospitalDetailsCopyWith<$Res>? get clinicHospitalDetails {
    if (_value.clinicHospitalDetails == null) {
      return null;
    }

    return $DoctorClinicHospitalDetailsCopyWith<$Res>(
      _value.clinicHospitalDetails!,
      (value) {
        return _then(_value.copyWith(clinicHospitalDetails: value) as $Val);
      },
    );
  }
}

/// @nodoc
abstract class _$$DoctorProfileDataImplCopyWith<$Res>
    implements $DoctorProfileDataCopyWith<$Res> {
  factory _$$DoctorProfileDataImplCopyWith(
    _$DoctorProfileDataImpl value,
    $Res Function(_$DoctorProfileDataImpl) then,
  ) = __$$DoctorProfileDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'doctor_no') String? doctorNo,
    String? photo,
    @JsonKey(name: 'organization_name') String? organizationName,
    @JsonKey(name: 'prifix') String? prifix,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'middle_name') String? middleName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'full_name') String? fullName,
    String? email,
    @JsonKey(name: 'mobile_no') String? mobileNo,
    @JsonKey(name: 'alternate_no') String? alternateNo,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'speciality_name') String? specialityName,
    String? degree,
    @JsonKey(name: 'establishment_name') String? establishmentName,
    String? dob,
    String? gender,
    List<DoctorAddress> addresses,
    @JsonKey(name: 'clinic_hospital_details')
    DoctorClinicHospitalDetails? clinicHospitalDetails,
    List<DoctorDocument> documents,
  });

  @override
  $DoctorClinicHospitalDetailsCopyWith<$Res>? get clinicHospitalDetails;
}

/// @nodoc
class __$$DoctorProfileDataImplCopyWithImpl<$Res>
    extends _$DoctorProfileDataCopyWithImpl<$Res, _$DoctorProfileDataImpl>
    implements _$$DoctorProfileDataImplCopyWith<$Res> {
  __$$DoctorProfileDataImplCopyWithImpl(
    _$DoctorProfileDataImpl _value,
    $Res Function(_$DoctorProfileDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DoctorProfileData
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
    Object? categoryName = freezed,
    Object? specialityName = freezed,
    Object? degree = freezed,
    Object? establishmentName = freezed,
    Object? dob = freezed,
    Object? gender = freezed,
    Object? addresses = null,
    Object? clinicHospitalDetails = freezed,
    Object? documents = null,
  }) {
    return _then(
      _$DoctorProfileDataImpl(
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
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
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
                  as List<DoctorAddress>,
        clinicHospitalDetails: freezed == clinicHospitalDetails
            ? _value.clinicHospitalDetails
            : clinicHospitalDetails // ignore: cast_nullable_to_non_nullable
                  as DoctorClinicHospitalDetails?,
        documents: null == documents
            ? _value._documents
            : documents // ignore: cast_nullable_to_non_nullable
                  as List<DoctorDocument>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorProfileDataImpl implements _DoctorProfileData {
  const _$DoctorProfileDataImpl({
    required this.id,
    @JsonKey(name: 'doctor_no') this.doctorNo,
    this.photo,
    @JsonKey(name: 'organization_name') this.organizationName,
    @JsonKey(name: 'prifix') this.prifix,
    @JsonKey(name: 'first_name') this.firstName,
    @JsonKey(name: 'middle_name') this.middleName,
    @JsonKey(name: 'last_name') this.lastName,
    @JsonKey(name: 'full_name') this.fullName,
    this.email,
    @JsonKey(name: 'mobile_no') this.mobileNo,
    @JsonKey(name: 'alternate_no') this.alternateNo,
    @JsonKey(name: 'category_name') this.categoryName,
    @JsonKey(name: 'speciality_name') this.specialityName,
    this.degree,
    @JsonKey(name: 'establishment_name') this.establishmentName,
    this.dob,
    this.gender,
    final List<DoctorAddress> addresses = const [],
    @JsonKey(name: 'clinic_hospital_details') this.clinicHospitalDetails,
    final List<DoctorDocument> documents = const [],
  }) : _addresses = addresses,
       _documents = documents;

  factory _$DoctorProfileDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoctorProfileDataImplFromJson(json);

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
  @JsonKey(name: 'prifix')
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
  @JsonKey(name: 'category_name')
  final String? categoryName;
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
  final List<DoctorAddress> _addresses;
  @override
  @JsonKey()
  List<DoctorAddress> get addresses {
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addresses);
  }

  @override
  @JsonKey(name: 'clinic_hospital_details')
  final DoctorClinicHospitalDetails? clinicHospitalDetails;
  final List<DoctorDocument> _documents;
  @override
  @JsonKey()
  List<DoctorDocument> get documents {
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documents);
  }

  @override
  String toString() {
    return 'DoctorProfileData(id: $id, doctorNo: $doctorNo, photo: $photo, organizationName: $organizationName, prifix: $prifix, firstName: $firstName, middleName: $middleName, lastName: $lastName, fullName: $fullName, email: $email, mobileNo: $mobileNo, alternateNo: $alternateNo, categoryName: $categoryName, specialityName: $specialityName, degree: $degree, establishmentName: $establishmentName, dob: $dob, gender: $gender, addresses: $addresses, clinicHospitalDetails: $clinicHospitalDetails, documents: $documents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorProfileDataImpl &&
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
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
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
                other.clinicHospitalDetails == clinicHospitalDetails) &&
            const DeepCollectionEquality().equals(
              other._documents,
              _documents,
            ));
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
    categoryName,
    specialityName,
    degree,
    establishmentName,
    dob,
    gender,
    const DeepCollectionEquality().hash(_addresses),
    clinicHospitalDetails,
    const DeepCollectionEquality().hash(_documents),
  ]);

  /// Create a copy of DoctorProfileData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorProfileDataImplCopyWith<_$DoctorProfileDataImpl> get copyWith =>
      __$$DoctorProfileDataImplCopyWithImpl<_$DoctorProfileDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorProfileDataImplToJson(this);
  }
}

abstract class _DoctorProfileData implements DoctorProfileData {
  const factory _DoctorProfileData({
    required final int id,
    @JsonKey(name: 'doctor_no') final String? doctorNo,
    final String? photo,
    @JsonKey(name: 'organization_name') final String? organizationName,
    @JsonKey(name: 'prifix') final String? prifix,
    @JsonKey(name: 'first_name') final String? firstName,
    @JsonKey(name: 'middle_name') final String? middleName,
    @JsonKey(name: 'last_name') final String? lastName,
    @JsonKey(name: 'full_name') final String? fullName,
    final String? email,
    @JsonKey(name: 'mobile_no') final String? mobileNo,
    @JsonKey(name: 'alternate_no') final String? alternateNo,
    @JsonKey(name: 'category_name') final String? categoryName,
    @JsonKey(name: 'speciality_name') final String? specialityName,
    final String? degree,
    @JsonKey(name: 'establishment_name') final String? establishmentName,
    final String? dob,
    final String? gender,
    final List<DoctorAddress> addresses,
    @JsonKey(name: 'clinic_hospital_details')
    final DoctorClinicHospitalDetails? clinicHospitalDetails,
    final List<DoctorDocument> documents,
  }) = _$DoctorProfileDataImpl;

  factory _DoctorProfileData.fromJson(Map<String, dynamic> json) =
      _$DoctorProfileDataImpl.fromJson;

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
  @JsonKey(name: 'prifix')
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
  @JsonKey(name: 'category_name')
  String? get categoryName;
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
  List<DoctorAddress> get addresses;
  @override
  @JsonKey(name: 'clinic_hospital_details')
  DoctorClinicHospitalDetails? get clinicHospitalDetails;
  @override
  List<DoctorDocument> get documents;

  /// Create a copy of DoctorProfileData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoctorProfileDataImplCopyWith<_$DoctorProfileDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DoctorAddress _$DoctorAddressFromJson(Map<String, dynamic> json) {
  return _DoctorAddress.fromJson(json);
}

/// @nodoc
mixin _$DoctorAddress {
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

  /// Serializes this DoctorAddress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DoctorAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoctorAddressCopyWith<DoctorAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorAddressCopyWith<$Res> {
  factory $DoctorAddressCopyWith(
    DoctorAddress value,
    $Res Function(DoctorAddress) then,
  ) = _$DoctorAddressCopyWithImpl<$Res, DoctorAddress>;
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
class _$DoctorAddressCopyWithImpl<$Res, $Val extends DoctorAddress>
    implements $DoctorAddressCopyWith<$Res> {
  _$DoctorAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoctorAddress
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
abstract class _$$DoctorAddressImplCopyWith<$Res>
    implements $DoctorAddressCopyWith<$Res> {
  factory _$$DoctorAddressImplCopyWith(
    _$DoctorAddressImpl value,
    $Res Function(_$DoctorAddressImpl) then,
  ) = __$$DoctorAddressImplCopyWithImpl<$Res>;
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
class __$$DoctorAddressImplCopyWithImpl<$Res>
    extends _$DoctorAddressCopyWithImpl<$Res, _$DoctorAddressImpl>
    implements _$$DoctorAddressImplCopyWith<$Res> {
  __$$DoctorAddressImplCopyWithImpl(
    _$DoctorAddressImpl _value,
    $Res Function(_$DoctorAddressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DoctorAddress
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
      _$DoctorAddressImpl(
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
class _$DoctorAddressImpl implements _DoctorAddress {
  const _$DoctorAddressImpl({
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

  factory _$DoctorAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoctorAddressImplFromJson(json);

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
    return 'DoctorAddress(id: $id, addressType: $addressType, ownVisiting: $ownVisiting, address1: $address1, address2: $address2, landmark: $landmark, area: $area, state: $state, city: $city, pincode: $pincode, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorAddressImpl &&
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

  /// Create a copy of DoctorAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorAddressImplCopyWith<_$DoctorAddressImpl> get copyWith =>
      __$$DoctorAddressImplCopyWithImpl<_$DoctorAddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorAddressImplToJson(this);
  }
}

abstract class _DoctorAddress implements DoctorAddress {
  const factory _DoctorAddress({
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
  }) = _$DoctorAddressImpl;

  factory _DoctorAddress.fromJson(Map<String, dynamic> json) =
      _$DoctorAddressImpl.fromJson;

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

  /// Create a copy of DoctorAddress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoctorAddressImplCopyWith<_$DoctorAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DoctorClinicHospitalDetails _$DoctorClinicHospitalDetailsFromJson(
  Map<String, dynamic> json,
) {
  return _DoctorClinicHospitalDetails.fromJson(json);
}

/// @nodoc
mixin _$DoctorClinicHospitalDetails {
  int? get id => throw _privateConstructorUsedError;
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

  /// Serializes this DoctorClinicHospitalDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DoctorClinicHospitalDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoctorClinicHospitalDetailsCopyWith<DoctorClinicHospitalDetails>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorClinicHospitalDetailsCopyWith<$Res> {
  factory $DoctorClinicHospitalDetailsCopyWith(
    DoctorClinicHospitalDetails value,
    $Res Function(DoctorClinicHospitalDetails) then,
  ) =
      _$DoctorClinicHospitalDetailsCopyWithImpl<
        $Res,
        DoctorClinicHospitalDetails
      >;
  @useResult
  $Res call({
    int? id,
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
class _$DoctorClinicHospitalDetailsCopyWithImpl<
  $Res,
  $Val extends DoctorClinicHospitalDetails
>
    implements $DoctorClinicHospitalDetailsCopyWith<$Res> {
  _$DoctorClinicHospitalDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoctorClinicHospitalDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
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
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
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
abstract class _$$DoctorClinicHospitalDetailsImplCopyWith<$Res>
    implements $DoctorClinicHospitalDetailsCopyWith<$Res> {
  factory _$$DoctorClinicHospitalDetailsImplCopyWith(
    _$DoctorClinicHospitalDetailsImpl value,
    $Res Function(_$DoctorClinicHospitalDetailsImpl) then,
  ) = __$$DoctorClinicHospitalDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
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
class __$$DoctorClinicHospitalDetailsImplCopyWithImpl<$Res>
    extends
        _$DoctorClinicHospitalDetailsCopyWithImpl<
          $Res,
          _$DoctorClinicHospitalDetailsImpl
        >
    implements _$$DoctorClinicHospitalDetailsImplCopyWith<$Res> {
  __$$DoctorClinicHospitalDetailsImplCopyWithImpl(
    _$DoctorClinicHospitalDetailsImpl _value,
    $Res Function(_$DoctorClinicHospitalDetailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DoctorClinicHospitalDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
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
      _$DoctorClinicHospitalDetailsImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
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
class _$DoctorClinicHospitalDetailsImpl
    implements _DoctorClinicHospitalDetails {
  const _$DoctorClinicHospitalDetailsImpl({
    this.id,
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

  factory _$DoctorClinicHospitalDetailsImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DoctorClinicHospitalDetailsImplFromJson(json);

  @override
  final int? id;
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
    return 'DoctorClinicHospitalDetails(id: $id, medicleRegState: $medicleRegState, medicleRegNo: $medicleRegNo, medicleRegYear: $medicleRegYear, hospclinRegState: $hospclinRegState, hospclinRegNo: $hospclinRegNo, hospclinRegYear: $hospclinRegYear, retroactive: $retroactive, retroactiveDate: $retroactiveDate, retroactivePolicydoc: $retroactivePolicydoc, worldwide: $worldwide, unqualifiedStaff: $unqualifiedStaff, unqualifiedStaffCount: $unqualifiedStaffCount, opd: $opd, ipd: $ipd, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorClinicHospitalDetailsImpl &&
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

  /// Create a copy of DoctorClinicHospitalDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorClinicHospitalDetailsImplCopyWith<_$DoctorClinicHospitalDetailsImpl>
  get copyWith =>
      __$$DoctorClinicHospitalDetailsImplCopyWithImpl<
        _$DoctorClinicHospitalDetailsImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorClinicHospitalDetailsImplToJson(this);
  }
}

abstract class _DoctorClinicHospitalDetails
    implements DoctorClinicHospitalDetails {
  const factory _DoctorClinicHospitalDetails({
    final int? id,
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
  }) = _$DoctorClinicHospitalDetailsImpl;

  factory _DoctorClinicHospitalDetails.fromJson(Map<String, dynamic> json) =
      _$DoctorClinicHospitalDetailsImpl.fromJson;

  @override
  int? get id;
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

  /// Create a copy of DoctorClinicHospitalDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoctorClinicHospitalDetailsImplCopyWith<_$DoctorClinicHospitalDetailsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DoctorDocument _$DoctorDocumentFromJson(Map<String, dynamic> json) {
  return _DoctorDocument.fromJson(json);
}

/// @nodoc
mixin _$DoctorDocument {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'doc_name')
  String? get docName => throw _privateConstructorUsedError;
  String? get documents => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this DoctorDocument to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DoctorDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoctorDocumentCopyWith<DoctorDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorDocumentCopyWith<$Res> {
  factory $DoctorDocumentCopyWith(
    DoctorDocument value,
    $Res Function(DoctorDocument) then,
  ) = _$DoctorDocumentCopyWithImpl<$Res, DoctorDocument>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'doc_name') String? docName,
    String? documents,
    String? status,
  });
}

/// @nodoc
class _$DoctorDocumentCopyWithImpl<$Res, $Val extends DoctorDocument>
    implements $DoctorDocumentCopyWith<$Res> {
  _$DoctorDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoctorDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? docName = freezed,
    Object? documents = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            docName: freezed == docName
                ? _value.docName
                : docName // ignore: cast_nullable_to_non_nullable
                      as String?,
            documents: freezed == documents
                ? _value.documents
                : documents // ignore: cast_nullable_to_non_nullable
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
abstract class _$$DoctorDocumentImplCopyWith<$Res>
    implements $DoctorDocumentCopyWith<$Res> {
  factory _$$DoctorDocumentImplCopyWith(
    _$DoctorDocumentImpl value,
    $Res Function(_$DoctorDocumentImpl) then,
  ) = __$$DoctorDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'doc_name') String? docName,
    String? documents,
    String? status,
  });
}

/// @nodoc
class __$$DoctorDocumentImplCopyWithImpl<$Res>
    extends _$DoctorDocumentCopyWithImpl<$Res, _$DoctorDocumentImpl>
    implements _$$DoctorDocumentImplCopyWith<$Res> {
  __$$DoctorDocumentImplCopyWithImpl(
    _$DoctorDocumentImpl _value,
    $Res Function(_$DoctorDocumentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DoctorDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? docName = freezed,
    Object? documents = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$DoctorDocumentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        docName: freezed == docName
            ? _value.docName
            : docName // ignore: cast_nullable_to_non_nullable
                  as String?,
        documents: freezed == documents
            ? _value.documents
            : documents // ignore: cast_nullable_to_non_nullable
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
class _$DoctorDocumentImpl implements _DoctorDocument {
  const _$DoctorDocumentImpl({
    required this.id,
    @JsonKey(name: 'doc_name') this.docName,
    this.documents,
    this.status,
  });

  factory _$DoctorDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoctorDocumentImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'doc_name')
  final String? docName;
  @override
  final String? documents;
  @override
  final String? status;

  @override
  String toString() {
    return 'DoctorDocument(id: $id, docName: $docName, documents: $documents, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorDocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.docName, docName) || other.docName == docName) &&
            (identical(other.documents, documents) ||
                other.documents == documents) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, docName, documents, status);

  /// Create a copy of DoctorDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorDocumentImplCopyWith<_$DoctorDocumentImpl> get copyWith =>
      __$$DoctorDocumentImplCopyWithImpl<_$DoctorDocumentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorDocumentImplToJson(this);
  }
}

abstract class _DoctorDocument implements DoctorDocument {
  const factory _DoctorDocument({
    required final int id,
    @JsonKey(name: 'doc_name') final String? docName,
    final String? documents,
    final String? status,
  }) = _$DoctorDocumentImpl;

  factory _DoctorDocument.fromJson(Map<String, dynamic> json) =
      _$DoctorDocumentImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'doc_name')
  String? get docName;
  @override
  String? get documents;
  @override
  String? get status;

  /// Create a copy of DoctorDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoctorDocumentImplCopyWith<_$DoctorDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
