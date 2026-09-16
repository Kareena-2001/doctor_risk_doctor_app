// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_submission_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MySubmissionListModel _$MySubmissionListModelFromJson(
  Map<String, dynamic> json,
) {
  return _MySubmissionListModel.fromJson(json);
}

/// @nodoc
mixin _$MySubmissionListModel {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  List<SubmissionModel> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page')
  int get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;

  /// Serializes this MySubmissionListModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MySubmissionListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MySubmissionListModelCopyWith<MySubmissionListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MySubmissionListModelCopyWith<$Res> {
  factory $MySubmissionListModelCopyWith(
    MySubmissionListModel value,
    $Res Function(MySubmissionListModel) then,
  ) = _$MySubmissionListModelCopyWithImpl<$Res, MySubmissionListModel>;
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<SubmissionModel> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class _$MySubmissionListModelCopyWithImpl<
  $Res,
  $Val extends MySubmissionListModel
>
    implements $MySubmissionListModelCopyWith<$Res> {
  _$MySubmissionListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MySubmissionListModel
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
                      as List<SubmissionModel>,
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
abstract class _$$MySubmissionListModelImplCopyWith<$Res>
    implements $MySubmissionListModelCopyWith<$Res> {
  factory _$$MySubmissionListModelImplCopyWith(
    _$MySubmissionListModelImpl value,
    $Res Function(_$MySubmissionListModelImpl) then,
  ) = __$$MySubmissionListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<SubmissionModel> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class __$$MySubmissionListModelImplCopyWithImpl<$Res>
    extends
        _$MySubmissionListModelCopyWithImpl<$Res, _$MySubmissionListModelImpl>
    implements _$$MySubmissionListModelImplCopyWith<$Res> {
  __$$MySubmissionListModelImplCopyWithImpl(
    _$MySubmissionListModelImpl _value,
    $Res Function(_$MySubmissionListModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MySubmissionListModel
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
      _$MySubmissionListModelImpl(
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
                  as List<SubmissionModel>,
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
class _$MySubmissionListModelImpl implements _MySubmissionListModel {
  const _$MySubmissionListModelImpl({
    required this.status,
    required this.code,
    required this.msg,
    required final List<SubmissionModel> data,
    required this.total,
    @JsonKey(name: 'current_page') required this.currentPage,
    @JsonKey(name: 'last_page') required this.lastPage,
    @JsonKey(name: 'per_page') required this.perPage,
  }) : _data = data;

  factory _$MySubmissionListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MySubmissionListModelImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  final List<SubmissionModel> _data;
  @override
  List<SubmissionModel> get data {
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
    return 'MySubmissionListModel(status: $status, code: $code, msg: $msg, data: $data, total: $total, currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MySubmissionListModelImpl &&
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

  /// Create a copy of MySubmissionListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MySubmissionListModelImplCopyWith<_$MySubmissionListModelImpl>
  get copyWith =>
      __$$MySubmissionListModelImplCopyWithImpl<_$MySubmissionListModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MySubmissionListModelImplToJson(this);
  }
}

abstract class _MySubmissionListModel implements MySubmissionListModel {
  const factory _MySubmissionListModel({
    required final bool status,
    required final int code,
    required final String msg,
    required final List<SubmissionModel> data,
    required final int total,
    @JsonKey(name: 'current_page') required final int currentPage,
    @JsonKey(name: 'last_page') required final int lastPage,
    @JsonKey(name: 'per_page') required final int perPage,
  }) = _$MySubmissionListModelImpl;

  factory _MySubmissionListModel.fromJson(Map<String, dynamic> json) =
      _$MySubmissionListModelImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  List<SubmissionModel> get data;
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

  /// Create a copy of MySubmissionListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MySubmissionListModelImplCopyWith<_$MySubmissionListModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SubmissionModel _$SubmissionModelFromJson(Map<String, dynamic> json) {
  return _SubmissionModel.fromJson(json);
}

/// @nodoc
mixin _$SubmissionModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'approve_status')
  String? get approveStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'view_count')
  String get viewCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'i_agree_accepted')
  String get iAgreeAccepted => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_on')
  String get createdOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_on')
  String get updatedOn => throw _privateConstructorUsedError;
  List<KeywordModel> get keywords => throw _privateConstructorUsedError;

  /// Serializes this SubmissionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubmissionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubmissionModelCopyWith<SubmissionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmissionModelCopyWith<$Res> {
  factory $SubmissionModelCopyWith(
    SubmissionModel value,
    $Res Function(SubmissionModel) then,
  ) = _$SubmissionModelCopyWithImpl<$Res, SubmissionModel>;
  @useResult
  $Res call({
    int id,
    String title,
    String? image,
    String description,
    @JsonKey(name: 'approve_status') String? approveStatus,
    @JsonKey(name: 'view_count') String viewCount,
    @JsonKey(name: 'i_agree_accepted') String iAgreeAccepted,
    @JsonKey(name: 'created_on') String createdOn,
    @JsonKey(name: 'updated_on') String updatedOn,
    List<KeywordModel> keywords,
  });
}

/// @nodoc
class _$SubmissionModelCopyWithImpl<$Res, $Val extends SubmissionModel>
    implements $SubmissionModelCopyWith<$Res> {
  _$SubmissionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubmissionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? image = freezed,
    Object? description = null,
    Object? approveStatus = freezed,
    Object? viewCount = null,
    Object? iAgreeAccepted = null,
    Object? createdOn = null,
    Object? updatedOn = null,
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
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            approveStatus: freezed == approveStatus
                ? _value.approveStatus
                : approveStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            viewCount: null == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as String,
            iAgreeAccepted: null == iAgreeAccepted
                ? _value.iAgreeAccepted
                : iAgreeAccepted // ignore: cast_nullable_to_non_nullable
                      as String,
            createdOn: null == createdOn
                ? _value.createdOn
                : createdOn // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedOn: null == updatedOn
                ? _value.updatedOn
                : updatedOn // ignore: cast_nullable_to_non_nullable
                      as String,
            keywords: null == keywords
                ? _value.keywords
                : keywords // ignore: cast_nullable_to_non_nullable
                      as List<KeywordModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubmissionModelImplCopyWith<$Res>
    implements $SubmissionModelCopyWith<$Res> {
  factory _$$SubmissionModelImplCopyWith(
    _$SubmissionModelImpl value,
    $Res Function(_$SubmissionModelImpl) then,
  ) = __$$SubmissionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    String? image,
    String description,
    @JsonKey(name: 'approve_status') String? approveStatus,
    @JsonKey(name: 'view_count') String viewCount,
    @JsonKey(name: 'i_agree_accepted') String iAgreeAccepted,
    @JsonKey(name: 'created_on') String createdOn,
    @JsonKey(name: 'updated_on') String updatedOn,
    List<KeywordModel> keywords,
  });
}

/// @nodoc
class __$$SubmissionModelImplCopyWithImpl<$Res>
    extends _$SubmissionModelCopyWithImpl<$Res, _$SubmissionModelImpl>
    implements _$$SubmissionModelImplCopyWith<$Res> {
  __$$SubmissionModelImplCopyWithImpl(
    _$SubmissionModelImpl _value,
    $Res Function(_$SubmissionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubmissionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? image = freezed,
    Object? description = null,
    Object? approveStatus = freezed,
    Object? viewCount = null,
    Object? iAgreeAccepted = null,
    Object? createdOn = null,
    Object? updatedOn = null,
    Object? keywords = null,
  }) {
    return _then(
      _$SubmissionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        approveStatus: freezed == approveStatus
            ? _value.approveStatus
            : approveStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        viewCount: null == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as String,
        iAgreeAccepted: null == iAgreeAccepted
            ? _value.iAgreeAccepted
            : iAgreeAccepted // ignore: cast_nullable_to_non_nullable
                  as String,
        createdOn: null == createdOn
            ? _value.createdOn
            : createdOn // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedOn: null == updatedOn
            ? _value.updatedOn
            : updatedOn // ignore: cast_nullable_to_non_nullable
                  as String,
        keywords: null == keywords
            ? _value._keywords
            : keywords // ignore: cast_nullable_to_non_nullable
                  as List<KeywordModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubmissionModelImpl implements _SubmissionModel {
  const _$SubmissionModelImpl({
    required this.id,
    required this.title,
    this.image,
    required this.description,
    @JsonKey(name: 'approve_status') this.approveStatus,
    @JsonKey(name: 'view_count') required this.viewCount,
    @JsonKey(name: 'i_agree_accepted') required this.iAgreeAccepted,
    @JsonKey(name: 'created_on') required this.createdOn,
    @JsonKey(name: 'updated_on') required this.updatedOn,
    final List<KeywordModel> keywords = const <KeywordModel>[],
  }) : _keywords = keywords;

  factory _$SubmissionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubmissionModelImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? image;
  @override
  final String description;
  @override
  @JsonKey(name: 'approve_status')
  final String? approveStatus;
  @override
  @JsonKey(name: 'view_count')
  final String viewCount;
  @override
  @JsonKey(name: 'i_agree_accepted')
  final String iAgreeAccepted;
  @override
  @JsonKey(name: 'created_on')
  final String createdOn;
  @override
  @JsonKey(name: 'updated_on')
  final String updatedOn;
  final List<KeywordModel> _keywords;
  @override
  @JsonKey()
  List<KeywordModel> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  @override
  String toString() {
    return 'SubmissionModel(id: $id, title: $title, image: $image, description: $description, approveStatus: $approveStatus, viewCount: $viewCount, iAgreeAccepted: $iAgreeAccepted, createdOn: $createdOn, updatedOn: $updatedOn, keywords: $keywords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmissionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.approveStatus, approveStatus) ||
                other.approveStatus == approveStatus) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.iAgreeAccepted, iAgreeAccepted) ||
                other.iAgreeAccepted == iAgreeAccepted) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.updatedOn, updatedOn) ||
                other.updatedOn == updatedOn) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    image,
    description,
    approveStatus,
    viewCount,
    iAgreeAccepted,
    createdOn,
    updatedOn,
    const DeepCollectionEquality().hash(_keywords),
  );

  /// Create a copy of SubmissionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmissionModelImplCopyWith<_$SubmissionModelImpl> get copyWith =>
      __$$SubmissionModelImplCopyWithImpl<_$SubmissionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubmissionModelImplToJson(this);
  }
}

