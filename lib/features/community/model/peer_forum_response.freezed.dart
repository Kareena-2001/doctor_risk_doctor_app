// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'peer_forum_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PeerForumResponse _$PeerForumResponseFromJson(Map<String, dynamic> json) {
  return _PeerForumResponse.fromJson(json);
}

/// @nodoc
mixin _$PeerForumResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  List<PeerForumModel> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page')
  int get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;

  /// Serializes this PeerForumResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PeerForumResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PeerForumResponseCopyWith<PeerForumResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeerForumResponseCopyWith<$Res> {
  factory $PeerForumResponseCopyWith(
    PeerForumResponse value,
    $Res Function(PeerForumResponse) then,
  ) = _$PeerForumResponseCopyWithImpl<$Res, PeerForumResponse>;
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<PeerForumModel> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class _$PeerForumResponseCopyWithImpl<$Res, $Val extends PeerForumResponse>
    implements $PeerForumResponseCopyWith<$Res> {
  _$PeerForumResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PeerForumResponse
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
                      as List<PeerForumModel>,
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
abstract class _$$PeerForumResponseImplCopyWith<$Res>
    implements $PeerForumResponseCopyWith<$Res> {
  factory _$$PeerForumResponseImplCopyWith(
    _$PeerForumResponseImpl value,
    $Res Function(_$PeerForumResponseImpl) then,
  ) = __$$PeerForumResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<PeerForumModel> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class __$$PeerForumResponseImplCopyWithImpl<$Res>
    extends _$PeerForumResponseCopyWithImpl<$Res, _$PeerForumResponseImpl>
    implements _$$PeerForumResponseImplCopyWith<$Res> {
  __$$PeerForumResponseImplCopyWithImpl(
    _$PeerForumResponseImpl _value,
    $Res Function(_$PeerForumResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PeerForumResponse
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
      _$PeerForumResponseImpl(
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
                  as List<PeerForumModel>,
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
class _$PeerForumResponseImpl implements _PeerForumResponse {
  const _$PeerForumResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    final List<PeerForumModel> data = const [],
    required this.total,
    @JsonKey(name: 'current_page') required this.currentPage,
    @JsonKey(name: 'last_page') required this.lastPage,
    @JsonKey(name: 'per_page') required this.perPage,
  }) : _data = data;

  factory _$PeerForumResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PeerForumResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  final List<PeerForumModel> _data;
  @override
  @JsonKey()
  List<PeerForumModel> get data {
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
    return 'PeerForumResponse(status: $status, code: $code, msg: $msg, data: $data, total: $total, currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeerForumResponseImpl &&
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

  /// Create a copy of PeerForumResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PeerForumResponseImplCopyWith<_$PeerForumResponseImpl> get copyWith =>
      __$$PeerForumResponseImplCopyWithImpl<_$PeerForumResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PeerForumResponseImplToJson(this);
  }
}

abstract class _PeerForumResponse implements PeerForumResponse {
  const factory _PeerForumResponse({
    required final bool status,
    required final int code,
    required final String msg,
    final List<PeerForumModel> data,
    required final int total,
    @JsonKey(name: 'current_page') required final int currentPage,
    @JsonKey(name: 'last_page') required final int lastPage,
    @JsonKey(name: 'per_page') required final int perPage,
  }) = _$PeerForumResponseImpl;

  factory _PeerForumResponse.fromJson(Map<String, dynamic> json) =
      _$PeerForumResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  List<PeerForumModel> get data;
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

  /// Create a copy of PeerForumResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PeerForumResponseImplCopyWith<_$PeerForumResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PeerForumModel _$PeerForumModelFromJson(Map<String, dynamic> json) {
  return _PeerForumModel.fromJson(json);
}

/// @nodoc
mixin _$PeerForumModel {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_label')
  String get typeLabel => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_url')
  String? get sourceUrl => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_on')
  String? get createdOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'days_ago')
  int? get daysAgo => throw _privateConstructorUsedError;
  @JsonKey(name: 'days_ago_label')
  String? get daysAgoLabel => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  String? get degree => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'speciality_name')
  String? get specialityName => throw _privateConstructorUsedError;

  /// Serializes this PeerForumModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PeerForumModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PeerForumModelCopyWith<PeerForumModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeerForumModelCopyWith<$Res> {
  factory $PeerForumModelCopyWith(
    PeerForumModel value,
    $Res Function(PeerForumModel) then,
  ) = _$PeerForumModelCopyWithImpl<$Res, PeerForumModel>;
  @useResult
  $Res call({
    int id,
    String type,
    @JsonKey(name: 'type_label') String typeLabel,
    String title,
    String description,
    String? image,
    String? source,
    @JsonKey(name: 'source_url') String? sourceUrl,
    String? date,
    @JsonKey(name: 'created_on') String? createdOn,
    @JsonKey(name: 'days_ago') int? daysAgo,
    @JsonKey(name: 'days_ago_label') String? daysAgoLabel,
    String? author,
    String? degree,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'speciality_name') String? specialityName,
  });
}

/// @nodoc
class _$PeerForumModelCopyWithImpl<$Res, $Val extends PeerForumModel>
    implements $PeerForumModelCopyWith<$Res> {
  _$PeerForumModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PeerForumModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? typeLabel = null,
    Object? title = null,
    Object? description = null,
    Object? image = freezed,
    Object? source = freezed,
    Object? sourceUrl = freezed,
    Object? date = freezed,
    Object? createdOn = freezed,
    Object? daysAgo = freezed,
    Object? daysAgoLabel = freezed,
    Object? author = freezed,
    Object? degree = freezed,
    Object? categoryName = freezed,
    Object? specialityName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            typeLabel: null == typeLabel
                ? _value.typeLabel
                : typeLabel // ignore: cast_nullable_to_non_nullable
                      as String,
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
            source: freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String?,
            sourceUrl: freezed == sourceUrl
                ? _value.sourceUrl
                : sourceUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            date: freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdOn: freezed == createdOn
                ? _value.createdOn
                : createdOn // ignore: cast_nullable_to_non_nullable
                      as String?,
            daysAgo: freezed == daysAgo
                ? _value.daysAgo
                : daysAgo // ignore: cast_nullable_to_non_nullable
                      as int?,
            daysAgoLabel: freezed == daysAgoLabel
                ? _value.daysAgoLabel
                : daysAgoLabel // ignore: cast_nullable_to_non_nullable
                      as String?,
            author: freezed == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PeerForumModelImplCopyWith<$Res>
    implements $PeerForumModelCopyWith<$Res> {
  factory _$$PeerForumModelImplCopyWith(
    _$PeerForumModelImpl value,
    $Res Function(_$PeerForumModelImpl) then,
  ) = __$$PeerForumModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String type,
    @JsonKey(name: 'type_label') String typeLabel,
    String title,
    String description,
    String? image,
    String? source,
    @JsonKey(name: 'source_url') String? sourceUrl,
    String? date,
    @JsonKey(name: 'created_on') String? createdOn,
    @JsonKey(name: 'days_ago') int? daysAgo,
    @JsonKey(name: 'days_ago_label') String? daysAgoLabel,
    String? author,
    String? degree,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'speciality_name') String? specialityName,
  });
}

