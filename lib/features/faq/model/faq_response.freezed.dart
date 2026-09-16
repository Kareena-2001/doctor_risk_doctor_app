// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faq_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FaqResponse _$FaqResponseFromJson(Map<String, dynamic> json) {
  return _FaqResponse.fromJson(json);
}

/// @nodoc
mixin _$FaqResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  List<FaqModel> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page')
  int get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;

  /// Serializes this FaqResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FaqResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FaqResponseCopyWith<FaqResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaqResponseCopyWith<$Res> {
  factory $FaqResponseCopyWith(
    FaqResponse value,
    $Res Function(FaqResponse) then,
  ) = _$FaqResponseCopyWithImpl<$Res, FaqResponse>;
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<FaqModel> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class _$FaqResponseCopyWithImpl<$Res, $Val extends FaqResponse>
    implements $FaqResponseCopyWith<$Res> {
  _$FaqResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FaqResponse
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
                      as List<FaqModel>,
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
abstract class _$$FaqResponseImplCopyWith<$Res>
    implements $FaqResponseCopyWith<$Res> {
  factory _$$FaqResponseImplCopyWith(
    _$FaqResponseImpl value,
    $Res Function(_$FaqResponseImpl) then,
  ) = __$$FaqResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<FaqModel> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class __$$FaqResponseImplCopyWithImpl<$Res>
    extends _$FaqResponseCopyWithImpl<$Res, _$FaqResponseImpl>
    implements _$$FaqResponseImplCopyWith<$Res> {
  __$$FaqResponseImplCopyWithImpl(
    _$FaqResponseImpl _value,
    $Res Function(_$FaqResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FaqResponse
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
      _$FaqResponseImpl(
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
                  as List<FaqModel>,
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
class _$FaqResponseImpl implements _FaqResponse {
  const _$FaqResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    required final List<FaqModel> data,
    required this.total,
    @JsonKey(name: 'current_page') required this.currentPage,
    @JsonKey(name: 'last_page') required this.lastPage,
    @JsonKey(name: 'per_page') required this.perPage,
  }) : _data = data;

  factory _$FaqResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaqResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  final List<FaqModel> _data;
  @override
  List<FaqModel> get data {
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
    return 'FaqResponse(status: $status, code: $code, msg: $msg, data: $data, total: $total, currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaqResponseImpl &&
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

  /// Create a copy of FaqResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FaqResponseImplCopyWith<_$FaqResponseImpl> get copyWith =>
      __$$FaqResponseImplCopyWithImpl<_$FaqResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FaqResponseImplToJson(this);
  }
}

abstract class _FaqResponse implements FaqResponse {
  const factory _FaqResponse({
    required final bool status,
    required final int code,
    required final String msg,
    required final List<FaqModel> data,
    required final int total,
    @JsonKey(name: 'current_page') required final int currentPage,
    @JsonKey(name: 'last_page') required final int lastPage,
    @JsonKey(name: 'per_page') required final int perPage,
  }) = _$FaqResponseImpl;

  factory _FaqResponse.fromJson(Map<String, dynamic> json) =
      _$FaqResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  List<FaqModel> get data;
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

  /// Create a copy of FaqResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaqResponseImplCopyWith<_$FaqResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FaqModel _$FaqModelFromJson(Map<String, dynamic> json) {
  return _FaqModel.fromJson(json);
}

/// @nodoc
mixin _$FaqModel {
  int get id => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  @JsonKey(name: 'ans_description')
  String get answerDescription => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'added_on')
  String get addedOn => throw _privateConstructorUsedError;

  /// Serializes this FaqModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FaqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FaqModelCopyWith<FaqModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaqModelCopyWith<$Res> {
  factory $FaqModelCopyWith(FaqModel value, $Res Function(FaqModel) then) =
      _$FaqModelCopyWithImpl<$Res, FaqModel>;
  @useResult
  $Res call({
    int id,
    String question,
    @JsonKey(name: 'ans_description') String answerDescription,
    String status,
    @JsonKey(name: 'added_on') String addedOn,
  });
}

/// @nodoc
class _$FaqModelCopyWithImpl<$Res, $Val extends FaqModel>
    implements $FaqModelCopyWith<$Res> {
  _$FaqModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FaqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? answerDescription = null,
    Object? status = null,
    Object? addedOn = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            answerDescription: null == answerDescription
                ? _value.answerDescription
                : answerDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            addedOn: null == addedOn
                ? _value.addedOn
                : addedOn // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FaqModelImplCopyWith<$Res>
    implements $FaqModelCopyWith<$Res> {
  factory _$$FaqModelImplCopyWith(
    _$FaqModelImpl value,
    $Res Function(_$FaqModelImpl) then,
  ) = __$$FaqModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String question,
    @JsonKey(name: 'ans_description') String answerDescription,
    String status,
    @JsonKey(name: 'added_on') String addedOn,
  });
}

/// @nodoc
class __$$FaqModelImplCopyWithImpl<$Res>
    extends _$FaqModelCopyWithImpl<$Res, _$FaqModelImpl>
    implements _$$FaqModelImplCopyWith<$Res> {
  __$$FaqModelImplCopyWithImpl(
    _$FaqModelImpl _value,
    $Res Function(_$FaqModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FaqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? answerDescription = null,
    Object? status = null,
    Object? addedOn = null,
  }) {
    return _then(
      _$FaqModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        answerDescription: null == answerDescription
            ? _value.answerDescription
            : answerDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        addedOn: null == addedOn
            ? _value.addedOn
            : addedOn // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FaqModelImpl implements _FaqModel {
  const _$FaqModelImpl({
    required this.id,
    required this.question,
    @JsonKey(name: 'ans_description') required this.answerDescription,
    required this.status,
    @JsonKey(name: 'added_on') required this.addedOn,
  });

  factory _$FaqModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaqModelImplFromJson(json);

  @override
  final int id;
  @override
  final String question;
  @override
  @JsonKey(name: 'ans_description')
  final String answerDescription;
  @override
  final String status;
  @override
  @JsonKey(name: 'added_on')
  final String addedOn;

  @override
  String toString() {
    return 'FaqModel(id: $id, question: $question, answerDescription: $answerDescription, status: $status, addedOn: $addedOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaqModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.answerDescription, answerDescription) ||
                other.answerDescription == answerDescription) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.addedOn, addedOn) || other.addedOn == addedOn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    question,
    answerDescription,
    status,
    addedOn,
  );

  /// Create a copy of FaqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FaqModelImplCopyWith<_$FaqModelImpl> get copyWith =>
      __$$FaqModelImplCopyWithImpl<_$FaqModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FaqModelImplToJson(this);
  }
}

abstract class _FaqModel implements FaqModel {
  const factory _FaqModel({
    required final int id,
    required final String question,
    @JsonKey(name: 'ans_description') required final String answerDescription,
    required final String status,
    @JsonKey(name: 'added_on') required final String addedOn,
  }) = _$FaqModelImpl;

  factory _FaqModel.fromJson(Map<String, dynamic> json) =
      _$FaqModelImpl.fromJson;

  @override
  int get id;
  @override
  String get question;
  @override
  @JsonKey(name: 'ans_description')
  String get answerDescription;
  @override
  String get status;
  @override
  @JsonKey(name: 'added_on')
  String get addedOn;

  /// Create a copy of FaqModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaqModelImplCopyWith<_$FaqModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
