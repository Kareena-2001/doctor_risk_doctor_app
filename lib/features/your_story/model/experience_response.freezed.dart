// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'experience_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ExperienceResponse _$ExperienceResponseFromJson(Map<String, dynamic> json) {
  return _ExperienceResponse.fromJson(json);
}

/// @nodoc
mixin _$ExperienceResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  List<ExperienceData> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page')
  int get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;

  /// Serializes this ExperienceResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExperienceResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExperienceResponseCopyWith<ExperienceResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperienceResponseCopyWith<$Res> {
  factory $ExperienceResponseCopyWith(
    ExperienceResponse value,
    $Res Function(ExperienceResponse) then,
  ) = _$ExperienceResponseCopyWithImpl<$Res, ExperienceResponse>;
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<ExperienceData> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class _$ExperienceResponseCopyWithImpl<$Res, $Val extends ExperienceResponse>
    implements $ExperienceResponseCopyWith<$Res> {
  _$ExperienceResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExperienceResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? msg = null,
    Object? data = null,
    Object? total = null,
    Object? currentPage = null,
    Object? lastPage = null,
    Object? perPage = null,
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
                      as List<ExperienceData>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            lastPage: null == lastPage
                ? _value.lastPage
                : lastPage // ignore: cast_nullable_to_non_nullable
                      as int,
            perPage: null == perPage
                ? _value.perPage
                : perPage // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExperienceResponseImplCopyWith<$Res>
    implements $ExperienceResponseCopyWith<$Res> {
  factory _$$ExperienceResponseImplCopyWith(
    _$ExperienceResponseImpl value,
    $Res Function(_$ExperienceResponseImpl) then,
  ) = __$$ExperienceResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<ExperienceData> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class __$$ExperienceResponseImplCopyWithImpl<$Res>
    extends _$ExperienceResponseCopyWithImpl<$Res, _$ExperienceResponseImpl>
    implements _$$ExperienceResponseImplCopyWith<$Res> {
  __$$ExperienceResponseImplCopyWithImpl(
    _$ExperienceResponseImpl _value,
    $Res Function(_$ExperienceResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExperienceResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? msg = null,
    Object? data = null,
    Object? total = null,
    Object? currentPage = null,
    Object? lastPage = null,
    Object? perPage = null,
  }) {
    return _then(
      _$ExperienceResponseImpl(
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
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<ExperienceData>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        lastPage: null == lastPage
            ? _value.lastPage
            : lastPage // ignore: cast_nullable_to_non_nullable
                  as int,
        perPage: null == perPage
            ? _value.perPage
            : perPage // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExperienceResponseImpl implements _ExperienceResponse {
  const _$ExperienceResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    final List<ExperienceData> data = const [],
    this.total = 0,
    @JsonKey(name: 'current_page') this.currentPage = 1,
    @JsonKey(name: 'last_page') this.lastPage = 1,
    @JsonKey(name: 'per_page') this.perPage = 10,
  }) : _data = data;

  factory _$ExperienceResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperienceResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  final List<ExperienceData> _data;
  @override
  @JsonKey()
  List<ExperienceData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey()
  final int total;
  @override
  @JsonKey(name: 'current_page')
  final int currentPage;
  @override
  @JsonKey(name: 'last_page')
  final int lastPage;
  @override
  @JsonKey(name: 'per_page')
  final int perPage;

  @override
  String toString() {
    return 'ExperienceResponse(status: $status, code: $code, msg: $msg, data: $data, total: $total, currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperienceResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    code,
    msg,
    const DeepCollectionEquality().hash(_data),
    total,
    currentPage,
    lastPage,
    perPage,
  );

  /// Create a copy of ExperienceResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExperienceResponseImplCopyWith<_$ExperienceResponseImpl> get copyWith =>
      __$$ExperienceResponseImplCopyWithImpl<_$ExperienceResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperienceResponseImplToJson(this);
  }
}

abstract class _ExperienceResponse implements ExperienceResponse {
  const factory _ExperienceResponse({
    required final bool status,
    required final int code,
    required final String msg,
    final List<ExperienceData> data,
    final int total,
    @JsonKey(name: 'current_page') final int currentPage,
    @JsonKey(name: 'last_page') final int lastPage,
    @JsonKey(name: 'per_page') final int perPage,
  }) = _$ExperienceResponseImpl;

  factory _ExperienceResponse.fromJson(Map<String, dynamic> json) =
      _$ExperienceResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  List<ExperienceData> get data;
  @override
  int get total;
  @override
  @JsonKey(name: 'current_page')
  int get currentPage;
  @override
  @JsonKey(name: 'last_page')
  int get lastPage;
  @override
  @JsonKey(name: 'per_page')
  int get perPage;

  /// Create a copy of ExperienceResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExperienceResponseImplCopyWith<_$ExperienceResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExperienceData _$ExperienceDataFromJson(Map<String, dynamic> json) {
  return _ExperienceData.fromJson(json);
}

/// @nodoc
mixin _$ExperienceData {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'experience_type')
  String get experienceType => throw _privateConstructorUsedError;
  String get details => throw _privateConstructorUsedError;
  String? get file => throw _privateConstructorUsedError;
  @JsonKey(name: 'dr_name')
  String? get drName => throw _privateConstructorUsedError;
  String? get degree => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'speciality_name')
  String? get specialityName => throw _privateConstructorUsedError;
  @JsonKey(name: 'i_agree_accepted')
  String? get iAgreeAccepted => throw _privateConstructorUsedError;
  @JsonKey(name: 'approve_status')
  String? get approveStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'approved_by')
  String? get approvedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'approve_date')
  String? get approveDate => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_on')
  String? get createdOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_on')
  String? get updatedOn => throw _privateConstructorUsedError;

  /// Serializes this ExperienceData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExperienceData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExperienceDataCopyWith<ExperienceData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperienceDataCopyWith<$Res> {
  factory $ExperienceDataCopyWith(
    ExperienceData value,
    $Res Function(ExperienceData) then,
  ) = _$ExperienceDataCopyWithImpl<$Res, ExperienceData>;
  @useResult
  $Res call({
    int id,
    String title,
    @JsonKey(name: 'experience_type') String experienceType,
    String details,
    String? file,
    @JsonKey(name: 'dr_name') String? drName,
    String? degree,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'speciality_name') String? specialityName,
    @JsonKey(name: 'i_agree_accepted') String? iAgreeAccepted,
    @JsonKey(name: 'approve_status') String? approveStatus,
    @JsonKey(name: 'approved_by') String? approvedBy,
    @JsonKey(name: 'approve_date') String? approveDate,
    String? status,
    @JsonKey(name: 'created_on') String? createdOn,
    @JsonKey(name: 'updated_on') String? updatedOn,
  });
}