/// @nodoc
class __$$PeerForumModelImplCopyWithImpl<$Res>
    extends _$PeerForumModelCopyWithImpl<$Res, _$PeerForumModelImpl>
    implements _$$PeerForumModelImplCopyWith<$Res> {
  __$$PeerForumModelImplCopyWithImpl(
    _$PeerForumModelImpl _value,
    $Res Function(_$PeerForumModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PeerForumModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? typeLabel = null,
    Object? title = null,
    Object? description = null,
    Object? image = freezed,
    Object? source = freezed,
    Object? sourceUrl = freezed,
    Object? date = freezed,
    Object? createdOn = freezed,
    Object? daysAgo = freezed,
    Object? daysAgoLabel = freezed,
    Object? author = freezed,
    Object? degree = freezed,
    Object? categoryName = freezed,
    Object? specialityName = freezed,
  }) {
    return _then(
      _$PeerForumModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        typeLabel: null == typeLabel
            ? _value.typeLabel
            : typeLabel // ignore: cast_nullable_to_non_nullable
                  as String,
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
        source: freezed == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String?,
        sourceUrl: freezed == sourceUrl
            ? _value.sourceUrl
            : sourceUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        date: freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdOn: freezed == createdOn
            ? _value.createdOn
            : createdOn // ignore: cast_nullable_to_non_nullable
                  as String?,
        daysAgo: freezed == daysAgo
            ? _value.daysAgo
            : daysAgo // ignore: cast_nullable_to_non_nullable
                  as int?,
        daysAgoLabel: freezed == daysAgoLabel
            ? _value.daysAgoLabel
            : daysAgoLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        author: freezed == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PeerForumModelImpl implements _PeerForumModel {
  const _$PeerForumModelImpl({
    required this.id,
    required this.type,
    @JsonKey(name: 'type_label') required this.typeLabel,
    required this.title,
    required this.description,
    this.image,
    this.source,
    @JsonKey(name: 'source_url') this.sourceUrl,
    this.date,
    @JsonKey(name: 'created_on') this.createdOn,
    @JsonKey(name: 'days_ago') this.daysAgo,
    @JsonKey(name: 'days_ago_label') this.daysAgoLabel,
    this.author,
    this.degree,
    @JsonKey(name: 'category_name') this.categoryName,
    @JsonKey(name: 'speciality_name') this.specialityName,
  });

  factory _$PeerForumModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PeerForumModelImplFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  @JsonKey(name: 'type_label')
  final String typeLabel;
  @override
  final String title;
  @override
  final String description;
  @override
  final String? image;
  @override
  final String? source;
  @override
  @JsonKey(name: 'source_url')
  final String? sourceUrl;
  @override
  final String? date;
  @override
  @JsonKey(name: 'created_on')
  final String? createdOn;
  @override
  @JsonKey(name: 'days_ago')
  final int? daysAgo;
  @override
  @JsonKey(name: 'days_ago_label')
  final String? daysAgoLabel;
  @override
  final String? author;
  @override
  final String? degree;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'speciality_name')
  final String? specialityName;

  @override
  String toString() {
    return 'PeerForumModel(id: $id, type: $type, typeLabel: $typeLabel, title: $title, description: $description, image: $image, source: $source, sourceUrl: $sourceUrl, date: $date, createdOn: $createdOn, daysAgo: $daysAgo, daysAgoLabel: $daysAgoLabel, author: $author, degree: $degree, categoryName: $categoryName, specialityName: $specialityName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeerForumModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.typeLabel, typeLabel) ||
                other.typeLabel == typeLabel) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.daysAgo, daysAgo) || other.daysAgo == daysAgo) &&
            (identical(other.daysAgoLabel, daysAgoLabel) ||
                other.daysAgoLabel == daysAgoLabel) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.degree, degree) || other.degree == degree) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.specialityName, specialityName) ||
                other.specialityName == specialityName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    typeLabel,
    title,
    description,
    image,
    source,
    sourceUrl,
    date,
    createdOn,
    daysAgo,
    daysAgoLabel,
    author,
    degree,
    categoryName,
    specialityName,
  );

  /// Create a copy of PeerForumModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PeerForumModelImplCopyWith<_$PeerForumModelImpl> get copyWith =>
      __$$PeerForumModelImplCopyWithImpl<_$PeerForumModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PeerForumModelImplToJson(this);
  }
}

