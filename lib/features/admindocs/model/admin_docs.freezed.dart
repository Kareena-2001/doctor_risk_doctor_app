// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_docs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AdminDocsResponse _$AdminDocsResponseFromJson(Map<String, dynamic> json) {
  return _AdminDocsResponse.fromJson(json);
}

/// @nodoc
mixin _$AdminDocsResponse {
  int get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  List<AdminDocsData> get data => throw _privateConstructorUsedError;

  /// Serializes this AdminDocsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminDocsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminDocsResponseCopyWith<AdminDocsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminDocsResponseCopyWith<$Res> {
  factory $AdminDocsResponseCopyWith(
    AdminDocsResponse value,
    $Res Function(AdminDocsResponse) then,
  ) = _$AdminDocsResponseCopyWithImpl<$Res, AdminDocsResponse>;
  @useResult
  $Res call({int status, String msg, List<AdminDocsData> data});
}

/// @nodoc
class _$AdminDocsResponseCopyWithImpl<$Res, $Val extends AdminDocsResponse>
    implements $AdminDocsResponseCopyWith<$Res> {
  _$AdminDocsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminDocsResponse
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
                      as List<AdminDocsData>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminDocsResponseImplCopyWith<$Res>
    implements $AdminDocsResponseCopyWith<$Res> {
  factory _$$AdminDocsResponseImplCopyWith(
    _$AdminDocsResponseImpl value,
    $Res Function(_$AdminDocsResponseImpl) then,
  ) = __$$AdminDocsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String msg, List<AdminDocsData> data});
}

/// @nodoc
class __$$AdminDocsResponseImplCopyWithImpl<$Res>
    extends _$AdminDocsResponseCopyWithImpl<$Res, _$AdminDocsResponseImpl>
    implements _$$AdminDocsResponseImplCopyWith<$Res> {
  __$$AdminDocsResponseImplCopyWithImpl(
    _$AdminDocsResponseImpl _value,
    $Res Function(_$AdminDocsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminDocsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? msg = null, Object? data = null}) {
    return _then(
      _$AdminDocsResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        msg: null == msg
            ? _value.msg
            : msg // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<AdminDocsData>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminDocsResponseImpl implements _AdminDocsResponse {
  const _$AdminDocsResponseImpl({
    required this.status,
    required this.msg,
    required final List<AdminDocsData> data,
  }) : _data = data;

  factory _$AdminDocsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminDocsResponseImplFromJson(json);

  @override
  final int status;
  @override
  final String msg;
  final List<AdminDocsData> _data;
  @override
  List<AdminDocsData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'AdminDocsResponse(status: $status, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminDocsResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    msg,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of AdminDocsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminDocsResponseImplCopyWith<_$AdminDocsResponseImpl> get copyWith =>
      __$$AdminDocsResponseImplCopyWithImpl<_$AdminDocsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminDocsResponseImplToJson(this);
  }
}

abstract class _AdminDocsResponse implements AdminDocsResponse {
  const factory _AdminDocsResponse({
    required final int status,
    required final String msg,
    required final List<AdminDocsData> data,
  }) = _$AdminDocsResponseImpl;

  factory _AdminDocsResponse.fromJson(Map<String, dynamic> json) =
      _$AdminDocsResponseImpl.fromJson;

  @override
  int get status;
  @override
  String get msg;
  @override
  List<AdminDocsData> get data;

  /// Create a copy of AdminDocsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminDocsResponseImplCopyWith<_$AdminDocsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdminDocsData _$AdminDocsDataFromJson(Map<String, dynamic> json) {
  return _AdminDocsData.fromJson(json);
}

/// @nodoc
mixin _$AdminDocsData {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'letter_type')
  String get letterType => throw _privateConstructorUsedError;
  @JsonKey(name: 'file')
  String get fileUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_send_date')
  String get fileSendDate => throw _privateConstructorUsedError;

  /// Serializes this AdminDocsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminDocsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminDocsDataCopyWith<AdminDocsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminDocsDataCopyWith<$Res> {
  factory $AdminDocsDataCopyWith(
    AdminDocsData value,
    $Res Function(AdminDocsData) then,
  ) = _$AdminDocsDataCopyWithImpl<$Res, AdminDocsData>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'letter_type') String letterType,
    @JsonKey(name: 'file') String fileUrl,
    @JsonKey(name: 'file_send_date') String fileSendDate,
  });
}

