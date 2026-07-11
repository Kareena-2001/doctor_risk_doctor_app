// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProfileResponse _$UserProfileResponseFromJson(Map<String, dynamic> json) {
  return _UserProfileResponse.fromJson(json);
}

/// @nodoc
mixin _$UserProfileResponse {
  int get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  UserProfileModel get data => throw _privateConstructorUsedError;

  /// Serializes this UserProfileResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileResponseCopyWith<UserProfileResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileResponseCopyWith<$Res> {
  factory $UserProfileResponseCopyWith(
    UserProfileResponse value,
    $Res Function(UserProfileResponse) then,
  ) = _$UserProfileResponseCopyWithImpl<$Res, UserProfileResponse>;
  @useResult
  $Res call({int status, String msg, UserProfileModel data});

  $UserProfileModelCopyWith<$Res> get data;
}

/// @nodoc
class _$UserProfileResponseCopyWithImpl<$Res, $Val extends UserProfileResponse>
    implements $UserProfileResponseCopyWith<$Res> {
  _$UserProfileResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileResponse
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
                      as UserProfileModel,
          )
          as $Val,
    );
  }

  /// Create a copy of UserProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileModelCopyWith<$Res> get data {
    return $UserProfileModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileResponseImplCopyWith<$Res>
    implements $UserProfileResponseCopyWith<$Res> {
  factory _$$UserProfileResponseImplCopyWith(
    _$UserProfileResponseImpl value,
    $Res Function(_$UserProfileResponseImpl) then,
  ) = __$$UserProfileResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String msg, UserProfileModel data});

  @override
  $UserProfileModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$UserProfileResponseImplCopyWithImpl<$Res>
    extends _$UserProfileResponseCopyWithImpl<$Res, _$UserProfileResponseImpl>
    implements _$$UserProfileResponseImplCopyWith<$Res> {
  __$$UserProfileResponseImplCopyWithImpl(
    _$UserProfileResponseImpl _value,
    $Res Function(_$UserProfileResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? msg = null, Object? data = null}) {
    return _then(
      _$UserProfileResponseImpl(
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
                  as UserProfileModel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileResponseImpl implements _UserProfileResponse {
  const _$UserProfileResponseImpl({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory _$UserProfileResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileResponseImplFromJson(json);

  @override
  final int status;
  @override
  final String msg;
  @override
  final UserProfileModel data;

  @override
  String toString() {
    return 'UserProfileResponse(status: $status, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, msg, data);

  /// Create a copy of UserProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileResponseImplCopyWith<_$UserProfileResponseImpl> get copyWith =>
      __$$UserProfileResponseImplCopyWithImpl<_$UserProfileResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileResponseImplToJson(this);
  }
}

abstract class _UserProfileResponse implements UserProfileResponse {
  const factory _UserProfileResponse({
    required final int status,
    required final String msg,
    required final UserProfileModel data,
  }) = _$UserProfileResponseImpl;

  factory _UserProfileResponse.fromJson(Map<String, dynamic> json) =
      _$UserProfileResponseImpl.fromJson;

  @override
  int get status;
  @override
  String get msg;
  @override
  UserProfileModel get data;

  /// Create a copy of UserProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileResponseImplCopyWith<_$UserProfileResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) {
  return _UserProfileModel.fromJson(json);
}

/// @nodoc
mixin _$UserProfileModel {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String? get fullName => throw _privateConstructorUsedError;
  String? get mobile => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get dob => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  @JsonKey(name: 'blood_group')
  String? get bloodGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'marital_status')
  String? get maritalStatus => throw _privateConstructorUsedError;
  String? get religion => throw _privateConstructorUsedError;
  String? get nationality => throw _privateConstructorUsedError;
  @JsonKey(name: 'father_name')
  String? get fatherName => throw _privateConstructorUsedError;
  @JsonKey(name: 'emergency_name')
  String? get emergencyName => throw _privateConstructorUsedError;
  @JsonKey(name: 'emergency_contact')
  String? get emergencyContact => throw _privateConstructorUsedError;
  @JsonKey(name: 'physical_disability')
  String? get physicalDisability => throw _privateConstructorUsedError;
  @JsonKey(name: 't_shirt_size')
  String? get tShirtSize => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'trouser_size')
  String? get trouserSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'experience_status')
  String? get experienceStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_experience_year')
  String? get totalExperienceYear => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_experience_month')
  String? get totalExperienceMonth => throw _privateConstructorUsedError;
  @JsonKey(name: 'currently_employed')
  String? get currentlyEmployed => throw _privateConstructorUsedError;
  @JsonKey(name: 'application_status')
  String? get applicationStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_name')
  String? get companyName => throw _privateConstructorUsedError;
  @JsonKey(name: 'hrms_employee_code')
  String? get hrmsEmployeeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_contact_number')
  String? get employeeContactNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'vendor_employee_code')
  String? get vendorEmployeeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'vendor_name')
  String? get vendorName => throw _privateConstructorUsedError;
  String? get doj => throw _privateConstructorUsedError;
  String? get department => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_code')
  String? get storeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_location')
  String? get storeLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_city')
  String? get storeCity => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;
  @JsonKey(name: 'manager_email')
  String? get managerEmail => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'skill_set')
  String? get skillSet => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  @JsonKey(name: 'separation_date')
  String? get separationDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_working_date')
  String? get lastWorkingDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'separation_type')
  String? get separationType => throw _privateConstructorUsedError;
  @JsonKey(name: 'ol_generate')
  String? get olGenerate => throw _privateConstructorUsedError;
  @JsonKey(name: 'ol_generate_date')
  String? get olGenerateDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'send_ol_letter')
  String? get sendOlLetter => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'added_on')
  String? get addedOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_on')
  String? get updatedOn => throw _privateConstructorUsedError;
  bool? get attendance => throw _privateConstructorUsedError;
  @JsonKey(name: 'attend_type')
  String? get attendType => throw _privateConstructorUsedError;

  /// Serializes this UserProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileModelCopyWith<UserProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileModelCopyWith<$Res> {
  factory $UserProfileModelCopyWith(
    UserProfileModel value,
    $Res Function(UserProfileModel) then,
  ) = _$UserProfileModelCopyWithImpl<$Res, UserProfileModel>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'full_name') String? fullName,
    String? mobile,
    String? email,
    String? dob,
    String? photo,
    @JsonKey(name: 'blood_group') String? bloodGroup,
    @JsonKey(name: 'marital_status') String? maritalStatus,
    String? religion,
    String? nationality,
    @JsonKey(name: 'father_name') String? fatherName,
    @JsonKey(name: 'emergency_name') String? emergencyName,
    @JsonKey(name: 'emergency_contact') String? emergencyContact,
    @JsonKey(name: 'physical_disability') String? physicalDisability,
    @JsonKey(name: 't_shirt_size') String? tShirtSize,
    String? password,
    @JsonKey(name: 'trouser_size') String? trouserSize,
    @JsonKey(name: 'experience_status') String? experienceStatus,
    @JsonKey(name: 'total_experience_year') String? totalExperienceYear,
    @JsonKey(name: 'total_experience_month') String? totalExperienceMonth,
    @JsonKey(name: 'currently_employed') String? currentlyEmployed,
    @JsonKey(name: 'application_status') String? applicationStatus,
    @JsonKey(name: 'company_name') String? companyName,
    @JsonKey(name: 'hrms_employee_code') String? hrmsEmployeeCode,
    @JsonKey(name: 'employee_contact_number') String? employeeContactNumber,
    @JsonKey(name: 'vendor_employee_code') String? vendorEmployeeCode,
    @JsonKey(name: 'vendor_name') String? vendorName,
    String? doj,
    String? department,
    @JsonKey(name: 'store_code') String? storeCode,
    @JsonKey(name: 'store_location') String? storeLocation,
    @JsonKey(name: 'store_city') String? storeCity,
    String? designation,
    @JsonKey(name: 'manager_email') String? managerEmail,
    String? gender,
    @JsonKey(name: 'skill_set') String? skillSet,
    String? state,
    @JsonKey(name: 'separation_date') String? separationDate,
    @JsonKey(name: 'last_working_date') String? lastWorkingDate,
    @JsonKey(name: 'separation_type') String? separationType,
    @JsonKey(name: 'ol_generate') String? olGenerate,
    @JsonKey(name: 'ol_generate_date') String? olGenerateDate,
    @JsonKey(name: 'send_ol_letter') String? sendOlLetter,
    String? status,
    @JsonKey(name: 'added_on') String? addedOn,
    @JsonKey(name: 'updated_on') String? updatedOn,
    bool? attendance,
    @JsonKey(name: 'attend_type') String? attendType,
  });
}

