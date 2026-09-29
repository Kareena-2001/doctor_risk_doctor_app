// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QueryDetailModel _$QueryDetailModelFromJson(Map<String, dynamic> json) {
  return _QueryDetailModel.fromJson(json);
}

/// @nodoc
mixin _$QueryDetailModel {
  int get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  QueryDetailItem get data => throw _privateConstructorUsedError;

  /// Serializes this QueryDetailModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueryDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueryDetailModelCopyWith<QueryDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryDetailModelCopyWith<$Res> {
  factory $QueryDetailModelCopyWith(
    QueryDetailModel value,
    $Res Function(QueryDetailModel) then,
  ) = _$QueryDetailModelCopyWithImpl<$Res, QueryDetailModel>;
  @useResult
  $Res call({int status, String msg, QueryDetailItem data});

  $QueryDetailItemCopyWith<$Res> get data;
}

/// @nodoc
class _$QueryDetailModelCopyWithImpl<$Res, $Val extends QueryDetailModel>
    implements $QueryDetailModelCopyWith<$Res> {
  _$QueryDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueryDetailModel
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
                      as QueryDetailItem,
          )
          as $Val,
    );
  }

  /// Create a copy of QueryDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueryDetailItemCopyWith<$Res> get data {
    return $QueryDetailItemCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QueryDetailModelImplCopyWith<$Res>
    implements $QueryDetailModelCopyWith<$Res> {
  factory _$$QueryDetailModelImplCopyWith(
    _$QueryDetailModelImpl value,
    $Res Function(_$QueryDetailModelImpl) then,
  ) = __$$QueryDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String msg, QueryDetailItem data});

  @override
  $QueryDetailItemCopyWith<$Res> get data;
}

