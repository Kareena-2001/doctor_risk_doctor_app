// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blog_list_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BlogListDetail _$BlogListDetailFromJson(Map<String, dynamic> json) {
  return _BlogListDetail.fromJson(json);
}

/// @nodoc
mixin _$BlogListDetail {
  bool? get status => throw _privateConstructorUsedError;
  int? get code => throw _privateConstructorUsedError;
  String? get msg => throw _privateConstructorUsedError;
  List<BlogData> get data => throw _privateConstructorUsedError;

  /// Serializes this BlogListDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BlogListDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlogListDetailCopyWith<BlogListDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlogListDetailCopyWith<$Res> {
  factory $BlogListDetailCopyWith(
    BlogListDetail value,
    $Res Function(BlogListDetail) then,
  ) = _$BlogListDetailCopyWithImpl<$Res, BlogListDetail>;
  @useResult
  $Res call({bool? status, int? code, String? msg, List<BlogData> data});
}

/// @nodoc
class _$BlogListDetailCopyWithImpl<$Res, $Val extends BlogListDetail>
    implements $BlogListDetailCopyWith<$Res> {
  _$BlogListDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlogListDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? code = freezed,
    Object? msg = freezed,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as bool?,
            code: freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as int?,
            msg: freezed == msg
                ? _value.msg
                : msg // ignore: cast_nullable_to_non_nullable
                      as String?,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<BlogData>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BlogListDetailImplCopyWith<$Res>
    implements $BlogListDetailCopyWith<$Res> {
  factory _$$BlogListDetailImplCopyWith(
    _$BlogListDetailImpl value,
    $Res Function(_$BlogListDetailImpl) then,
  ) = __$$BlogListDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? status, int? code, String? msg, List<BlogData> data});
}