abstract class _SubmissionModel implements SubmissionModel {
  const factory _SubmissionModel({
    required final int id,
    required final String title,
    final String? image,
    required final String description,
    @JsonKey(name: 'approve_status') final String? approveStatus,
    @JsonKey(name: 'view_count') required final String viewCount,
    @JsonKey(name: 'i_agree_accepted') required final String iAgreeAccepted,
    @JsonKey(name: 'created_on') required final String createdOn,
    @JsonKey(name: 'updated_on') required final String updatedOn,
    final List<KeywordModel> keywords,
  }) = _$SubmissionModelImpl;

  factory _SubmissionModel.fromJson(Map<String, dynamic> json) =
      _$SubmissionModelImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String? get image;
  @override
  String get description;
  @override
  @JsonKey(name: 'approve_status')
  String? get approveStatus;
  @override
  @JsonKey(name: 'view_count')
  String get viewCount;
  @override
  @JsonKey(name: 'i_agree_accepted')
  String get iAgreeAccepted;
  @override
  @JsonKey(name: 'created_on')
  String get createdOn;
  @override
  @JsonKey(name: 'updated_on')
  String get updatedOn;
  @override
  List<KeywordModel> get keywords;

  /// Create a copy of SubmissionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmissionModelImplCopyWith<_$SubmissionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KeywordModel _$KeywordModelFromJson(Map<String, dynamic> json) {
  return _KeywordModel.fromJson(json);
}

