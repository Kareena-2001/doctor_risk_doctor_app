// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blog_submit_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BlogSubmitResponse _$BlogSubmitResponseFromJson(Map<String, dynamic> json) {
  return _BlogSubmitResponse.fromJson(json);
}

/// @nodoc
mixin _$BlogSubmitResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  BlogSubmitData get data => throw _privateConstructorUsedError;

  /// Serializes this BlogSubmitResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BlogSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlogSubmitResponseCopyWith<BlogSubmitResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlogSubmitResponseCopyWith<$Res> {
  factory $BlogSubmitResponseCopyWith(
    BlogSubmitResponse value,
    $Res Function(BlogSubmitResponse) then,
  ) = _$BlogSubmitResponseCopyWithImpl<$Res, BlogSubmitResponse>;
  @useResult
  $Res call({bool status, int code, String msg, BlogSubmitData data});

  $BlogSubmitDataCopyWith<$Res> get data;
}

/// @nodoc
class _$BlogSubmitResponseCopyWithImpl<$Res, $Val extends BlogSubmitResponse>
    implements $BlogSubmitResponseCopyWith<$Res> {
  _$BlogSubmitResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlogSubmitResponse
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
                      as BlogSubmitData,
          )
          as $Val,
    );
  }

  /// Create a copy of BlogSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BlogSubmitDataCopyWith<$Res> get data {
    return $BlogSubmitDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BlogSubmitResponseImplCopyWith<$Res>
    implements $BlogSubmitResponseCopyWith<$Res> {
  factory _$$BlogSubmitResponseImplCopyWith(
    _$BlogSubmitResponseImpl value,
    $Res Function(_$BlogSubmitResponseImpl) then,
  ) = __$$BlogSubmitResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, int code, String msg, BlogSubmitData data});

  @override
  $BlogSubmitDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$BlogSubmitResponseImplCopyWithImpl<$Res>
    extends _$BlogSubmitResponseCopyWithImpl<$Res, _$BlogSubmitResponseImpl>
    implements _$$BlogSubmitResponseImplCopyWith<$Res> {
  __$$BlogSubmitResponseImplCopyWithImpl(
    _$BlogSubmitResponseImpl _value,
    $Res Function(_$BlogSubmitResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BlogSubmitResponse
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
      _$BlogSubmitResponseImpl(
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
                  as BlogSubmitData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BlogSubmitResponseImpl implements _BlogSubmitResponse {
  const _$BlogSubmitResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory _$BlogSubmitResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlogSubmitResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  @override
  final BlogSubmitData data;

  @override
  String toString() {
    return 'BlogSubmitResponse(status: $status, code: $code, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlogSubmitResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, msg, data);

  /// Create a copy of BlogSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlogSubmitResponseImplCopyWith<_$BlogSubmitResponseImpl> get copyWith =>
      __$$BlogSubmitResponseImplCopyWithImpl<_$BlogSubmitResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BlogSubmitResponseImplToJson(this);
  }
}

abstract class _BlogSubmitResponse implements BlogSubmitResponse {
  const factory _BlogSubmitResponse({
    required final bool status,
    required final int code,
    required final String msg,
    required final BlogSubmitData data,
  }) = _$BlogSubmitResponseImpl;

  factory _BlogSubmitResponse.fromJson(Map<String, dynamic> json) =
      _$BlogSubmitResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  BlogSubmitData get data;

  /// Create a copy of BlogSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlogSubmitResponseImplCopyWith<_$BlogSubmitResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BlogSubmitData _$BlogSubmitDataFromJson(Map<String, dynamic> json) {
  return _BlogSubmitData.fromJson(json);
}

/// @nodoc
mixin _$BlogSubmitData {
  @JsonKey(name: 'blog_id')
  int get blogId => throw _privateConstructorUsedError;
  @JsonKey(name: 'approve_status')
  String get approveStatus => throw _privateConstructorUsedError;
  List<String> get keywords => throw _privateConstructorUsedError;

  /// Serializes this BlogSubmitData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BlogSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlogSubmitDataCopyWith<BlogSubmitData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlogSubmitDataCopyWith<$Res> {
  factory $BlogSubmitDataCopyWith(
    BlogSubmitData value,
    $Res Function(BlogSubmitData) then,
  ) = _$BlogSubmitDataCopyWithImpl<$Res, BlogSubmitData>;
  @useResult
  $Res call({
    @JsonKey(name: 'blog_id') int blogId,
    @JsonKey(name: 'approve_status') String approveStatus,
    List<String> keywords,
  });
}

/// @nodoc
class _$BlogSubmitDataCopyWithImpl<$Res, $Val extends BlogSubmitData>
    implements $BlogSubmitDataCopyWith<$Res> {
  _$BlogSubmitDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlogSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? blogId = null,
    Object? approveStatus = null,
    Object? keywords = null,
  }) {
    return _then(
      _value.copyWith(
            blogId: null == blogId
                ? _value.blogId
                : blogId // ignore: cast_nullable_to_non_nullable
                      as int,
            approveStatus: null == approveStatus
                ? _value.approveStatus
                : approveStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            keywords: null == keywords
                ? _value.keywords
                : keywords // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BlogSubmitDataImplCopyWith<$Res>
    implements $BlogSubmitDataCopyWith<$Res> {
  factory _$$BlogSubmitDataImplCopyWith(
    _$BlogSubmitDataImpl value,
    $Res Function(_$BlogSubmitDataImpl) then,
  ) = __$$BlogSubmitDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'blog_id') int blogId,
    @JsonKey(name: 'approve_status') String approveStatus,
    List<String> keywords,
  });
}

/// @nodoc
class __$$BlogSubmitDataImplCopyWithImpl<$Res>
    extends _$BlogSubmitDataCopyWithImpl<$Res, _$BlogSubmitDataImpl>
    implements _$$BlogSubmitDataImplCopyWith<$Res> {
  __$$BlogSubmitDataImplCopyWithImpl(
    _$BlogSubmitDataImpl _value,
    $Res Function(_$BlogSubmitDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BlogSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? blogId = null,
    Object? approveStatus = null,
    Object? keywords = null,
  }) {
    return _then(
      _$BlogSubmitDataImpl(
        blogId: null == blogId
            ? _value.blogId
            : blogId // ignore: cast_nullable_to_non_nullable
                  as int,
        approveStatus: null == approveStatus
            ? _value.approveStatus
            : approveStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        keywords: null == keywords
            ? _value._keywords
            : keywords // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BlogSubmitDataImpl implements _BlogSubmitData {
  const _$BlogSubmitDataImpl({
    @JsonKey(name: 'blog_id') required this.blogId,
    @JsonKey(name: 'approve_status') required this.approveStatus,
    required final List<String> keywords,
  }) : _keywords = keywords;

  factory _$BlogSubmitDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlogSubmitDataImplFromJson(json);

  @override
  @JsonKey(name: 'blog_id')
  final int blogId;
  @override
  @JsonKey(name: 'approve_status')
  final String approveStatus;
  final List<String> _keywords;
  @override
  List<String> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  @override
  String toString() {
    return 'BlogSubmitData(blogId: $blogId, approveStatus: $approveStatus, keywords: $keywords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlogSubmitDataImpl &&
            (identical(other.blogId, blogId) || other.blogId == blogId) &&
            (identical(other.approveStatus, approveStatus) ||
                other.approveStatus == approveStatus) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    blogId,
    approveStatus,
    const DeepCollectionEquality().hash(_keywords),
  );

  /// Create a copy of BlogSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlogSubmitDataImplCopyWith<_$BlogSubmitDataImpl> get copyWith =>
      __$$BlogSubmitDataImplCopyWithImpl<_$BlogSubmitDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BlogSubmitDataImplToJson(this);
  }
}

abstract class _BlogSubmitData implements BlogSubmitData {
  const factory _BlogSubmitData({
    @JsonKey(name: 'blog_id') required final int blogId,
    @JsonKey(name: 'approve_status') required final String approveStatus,
    required final List<String> keywords,
  }) = _$BlogSubmitDataImpl;

  factory _BlogSubmitData.fromJson(Map<String, dynamic> json) =
      _$BlogSubmitDataImpl.fromJson;

  @override
  @JsonKey(name: 'blog_id')
  int get blogId;
  @override
  @JsonKey(name: 'approve_status')
  String get approveStatus;
  @override
  List<String> get keywords;

  /// Create a copy of BlogSubmitData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlogSubmitDataImplCopyWith<_$BlogSubmitDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