/// @nodoc
class _$ExperienceDataCopyWithImpl<$Res, $Val extends ExperienceData>
    implements $ExperienceDataCopyWith<$Res> {
  _$ExperienceDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExperienceData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? experienceType = null,
    Object? details = null,
    Object? file = freezed,
    Object? drName = freezed,
    Object? degree = freezed,
    Object? categoryName = freezed,
    Object? specialityName = freezed,
    Object? iAgreeAccepted = freezed,
    Object? approveStatus = freezed,
    Object? approvedBy = freezed,
    Object? approveDate = freezed,
    Object? status = freezed,
    Object? createdOn = freezed,
    Object? updatedOn = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            experienceType: null == experienceType
                ? _value.experienceType
                : experienceType // ignore: cast_nullable_to_non_nullable
                      as String,
            details: null == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as String,
            file: freezed == file
                ? _value.file
                : file // ignore: cast_nullable_to_non_nullable
                      as String?,
            drName: freezed == drName
                ? _value.drName
                : drName // ignore: cast_nullable_to_non_nullable
                      as String?,
            degree: freezed == degree
                ? _value.degree
                : degree // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            specialityName: freezed == specialityName
                ? _value.specialityName
                : specialityName // ignore: cast_nullable_to_non_nullable
                      as String?,
            iAgreeAccepted: freezed == iAgreeAccepted
                ? _value.iAgreeAccepted
                : iAgreeAccepted // ignore: cast_nullable_to_non_nullable
                      as String?,
            approveStatus: freezed == approveStatus
                ? _value.approveStatus
                : approveStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            approvedBy: freezed == approvedBy
                ? _value.approvedBy
                : approvedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            approveDate: freezed == approveDate
                ? _value.approveDate
                : approveDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdOn: freezed == createdOn
                ? _value.createdOn
                : createdOn // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedOn: freezed == updatedOn
                ? _value.updatedOn
                : updatedOn // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExperienceDataImplCopyWith<$Res>
    implements $ExperienceDataCopyWith<$Res> {
  factory _$$ExperienceDataImplCopyWith(
    _$ExperienceDataImpl value,
    $Res Function(_$ExperienceDataImpl) then,
  ) = __$$ExperienceDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    @JsonKey(name: 'experience_type') String experienceType,
    String details,
    String? file,
    @JsonKey(name: 'dr_name') String? drName,
    String? degree,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'speciality_name') String? specialityName,
    @JsonKey(name: 'i_agree_accepted') String? iAgreeAccepted,
    @JsonKey(name: 'approve_status') String? approveStatus,
    @JsonKey(name: 'approved_by') String? approvedBy,
    @JsonKey(name: 'approve_date') String? approveDate,
    String? status,
    @JsonKey(name: 'created_on') String? createdOn,
    @JsonKey(name: 'updated_on') String? updatedOn,
  });
}