/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res, $Val extends UserProfileModel>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = freezed,
    Object? mobile = freezed,
    Object? email = freezed,
    Object? dob = freezed,
    Object? photo = freezed,
    Object? bloodGroup = freezed,
    Object? maritalStatus = freezed,
    Object? religion = freezed,
    Object? nationality = freezed,
    Object? fatherName = freezed,
    Object? emergencyName = freezed,
    Object? emergencyContact = freezed,
    Object? physicalDisability = freezed,
    Object? tShirtSize = freezed,
    Object? password = freezed,
    Object? trouserSize = freezed,
    Object? experienceStatus = freezed,
    Object? totalExperienceYear = freezed,
    Object? totalExperienceMonth = freezed,
    Object? currentlyEmployed = freezed,
    Object? applicationStatus = freezed,
    Object? companyName = freezed,
    Object? hrmsEmployeeCode = freezed,
    Object? employeeContactNumber = freezed,
    Object? vendorEmployeeCode = freezed,
    Object? vendorName = freezed,
    Object? doj = freezed,
    Object? department = freezed,
    Object? storeCode = freezed,
    Object? storeLocation = freezed,
    Object? storeCity = freezed,
    Object? designation = freezed,
    Object? managerEmail = freezed,
    Object? gender = freezed,
    Object? skillSet = freezed,
    Object? state = freezed,
    Object? separationDate = freezed,
    Object? lastWorkingDate = freezed,
    Object? separationType = freezed,
    Object? olGenerate = freezed,
    Object? olGenerateDate = freezed,
    Object? sendOlLetter = freezed,
    Object? status = freezed,
    Object? addedOn = freezed,
    Object? updatedOn = freezed,
    Object? attendance = freezed,
    Object? attendType = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            fullName: freezed == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String?,
            mobile: freezed == mobile
                ? _value.mobile
                : mobile // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            dob: freezed == dob
                ? _value.dob
                : dob // ignore: cast_nullable_to_non_nullable
                      as String?,
            photo: freezed == photo
                ? _value.photo
                : photo // ignore: cast_nullable_to_non_nullable
                      as String?,
            bloodGroup: freezed == bloodGroup
                ? _value.bloodGroup
                : bloodGroup // ignore: cast_nullable_to_non_nullable
                      as String?,
            maritalStatus: freezed == maritalStatus
                ? _value.maritalStatus
                : maritalStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            religion: freezed == religion
                ? _value.religion
                : religion // ignore: cast_nullable_to_non_nullable
                      as String?,
            nationality: freezed == nationality
                ? _value.nationality
                : nationality // ignore: cast_nullable_to_non_nullable
                      as String?,
            fatherName: freezed == fatherName
                ? _value.fatherName
                : fatherName // ignore: cast_nullable_to_non_nullable
                      as String?,
            emergencyName: freezed == emergencyName
                ? _value.emergencyName
                : emergencyName // ignore: cast_nullable_to_non_nullable
                      as String?,
            emergencyContact: freezed == emergencyContact
                ? _value.emergencyContact
                : emergencyContact // ignore: cast_nullable_to_non_nullable
                      as String?,
            physicalDisability: freezed == physicalDisability
                ? _value.physicalDisability
                : physicalDisability // ignore: cast_nullable_to_non_nullable
                      as String?,
            tShirtSize: freezed == tShirtSize
                ? _value.tShirtSize
                : tShirtSize // ignore: cast_nullable_to_non_nullable
                      as String?,
            password: freezed == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String?,
            trouserSize: freezed == trouserSize
                ? _value.trouserSize
                : trouserSize // ignore: cast_nullable_to_non_nullable
                      as String?,
            experienceStatus: freezed == experienceStatus
                ? _value.experienceStatus
                : experienceStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalExperienceYear: freezed == totalExperienceYear
                ? _value.totalExperienceYear
                : totalExperienceYear // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalExperienceMonth: freezed == totalExperienceMonth
                ? _value.totalExperienceMonth
                : totalExperienceMonth // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentlyEmployed: freezed == currentlyEmployed
                ? _value.currentlyEmployed
                : currentlyEmployed // ignore: cast_nullable_to_non_nullable
                      as String?,
            applicationStatus: freezed == applicationStatus
                ? _value.applicationStatus
                : applicationStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            companyName: freezed == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String?,
            hrmsEmployeeCode: freezed == hrmsEmployeeCode
                ? _value.hrmsEmployeeCode
                : hrmsEmployeeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            employeeContactNumber: freezed == employeeContactNumber
                ? _value.employeeContactNumber
                : employeeContactNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            vendorEmployeeCode: freezed == vendorEmployeeCode
                ? _value.vendorEmployeeCode
                : vendorEmployeeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            vendorName: freezed == vendorName
                ? _value.vendorName
                : vendorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            doj: freezed == doj
                ? _value.doj
                : doj // ignore: cast_nullable_to_non_nullable
                      as String?,
            department: freezed == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeCode: freezed == storeCode
                ? _value.storeCode
                : storeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeLocation: freezed == storeLocation
                ? _value.storeLocation
                : storeLocation // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeCity: freezed == storeCity
                ? _value.storeCity
                : storeCity // ignore: cast_nullable_to_non_nullable
                      as String?,
            designation: freezed == designation
                ? _value.designation
                : designation // ignore: cast_nullable_to_non_nullable
                      as String?,
            managerEmail: freezed == managerEmail
                ? _value.managerEmail
                : managerEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String?,
            skillSet: freezed == skillSet
                ? _value.skillSet
                : skillSet // ignore: cast_nullable_to_non_nullable
                      as String?,
            state: freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String?,
            separationDate: freezed == separationDate
                ? _value.separationDate
                : separationDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastWorkingDate: freezed == lastWorkingDate
                ? _value.lastWorkingDate
                : lastWorkingDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            separationType: freezed == separationType
                ? _value.separationType
                : separationType // ignore: cast_nullable_to_non_nullable
                      as String?,
            olGenerate: freezed == olGenerate
                ? _value.olGenerate
                : olGenerate // ignore: cast_nullable_to_non_nullable
                      as String?,
            olGenerateDate: freezed == olGenerateDate
                ? _value.olGenerateDate
                : olGenerateDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            sendOlLetter: freezed == sendOlLetter
                ? _value.sendOlLetter
                : sendOlLetter // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            addedOn: freezed == addedOn
                ? _value.addedOn
                : addedOn // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedOn: freezed == updatedOn
                ? _value.updatedOn
                : updatedOn // ignore: cast_nullable_to_non_nullable
                      as String?,
            attendance: freezed == attendance
                ? _value.attendance
                : attendance // ignore: cast_nullable_to_non_nullable
                      as bool?,
            attendType: freezed == attendType
                ? _value.attendType
                : attendType // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileModelImplCopyWith<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  factory _$$UserProfileModelImplCopyWith(
    _$UserProfileModelImpl value,
    $Res Function(_$UserProfileModelImpl) then,
  ) = __$$UserProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'full_name') String? fullName,
    String? mobile,
    String? email,
    String? dob,
    String? photo,
    @JsonKey(name: 'blood_group') String? bloodGroup,
    @JsonKey(name: 'marital_status') String? maritalStatus,
    String? religion,
    String? nationality,
    @JsonKey(name: 'father_name') String? fatherName,
    @JsonKey(name: 'emergency_name') String? emergencyName,
    @JsonKey(name: 'emergency_contact') String? emergencyContact,
    @JsonKey(name: 'physical_disability') String? physicalDisability,
    @JsonKey(name: 't_shirt_size') String? tShirtSize,
    String? password,
    @JsonKey(name: 'trouser_size') String? trouserSize,
    @JsonKey(name: 'experience_status') String? experienceStatus,
    @JsonKey(name: 'total_experience_year') String? totalExperienceYear,
    @JsonKey(name: 'total_experience_month') String? totalExperienceMonth,
    @JsonKey(name: 'currently_employed') String? currentlyEmployed,
    @JsonKey(name: 'application_status') String? applicationStatus,
    @JsonKey(name: 'company_name') String? companyName,
    @JsonKey(name: 'hrms_employee_code') String? hrmsEmployeeCode,
    @JsonKey(name: 'employee_contact_number') String? employeeContactNumber,
    @JsonKey(name: 'vendor_employee_code') String? vendorEmployeeCode,
    @JsonKey(name: 'vendor_name') String? vendorName,
    String? doj,
    String? department,
    @JsonKey(name: 'store_code') String? storeCode,
    @JsonKey(name: 'store_location') String? storeLocation,
    @JsonKey(name: 'store_city') String? storeCity,
    String? designation,
    @JsonKey(name: 'manager_email') String? managerEmail,
    String? gender,
    @JsonKey(name: 'skill_set') String? skillSet,
    String? state,
    @JsonKey(name: 'separation_date') String? separationDate,
    @JsonKey(name: 'last_working_date') String? lastWorkingDate,
    @JsonKey(name: 'separation_type') String? separationType,
    @JsonKey(name: 'ol_generate') String? olGenerate,
    @JsonKey(name: 'ol_generate_date') String? olGenerateDate,
    @JsonKey(name: 'send_ol_letter') String? sendOlLetter,
    String? status,
    @JsonKey(name: 'added_on') String? addedOn,
    @JsonKey(name: 'updated_on') String? updatedOn,
    bool? attendance,
    @JsonKey(name: 'attend_type') String? attendType,
  });
}

