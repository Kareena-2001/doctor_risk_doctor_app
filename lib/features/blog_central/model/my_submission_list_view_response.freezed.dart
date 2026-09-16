// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_submission_list_view_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MySubmissionListViewResponse _$MySubmissionListViewResponseFromJson(
  Map<String, dynamic> json,
) {
  return _MySubmissionListViewResponse.fromJson(json);
}

/// @nodoc
mixin _$MySubmissionListViewResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  BlogData get data => throw _privateConstructorUsedError;

  /// Serializes this MySubmissionListViewResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MySubmissionListViewResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MySubmissionListViewResponseCopyWith<MySubmissionListViewResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MySubmissionListViewResponseCopyWith<$Res> {
  factory $MySubmissionListViewResponseCopyWith(
    MySubmissionListViewResponse value,
    $Res Function(MySubmissionListViewResponse) then,
  ) =
      _$MySubmissionListViewResponseCopyWithImpl<
        $Res,
        MySubmissionListViewResponse
      >;
  @useResult
  $Res call({bool status, int code, String msg, BlogData data});

  $BlogDataCopyWith<$Res> get data;
}

/// @nodoc
class _$MySubmissionListViewResponseCopyWithImpl<
  $Res,
  $Val extends MySubmissionListViewResponse