/// @nodoc
class __$$QueryDetailModelImplCopyWithImpl<$Res>
    extends _$QueryDetailModelCopyWithImpl<$Res, _$QueryDetailModelImpl>
    implements _$$QueryDetailModelImplCopyWith<$Res> {
  __$$QueryDetailModelImplCopyWithImpl(
    _$QueryDetailModelImpl _value,
    $Res Function(_$QueryDetailModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueryDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? msg = null, Object? data = null}) {
    return _then(
      _$QueryDetailModelImpl(
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
                  as QueryDetailItem,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueryDetailModelImpl implements _QueryDetailModel {
  const _$QueryDetailModelImpl({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory _$QueryDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueryDetailModelImplFromJson(json);

  @override
  final int status;
  @override
  final String msg;
  @override
  final QueryDetailItem data;

  @override
  String toString() {
    return 'QueryDetailModel(status: $status, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueryDetailModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, msg, data);

  /// Create a copy of QueryDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryDetailModelImplCopyWith<_$QueryDetailModelImpl> get copyWith =>
      __$$QueryDetailModelImplCopyWithImpl<_$QueryDetailModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QueryDetailModelImplToJson(this);
  }
}

abstract class _QueryDetailModel implements QueryDetailModel {
  const factory _QueryDetailModel({
    required final int status,
    required final String msg,
    required final QueryDetailItem data,
  }) = _$QueryDetailModelImpl;

  factory _QueryDetailModel.fromJson(Map<String, dynamic> json) =
      _$QueryDetailModelImpl.fromJson;

  @override
  int get status;
  @override
  String get msg;
  @override
  QueryDetailItem get data;

  /// Create a copy of QueryDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueryDetailModelImplCopyWith<_$QueryDetailModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QueryDetailItem _$QueryDetailItemFromJson(Map<String, dynamic> json) {
  return _QueryDetailItem.fromJson(json);
}

/// @nodoc
mixin _$QueryDetailItem {
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
  String? get replied => throw _privateConstructorUsedError;
  @JsonKey(name: 'replied_date')
  String? get repliedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_attachment')
  String? get replyAttachment => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_attachment')
  String? get userAttachment => throw _privateConstructorUsedError;

  /// Serializes this QueryDetailItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueryDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueryDetailItemCopyWith<QueryDetailItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryDetailItemCopyWith<$Res> {
  factory $QueryDetailItemCopyWith(
    QueryDetailItem value,
    $Res Function(QueryDetailItem) then,
  ) = _$QueryDetailItemCopyWithImpl<$Res, QueryDetailItem>;
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
    String? replied,
    @JsonKey(name: 'replied_date') String? repliedDate,
    @JsonKey(name: 'reply_attachment') String? replyAttachment,
    @JsonKey(name: 'user_attachment') String? userAttachment,
  });
}

/// @nodoc
class _$QueryDetailItemCopyWithImpl<$Res, $Val extends QueryDetailItem>
    implements $QueryDetailItemCopyWith<$Res> {
  _$QueryDetailItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueryDetailItem
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
    Object? replied = freezed,
    Object? repliedDate = freezed,
    Object? replyAttachment = freezed,
    Object? userAttachment = freezed,
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
            replied: freezed == replied
                ? _value.replied
                : replied // ignore: cast_nullable_to_non_nullable
                      as String?,
            repliedDate: freezed == repliedDate
                ? _value.repliedDate
                : repliedDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            replyAttachment: freezed == replyAttachment
                ? _value.replyAttachment
                : replyAttachment // ignore: cast_nullable_to_non_nullable
                      as String?,
            userAttachment: freezed == userAttachment
                ? _value.userAttachment
                : userAttachment // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QueryDetailItemImplCopyWith<$Res>
    implements $QueryDetailItemCopyWith<$Res> {
  factory _$$QueryDetailItemImplCopyWith(
    _$QueryDetailItemImpl value,
    $Res Function(_$QueryDetailItemImpl) then,
  ) = __$$QueryDetailItemImplCopyWithImpl<$Res>;
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
    String? replied,
    @JsonKey(name: 'replied_date') String? repliedDate,
    @JsonKey(name: 'reply_attachment') String? replyAttachment,
    @JsonKey(name: 'user_attachment') String? userAttachment,
  });
}

/// @nodoc
class __$$QueryDetailItemImplCopyWithImpl<$Res>
    extends _$QueryDetailItemCopyWithImpl<$Res, _$QueryDetailItemImpl>
    implements _$$QueryDetailItemImplCopyWith<$Res> {
  __$$QueryDetailItemImplCopyWithImpl(
    _$QueryDetailItemImpl _value,
    $Res Function(_$QueryDetailItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueryDetailItem
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
    Object? replied = freezed,
    Object? repliedDate = freezed,
    Object? replyAttachment = freezed,
    Object? userAttachment = freezed,
  }) {
    return _then(
      _$QueryDetailItemImpl(
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
        replied: freezed == replied
            ? _value.replied
            : replied // ignore: cast_nullable_to_non_nullable
                  as String?,
        repliedDate: freezed == repliedDate
            ? _value.repliedDate
            : repliedDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        replyAttachment: freezed == replyAttachment
            ? _value.replyAttachment
            : replyAttachment // ignore: cast_nullable_to_non_nullable
                  as String?,
        userAttachment: freezed == userAttachment
            ? _value.userAttachment
            : userAttachment // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueryDetailItemImpl implements _QueryDetailItem {
  const _$QueryDetailItemImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'tkt_number') required this.ticketNumber,
    required this.category,
    required this.question,
    required this.description,
    @JsonKey(name: 'tkt_status') required this.ticketStatus,
    @JsonKey(name: 'query_submit') required this.querySubmit,
    this.replied,
    @JsonKey(name: 'replied_date') this.repliedDate,
    @JsonKey(name: 'reply_attachment') this.replyAttachment,
    @JsonKey(name: 'user_attachment') this.userAttachment,
  });

  factory _$QueryDetailItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueryDetailItemImplFromJson(json);

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
  final String? replied;
  @override
  @JsonKey(name: 'replied_date')
  final String? repliedDate;
  @override
  @JsonKey(name: 'reply_attachment')
  final String? replyAttachment;
  @override
  @JsonKey(name: 'user_attachment')
  final String? userAttachment;

  @override
  String toString() {
    return 'QueryDetailItem(id: $id, userId: $userId, ticketNumber: $ticketNumber, category: $category, question: $question, description: $description, ticketStatus: $ticketStatus, querySubmit: $querySubmit, replied: $replied, repliedDate: $repliedDate, replyAttachment: $replyAttachment, userAttachment: $userAttachment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueryDetailItemImpl &&
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
                other.querySubmit == querySubmit) &&
            (identical(other.replied, replied) || other.replied == replied) &&
            (identical(other.repliedDate, repliedDate) ||
                other.repliedDate == repliedDate) &&
            (identical(other.replyAttachment, replyAttachment) ||
                other.replyAttachment == replyAttachment) &&
            (identical(other.userAttachment, userAttachment) ||
                other.userAttachment == userAttachment));
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
    replied,
    repliedDate,
    replyAttachment,
    userAttachment,
  );

  /// Create a copy of QueryDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryDetailItemImplCopyWith<_$QueryDetailItemImpl> get copyWith =>
      __$$QueryDetailItemImplCopyWithImpl<_$QueryDetailItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QueryDetailItemImplToJson(this);
  }
}

abstract class _QueryDetailItem implements QueryDetailItem {
  const factory _QueryDetailItem({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'tkt_number') required final String ticketNumber,
    required final String category,
    required final String question,
    required final String description,
    @JsonKey(name: 'tkt_status') required final String ticketStatus,
    @JsonKey(name: 'query_submit') required final String querySubmit,
    final String? replied,
    @JsonKey(name: 'replied_date') final String? repliedDate,
    @JsonKey(name: 'reply_attachment') final String? replyAttachment,
    @JsonKey(name: 'user_attachment') final String? userAttachment,
  }) = _$QueryDetailItemImpl;

  factory _QueryDetailItem.fromJson(Map<String, dynamic> json) =
      _$QueryDetailItemImpl.fromJson;

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
  @override
  String? get replied;
  @override
  @JsonKey(name: 'replied_date')
  String? get repliedDate;
  @override
  @JsonKey(name: 'reply_attachment')
  String? get replyAttachment;
  @override
  @JsonKey(name: 'user_attachment')
  String? get userAttachment;

  /// Create a copy of QueryDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueryDetailItemImplCopyWith<_$QueryDetailItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