/// @nodoc
mixin _$KeywordModel {
  @JsonKey(name: 'blog_id')
  int get blogId => throw _privateConstructorUsedError;
  String get keyword => throw _privateConstructorUsedError;

  /// Serializes this KeywordModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KeywordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeywordModelCopyWith<KeywordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeywordModelCopyWith<$Res> {
  factory $KeywordModelCopyWith(
    KeywordModel value,
    $Res Function(KeywordModel) then,
  ) = _$KeywordModelCopyWithImpl<$Res, KeywordModel>;
  @useResult
  $Res call({@JsonKey(name: 'blog_id') int blogId, String keyword});
}

/// @nodoc
class _$KeywordModelCopyWithImpl<$Res, $Val extends KeywordModel>
    implements $KeywordModelCopyWith<$Res> {
  _$KeywordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeywordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? blogId = null, Object? keyword = null}) {
    return _then(
      _value.copyWith(
            blogId: null == blogId
                ? _value.blogId
                : blogId // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$KeywordModelImplCopyWith<$Res>
    implements $KeywordModelCopyWith<$Res> {
  factory _$$KeywordModelImplCopyWith(
    _$KeywordModelImpl value,
    $Res Function(_$KeywordModelImpl) then,
  ) = __$$KeywordModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'blog_id') int blogId, String keyword});
}

/// @nodoc
class __$$KeywordModelImplCopyWithImpl<$Res>
    extends _$KeywordModelCopyWithImpl<$Res, _$KeywordModelImpl>
    implements _$$KeywordModelImplCopyWith<$Res> {
  __$$KeywordModelImplCopyWithImpl(
    _$KeywordModelImpl _value,
    $Res Function(_$KeywordModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KeywordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? blogId = null, Object? keyword = null}) {
    return _then(
      _$KeywordModelImpl(
        blogId: null == blogId
            ? _value.blogId
            : blogId // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$KeywordModelImpl implements _KeywordModel {
  const _$KeywordModelImpl({
    @JsonKey(name: 'blog_id') required this.blogId,
    required this.keyword,
  });

  factory _$KeywordModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeywordModelImplFromJson(json);

  @override
  @JsonKey(name: 'blog_id')
  final int blogId;
  @override
  final String keyword;

  @override
  String toString() {
    return 'KeywordModel(blogId: $blogId, keyword: $keyword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeywordModelImpl &&
            (identical(other.blogId, blogId) || other.blogId == blogId) &&
            (identical(other.keyword, keyword) || other.keyword == keyword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, blogId, keyword);

  /// Create a copy of KeywordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeywordModelImplCopyWith<_$KeywordModelImpl> get copyWith =>
      __$$KeywordModelImplCopyWithImpl<_$KeywordModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeywordModelImplToJson(this);
  }
}

abstract class _KeywordModel implements KeywordModel {
  const factory _KeywordModel({
    @JsonKey(name: 'blog_id') required final int blogId,
    required final String keyword,
  }) = _$KeywordModelImpl;

  factory _KeywordModel.fromJson(Map<String, dynamic> json) =
      _$KeywordModelImpl.fromJson;

  @override
  @JsonKey(name: 'blog_id')
  int get blogId;
  @override
  String get keyword;

  /// Create a copy of KeywordModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeywordModelImplCopyWith<_$KeywordModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