>
    implements $MySubmissionListViewResponseCopyWith<$Res> {
  _$MySubmissionListViewResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MySubmissionListViewResponse
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
                      as BlogData,
          )
          as $Val,
    );
  }

  /// Create a copy of MySubmissionListViewResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BlogDataCopyWith<$Res> get data {
    return $BlogDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MySubmissionListViewResponseImplCopyWith<$Res>
    implements $MySubmissionListViewResponseCopyWith<$Res> {
  factory _$$MySubmissionListViewResponseImplCopyWith(
    _$MySubmissionListViewResponseImpl value,
    $Res Function(_$MySubmissionListViewResponseImpl) then,
  ) = __$$MySubmissionListViewResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, int code, String msg, BlogData data});

  @override
  $BlogDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$MySubmissionListViewResponseImplCopyWithImpl<$Res>
    extends
        _$MySubmissionListViewResponseCopyWithImpl<
          $Res,
          _$MySubmissionListViewResponseImpl
        >
    implements _$$MySubmissionListViewResponseImplCopyWith<$Res> {
  __$$MySubmissionListViewResponseImplCopyWithImpl(
    _$MySubmissionListViewResponseImpl _value,
    $Res Function(_$MySubmissionListViewResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MySubmissionListViewResponse
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
      _$MySubmissionListViewResponseImpl(
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
                  as BlogData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MySubmissionListViewResponseImpl
    implements _MySubmissionListViewResponse {
  const _$MySubmissionListViewResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory _$MySubmissionListViewResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$MySubmissionListViewResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  @override
  final BlogData data;

  @override
  String toString() {
    return 'MySubmissionListViewResponse(status: $status, code: $code, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MySubmissionListViewResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, msg, data);

  /// Create a copy of MySubmissionListViewResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MySubmissionListViewResponseImplCopyWith<
    _$MySubmissionListViewResponseImpl
  >
  get copyWith =>
      __$$MySubmissionListViewResponseImplCopyWithImpl<
        _$MySubmissionListViewResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MySubmissionListViewResponseImplToJson(this);
  }
}

abstract class _MySubmissionListViewResponse
    implements MySubmissionListViewResponse {
  const factory _MySubmissionListViewResponse({
    required final bool status,
    required final int code,
    required final String msg,
    required final BlogData data,
  }) = _$MySubmissionListViewResponseImpl;

  factory _MySubmissionListViewResponse.fromJson(Map<String, dynamic> json) =
      _$MySubmissionListViewResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  BlogData get data;

  /// Create a copy of MySubmissionListViewResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MySubmissionListViewResponseImplCopyWith<
    _$MySubmissionListViewResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

BlogData _$BlogDataFromJson(Map<String, dynamic> json) {
  return _BlogData.fromJson(json);
}

/// @nodoc
mixin _$BlogData {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'i_agree_accepted')
  String? get iAgreeAccepted => throw _privateConstructorUsedError;
  List<String> get keywords => throw _privateConstructorUsedError;

  /// Serializes this BlogData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BlogData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlogDataCopyWith<BlogData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlogDataCopyWith<$Res> {
  factory $BlogDataCopyWith(BlogData value, $Res Function(BlogData) then) =
      _$BlogDataCopyWithImpl<$Res, BlogData>;
  @useResult
  $Res call({
    int id,
    String title,
    String description,
    String? image,
    @JsonKey(name: 'i_agree_accepted') String? iAgreeAccepted,
    List<String> keywords,
  });
}

/// @nodoc
class _$BlogDataCopyWithImpl<$Res, $Val extends BlogData>
    implements $BlogDataCopyWith<$Res> {
  _$BlogDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlogData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? image = freezed,
    Object? iAgreeAccepted = freezed,
    Object? keywords = null,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            iAgreeAccepted: freezed == iAgreeAccepted
                ? _value.iAgreeAccepted
                : iAgreeAccepted // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$BlogDataImplCopyWith<$Res>
    implements $BlogDataCopyWith<$Res> {
  factory _$$BlogDataImplCopyWith(
    _$BlogDataImpl value,
    $Res Function(_$BlogDataImpl) then,
  ) = __$$BlogDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    String description,
    String? image,
    @JsonKey(name: 'i_agree_accepted') String? iAgreeAccepted,
    List<String> keywords,
  });
}

/// @nodoc
class __$$BlogDataImplCopyWithImpl<$Res>
    extends _$BlogDataCopyWithImpl<$Res, _$BlogDataImpl>
    implements _$$BlogDataImplCopyWith<$Res> {
  __$$BlogDataImplCopyWithImpl(
    _$BlogDataImpl _value,
    $Res Function(_$BlogDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BlogData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? image = freezed,
    Object? iAgreeAccepted = freezed,
    Object? keywords = null,
  }) {
    return _then(
      _$BlogDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        iAgreeAccepted: freezed == iAgreeAccepted
            ? _value.iAgreeAccepted
            : iAgreeAccepted // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$BlogDataImpl implements _BlogData {
  const _$BlogDataImpl({
    required this.id,
    this.title = '',
    this.description = '',
    this.image,
    @JsonKey(name: 'i_agree_accepted') this.iAgreeAccepted,
    final List<String> keywords = const [],
  }) : _keywords = keywords;

  factory _$BlogDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlogDataImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  final String? image;
  @override
  @JsonKey(name: 'i_agree_accepted')
  final String? iAgreeAccepted;
  final List<String> _keywords;
  @override
  @JsonKey()
  List<String> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  @override
  String toString() {
    return 'BlogData(id: $id, title: $title, description: $description, image: $image, iAgreeAccepted: $iAgreeAccepted, keywords: $keywords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlogDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.iAgreeAccepted, iAgreeAccepted) ||
                other.iAgreeAccepted == iAgreeAccepted) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    image,
    iAgreeAccepted,
    const DeepCollectionEquality().hash(_keywords),
  );

  /// Create a copy of BlogData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlogDataImplCopyWith<_$BlogDataImpl> get copyWith =>
      __$$BlogDataImplCopyWithImpl<_$BlogDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BlogDataImplToJson(this);
  }
}

abstract class _BlogData implements BlogData {
  const factory _BlogData({
    required final int id,
    final String title,
    final String description,
    final String? image,
    @JsonKey(name: 'i_agree_accepted') final String? iAgreeAccepted,
    final List<String> keywords,
  }) = _$BlogDataImpl;

  factory _BlogData.fromJson(Map<String, dynamic> json) =
      _$BlogDataImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String? get image;
  @override
  @JsonKey(name: 'i_agree_accepted')
  String? get iAgreeAccepted;
  @override
  List<String> get keywords;

  /// Create a copy of BlogData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlogDataImplCopyWith<_$BlogDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