/// @nodoc
class __$$BlogListDetailImplCopyWithImpl<$Res>
    extends _$BlogListDetailCopyWithImpl<$Res, _$BlogListDetailImpl>
    implements _$$BlogListDetailImplCopyWith<$Res> {
  __$$BlogListDetailImplCopyWithImpl(
    _$BlogListDetailImpl _value,
    $Res Function(_$BlogListDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BlogListDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? code = freezed,
    Object? msg = freezed,
    Object? data = null,
  }) {
    return _then(
      _$BlogListDetailImpl(
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as bool?,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as int?,
        msg: freezed == msg
            ? _value.msg
            : msg // ignore: cast_nullable_to_non_nullable
                  as String?,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<BlogData>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BlogListDetailImpl implements _BlogListDetail {
  const _$BlogListDetailImpl({
    this.status,
    this.code,
    this.msg,
    final List<BlogData> data = const [],
  }) : _data = data;

  factory _$BlogListDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlogListDetailImplFromJson(json);

  @override
  final bool? status;
  @override
  final int? code;
  @override
  final String? msg;
  final List<BlogData> _data;
  @override
  @JsonKey()
  List<BlogData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'BlogListDetail(status: $status, code: $code, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlogListDetailImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    code,
    msg,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of BlogListDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlogListDetailImplCopyWith<_$BlogListDetailImpl> get copyWith =>
      __$$BlogListDetailImplCopyWithImpl<_$BlogListDetailImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BlogListDetailImplToJson(this);
  }
}

abstract class _BlogListDetail implements BlogListDetail {
  const factory _BlogListDetail({
    final bool? status,
    final int? code,
    final String? msg,
    final List<BlogData> data,
  }) = _$BlogListDetailImpl;

  factory _BlogListDetail.fromJson(Map<String, dynamic> json) =
      _$BlogListDetailImpl.fromJson;

  @override
  bool? get status;
  @override
  int? get code;
  @override
  String? get msg;
  @override
  List<BlogData> get data;

  /// Create a copy of BlogListDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlogListDetailImplCopyWith<_$BlogListDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
  @JsonKey(name: 'dr_name')
  String? get drName => throw _privateConstructorUsedError;
  String? get degree => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  dynamic get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'speciality_id')
  dynamic get specialityId => throw _privateConstructorUsedError;
  @JsonKey(name: 'view_count')
  dynamic get viewCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_on')
  String? get createdOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'approve_date')
  String? get approveDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'speciality_name')
  String? get specialityName => throw _privateConstructorUsedError;
  List<KeywordData> get keywords => throw _privateConstructorUsedError;

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
    @JsonKey(name: 'dr_name') String? drName,
    String? degree,
    @JsonKey(name: 'category_id') dynamic categoryId,
    @JsonKey(name: 'speciality_id') dynamic specialityId,
    @JsonKey(name: 'view_count') dynamic viewCount,
    @JsonKey(name: 'created_on') String? createdOn,
    @JsonKey(name: 'approve_date') String? approveDate,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'speciality_name') String? specialityName,
    List<KeywordData> keywords,
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
    Object? drName = freezed,
    Object? degree = freezed,
    Object? categoryId = freezed,
    Object? specialityId = freezed,
    Object? viewCount = freezed,
    Object? createdOn = freezed,
    Object? approveDate = freezed,
    Object? categoryName = freezed,
    Object? specialityName = freezed,
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
            drName: freezed == drName
                ? _value.drName
                : drName // ignore: cast_nullable_to_non_nullable
                      as String?,
            degree: freezed == degree
                ? _value.degree
                : degree // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            specialityId: freezed == specialityId
                ? _value.specialityId
                : specialityId // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            viewCount: freezed == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            createdOn: freezed == createdOn
                ? _value.createdOn
                : createdOn // ignore: cast_nullable_to_non_nullable
                      as String?,
            approveDate: freezed == approveDate
                ? _value.approveDate
                : approveDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            specialityName: freezed == specialityName
                ? _value.specialityName
                : specialityName // ignore: cast_nullable_to_non_nullable
                      as String?,
            keywords: null == keywords
                ? _value.keywords
                : keywords // ignore: cast_nullable_to_non_nullable
                      as List<KeywordData>,
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
    @JsonKey(name: 'dr_name') String? drName,
    String? degree,
    @JsonKey(name: 'category_id') dynamic categoryId,
    @JsonKey(name: 'speciality_id') dynamic specialityId,
    @JsonKey(name: 'view_count') dynamic viewCount,
    @JsonKey(name: 'created_on') String? createdOn,
    @JsonKey(name: 'approve_date') String? approveDate,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'speciality_name') String? specialityName,
    List<KeywordData> keywords,
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
    Object? drName = freezed,
    Object? degree = freezed,
    Object? categoryId = freezed,
    Object? specialityId = freezed,
    Object? viewCount = freezed,
    Object? createdOn = freezed,
    Object? approveDate = freezed,
    Object? categoryName = freezed,
    Object? specialityName = freezed,
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
        drName: freezed == drName
            ? _value.drName
            : drName // ignore: cast_nullable_to_non_nullable
                  as String?,
        degree: freezed == degree
            ? _value.degree
            : degree // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        specialityId: freezed == specialityId
            ? _value.specialityId
            : specialityId // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        viewCount: freezed == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        createdOn: freezed == createdOn
            ? _value.createdOn
            : createdOn // ignore: cast_nullable_to_non_nullable
                  as String?,
        approveDate: freezed == approveDate
            ? _value.approveDate
            : approveDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        specialityName: freezed == specialityName
            ? _value.specialityName
            : specialityName // ignore: cast_nullable_to_non_nullable
                  as String?,
        keywords: null == keywords
            ? _value._keywords
            : keywords // ignore: cast_nullable_to_non_nullable
                  as List<KeywordData>,
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
    @JsonKey(name: 'dr_name') this.drName,
    this.degree,
    @JsonKey(name: 'category_id') this.categoryId,
    @JsonKey(name: 'speciality_id') this.specialityId,
    @JsonKey(name: 'view_count') this.viewCount,
    @JsonKey(name: 'created_on') this.createdOn,
    @JsonKey(name: 'approve_date') this.approveDate,
    @JsonKey(name: 'category_name') this.categoryName,
    @JsonKey(name: 'speciality_name') this.specialityName,
    final List<KeywordData> keywords = const [],
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
  @JsonKey(name: 'dr_name')
  final String? drName;
  @override
  final String? degree;
  @override
  @JsonKey(name: 'category_id')
  final dynamic categoryId;
  @override
  @JsonKey(name: 'speciality_id')
  final dynamic specialityId;
  @override
  @JsonKey(name: 'view_count')
  final dynamic viewCount;
  @override
  @JsonKey(name: 'created_on')
  final String? createdOn;
  @override
  @JsonKey(name: 'approve_date')
  final String? approveDate;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'speciality_name')
  final String? specialityName;
  final List<KeywordData> _keywords;
  @override
  @JsonKey()
  List<KeywordData> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  @override
  String toString() {
    return 'BlogData(id: $id, title: $title, description: $description, image: $image, drName: $drName, degree: $degree, categoryId: $categoryId, specialityId: $specialityId, viewCount: $viewCount, createdOn: $createdOn, approveDate: $approveDate, categoryName: $categoryName, specialityName: $specialityName, keywords: $keywords)';
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
            (identical(other.drName, drName) || other.drName == drName) &&
            (identical(other.degree, degree) || other.degree == degree) &&
            const DeepCollectionEquality().equals(
              other.categoryId,
              categoryId,
            ) &&
            const DeepCollectionEquality().equals(
              other.specialityId,
              specialityId,
            ) &&
            const DeepCollectionEquality().equals(other.viewCount, viewCount) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.approveDate, approveDate) ||
                other.approveDate == approveDate) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.specialityName, specialityName) ||
                other.specialityName == specialityName) &&
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
    drName,
    degree,
    const DeepCollectionEquality().hash(categoryId),
    const DeepCollectionEquality().hash(specialityId),
    const DeepCollectionEquality().hash(viewCount),
    createdOn,
    approveDate,
    categoryName,
    specialityName,
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
    @JsonKey(name: 'dr_name') final String? drName,
    final String? degree,
    @JsonKey(name: 'category_id') final dynamic categoryId,
    @JsonKey(name: 'speciality_id') final dynamic specialityId,
    @JsonKey(name: 'view_count') final dynamic viewCount,
    @JsonKey(name: 'created_on') final String? createdOn,
    @JsonKey(name: 'approve_date') final String? approveDate,
    @JsonKey(name: 'category_name') final String? categoryName,
    @JsonKey(name: 'speciality_name') final String? specialityName,
    final List<KeywordData> keywords,
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
  @JsonKey(name: 'dr_name')
  String? get drName;
  @override
  String? get degree;
  @override
  @JsonKey(name: 'category_id')
  dynamic get categoryId;
  @override
  @JsonKey(name: 'speciality_id')
  dynamic get specialityId;
  @override
  @JsonKey(name: 'view_count')
  dynamic get viewCount;
  @override
  @JsonKey(name: 'created_on')
  String? get createdOn;
  @override
  @JsonKey(name: 'approve_date')
  String? get approveDate;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'speciality_name')
  String? get specialityName;
  @override
  List<KeywordData> get keywords;

  /// Create a copy of BlogData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlogDataImplCopyWith<_$BlogDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KeywordData _$KeywordDataFromJson(Map<String, dynamic> json) {
  return _KeywordData.fromJson(json);
}

