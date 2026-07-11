// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QueryListModel _$QueryListModelFromJson(Map<String, dynamic> json) {
  return _QueryListModel.fromJson(json);
}

/// @nodoc
mixin _$QueryListModel {
  int get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  List<QueryListItem> get data => throw _privateConstructorUsedError;

  /// Serializes this QueryListModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueryListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueryListModelCopyWith<QueryListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryListModelCopyWith<$Res> {
  factory $QueryListModelCopyWith(
    QueryListModel value,
    $Res Function(QueryListModel) then,
  ) = _$QueryListModelCopyWithImpl<$Res, QueryListModel>;
  @useResult
  $Res call({int status, String msg, List<QueryListItem> data});
}

/// @nodoc
class _$QueryListModelCopyWithImpl<$Res, $Val extends QueryListModel>
    implements $QueryListModelCopyWith<$Res> {
  _$QueryListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueryListModel
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
                      as List<QueryListItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QueryListModelImplCopyWith<$Res>
    implements $QueryListModelCopyWith<$Res> {
  factory _$$QueryListModelImplCopyWith(
    _$QueryListModelImpl value,
    $Res Function(_$QueryListModelImpl) then,
  ) = __$$QueryListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String msg, List<QueryListItem> data});
}

/// @nodoc
class __$$QueryListModelImplCopyWithImpl<$Res>
    extends _$QueryListModelCopyWithImpl<$Res, _$QueryListModelImpl>
    implements _$$QueryListModelImplCopyWith<$Res> {
  __$$QueryListModelImplCopyWithImpl(
    _$QueryListModelImpl _value,
    $Res Function(_$QueryListModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueryListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? msg = null, Object? data = null}) {
    return _then(
      _$QueryListModelImpl(
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
                  as List<QueryListItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueryListModelImpl implements _QueryListModel {
  const _$QueryListModelImpl({
    required this.status,
    required this.msg,
    final List<QueryListItem> data = const [],
  }) : _data = data;

  factory _$QueryListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueryListModelImplFromJson(json);

  @override
  final int status;
  @override
  final String msg;
  final List<QueryListItem> _data;
  @override
  @JsonKey()
  List<QueryListItem> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'QueryListModel(status: $status, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueryListModelImpl &&
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

  /// Create a copy of QueryListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryListModelImplCopyWith<_$QueryListModelImpl> get copyWith =>
      __$$QueryListModelImplCopyWithImpl<_$QueryListModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QueryListModelImplToJson(this);
  }
}

abstract class _QueryListModel implements QueryListModel {
  const factory _QueryListModel({
    required final int status,
    required final String msg,
    final List<QueryListItem> data,
  }) = _$QueryListModelImpl;

  factory _QueryListModel.fromJson(Map<String, dynamic> json) =
      _$QueryListModelImpl.fromJson;

  @override
  int get status;
  @override
  String get msg;
  @override
  List<QueryListItem> get data;

  /// Create a copy of QueryListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueryListModelImplCopyWith<_$QueryListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QueryListItem _$QueryListItemFromJson(Map<String, dynamic> json) {
  return _QueryListItem.fromJson(json);
}

/// @nodoc
mixin _$QueryListItem {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tkt_number')
  String get ticketNumber => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'tkt_status')
  String get ticketStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'query_submit')
  String get querySubmit => throw _privateConstructorUsedError;

  /// Serializes this QueryListItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueryListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueryListItemCopyWith<QueryListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryListItemCopyWith<$Res> {
  factory $QueryListItemCopyWith(
    QueryListItem value,
    $Res Function(QueryListItem) then,
  ) = _$QueryListItemCopyWithImpl<$Res, QueryListItem>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'tkt_number') String ticketNumber,
    String category,
    String question,
    String description,
    @JsonKey(name: 'tkt_status') String ticketStatus,
    @JsonKey(name: 'query_submit') String querySubmit,
  });
}