/// @nodoc
class __$$ExperienceDataImplCopyWithImpl<$Res>
    extends _$ExperienceDataCopyWithImpl<$Res, _$ExperienceDataImpl>
    implements _$$ExperienceDataImplCopyWith<$Res> {
  __$$ExperienceDataImplCopyWithImpl(
    _$ExperienceDataImpl _value,
    $Res Function(_$ExperienceDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExperienceData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? experienceType = null,
    Object? details = null,
    Object? file = freezed,
    Object? drName = freezed,
    Object? degree = freezed,
    Object? categoryName = freezed,
    Object? specialityName = freezed,
    Object? iAgreeAccepted = freezed,
    Object? approveStatus = freezed,
    Object? approvedBy = freezed,
    Object? approveDate = freezed,
    Object? status = freezed,
    Object? createdOn = freezed,
    Object? updatedOn = freezed,
  }) {
    return _then(
      _$ExperienceDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        experienceType: null == experienceType
            ? _value.experienceType
            : experienceType // ignore: cast_nullable_to_non_nullable
                  as String,
        details: null == details
            ? _value.details
            : details // ignore: cast_nullable_to_non_nullable
                  as String,
        file: freezed == file
            ? _value.file
            : file // ignore: cast_nullable_to_non_nullable
                  as String?,
        drName: freezed == drName
            ? _value.drName
            : drName // ignore: cast_nullable_to_non_nullable
                  as String?,
        degree: freezed == degree
            ? _value.degree
            : degree // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        specialityName: freezed == specialityName
            ? _value.specialityName
            : specialityName // ignore: cast_nullable_to_non_nullable
                  as String?,
        iAgreeAccepted: freezed == iAgreeAccepted
            ? _value.iAgreeAccepted
            : iAgreeAccepted // ignore: cast_nullable_to_non_nullable
                  as String?,
        approveStatus: freezed == approveStatus
            ? _value.approveStatus
            : approveStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        approvedBy: freezed == approvedBy
            ? _value.approvedBy
            : approvedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        approveDate: freezed == approveDate
            ? _value.approveDate
            : approveDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdOn: freezed == createdOn
            ? _value.createdOn
            : createdOn // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedOn: freezed == updatedOn
            ? _value.updatedOn
            : updatedOn // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExperienceDataImpl implements _ExperienceData {
  const _$ExperienceDataImpl({
    required this.id,
    this.title = '',
    @JsonKey(name: 'experience_type') this.experienceType = '',
    this.details = '',
    this.file,
    @JsonKey(name: 'dr_name') this.drName,
    this.degree,
    @JsonKey(name: 'category_name') this.categoryName,
    @JsonKey(name: 'speciality_name') this.specialityName,
    @JsonKey(name: 'i_agree_accepted') this.iAgreeAccepted,
    @JsonKey(name: 'approve_status') this.approveStatus,
    @JsonKey(name: 'approved_by') this.approvedBy,
    @JsonKey(name: 'approve_date') this.approveDate,
    this.status,
    @JsonKey(name: 'created_on') this.createdOn,
    @JsonKey(name: 'updated_on') this.updatedOn,
  });

  factory _$ExperienceDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperienceDataImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey(name: 'experience_type')
  final String experienceType;
  @override
  @JsonKey()
  final String details;
  @override
  final String? file;
  @override
  @JsonKey(name: 'dr_name')
  final String? drName;
  @override
  final String? degree;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'speciality_name')
  final String? specialityName;
  @override
  @JsonKey(name: 'i_agree_accepted')
  final String? iAgreeAccepted;
  @override
  @JsonKey(name: 'approve_status')
  final String? approveStatus;
  @override
  @JsonKey(name: 'approved_by')
  final String? approvedBy;
  @override
  @JsonKey(name: 'approve_date')
  final String? approveDate;
  @override
  final String? status;
  @override
  @JsonKey(name: 'created_on')
  final String? createdOn;
  @override
  @JsonKey(name: 'updated_on')
  final String? updatedOn;

  @override
  String toString() {
    return 'ExperienceData(id: $id, title: $title, experienceType: $experienceType, details: $details, file: $file, drName: $drName, degree: $degree, categoryName: $categoryName, specialityName: $specialityName, iAgreeAccepted: $iAgreeAccepted, approveStatus: $approveStatus, approvedBy: $approvedBy, approveDate: $approveDate, status: $status, createdOn: $createdOn, updatedOn: $updatedOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperienceDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.experienceType, experienceType) ||
                other.experienceType == experienceType) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.drName, drName) || other.drName == drName) &&
            (identical(other.degree, degree) || other.degree == degree) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.specialityName, specialityName) ||
                other.specialityName == specialityName) &&
            (identical(other.iAgreeAccepted, iAgreeAccepted) ||
                other.iAgreeAccepted == iAgreeAccepted) &&
            (identical(other.approveStatus, approveStatus) ||
                other.approveStatus == approveStatus) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approveDate, approveDate) ||
                other.approveDate == approveDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.updatedOn, updatedOn) ||
                other.updatedOn == updatedOn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    experienceType,
    details,
    file,
    drName,
    degree,
    categoryName,
    specialityName,
    iAgreeAccepted,
    approveStatus,
    approvedBy,
    approveDate,
    status,
    createdOn,
    updatedOn,
  );

  /// Create a copy of ExperienceData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExperienceDataImplCopyWith<_$ExperienceDataImpl> get copyWith =>
      __$$ExperienceDataImplCopyWithImpl<_$ExperienceDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperienceDataImplToJson(this);
  }
}