/// @nodoc
mixin _$KeywordData {
  @JsonKey(name: 'blog_id')
  int? get blogId => throw _privateConstructorUsedError;
  String get keyword => throw _privateConstructorUsedError;

  /// Serializes this KeywordData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KeywordData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeywordDataCopyWith<KeywordData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeywordDataCopyWith<$Res> {
  factory $KeywordDataCopyWith(
    KeywordData value,
    $Res Function(KeywordData) then,
  ) = _$KeywordDataCopyWithImpl<$Res, KeywordData>;
  @useResult
  $Res call({@JsonKey(name: 'blog_id') int? blogId, String keyword});
}

/// @nodoc
class _$KeywordDataCopyWithImpl<$Res, $Val extends KeywordData>
    implements $KeywordDataCopyWith<$Res> {
  _$KeywordDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeywordData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? blogId = freezed, Object? keyword = null}) {
    return _then(
      _value.copyWith(
            blogId: freezed == blogId
                ? _value.blogId
                : blogId // ignore: cast_nullable_to_non_nullable
                      as int?,
            keyword: null == keyword
                ? _value.keyword
                : keyword // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KeywordDataImplCopyWith<$Res>
    implements $KeywordDataCopyWith<$Res> {
  factory _$$KeywordDataImplCopyWith(
    _$KeywordDataImpl value,
    $Res Function(_$KeywordDataImpl) then,
  ) = __$$KeywordDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'blog_id') int? blogId, String keyword});
}

/// @nodoc
class __$$KeywordDataImplCopyWithImpl<$Res>
    extends _$KeywordDataCopyWithImpl<$Res, _$KeywordDataImpl>
    implements _$$KeywordDataImplCopyWith<$Res> {
  __$$KeywordDataImplCopyWithImpl(
    _$KeywordDataImpl _value,
    $Res Function(_$KeywordDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KeywordData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? blogId = freezed, Object? keyword = null}) {
    return _then(
      _$KeywordDataImpl(
        blogId: freezed == blogId
            ? _value.blogId
            : blogId // ignore: cast_nullable_to_non_nullable
                  as int?,
        keyword: null == keyword
            ? _value.keyword
            : keyword // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$KeywordDataImpl implements _KeywordData {
  const _$KeywordDataImpl({
    @JsonKey(name: 'blog_id') this.blogId,
    this.keyword = '',
  });

  factory _$KeywordDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeywordDataImplFromJson(json);

  @override
  @JsonKey(name: 'blog_id')
  final int? blogId;
  @override
  @JsonKey()
  final String keyword;

  @override
  String toString() {
    return 'KeywordData(blogId: $blogId, keyword: $keyword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeywordDataImpl &&
            (identical(other.blogId, blogId) || other.blogId == blogId) &&
            (identical(other.keyword, keyword) || other.keyword == keyword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, blogId, keyword);

  /// Create a copy of KeywordData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeywordDataImplCopyWith<_$KeywordDataImpl> get copyWith =>
      __$$KeywordDataImplCopyWithImpl<_$KeywordDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeywordDataImplToJson(this);
  }
}

abstract class _KeywordData implements KeywordData {
  const factory _KeywordData({
    @JsonKey(name: 'blog_id') final int? blogId,
    final String keyword,
  }) = _$KeywordDataImpl;

  factory _KeywordData.fromJson(Map<String, dynamic> json) =
      _$KeywordDataImpl.fromJson;

  @override
  @JsonKey(name: 'blog_id')
  int? get blogId;
  @override
  String get keyword;

  /// Create a copy of KeywordData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeywordDataImplCopyWith<_$KeywordDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
