// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'testimonial_submit_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TestimonialSubmitResponse _$TestimonialSubmitResponseFromJson(
  Map<String, dynamic> json,
) {
  return _TestimonialSubmitResponse.fromJson(json);
}

/// @nodoc
mixin _$TestimonialSubmitResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  TestimonialSubmitData get data => throw _privateConstructorUsedError;

  /// Serializes this TestimonialSubmitResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestimonialSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestimonialSubmitResponseCopyWith<TestimonialSubmitResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestimonialSubmitResponseCopyWith<$Res> {
  factory $TestimonialSubmitResponseCopyWith(
    TestimonialSubmitResponse value,
    $Res Function(TestimonialSubmitResponse) then,
  ) = _$TestimonialSubmitResponseCopyWithImpl<$Res, TestimonialSubmitResponse>;
  @useResult
  $Res call({bool status, int code, String msg, TestimonialSubmitData data});

  $TestimonialSubmitDataCopyWith<$Res> get data;
}

/// @nodoc
class _$TestimonialSubmitResponseCopyWithImpl<
  $Res,
  $Val extends TestimonialSubmitResponse
>
    implements $TestimonialSubmitResponseCopyWith<$Res> {
  _$TestimonialSubmitResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestimonialSubmitResponse
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
                      as TestimonialSubmitData,
          )
          as $Val,
    );
  }

  /// Create a copy of TestimonialSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TestimonialSubmitDataCopyWith<$Res> get data {
    return $TestimonialSubmitDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TestimonialSubmitResponseImplCopyWith<$Res>
    implements $TestimonialSubmitResponseCopyWith<$Res> {
  factory _$$TestimonialSubmitResponseImplCopyWith(
    _$TestimonialSubmitResponseImpl value,
    $Res Function(_$TestimonialSubmitResponseImpl) then,
  ) = __$$TestimonialSubmitResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, int code, String msg, TestimonialSubmitData data});

  @override
  $TestimonialSubmitDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$TestimonialSubmitResponseImplCopyWithImpl<$Res>
    extends
        _$TestimonialSubmitResponseCopyWithImpl<
          $Res,
          _$TestimonialSubmitResponseImpl
        >
    implements _$$TestimonialSubmitResponseImplCopyWith<$Res> {
  __$$TestimonialSubmitResponseImplCopyWithImpl(
    _$TestimonialSubmitResponseImpl _value,
    $Res Function(_$TestimonialSubmitResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TestimonialSubmitResponse
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
      _$TestimonialSubmitResponseImpl(
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
                  as TestimonialSubmitData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TestimonialSubmitResponseImpl implements _TestimonialSubmitResponse {
  const _$TestimonialSubmitResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory _$TestimonialSubmitResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestimonialSubmitResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  @override
  final TestimonialSubmitData data;

  @override
  String toString() {
    return 'TestimonialSubmitResponse(status: $status, code: $code, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestimonialSubmitResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, msg, data);

  /// Create a copy of TestimonialSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestimonialSubmitResponseImplCopyWith<_$TestimonialSubmitResponseImpl>
  get copyWith =>
      __$$TestimonialSubmitResponseImplCopyWithImpl<
        _$TestimonialSubmitResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestimonialSubmitResponseImplToJson(this);
  }
}

abstract class _TestimonialSubmitResponse implements TestimonialSubmitResponse {
  const factory _TestimonialSubmitResponse({
    required final bool status,
    required final int code,
    required final String msg,
    required final TestimonialSubmitData data,
  }) = _$TestimonialSubmitResponseImpl;

  factory _TestimonialSubmitResponse.fromJson(Map<String, dynamic> json) =
      _$TestimonialSubmitResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  TestimonialSubmitData get data;

  /// Create a copy of TestimonialSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestimonialSubmitResponseImplCopyWith<_$TestimonialSubmitResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TestimonialSubmitData _$TestimonialSubmitDataFromJson(
  Map<String, dynamic> json,
) {
  return _TestimonialSubmitData.fromJson(json);
}

/// @nodoc
mixin _$TestimonialSubmitData {
  @JsonKey(name: 'testimonial_id')
  int get testimonialId => throw _privateConstructorUsedError;
  @JsonKey(name: 'testimonial_type')
  String get testimonialType => throw _privateConstructorUsedError;
  String get details => throw _privateConstructorUsedError;
  String? get file => throw _privateConstructorUsedError;
  @JsonKey(name: 'approve_status')
  String? get approveStatus => throw _privateConstructorUsedError;

  /// Serializes this TestimonialSubmitData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestimonialSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestimonialSubmitDataCopyWith<TestimonialSubmitData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestimonialSubmitDataCopyWith<$Res> {
  factory $TestimonialSubmitDataCopyWith(
    TestimonialSubmitData value,
    $Res Function(TestimonialSubmitData) then,
  ) = _$TestimonialSubmitDataCopyWithImpl<$Res, TestimonialSubmitData>;
  @useResult
  $Res call({
    @JsonKey(name: 'testimonial_id') int testimonialId,
    @JsonKey(name: 'testimonial_type') String testimonialType,
    String details,
    String? file,
    @JsonKey(name: 'approve_status') String? approveStatus,
  });
}

/// @nodoc
class _$TestimonialSubmitDataCopyWithImpl<
  $Res,
  $Val extends TestimonialSubmitData
>
    implements $TestimonialSubmitDataCopyWith<$Res> {
  _$TestimonialSubmitDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestimonialSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testimonialId = null,
    Object? testimonialType = null,
    Object? details = null,
    Object? file = freezed,
    Object? approveStatus = freezed,
  }) {
    return _then(
      _value.copyWith(
            testimonialId: null == testimonialId
                ? _value.testimonialId
                : testimonialId // ignore: cast_nullable_to_non_nullable
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
            approveStatus: freezed == approveStatus
                ? _value.approveStatus
                : approveStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TestimonialSubmitDataImplCopyWith<$Res>
    implements $TestimonialSubmitDataCopyWith<$Res> {
  factory _$$TestimonialSubmitDataImplCopyWith(
    _$TestimonialSubmitDataImpl value,
    $Res Function(_$TestimonialSubmitDataImpl) then,
  ) = __$$TestimonialSubmitDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'testimonial_id') int testimonialId,
    @JsonKey(name: 'testimonial_type') String testimonialType,
    String details,
    String? file,
    @JsonKey(name: 'approve_status') String? approveStatus,
  });
}

/// @nodoc
class __$$TestimonialSubmitDataImplCopyWithImpl<$Res>
    extends
        _$TestimonialSubmitDataCopyWithImpl<$Res, _$TestimonialSubmitDataImpl>
    implements _$$TestimonialSubmitDataImplCopyWith<$Res> {
  __$$TestimonialSubmitDataImplCopyWithImpl(
    _$TestimonialSubmitDataImpl _value,
    $Res Function(_$TestimonialSubmitDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TestimonialSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testimonialId = null,
    Object? testimonialType = null,
    Object? details = null,
    Object? file = freezed,
    Object? approveStatus = freezed,
  }) {
    return _then(
      _$TestimonialSubmitDataImpl(
        testimonialId: null == testimonialId
            ? _value.testimonialId
            : testimonialId // ignore: cast_nullable_to_non_nullable
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
        approveStatus: freezed == approveStatus
            ? _value.approveStatus
            : approveStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TestimonialSubmitDataImpl implements _TestimonialSubmitData {
  const _$TestimonialSubmitDataImpl({
    @JsonKey(name: 'testimonial_id') required this.testimonialId,
    @JsonKey(name: 'testimonial_type') this.testimonialType = '',
    this.details = '',
    this.file,
    @JsonKey(name: 'approve_status') this.approveStatus,
  });

  factory _$TestimonialSubmitDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestimonialSubmitDataImplFromJson(json);

  @override
  @JsonKey(name: 'testimonial_id')
  final int testimonialId;
  @override
  @JsonKey(name: 'testimonial_type')
  final String testimonialType;
  @override
  @JsonKey()
  final String details;
  @override
  final String? file;
  @override
  @JsonKey(name: 'approve_status')
  final String? approveStatus;

  @override
  String toString() {
    return 'TestimonialSubmitData(testimonialId: $testimonialId, testimonialType: $testimonialType, details: $details, file: $file, approveStatus: $approveStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestimonialSubmitDataImpl &&
            (identical(other.testimonialId, testimonialId) ||
                other.testimonialId == testimonialId) &&
            (identical(other.testimonialType, testimonialType) ||
                other.testimonialType == testimonialType) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.approveStatus, approveStatus) ||
                other.approveStatus == approveStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    testimonialId,
    testimonialType,
    details,
    file,
    approveStatus,
  );

  /// Create a copy of TestimonialSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestimonialSubmitDataImplCopyWith<_$TestimonialSubmitDataImpl>
  get copyWith =>
      __$$TestimonialSubmitDataImplCopyWithImpl<_$TestimonialSubmitDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TestimonialSubmitDataImplToJson(this);
  }
}

abstract class _TestimonialSubmitData implements TestimonialSubmitData {
  const factory _TestimonialSubmitData({
    @JsonKey(name: 'testimonial_id') required final int testimonialId,
    @JsonKey(name: 'testimonial_type') final String testimonialType,
    final String details,
    final String? file,
    @JsonKey(name: 'approve_status') final String? approveStatus,
  }) = _$TestimonialSubmitDataImpl;

  factory _TestimonialSubmitData.fromJson(Map<String, dynamic> json) =
      _$TestimonialSubmitDataImpl.fromJson;

  @override
  @JsonKey(name: 'testimonial_id')
  int get testimonialId;
  @override
  @JsonKey(name: 'testimonial_type')
  String get testimonialType;
  @override
  String get details;
  @override
  String? get file;
  @override
  @JsonKey(name: 'approve_status')
  String? get approveStatus;

  /// Create a copy of TestimonialSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestimonialSubmitDataImplCopyWith<_$TestimonialSubmitDataImpl>
  get copyWith => throw _privateConstructorUsedError;
}