abstract class _ExperienceData implements ExperienceData {
  const factory _ExperienceData({
    required final int id,
    final String title,
    @JsonKey(name: 'experience_type') final String experienceType,
    final String details,
    final String? file,
    @JsonKey(name: 'dr_name') final String? drName,
    final String? degree,
    @JsonKey(name: 'category_name') final String? categoryName,
    @JsonKey(name: 'speciality_name') final String? specialityName,
    @JsonKey(name: 'i_agree_accepted') final String? iAgreeAccepted,
    @JsonKey(name: 'approve_status') final String? approveStatus,
    @JsonKey(name: 'approved_by') final String? approvedBy,
    @JsonKey(name: 'approve_date') final String? approveDate,
    final String? status,
    @JsonKey(name: 'created_on') final String? createdOn,
    @JsonKey(name: 'updated_on') final String? updatedOn,
  }) = _$ExperienceDataImpl;

  factory _ExperienceData.fromJson(Map<String, dynamic> json) =
      _$ExperienceDataImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  @JsonKey(name: 'experience_type')
  String get experienceType;
  @override
  String get details;
  @override
  String? get file;
  @override
  @JsonKey(name: 'dr_name')
  String? get drName;
  @override
  String? get degree;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'speciality_name')
  String? get specialityName;
  @override
  @JsonKey(name: 'i_agree_accepted')
  String? get iAgreeAccepted;
  @override
  @JsonKey(name: 'approve_status')
  String? get approveStatus;
  @override
  @JsonKey(name: 'approved_by')
  String? get approvedBy;
  @override
  @JsonKey(name: 'approve_date')
  String? get approveDate;
  @override
  String? get status;
  @override
  @JsonKey(name: 'created_on')
  String? get createdOn;
  @override
  @JsonKey(name: 'updated_on')
  String? get updatedOn;

  /// Create a copy of ExperienceData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExperienceDataImplCopyWith<_$ExperienceDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
