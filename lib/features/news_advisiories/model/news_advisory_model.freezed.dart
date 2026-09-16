// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_advisory_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NewsAdvisoryResponse _$NewsAdvisoryResponseFromJson(Map<String, dynamic> json) {
  return _NewsAdvisoryResponse.fromJson(json);
}

/// @nodoc
mixin _$NewsAdvisoryResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  List<NewsAdvisoryModel> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page')
  int get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;

  /// Serializes this NewsAdvisoryResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewsAdvisoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewsAdvisoryResponseCopyWith<NewsAdvisoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsAdvisoryResponseCopyWith<$Res> {
  factory $NewsAdvisoryResponseCopyWith(
    NewsAdvisoryResponse value,
    $Res Function(NewsAdvisoryResponse) then,
  ) = _$NewsAdvisoryResponseCopyWithImpl<$Res, NewsAdvisoryResponse>;
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<NewsAdvisoryModel> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class _$NewsAdvisoryResponseCopyWithImpl<
  $Res,
  $Val extends NewsAdvisoryResponse
>
    implements $NewsAdvisoryResponseCopyWith<$Res> {
  _$NewsAdvisoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewsAdvisoryResponse
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
                      as List<NewsAdvisoryModel>,
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
abstract class _$$NewsAdvisoryResponseImplCopyWith<$Res>
    implements $NewsAdvisoryResponseCopyWith<$Res> {
  factory _$$NewsAdvisoryResponseImplCopyWith(
    _$NewsAdvisoryResponseImpl value,
    $Res Function(_$NewsAdvisoryResponseImpl) then,
  ) = __$$NewsAdvisoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<NewsAdvisoryModel> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class __$$NewsAdvisoryResponseImplCopyWithImpl<$Res>
    extends _$NewsAdvisoryResponseCopyWithImpl<$Res, _$NewsAdvisoryResponseImpl>
    implements _$$NewsAdvisoryResponseImplCopyWith<$Res> {
  __$$NewsAdvisoryResponseImplCopyWithImpl(
    _$NewsAdvisoryResponseImpl _value,
    $Res Function(_$NewsAdvisoryResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsAdvisoryResponse
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
      _$NewsAdvisoryResponseImpl(
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
                  as List<NewsAdvisoryModel>,
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
class _$NewsAdvisoryResponseImpl implements _NewsAdvisoryResponse {
  const _$NewsAdvisoryResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    required final List<NewsAdvisoryModel> data,
    required this.total,
    @JsonKey(name: 'current_page') required this.currentPage,
    @JsonKey(name: 'last_page') required this.lastPage,
    @JsonKey(name: 'per_page') required this.perPage,
  }) : _data = data;

  factory _$NewsAdvisoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsAdvisoryResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  final List<NewsAdvisoryModel> _data;
  @override
  List<NewsAdvisoryModel> get data {
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
    return 'NewsAdvisoryResponse(status: $status, code: $code, msg: $msg, data: $data, total: $total, currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsAdvisoryResponseImpl &&
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

  /// Create a copy of NewsAdvisoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsAdvisoryResponseImplCopyWith<_$NewsAdvisoryResponseImpl>
  get copyWith =>
      __$$NewsAdvisoryResponseImplCopyWithImpl<_$NewsAdvisoryResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsAdvisoryResponseImplToJson(this);
  }
}

abstract class _NewsAdvisoryResponse implements NewsAdvisoryResponse {
  const factory _NewsAdvisoryResponse({
    required final bool status,
    required final int code,
    required final String msg,
    required final List<NewsAdvisoryModel> data,
    required final int total,
    @JsonKey(name: 'current_page') required final int currentPage,
    @JsonKey(name: 'last_page') required final int lastPage,
    @JsonKey(name: 'per_page') required final int perPage,
  }) = _$NewsAdvisoryResponseImpl;

  factory _NewsAdvisoryResponse.fromJson(Map<String, dynamic> json) =
      _$NewsAdvisoryResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  List<NewsAdvisoryModel> get data;
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

  /// Create a copy of NewsAdvisoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsAdvisoryResponseImplCopyWith<_$NewsAdvisoryResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

NewsAdvisoryModel _$NewsAdvisoryModelFromJson(Map<String, dynamic> json) {
  return _NewsAdvisoryModel.fromJson(json);
}

/// @nodoc
mixin _$NewsAdvisoryModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'news_source')
  String get newsSource => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_date')
  String get sourceDate => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_url')
  String get sourceUrl => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_on')
  String get createdOn => throw _privateConstructorUsedError;

  /// Serializes this NewsAdvisoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewsAdvisoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewsAdvisoryModelCopyWith<NewsAdvisoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsAdvisoryModelCopyWith<$Res> {
  factory $NewsAdvisoryModelCopyWith(
    NewsAdvisoryModel value,
    $Res Function(NewsAdvisoryModel) then,
  ) = _$NewsAdvisoryModelCopyWithImpl<$Res, NewsAdvisoryModel>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'news_source') String newsSource,
    @JsonKey(name: 'source_date') String sourceDate,
    String title,
    String description,
    @JsonKey(name: 'source_url') String sourceUrl,
    String status,
    @JsonKey(name: 'created_on') String createdOn,
  });
}

