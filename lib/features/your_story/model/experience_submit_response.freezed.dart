// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'experience_submit_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ExperienceSubmitResponse _$ExperienceSubmitResponseFromJson(
  Map<String, dynamic> json,
) {
  return _ExperienceSubmitResponse.fromJson(json);
}

/// @nodoc
mixin _$ExperienceSubmitResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  ExperienceSubmitData get data => throw _privateConstructorUsedError;

  /// Serializes this ExperienceSubmitResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExperienceSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExperienceSubmitResponseCopyWith<ExperienceSubmitResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperienceSubmitResponseCopyWith<$Res> {
  factory $ExperienceSubmitResponseCopyWith(
    ExperienceSubmitResponse value,
    $Res Function(ExperienceSubmitResponse) then,
  ) = _$ExperienceSubmitResponseCopyWithImpl<$Res, ExperienceSubmitResponse>;
  @useResult
  $Res call({bool status, int code, String msg, ExperienceSubmitData data});

  $ExperienceSubmitDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ExperienceSubmitResponseCopyWithImpl<
  $Res,
  $Val extends ExperienceSubmitResponse
>
    implements $ExperienceSubmitResponseCopyWith<$Res> {
  _$ExperienceSubmitResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExperienceSubmitResponse
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
                      as ExperienceSubmitData,
          )
          as $Val,
    );
  }

  /// Create a copy of ExperienceSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExperienceSubmitDataCopyWith<$Res> get data {
    return $ExperienceSubmitDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExperienceSubmitResponseImplCopyWith<$Res>
    implements $ExperienceSubmitResponseCopyWith<$Res> {
  factory _$$ExperienceSubmitResponseImplCopyWith(
    _$ExperienceSubmitResponseImpl value,
    $Res Function(_$ExperienceSubmitResponseImpl) then,
  ) = __$$ExperienceSubmitResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, int code, String msg, ExperienceSubmitData data});

  @override
  $ExperienceSubmitDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$ExperienceSubmitResponseImplCopyWithImpl<$Res>
    extends
        _$ExperienceSubmitResponseCopyWithImpl<
          $Res,
          _$ExperienceSubmitResponseImpl
        >
    implements _$$ExperienceSubmitResponseImplCopyWith<$Res> {
  __$$ExperienceSubmitResponseImplCopyWithImpl(
    _$ExperienceSubmitResponseImpl _value,
    $Res Function(_$ExperienceSubmitResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExperienceSubmitResponse
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
      _$ExperienceSubmitResponseImpl(
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
                  as ExperienceSubmitData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExperienceSubmitResponseImpl implements _ExperienceSubmitResponse {
  const _$ExperienceSubmitResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory _$ExperienceSubmitResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperienceSubmitResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  @override
  final ExperienceSubmitData data;

  @override
  String toString() {
    return 'ExperienceSubmitResponse(status: $status, code: $code, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperienceSubmitResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, msg, data);

  /// Create a copy of ExperienceSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExperienceSubmitResponseImplCopyWith<_$ExperienceSubmitResponseImpl>
  get copyWith =>
      __$$ExperienceSubmitResponseImplCopyWithImpl<
        _$ExperienceSubmitResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperienceSubmitResponseImplToJson(this);
  }
}

abstract class _ExperienceSubmitResponse implements ExperienceSubmitResponse {
  const factory _ExperienceSubmitResponse({
    required final bool status,
    required final int code,
    required final String msg,
    required final ExperienceSubmitData data,
  }) = _$ExperienceSubmitResponseImpl;

  factory _ExperienceSubmitResponse.fromJson(Map<String, dynamic> json) =
      _$ExperienceSubmitResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  ExperienceSubmitData get data;

  /// Create a copy of ExperienceSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExperienceSubmitResponseImplCopyWith<_$ExperienceSubmitResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ExperienceSubmitData _$ExperienceSubmitDataFromJson(Map<String, dynamic> json) {
  return _ExperienceSubmitData.fromJson(json);
}

/// @nodoc
mixin _$ExperienceSubmitData {
  @JsonKey(name: 'experience_id')
  int get experienceId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'experience_type')
  String get experienceType => throw _privateConstructorUsedError;
  String get details => throw _privateConstructorUsedError;
  String? get file => throw _privateConstructorUsedError;
  @JsonKey(name: 'approve_status')
  String? get approveStatus => throw _privateConstructorUsedError;

  /// Serializes this ExperienceSubmitData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExperienceSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExperienceSubmitDataCopyWith<ExperienceSubmitData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperienceSubmitDataCopyWith<$Res> {
  factory $ExperienceSubmitDataCopyWith(
    ExperienceSubmitData value,
    $Res Function(ExperienceSubmitData) then,
  ) = _$ExperienceSubmitDataCopyWithImpl<$Res, ExperienceSubmitData>;
  @useResult
  $Res call({
    @JsonKey(name: 'experience_id') int experienceId,
    String title,
    @JsonKey(name: 'experience_type') String experienceType,
    String details,
    String? file,
    @JsonKey(name: 'approve_status') String? approveStatus,
  });
}

/// @nodoc
class _$ExperienceSubmitDataCopyWithImpl<
  $Res,
  $Val extends ExperienceSubmitData
>
    implements $ExperienceSubmitDataCopyWith<$Res> {
  _$ExperienceSubmitDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExperienceSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? experienceId = null,
    Object? title = null,
    Object? experienceType = null,
    Object? details = null,
    Object? file = freezed,
    Object? approveStatus = freezed,
  }) {
    return _then(
      _value.copyWith(
            experienceId: null == experienceId
                ? _value.experienceId
                : experienceId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ExperienceSubmitDataImplCopyWith<$Res>
    implements $ExperienceSubmitDataCopyWith<$Res> {
  factory _$$ExperienceSubmitDataImplCopyWith(
    _$ExperienceSubmitDataImpl value,
    $Res Function(_$ExperienceSubmitDataImpl) then,
  ) = __$$ExperienceSubmitDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'experience_id') int experienceId,
    String title,
    @JsonKey(name: 'experience_type') String experienceType,
    String details,
    String? file,
    @JsonKey(name: 'approve_status') String? approveStatus,
  });
}

/// @nodoc
class __$$ExperienceSubmitDataImplCopyWithImpl<$Res>
    extends _$ExperienceSubmitDataCopyWithImpl<$Res, _$ExperienceSubmitDataImpl>
    implements _$$ExperienceSubmitDataImplCopyWith<$Res> {
  __$$ExperienceSubmitDataImplCopyWithImpl(
    _$ExperienceSubmitDataImpl _value,
    $Res Function(_$ExperienceSubmitDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExperienceSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? experienceId = null,
    Object? title = null,
    Object? experienceType = null,
    Object? details = null,
    Object? file = freezed,
    Object? approveStatus = freezed,
  }) {
    return _then(
      _$ExperienceSubmitDataImpl(
        experienceId: null == experienceId
            ? _value.experienceId
            : experienceId // ignore: cast_nullable_to_non_nullable
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
class _$ExperienceSubmitDataImpl implements _ExperienceSubmitData {
  const _$ExperienceSubmitDataImpl({
    @JsonKey(name: 'experience_id') required this.experienceId,
    this.title = '',
    @JsonKey(name: 'experience_type') this.experienceType = '',
    this.details = '',
    this.file,
    @JsonKey(name: 'approve_status') this.approveStatus,
  });

  factory _$ExperienceSubmitDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperienceSubmitDataImplFromJson(json);

  @override
  @JsonKey(name: 'experience_id')
  final int experienceId;
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
  @JsonKey(name: 'approve_status')
  final String? approveStatus;

  @override
  String toString() {
    return 'ExperienceSubmitData(experienceId: $experienceId, title: $title, experienceType: $experienceType, details: $details, file: $file, approveStatus: $approveStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperienceSubmitDataImpl &&
            (identical(other.experienceId, experienceId) ||
                other.experienceId == experienceId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.experienceType, experienceType) ||
                other.experienceType == experienceType) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.approveStatus, approveStatus) ||
                other.approveStatus == approveStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    experienceId,
    title,
    experienceType,
    details,
    file,
    approveStatus,
  );

  /// Create a copy of ExperienceSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExperienceSubmitDataImplCopyWith<_$ExperienceSubmitDataImpl>
  get copyWith =>
      __$$ExperienceSubmitDataImplCopyWithImpl<_$ExperienceSubmitDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperienceSubmitDataImplToJson(this);
  }
}

abstract class _ExperienceSubmitData implements ExperienceSubmitData {
  const factory _ExperienceSubmitData({
    @JsonKey(name: 'experience_id') required final int experienceId,
    final String title,
    @JsonKey(name: 'experience_type') final String experienceType,
    final String details,
    final String? file,
    @JsonKey(name: 'approve_status') final String? approveStatus,
  }) = _$ExperienceSubmitDataImpl;

  factory _ExperienceSubmitData.fromJson(Map<String, dynamic> json) =
      _$ExperienceSubmitDataImpl.fromJson;

  @override
  @JsonKey(name: 'experience_id')
  int get experienceId;
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
  @JsonKey(name: 'approve_status')
  String? get approveStatus;

  /// Create a copy of ExperienceSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExperienceSubmitDataImplCopyWith<_$ExperienceSubmitDataImpl>
  get copyWith => throw _privateConstructorUsedError;
}