/// @nodoc
class __$$UserProfileModelImplCopyWithImpl<$Res>
    extends _$UserProfileModelCopyWithImpl<$Res, _$UserProfileModelImpl>
    implements _$$UserProfileModelImplCopyWith<$Res> {
  __$$UserProfileModelImplCopyWithImpl(
    _$UserProfileModelImpl _value,
    $Res Function(_$UserProfileModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = freezed,
    Object? mobile = freezed,
    Object? email = freezed,
    Object? dob = freezed,
    Object? photo = freezed,
    Object? bloodGroup = freezed,
    Object? maritalStatus = freezed,
    Object? religion = freezed,
    Object? nationality = freezed,
    Object? fatherName = freezed,
    Object? emergencyName = freezed,
    Object? emergencyContact = freezed,
    Object? physicalDisability = freezed,
    Object? tShirtSize = freezed,
    Object? password = freezed,
    Object? trouserSize = freezed,
    Object? experienceStatus = freezed,
    Object? totalExperienceYear = freezed,
    Object? totalExperienceMonth = freezed,
    Object? currentlyEmployed = freezed,
    Object? applicationStatus = freezed,
    Object? companyName = freezed,
    Object? hrmsEmployeeCode = freezed,
    Object? employeeContactNumber = freezed,
    Object? vendorEmployeeCode = freezed,
    Object? vendorName = freezed,
    Object? doj = freezed,
    Object? department = freezed,
    Object? storeCode = freezed,
    Object? storeLocation = freezed,
    Object? storeCity = freezed,
    Object? designation = freezed,
    Object? managerEmail = freezed,
    Object? gender = freezed,
    Object? skillSet = freezed,
    Object? state = freezed,
    Object? separationDate = freezed,
    Object? lastWorkingDate = freezed,
    Object? separationType = freezed,
    Object? olGenerate = freezed,
    Object? olGenerateDate = freezed,
    Object? sendOlLetter = freezed,
    Object? status = freezed,
    Object? addedOn = freezed,
    Object? updatedOn = freezed,
    Object? attendance = freezed,
    Object? attendType = freezed,
  }) {
    return _then(
      _$UserProfileModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        fullName: freezed == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String?,
        mobile: freezed == mobile
            ? _value.mobile
            : mobile // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        dob: freezed == dob
            ? _value.dob
            : dob // ignore: cast_nullable_to_non_nullable
                  as String?,
        photo: freezed == photo
            ? _value.photo
            : photo // ignore: cast_nullable_to_non_nullable
                  as String?,
        bloodGroup: freezed == bloodGroup
            ? _value.bloodGroup
            : bloodGroup // ignore: cast_nullable_to_non_nullable
                  as String?,
        maritalStatus: freezed == maritalStatus
            ? _value.maritalStatus
            : maritalStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        religion: freezed == religion
            ? _value.religion
            : religion // ignore: cast_nullable_to_non_nullable
                  as String?,
        nationality: freezed == nationality
            ? _value.nationality
            : nationality // ignore: cast_nullable_to_non_nullable
                  as String?,
        fatherName: freezed == fatherName
            ? _value.fatherName
            : fatherName // ignore: cast_nullable_to_non_nullable
                  as String?,
        emergencyName: freezed == emergencyName
            ? _value.emergencyName
            : emergencyName // ignore: cast_nullable_to_non_nullable
                  as String?,
        emergencyContact: freezed == emergencyContact
            ? _value.emergencyContact
            : emergencyContact // ignore: cast_nullable_to_non_nullable
                  as String?,
        physicalDisability: freezed == physicalDisability
            ? _value.physicalDisability
            : physicalDisability // ignore: cast_nullable_to_non_nullable
                  as String?,
        tShirtSize: freezed == tShirtSize
            ? _value.tShirtSize
            : tShirtSize // ignore: cast_nullable_to_non_nullable
                  as String?,
        password: freezed == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String?,
        trouserSize: freezed == trouserSize
            ? _value.trouserSize
            : trouserSize // ignore: cast_nullable_to_non_nullable
                  as String?,
        experienceStatus: freezed == experienceStatus
            ? _value.experienceStatus
            : experienceStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalExperienceYear: freezed == totalExperienceYear
            ? _value.totalExperienceYear
            : totalExperienceYear // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalExperienceMonth: freezed == totalExperienceMonth
            ? _value.totalExperienceMonth
            : totalExperienceMonth // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentlyEmployed: freezed == currentlyEmployed
            ? _value.currentlyEmployed
            : currentlyEmployed // ignore: cast_nullable_to_non_nullable
                  as String?,
        applicationStatus: freezed == applicationStatus
            ? _value.applicationStatus
            : applicationStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        companyName: freezed == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String?,
        hrmsEmployeeCode: freezed == hrmsEmployeeCode
            ? _value.hrmsEmployeeCode
            : hrmsEmployeeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        employeeContactNumber: freezed == employeeContactNumber
            ? _value.employeeContactNumber
            : employeeContactNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        vendorEmployeeCode: freezed == vendorEmployeeCode
            ? _value.vendorEmployeeCode
            : vendorEmployeeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        vendorName: freezed == vendorName
            ? _value.vendorName
            : vendorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        doj: freezed == doj
            ? _value.doj
            : doj // ignore: cast_nullable_to_non_nullable
                  as String?,
        department: freezed == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeCode: freezed == storeCode
            ? _value.storeCode
            : storeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeLocation: freezed == storeLocation
            ? _value.storeLocation
            : storeLocation // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeCity: freezed == storeCity
            ? _value.storeCity
            : storeCity // ignore: cast_nullable_to_non_nullable
                  as String?,
        designation: freezed == designation
            ? _value.designation
            : designation // ignore: cast_nullable_to_non_nullable
                  as String?,
        managerEmail: freezed == managerEmail
            ? _value.managerEmail
            : managerEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String?,
        skillSet: freezed == skillSet
            ? _value.skillSet
            : skillSet // ignore: cast_nullable_to_non_nullable
                  as String?,
        state: freezed == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String?,
        separationDate: freezed == separationDate
            ? _value.separationDate
            : separationDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastWorkingDate: freezed == lastWorkingDate
            ? _value.lastWorkingDate
            : lastWorkingDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        separationType: freezed == separationType
            ? _value.separationType
            : separationType // ignore: cast_nullable_to_non_nullable
                  as String?,
        olGenerate: freezed == olGenerate
            ? _value.olGenerate
            : olGenerate // ignore: cast_nullable_to_non_nullable
                  as String?,
        olGenerateDate: freezed == olGenerateDate
            ? _value.olGenerateDate
            : olGenerateDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        sendOlLetter: freezed == sendOlLetter
            ? _value.sendOlLetter
            : sendOlLetter // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        addedOn: freezed == addedOn
            ? _value.addedOn
            : addedOn // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedOn: freezed == updatedOn
            ? _value.updatedOn
            : updatedOn // ignore: cast_nullable_to_non_nullable
                  as String?,
        attendance: freezed == attendance
            ? _value.attendance
            : attendance // ignore: cast_nullable_to_non_nullable
                  as bool?,
        attendType: freezed == attendType
            ? _value.attendType
            : attendType // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileModelImpl implements _UserProfileModel {
  const _$UserProfileModelImpl({
    this.id,
    @JsonKey(name: 'full_name') this.fullName,
    this.mobile,
    this.email,
    this.dob,
    this.photo,
    @JsonKey(name: 'blood_group') this.bloodGroup,
    @JsonKey(name: 'marital_status') this.maritalStatus,
    this.religion,
    this.nationality,
    @JsonKey(name: 'father_name') this.fatherName,
    @JsonKey(name: 'emergency_name') this.emergencyName,
    @JsonKey(name: 'emergency_contact') this.emergencyContact,
    @JsonKey(name: 'physical_disability') this.physicalDisability,
    @JsonKey(name: 't_shirt_size') this.tShirtSize,
    this.password,
    @JsonKey(name: 'trouser_size') this.trouserSize,
    @JsonKey(name: 'experience_status') this.experienceStatus,
    @JsonKey(name: 'total_experience_year') this.totalExperienceYear,
    @JsonKey(name: 'total_experience_month') this.totalExperienceMonth,
    @JsonKey(name: 'currently_employed') this.currentlyEmployed,
    @JsonKey(name: 'application_status') this.applicationStatus,
    @JsonKey(name: 'company_name') this.companyName,
    @JsonKey(name: 'hrms_employee_code') this.hrmsEmployeeCode,
    @JsonKey(name: 'employee_contact_number') this.employeeContactNumber,
    @JsonKey(name: 'vendor_employee_code') this.vendorEmployeeCode,
    @JsonKey(name: 'vendor_name') this.vendorName,
    this.doj,
    this.department,
    @JsonKey(name: 'store_code') this.storeCode,
    @JsonKey(name: 'store_location') this.storeLocation,
    @JsonKey(name: 'store_city') this.storeCity,
    this.designation,
    @JsonKey(name: 'manager_email') this.managerEmail,
    this.gender,
    @JsonKey(name: 'skill_set') this.skillSet,
    this.state,
    @JsonKey(name: 'separation_date') this.separationDate,
    @JsonKey(name: 'last_working_date') this.lastWorkingDate,
    @JsonKey(name: 'separation_type') this.separationType,
    @JsonKey(name: 'ol_generate') this.olGenerate,
    @JsonKey(name: 'ol_generate_date') this.olGenerateDate,
    @JsonKey(name: 'send_ol_letter') this.sendOlLetter,
    this.status,
    @JsonKey(name: 'added_on') this.addedOn,
    @JsonKey(name: 'updated_on') this.updatedOn,
    this.attendance = false,
    @JsonKey(name: 'attend_type') this.attendType,
  });

  factory _$UserProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileModelImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'full_name')
  final String? fullName;
  @override
  final String? mobile;
  @override
  final String? email;
  @override
  final String? dob;
  @override
  final String? photo;
  @override
  @JsonKey(name: 'blood_group')
  final String? bloodGroup;
  @override
  @JsonKey(name: 'marital_status')
  final String? maritalStatus;
  @override
  final String? religion;
  @override
  final String? nationality;
  @override
  @JsonKey(name: 'father_name')
  final String? fatherName;
  @override
  @JsonKey(name: 'emergency_name')
  final String? emergencyName;
  @override
  @JsonKey(name: 'emergency_contact')
  final String? emergencyContact;
  @override
  @JsonKey(name: 'physical_disability')
  final String? physicalDisability;
  @override
  @JsonKey(name: 't_shirt_size')
  final String? tShirtSize;
  @override
  final String? password;
  @override
  @JsonKey(name: 'trouser_size')
  final String? trouserSize;
  @override
  @JsonKey(name: 'experience_status')
  final String? experienceStatus;
  @override
  @JsonKey(name: 'total_experience_year')
  final String? totalExperienceYear;
  @override
  @JsonKey(name: 'total_experience_month')
  final String? totalExperienceMonth;
  @override
  @JsonKey(name: 'currently_employed')
  final String? currentlyEmployed;
  @override
  @JsonKey(name: 'application_status')
  final String? applicationStatus;
  @override
  @JsonKey(name: 'company_name')
  final String? companyName;
  @override
  @JsonKey(name: 'hrms_employee_code')
  final String? hrmsEmployeeCode;
  @override
  @JsonKey(name: 'employee_contact_number')
  final String? employeeContactNumber;
  @override
  @JsonKey(name: 'vendor_employee_code')
  final String? vendorEmployeeCode;
  @override
  @JsonKey(name: 'vendor_name')
  final String? vendorName;
  @override
  final String? doj;
  @override
  final String? department;
  @override
  @JsonKey(name: 'store_code')
  final String? storeCode;
  @override
  @JsonKey(name: 'store_location')
  final String? storeLocation;
  @override
  @JsonKey(name: 'store_city')
  final String? storeCity;
  @override
  final String? designation;
  @override
  @JsonKey(name: 'manager_email')
  final String? managerEmail;
  @override
  final String? gender;
  @override
  @JsonKey(name: 'skill_set')
  final String? skillSet;
  @override
  final String? state;
  @override
  @JsonKey(name: 'separation_date')
  final String? separationDate;
  @override
  @JsonKey(name: 'last_working_date')
  final String? lastWorkingDate;
  @override
  @JsonKey(name: 'separation_type')
  final String? separationType;
  @override
  @JsonKey(name: 'ol_generate')
  final String? olGenerate;
  @override
  @JsonKey(name: 'ol_generate_date')
  final String? olGenerateDate;
  @override
  @JsonKey(name: 'send_ol_letter')
  final String? sendOlLetter;
  @override
  final String? status;
  @override
  @JsonKey(name: 'added_on')
  final String? addedOn;
  @override
  @JsonKey(name: 'updated_on')
  final String? updatedOn;
  @override
  @JsonKey()
  final bool? attendance;
  @override
  @JsonKey(name: 'attend_type')
  final String? attendType;

  @override
  String toString() {
    return 'UserProfileModel(id: $id, fullName: $fullName, mobile: $mobile, email: $email, dob: $dob, photo: $photo, bloodGroup: $bloodGroup, maritalStatus: $maritalStatus, religion: $religion, nationality: $nationality, fatherName: $fatherName, emergencyName: $emergencyName, emergencyContact: $emergencyContact, physicalDisability: $physicalDisability, tShirtSize: $tShirtSize, password: $password, trouserSize: $trouserSize, experienceStatus: $experienceStatus, totalExperienceYear: $totalExperienceYear, totalExperienceMonth: $totalExperienceMonth, currentlyEmployed: $currentlyEmployed, applicationStatus: $applicationStatus, companyName: $companyName, hrmsEmployeeCode: $hrmsEmployeeCode, employeeContactNumber: $employeeContactNumber, vendorEmployeeCode: $vendorEmployeeCode, vendorName: $vendorName, doj: $doj, department: $department, storeCode: $storeCode, storeLocation: $storeLocation, storeCity: $storeCity, designation: $designation, managerEmail: $managerEmail, gender: $gender, skillSet: $skillSet, state: $state, separationDate: $separationDate, lastWorkingDate: $lastWorkingDate, separationType: $separationType, olGenerate: $olGenerate, olGenerateDate: $olGenerateDate, sendOlLetter: $sendOlLetter, status: $status, addedOn: $addedOn, updatedOn: $updatedOn, attendance: $attendance, attendType: $attendType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.bloodGroup, bloodGroup) ||
                other.bloodGroup == bloodGroup) &&
            (identical(other.maritalStatus, maritalStatus) ||
                other.maritalStatus == maritalStatus) &&
            (identical(other.religion, religion) ||
                other.religion == religion) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.fatherName, fatherName) ||
                other.fatherName == fatherName) &&
            (identical(other.emergencyName, emergencyName) ||
                other.emergencyName == emergencyName) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact) &&
            (identical(other.physicalDisability, physicalDisability) ||
                other.physicalDisability == physicalDisability) &&
            (identical(other.tShirtSize, tShirtSize) ||
                other.tShirtSize == tShirtSize) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.trouserSize, trouserSize) ||
                other.trouserSize == trouserSize) &&
            (identical(other.experienceStatus, experienceStatus) ||
                other.experienceStatus == experienceStatus) &&
            (identical(other.totalExperienceYear, totalExperienceYear) ||
                other.totalExperienceYear == totalExperienceYear) &&
            (identical(other.totalExperienceMonth, totalExperienceMonth) ||
                other.totalExperienceMonth == totalExperienceMonth) &&
            (identical(other.currentlyEmployed, currentlyEmployed) ||
                other.currentlyEmployed == currentlyEmployed) &&
            (identical(other.applicationStatus, applicationStatus) ||
                other.applicationStatus == applicationStatus) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.hrmsEmployeeCode, hrmsEmployeeCode) ||
                other.hrmsEmployeeCode == hrmsEmployeeCode) &&
            (identical(other.employeeContactNumber, employeeContactNumber) ||
                other.employeeContactNumber == employeeContactNumber) &&
            (identical(other.vendorEmployeeCode, vendorEmployeeCode) ||
                other.vendorEmployeeCode == vendorEmployeeCode) &&
            (identical(other.vendorName, vendorName) ||
                other.vendorName == vendorName) &&
            (identical(other.doj, doj) || other.doj == doj) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.storeCode, storeCode) ||
                other.storeCode == storeCode) &&
            (identical(other.storeLocation, storeLocation) ||
                other.storeLocation == storeLocation) &&
            (identical(other.storeCity, storeCity) ||
                other.storeCity == storeCity) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.managerEmail, managerEmail) ||
                other.managerEmail == managerEmail) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.skillSet, skillSet) ||
                other.skillSet == skillSet) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.separationDate, separationDate) ||
                other.separationDate == separationDate) &&
            (identical(other.lastWorkingDate, lastWorkingDate) ||
                other.lastWorkingDate == lastWorkingDate) &&
            (identical(other.separationType, separationType) ||
                other.separationType == separationType) &&
            (identical(other.olGenerate, olGenerate) ||
                other.olGenerate == olGenerate) &&
            (identical(other.olGenerateDate, olGenerateDate) ||
                other.olGenerateDate == olGenerateDate) &&
            (identical(other.sendOlLetter, sendOlLetter) ||
                other.sendOlLetter == sendOlLetter) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.addedOn, addedOn) || other.addedOn == addedOn) &&
            (identical(other.updatedOn, updatedOn) ||
                other.updatedOn == updatedOn) &&
            (identical(other.attendance, attendance) ||
                other.attendance == attendance) &&
            (identical(other.attendType, attendType) ||
                other.attendType == attendType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    fullName,
    mobile,
    email,
    dob,
    photo,
    bloodGroup,
    maritalStatus,
    religion,
    nationality,
    fatherName,
    emergencyName,
    emergencyContact,
    physicalDisability,
    tShirtSize,
    password,
    trouserSize,
    experienceStatus,
    totalExperienceYear,
    totalExperienceMonth,
    currentlyEmployed,
    applicationStatus,
    companyName,
    hrmsEmployeeCode,
    employeeContactNumber,
    vendorEmployeeCode,
    vendorName,
    doj,
    department,
    storeCode,
    storeLocation,
    storeCity,
    designation,
    managerEmail,
    gender,
    skillSet,
    state,
    separationDate,
    lastWorkingDate,
    separationType,
    olGenerate,
    olGenerateDate,
    sendOlLetter,
    status,
    addedOn,
    updatedOn,
    attendance,
    attendType,
  ]);

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      __$$UserProfileModelImplCopyWithImpl<_$UserProfileModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileModelImplToJson(this);
  }
}