/// @nodoc
class _$NewsAdvisoryModelCopyWithImpl<$Res, $Val extends NewsAdvisoryModel>
    implements $NewsAdvisoryModelCopyWith<$Res> {
  _$NewsAdvisoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewsAdvisoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? newsSource = null,
    Object? sourceDate = null,
    Object? title = null,
    Object? description = null,
    Object? sourceUrl = null,
    Object? status = null,
    Object? createdOn = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            newsSource: null == newsSource
                ? _value.newsSource
                : newsSource // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceDate: null == sourceDate
                ? _value.sourceDate
                : sourceDate // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceUrl: null == sourceUrl
                ? _value.sourceUrl
                : sourceUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            createdOn: null == createdOn
                ? _value.createdOn
                : createdOn // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NewsAdvisoryModelImplCopyWith<$Res>
    implements $NewsAdvisoryModelCopyWith<$Res> {
  factory _$$NewsAdvisoryModelImplCopyWith(
    _$NewsAdvisoryModelImpl value,
    $Res Function(_$NewsAdvisoryModelImpl) then,
  ) = __$$NewsAdvisoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'news_source') String newsSource,
    @JsonKey(name: 'source_date') String sourceDate,
    String title,
    String description,
    @JsonKey(name: 'source_url') String sourceUrl,
    String status,
    @JsonKey(name: 'created_on') String createdOn,
  });
}

/// @nodoc
class __$$NewsAdvisoryModelImplCopyWithImpl<$Res>
    extends _$NewsAdvisoryModelCopyWithImpl<$Res, _$NewsAdvisoryModelImpl>
    implements _$$NewsAdvisoryModelImplCopyWith<$Res> {
  __$$NewsAdvisoryModelImplCopyWithImpl(
    _$NewsAdvisoryModelImpl _value,
    $Res Function(_$NewsAdvisoryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsAdvisoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? newsSource = null,
    Object? sourceDate = null,
    Object? title = null,
    Object? description = null,
    Object? sourceUrl = null,
    Object? status = null,
    Object? createdOn = null,
  }) {
    return _then(
      _$NewsAdvisoryModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        newsSource: null == newsSource
            ? _value.newsSource
            : newsSource // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceDate: null == sourceDate
            ? _value.sourceDate
            : sourceDate // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceUrl: null == sourceUrl
            ? _value.sourceUrl
            : sourceUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        createdOn: null == createdOn
            ? _value.createdOn
            : createdOn // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsAdvisoryModelImpl implements _NewsAdvisoryModel {
  const _$NewsAdvisoryModelImpl({
    required this.id,
    @JsonKey(name: 'news_source') required this.newsSource,
    @JsonKey(name: 'source_date') required this.sourceDate,
    required this.title,
    required this.description,
    @JsonKey(name: 'source_url') required this.sourceUrl,
    required this.status,
    @JsonKey(name: 'created_on') required this.createdOn,
  });

  factory _$NewsAdvisoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsAdvisoryModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'news_source')
  final String newsSource;
  @override
  @JsonKey(name: 'source_date')
  final String sourceDate;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey(name: 'source_url')
  final String sourceUrl;
  @override
  final String status;
  @override
  @JsonKey(name: 'created_on')
  final String createdOn;

  @override
  String toString() {
    return 'NewsAdvisoryModel(id: $id, newsSource: $newsSource, sourceDate: $sourceDate, title: $title, description: $description, sourceUrl: $sourceUrl, status: $status, createdOn: $createdOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsAdvisoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.newsSource, newsSource) ||
                other.newsSource == newsSource) &&
            (identical(other.sourceDate, sourceDate) ||
                other.sourceDate == sourceDate) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    newsSource,
    sourceDate,
    title,
    description,
    sourceUrl,
    status,
    createdOn,
  );

  /// Create a copy of NewsAdvisoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsAdvisoryModelImplCopyWith<_$NewsAdvisoryModelImpl> get copyWith =>
      __$$NewsAdvisoryModelImplCopyWithImpl<_$NewsAdvisoryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsAdvisoryModelImplToJson(this);
  }
}

abstract class _NewsAdvisoryModel implements NewsAdvisoryModel {
  const factory _NewsAdvisoryModel({
    required final int id,
    @JsonKey(name: 'news_source') required final String newsSource,
    @JsonKey(name: 'source_date') required final String sourceDate,
    required final String title,
    required final String description,
    @JsonKey(name: 'source_url') required final String sourceUrl,
    required final String status,
    @JsonKey(name: 'created_on') required final String createdOn,
  }) = _$NewsAdvisoryModelImpl;

  factory _NewsAdvisoryModel.fromJson(Map<String, dynamic> json) =
      _$NewsAdvisoryModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'news_source')
  String get newsSource;
  @override
  @JsonKey(name: 'source_date')
  String get sourceDate;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'source_url')
  String get sourceUrl;
  @override
  String get status;
  @override
  @JsonKey(name: 'created_on')
  String get createdOn;

  /// Create a copy of NewsAdvisoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsAdvisoryModelImplCopyWith<_$NewsAdvisoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