abstract class _PeerForumModel implements PeerForumModel {
  const factory _PeerForumModel({
    required final int id,
    required final String type,
    @JsonKey(name: 'type_label') required final String typeLabel,
    required final String title,
    required final String description,
    final String? image,
    final String? source,
    @JsonKey(name: 'source_url') final String? sourceUrl,
    final String? date,
    @JsonKey(name: 'created_on') final String? createdOn,
    @JsonKey(name: 'days_ago') final int? daysAgo,
    @JsonKey(name: 'days_ago_label') final String? daysAgoLabel,
    final String? author,
    final String? degree,
    @JsonKey(name: 'category_name') final String? categoryName,
    @JsonKey(name: 'speciality_name') final String? specialityName,
  }) = _$PeerForumModelImpl;

  factory _PeerForumModel.fromJson(Map<String, dynamic> json) =
      _$PeerForumModelImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(name: 'type_label')
  String get typeLabel;
  @override
  String get title;
  @override
  String get description;
  @override
  String? get image;
  @override
  String? get source;
  @override
  @JsonKey(name: 'source_url')
  String? get sourceUrl;
  @override
  String? get date;
  @override
  @JsonKey(name: 'created_on')
  String? get createdOn;
  @override
  @JsonKey(name: 'days_ago')
  int? get daysAgo;
  @override
  @JsonKey(name: 'days_ago_label')
  String? get daysAgoLabel;
  @override
  String? get author;
  @override
  String? get degree;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'speciality_name')
  String? get specialityName;

  /// Create a copy of PeerForumModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PeerForumModelImplCopyWith<_$PeerForumModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