abstract class _UserProfileModel implements UserProfileModel {
  const factory _UserProfileModel({
    final String? id,
    @JsonKey(name: 'full_name') final String? fullName,
    final String? mobile,
    final String? email,
    final String? dob,
    final String? photo,
    @JsonKey(name: 'blood_group') final String? bloodGroup,
    @JsonKey(name: 'marital_status') final String? maritalStatus,
    final String? religion,
    final String? nationality,
    @JsonKey(name: 'father_name') final String? fatherName,
    @JsonKey(name: 'emergency_name') final String? emergencyName,
    @JsonKey(name: 'emergency_contact') final String? emergencyContact,
    @JsonKey(name: 'physical_disability') final String? physicalDisability,
    @JsonKey(name: 't_shirt_size') final String? tShirtSize,
    final String? password,
    @JsonKey(name: 'trouser_size') final String? trouserSize,
    @JsonKey(name: 'experience_status') final String? experienceStatus,
    @JsonKey(name: 'total_experience_year') final String? totalExperienceYear,
    @JsonKey(name: 'total_experience_month') final String? totalExperienceMonth,
    @JsonKey(name: 'currently_employed') final String? currentlyEmployed,
    @JsonKey(name: 'application_status') final String? applicationStatus,
    @JsonKey(name: 'company_name') final String? companyName,
    @JsonKey(name: 'hrms_employee_code') final String? hrmsEmployeeCode,
    @JsonKey(name: 'employee_contact_number')
    final String? employeeContactNumber,
    @JsonKey(name: 'vendor_employee_code') final String? vendorEmployeeCode,
    @JsonKey(name: 'vendor_name') final String? vendorName,
    final String? doj,
    final String? department,
    @JsonKey(name: 'store_code') final String? storeCode,
    @JsonKey(name: 'store_location') final String? storeLocation,
    @JsonKey(name: 'store_city') final String? storeCity,
    final String? designation,
    @JsonKey(name: 'manager_email') final String? managerEmail,
    final String? gender,
    @JsonKey(name: 'skill_set') final String? skillSet,
    final String? state,
    @JsonKey(name: 'separation_date') final String? separationDate,
    @JsonKey(name: 'last_working_date') final String? lastWorkingDate,
    @JsonKey(name: 'separation_type') final String? separationType,
    @JsonKey(name: 'ol_generate') final String? olGenerate,
    @JsonKey(name: 'ol_generate_date') final String? olGenerateDate,
    @JsonKey(name: 'send_ol_letter') final String? sendOlLetter,
    final String? status,
    @JsonKey(name: 'added_on') final String? addedOn,
    @JsonKey(name: 'updated_on') final String? updatedOn,
    final bool? attendance,
    @JsonKey(name: 'attend_type') final String? attendType,
  }) = _$UserProfileModelImpl;

