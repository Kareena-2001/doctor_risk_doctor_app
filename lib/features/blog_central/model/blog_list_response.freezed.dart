// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blog_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BlogListResponse _$BlogListResponseFromJson(Map<String, dynamic> json) {
  return _BlogListResponse.fromJson(json);
}

/// @nodoc
mixin _$BlogListResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  List<BlogData> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page')
  int get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;

  /// Serializes this BlogListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BlogListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlogListResponseCopyWith<BlogListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlogListResponseCopyWith<$Res> {
  factory $BlogListResponseCopyWith(
    BlogListResponse value,
    $Res Function(BlogListResponse) then,
  ) = _$BlogListResponseCopyWithImpl<$Res, BlogListResponse>;
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<BlogData> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class _$BlogListResponseCopyWithImpl<$Res, $Val extends BlogListResponse>
    implements $BlogListResponseCopyWith<$Res> {
  _$BlogListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlogListResponse
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
                      as List<BlogData>,
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
abstract class _$$BlogListResponseImplCopyWith<$Res>
    implements $BlogListResponseCopyWith<$Res> {
  factory _$$BlogListResponseImplCopyWith(
    _$BlogListResponseImpl value,
    $Res Function(_$BlogListResponseImpl) then,
  ) = __$$BlogListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<BlogData> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class __$$BlogListResponseImplCopyWithImpl<$Res>
    extends _$BlogListResponseCopyWithImpl<$Res, _$BlogListResponseImpl>
    implements _$$BlogListResponseImplCopyWith<$Res> {
  __$$BlogListResponseImplCopyWithImpl(
    _$BlogListResponseImpl _value,
    $Res Function(_$BlogListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BlogListResponse
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
      _$BlogListResponseImpl(
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
                  as List<BlogData>,
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
class _$BlogListResponseImpl implements _BlogListResponse {
  const _$BlogListResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    required final List<BlogData> data,
    required this.total,
    @JsonKey(name: 'current_page') required this.currentPage,
    @JsonKey(name: 'last_page') required this.lastPage,
    @JsonKey(name: 'per_page') required this.perPage,
  }) : _data = data;

  factory _$BlogListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlogListResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  final List<BlogData> _data;
  @override
  List<BlogData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
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
    return 'BlogListResponse(status: $status, code: $code, msg: $msg, data: $data, total: $total, currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlogListResponseImpl &&
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

  /// Create a copy of BlogListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlogListResponseImplCopyWith<_$BlogListResponseImpl> get copyWith =>
      __$$BlogListResponseImplCopyWithImpl<_$BlogListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BlogListResponseImplToJson(this);
  }
}

abstract class _BlogListResponse implements BlogListResponse {
  const factory _BlogListResponse({
    required final bool status,
    required final int code,
    required final String msg,
    required final List<BlogData> data,
    required final int total,
    @JsonKey(name: 'current_page') required final int currentPage,
    @JsonKey(name: 'last_page') required final int lastPage,
    @JsonKey(name: 'per_page') required final int perPage,
  }) = _$BlogListResponseImpl;

  factory _BlogListResponse.fromJson(Map<String, dynamic> json) =
      _$BlogListResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  List<BlogData> get data;
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

  /// Create a copy of BlogListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlogListResponseImplCopyWith<_$BlogListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BlogData _$BlogDataFromJson(Map<String, dynamic> json) {
  return _BlogData.fromJson(json);
}

/// @nodoc
mixin _$BlogData {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'dr_name')
  String get drName => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'speciality_name')
  String get specialityName => throw _privateConstructorUsedError;
  String get degree => throw _privateConstructorUsedError;
  @JsonKey(name: 'view_count')
  String get viewCount => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
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
    @JsonKey(name: 'dr_name') String drName,
    @JsonKey(name: 'category_name') String categoryName,
    @JsonKey(name: 'speciality_name') String specialityName,
    String degree,
    @JsonKey(name: 'view_count') String viewCount,
    String? date,
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
    Object? drName = null,
    Object? categoryName = null,
    Object? specialityName = null,
    Object? degree = null,
    Object? viewCount = null,
    Object? date = freezed,
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
            drName: null == drName
                ? _value.drName
                : drName // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            specialityName: null == specialityName
                ? _value.specialityName
                : specialityName // ignore: cast_nullable_to_non_nullable
                      as String,
            degree: null == degree
                ? _value.degree
                : degree // ignore: cast_nullable_to_non_nullable
                      as String,
            viewCount: null == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as String,
            date: freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
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
    @JsonKey(name: 'dr_name') String drName,
    @JsonKey(name: 'category_name') String categoryName,
    @JsonKey(name: 'speciality_name') String specialityName,
    String degree,
    @JsonKey(name: 'view_count') String viewCount,
    String? date,
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
    Object? drName = null,
    Object? categoryName = null,
    Object? specialityName = null,
    Object? degree = null,
    Object? viewCount = null,
    Object? date = freezed,
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
        drName: null == drName
            ? _value.drName
            : drName // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        specialityName: null == specialityName
            ? _value.specialityName
            : specialityName // ignore: cast_nullable_to_non_nullable
                  as String,
        degree: null == degree
            ? _value.degree
            : degree // ignore: cast_nullable_to_non_nullable
                  as String,
        viewCount: null == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as String,
        date: freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
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
    required this.title,
    @JsonKey(name: 'dr_name') required this.drName,
    @JsonKey(name: 'category_name') required this.categoryName,
    @JsonKey(name: 'speciality_name') required this.specialityName,
    required this.degree,
    @JsonKey(name: 'view_count') required this.viewCount,
    required this.date,
    required final List<String> keywords,
  }) : _keywords = keywords;

  factory _$BlogDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlogDataImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  @JsonKey(name: 'dr_name')
  final String drName;
  @override
  @JsonKey(name: 'category_name')
  final String categoryName;
  @override
  @JsonKey(name: 'speciality_name')
  final String specialityName;
  @override
  final String degree;
  @override
  @JsonKey(name: 'view_count')
  final String viewCount;
  @override
  final String? date;
  final List<String> _keywords;
  @override
  List<String> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  @override
  String toString() {
    return 'BlogData(id: $id, title: $title, drName: $drName, categoryName: $categoryName, specialityName: $specialityName, degree: $degree, viewCount: $viewCount, date: $date, keywords: $keywords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlogDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.drName, drName) || other.drName == drName) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.specialityName, specialityName) ||
                other.specialityName == specialityName) &&
            (identical(other.degree, degree) || other.degree == degree) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    drName,
    categoryName,
    specialityName,
    degree,
    viewCount,
    date,
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
    required final String title,
    @JsonKey(name: 'dr_name') required final String drName,
    @JsonKey(name: 'category_name') required final String categoryName,
    @JsonKey(name: 'speciality_name') required final String specialityName,
    required final String degree,
    @JsonKey(name: 'view_count') required final String viewCount,
    required final String? date,
    required final List<String> keywords,
  }) = _$BlogDataImpl;

  factory _BlogData.fromJson(Map<String, dynamic> json) =
      _$BlogDataImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  @JsonKey(name: 'dr_name')
  String get drName;
  @override
  @JsonKey(name: 'category_name')
  String get categoryName;
  @override
  @JsonKey(name: 'speciality_name')
  String get specialityName;
  @override
  String get degree;
  @override
  @JsonKey(name: 'view_count')
  String get viewCount;
  @override
  String? get date;
  @override
  List<String> get keywords;

  /// Create a copy of BlogData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlogDataImplCopyWith<_$BlogDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
