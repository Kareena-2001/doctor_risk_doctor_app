// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'testimonial_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TestimonialResponse _$TestimonialResponseFromJson(Map<String, dynamic> json) {
  return _TestimonialResponse.fromJson(json);
}

/// @nodoc
mixin _$TestimonialResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  List<TestimonialData> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page')
  int get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;

  /// Serializes this TestimonialResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestimonialResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestimonialResponseCopyWith<TestimonialResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestimonialResponseCopyWith<$Res> {
  factory $TestimonialResponseCopyWith(
    TestimonialResponse value,
    $Res Function(TestimonialResponse) then,
  ) = _$TestimonialResponseCopyWithImpl<$Res, TestimonialResponse>;
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<TestimonialData> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class _$TestimonialResponseCopyWithImpl<$Res, $Val extends TestimonialResponse>
    implements $TestimonialResponseCopyWith<$Res> {
  _$TestimonialResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestimonialResponse
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
                      as List<TestimonialData>,
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
abstract class _$$TestimonialResponseImplCopyWith<$Res>
    implements $TestimonialResponseCopyWith<$Res> {
  factory _$$TestimonialResponseImplCopyWith(
    _$TestimonialResponseImpl value,
    $Res Function(_$TestimonialResponseImpl) then,
  ) = __$$TestimonialResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<TestimonialData> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class __$$TestimonialResponseImplCopyWithImpl<$Res>
    extends _$TestimonialResponseCopyWithImpl<$Res, _$TestimonialResponseImpl>
    implements _$$TestimonialResponseImplCopyWith<$Res> {
  __$$TestimonialResponseImplCopyWithImpl(
    _$TestimonialResponseImpl _value,
    $Res Function(_$TestimonialResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TestimonialResponse
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
      _$TestimonialResponseImpl(
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
                  as List<TestimonialData>,
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
class _$TestimonialResponseImpl implements _TestimonialResponse {
  const _$TestimonialResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    final List<TestimonialData> data = const [],
    this.total = 0,
    @JsonKey(name: 'current_page') this.currentPage = 1,
    @JsonKey(name: 'last_page') this.lastPage = 1,
    @JsonKey(name: 'per_page') this.perPage = 10,
  }) : _data = data;

  factory _$TestimonialResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestimonialResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  final List<TestimonialData> _data;
  @override
  @JsonKey()
  List<TestimonialData> get data {
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
    return 'TestimonialResponse(status: $status, code: $code, msg: $msg, data: $data, total: $total, currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestimonialResponseImpl &&
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

  /// Create a copy of TestimonialResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestimonialResponseImplCopyWith<_$TestimonialResponseImpl> get copyWith =>
      __$$TestimonialResponseImplCopyWithImpl<_$TestimonialResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TestimonialResponseImplToJson(this);
  }
}

abstract class _TestimonialResponse implements TestimonialResponse {
  const factory _TestimonialResponse({
    required final bool status,
    required final int code,
    required final String msg,
    final List<TestimonialData> data,
    final int total,
    @JsonKey(name: 'current_page') final int currentPage,
    @JsonKey(name: 'last_page') final int lastPage,
    @JsonKey(name: 'per_page') final int perPage,
  }) = _$TestimonialResponseImpl;

  factory _TestimonialResponse.fromJson(Map<String, dynamic> json) =
      _$TestimonialResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  List<TestimonialData> get data;
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

  /// Create a copy of TestimonialResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestimonialResponseImplCopyWith<_$TestimonialResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TestimonialData _$TestimonialDataFromJson(Map<String, dynamic> json) {
  return _TestimonialData.fromJson(json);
}

/// @nodoc
mixin _$TestimonialData {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'testimonial_type')
  String get testimonialType => throw _privateConstructorUsedError;
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

  /// Serializes this TestimonialData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestimonialData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestimonialDataCopyWith<TestimonialData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestimonialDataCopyWith<$Res> {
  factory $TestimonialDataCopyWith(
    TestimonialData value,
    $Res Function(TestimonialData) then,
  ) = _$TestimonialDataCopyWithImpl<$Res, TestimonialData>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'testimonial_type') String testimonialType,
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
class _$TestimonialDataCopyWithImpl<$Res, $Val extends TestimonialData>
    implements $TestimonialDataCopyWith<$Res> {
  _$TestimonialDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestimonialData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? testimonialType = null,
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
            testimonialType: null == testimonialType
                ? _value.testimonialType
                : testimonialType // ignore: cast_nullable_to_non_nullable
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
abstract class _$$TestimonialDataImplCopyWith<$Res>
    implements $TestimonialDataCopyWith<$Res> {
  factory _$$TestimonialDataImplCopyWith(
    _$TestimonialDataImpl value,
    $Res Function(_$TestimonialDataImpl) then,
  ) = __$$TestimonialDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'testimonial_type') String testimonialType,
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
class __$$TestimonialDataImplCopyWithImpl<$Res>
    extends _$TestimonialDataCopyWithImpl<$Res, _$TestimonialDataImpl>
    implements _$$TestimonialDataImplCopyWith<$Res> {
  __$$TestimonialDataImplCopyWithImpl(
    _$TestimonialDataImpl _value,
    $Res Function(_$TestimonialDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TestimonialData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? testimonialType = null,
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
      _$TestimonialDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        testimonialType: null == testimonialType
            ? _value.testimonialType
            : testimonialType // ignore: cast_nullable_to_non_nullable
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
class _$TestimonialDataImpl implements _TestimonialData {
  const _$TestimonialDataImpl({
    required this.id,
    @JsonKey(name: 'testimonial_type') this.testimonialType = '',
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

  factory _$TestimonialDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestimonialDataImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'testimonial_type')
  final String testimonialType;
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
    return 'TestimonialData(id: $id, testimonialType: $testimonialType, details: $details, file: $file, drName: $drName, degree: $degree, categoryName: $categoryName, specialityName: $specialityName, iAgreeAccepted: $iAgreeAccepted, approveStatus: $approveStatus, approvedBy: $approvedBy, approveDate: $approveDate, status: $status, createdOn: $createdOn, updatedOn: $updatedOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestimonialDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.testimonialType, testimonialType) ||
                other.testimonialType == testimonialType) &&
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
    testimonialType,
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

  /// Create a copy of TestimonialData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestimonialDataImplCopyWith<_$TestimonialDataImpl> get copyWith =>
      __$$TestimonialDataImplCopyWithImpl<_$TestimonialDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TestimonialDataImplToJson(this);
  }
}

abstract class _TestimonialData implements TestimonialData {
  const factory _TestimonialData({
    required final int id,
    @JsonKey(name: 'testimonial_type') final String testimonialType,
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
  }) = _$TestimonialDataImpl;

  factory _TestimonialData.fromJson(Map<String, dynamic> json) =
      _$TestimonialDataImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'testimonial_type')
  String get testimonialType;
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

  /// Create a copy of TestimonialData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestimonialDataImplCopyWith<_$TestimonialDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