  factory _UserProfileModel.fromJson(Map<String, dynamic> json) =
      _$UserProfileModelImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'full_name')
  String? get fullName;
  @override
  String? get mobile;
  @override
  String? get email;
  @override
  String? get dob;
  @override
  String? get photo;
  @override
  @JsonKey(name: 'blood_group')
  String? get bloodGroup;
  @override
  @JsonKey(name: 'marital_status')
  String? get maritalStatus;
  @override
  String? get religion;
  @override
  String? get nationality;
  @override
  @JsonKey(name: 'father_name')
  String? get fatherName;
  @override
  @JsonKey(name: 'emergency_name')
  String? get emergencyName;
  @override
  @JsonKey(name: 'emergency_contact')
  String? get emergencyContact;
  @override
  @JsonKey(name: 'physical_disability')
  String? get physicalDisability;
  @override
  @JsonKey(name: 't_shirt_size')
  String? get tShirtSize;
  @override
  String? get password;
  @override
  @JsonKey(name: 'trouser_size')
  String? get trouserSize;
  @override
  @JsonKey(name: 'experience_status')
  String? get experienceStatus;
  @override
  @JsonKey(name: 'total_experience_year')
  String? get totalExperienceYear;
  @override
  @JsonKey(name: 'total_experience_month')
  String? get totalExperienceMonth;
  @override
  @JsonKey(name: 'currently_employed')
  String? get currentlyEmployed;
  @override
  @JsonKey(name: 'application_status')
  String? get applicationStatus;
  @override
  @JsonKey(name: 'company_name')
  String? get companyName;
  @override
  @JsonKey(name: 'hrms_employee_code')
  String? get hrmsEmployeeCode;
  @override
  @JsonKey(name: 'employee_contact_number')
  String? get employeeContactNumber;
  @override
  @JsonKey(name: 'vendor_employee_code')
  String? get vendorEmployeeCode;
  @override
  @JsonKey(name: 'vendor_name')
  String? get vendorName;
  @override
  String? get doj;
  @override
  String? get department;
  @override
  @JsonKey(name: 'store_code')
  String? get storeCode;
  @override
  @JsonKey(name: 'store_location')
  String? get storeLocation;
  @override
  @JsonKey(name: 'store_city')
  String? get storeCity;
  @override
  String? get designation;
  @override
  @JsonKey(name: 'manager_email')
  String? get managerEmail;
  @override
  String? get gender;
  @override
  @JsonKey(name: 'skill_set')
  String? get skillSet;
  @override
  String? get state;
  @override
  @JsonKey(name: 'separation_date')
  String? get separationDate;
  @override
  @JsonKey(name: 'last_working_date')
  String? get lastWorkingDate;
  @override
  @JsonKey(name: 'separation_type')
  String? get separationType;
  @override
  @JsonKey(name: 'ol_generate')
  String? get olGenerate;
  @override
  @JsonKey(name: 'ol_generate_date')
  String? get olGenerateDate;
  @override
  @JsonKey(name: 'send_ol_letter')
  String? get sendOlLetter;
  @override
  String? get status;
  @override
  @JsonKey(name: 'added_on')
  String? get addedOn;
  @override
  @JsonKey(name: 'updated_on')
  String? get updatedOn;
  @override
  bool? get attendance;
  @override
  @JsonKey(name: 'attend_type')
  String? get attendType;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