/// @nodoc
class _$AdminDocsDataCopyWithImpl<$Res, $Val extends AdminDocsData>
    implements $AdminDocsDataCopyWith<$Res> {
  _$AdminDocsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminDocsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? letterType = null,
    Object? fileUrl = null,
    Object? fileSendDate = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            letterType: null == letterType
                ? _value.letterType
                : letterType // ignore: cast_nullable_to_non_nullable
                      as String,
            fileUrl: null == fileUrl
                ? _value.fileUrl
                : fileUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            fileSendDate: null == fileSendDate
                ? _value.fileSendDate
                : fileSendDate // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminDocsDataImplCopyWith<$Res>
    implements $AdminDocsDataCopyWith<$Res> {
  factory _$$AdminDocsDataImplCopyWith(
    _$AdminDocsDataImpl value,
    $Res Function(_$AdminDocsDataImpl) then,
  ) = __$$AdminDocsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'letter_type') String letterType,
    @JsonKey(name: 'file') String fileUrl,
    @JsonKey(name: 'file_send_date') String fileSendDate,
  });
}

/// @nodoc
class __$$AdminDocsDataImplCopyWithImpl<$Res>
    extends _$AdminDocsDataCopyWithImpl<$Res, _$AdminDocsDataImpl>
    implements _$$AdminDocsDataImplCopyWith<$Res> {
  __$$AdminDocsDataImplCopyWithImpl(
    _$AdminDocsDataImpl _value,
    $Res Function(_$AdminDocsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminDocsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? letterType = null,
    Object? fileUrl = null,
    Object? fileSendDate = null,
  }) {
    return _then(
      _$AdminDocsDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        letterType: null == letterType
            ? _value.letterType
            : letterType // ignore: cast_nullable_to_non_nullable
                  as String,
        fileUrl: null == fileUrl
            ? _value.fileUrl
            : fileUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        fileSendDate: null == fileSendDate
            ? _value.fileSendDate
            : fileSendDate // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminDocsDataImpl implements _AdminDocsData {
  const _$AdminDocsDataImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'letter_type') required this.letterType,
    @JsonKey(name: 'file') required this.fileUrl,
    @JsonKey(name: 'file_send_date') required this.fileSendDate,
  });

  factory _$AdminDocsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminDocsDataImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'letter_type')
  final String letterType;
  @override
  @JsonKey(name: 'file')
  final String fileUrl;
  @override
  @JsonKey(name: 'file_send_date')
  final String fileSendDate;

  @override
  String toString() {
    return 'AdminDocsData(id: $id, userId: $userId, letterType: $letterType, fileUrl: $fileUrl, fileSendDate: $fileSendDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminDocsDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.letterType, letterType) ||
                other.letterType == letterType) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.fileSendDate, fileSendDate) ||
                other.fileSendDate == fileSendDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, letterType, fileUrl, fileSendDate);

  /// Create a copy of AdminDocsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminDocsDataImplCopyWith<_$AdminDocsDataImpl> get copyWith =>
      __$$AdminDocsDataImplCopyWithImpl<_$AdminDocsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminDocsDataImplToJson(this);
  }
}

abstract class _AdminDocsData implements AdminDocsData {
  const factory _AdminDocsData({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'letter_type') required final String letterType,
    @JsonKey(name: 'file') required final String fileUrl,
    @JsonKey(name: 'file_send_date') required final String fileSendDate,
  }) = _$AdminDocsDataImpl;

  factory _AdminDocsData.fromJson(Map<String, dynamic> json) =
      _$AdminDocsDataImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'letter_type')
  String get letterType;
  @override
  @JsonKey(name: 'file')
  String get fileUrl;
  @override
  @JsonKey(name: 'file_send_date')
  String get fileSendDate;

  /// Create a copy of AdminDocsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminDocsDataImplCopyWith<_$AdminDocsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