/// @nodoc
class _$QueryListItemCopyWithImpl<$Res, $Val extends QueryListItem>
    implements $QueryListItemCopyWith<$Res> {
  _$QueryListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueryListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? ticketNumber = null,
    Object? category = null,
    Object? question = null,
    Object? description = null,
    Object? ticketStatus = null,
    Object? querySubmit = null,
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
            ticketNumber: null == ticketNumber
                ? _value.ticketNumber
                : ticketNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            ticketStatus: null == ticketStatus
                ? _value.ticketStatus
                : ticketStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            querySubmit: null == querySubmit
                ? _value.querySubmit
                : querySubmit // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QueryListItemImplCopyWith<$Res>
    implements $QueryListItemCopyWith<$Res> {
  factory _$$QueryListItemImplCopyWith(
    _$QueryListItemImpl value,
    $Res Function(_$QueryListItemImpl) then,
  ) = __$$QueryListItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'tkt_number') String ticketNumber,
    String category,
    String question,
    String description,
    @JsonKey(name: 'tkt_status') String ticketStatus,
    @JsonKey(name: 'query_submit') String querySubmit,
  });
}

/// @nodoc
class __$$QueryListItemImplCopyWithImpl<$Res>
    extends _$QueryListItemCopyWithImpl<$Res, _$QueryListItemImpl>
    implements _$$QueryListItemImplCopyWith<$Res> {
  __$$QueryListItemImplCopyWithImpl(
    _$QueryListItemImpl _value,
    $Res Function(_$QueryListItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueryListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? ticketNumber = null,
    Object? category = null,
    Object? question = null,
    Object? description = null,
    Object? ticketStatus = null,
    Object? querySubmit = null,
  }) {
    return _then(
      _$QueryListItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        ticketNumber: null == ticketNumber
            ? _value.ticketNumber
            : ticketNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        ticketStatus: null == ticketStatus
            ? _value.ticketStatus
            : ticketStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        querySubmit: null == querySubmit
            ? _value.querySubmit
            : querySubmit // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueryListItemImpl implements _QueryListItem {
  const _$QueryListItemImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'tkt_number') required this.ticketNumber,
    required this.category,
    required this.question,
    required this.description,
    @JsonKey(name: 'tkt_status') required this.ticketStatus,
    @JsonKey(name: 'query_submit') required this.querySubmit,
  });

  factory _$QueryListItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueryListItemImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'tkt_number')
  final String ticketNumber;
  @override
  final String category;
  @override
  final String question;
  @override
  final String description;
  @override
  @JsonKey(name: 'tkt_status')
  final String ticketStatus;
  @override
  @JsonKey(name: 'query_submit')
  final String querySubmit;

  @override
  String toString() {
    return 'QueryListItem(id: $id, userId: $userId, ticketNumber: $ticketNumber, category: $category, question: $question, description: $description, ticketStatus: $ticketStatus, querySubmit: $querySubmit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueryListItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.ticketNumber, ticketNumber) ||
                other.ticketNumber == ticketNumber) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.ticketStatus, ticketStatus) ||
                other.ticketStatus == ticketStatus) &&
            (identical(other.querySubmit, querySubmit) ||
                other.querySubmit == querySubmit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    ticketNumber,
    category,
    question,
    description,
    ticketStatus,
    querySubmit,
  );

  /// Create a copy of QueryListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryListItemImplCopyWith<_$QueryListItemImpl> get copyWith =>
      __$$QueryListItemImplCopyWithImpl<_$QueryListItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueryListItemImplToJson(this);
  }
}

abstract class _QueryListItem implements QueryListItem {
  const factory _QueryListItem({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'tkt_number') required final String ticketNumber,
    required final String category,
    required final String question,
    required final String description,
    @JsonKey(name: 'tkt_status') required final String ticketStatus,
    @JsonKey(name: 'query_submit') required final String querySubmit,
  }) = _$QueryListItemImpl;

  factory _QueryListItem.fromJson(Map<String, dynamic> json) =
      _$QueryListItemImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'tkt_number')
  String get ticketNumber;
  @override
  String get category;
  @override
  String get question;
  @override
  String get description;
  @override
  @JsonKey(name: 'tkt_status')
  String get ticketStatus;
  @override
  @JsonKey(name: 'query_submit')
  String get querySubmit;

  /// Create a copy of QueryListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueryListItemImplCopyWith<_$QueryListItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
