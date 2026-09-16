// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medical_law_faq_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MedicalLawFaqResponse _$MedicalLawFaqResponseFromJson(
  Map<String, dynamic> json,
) {
  return _MedicalLawFaqResponse.fromJson(json);
}

/// @nodoc
mixin _$MedicalLawFaqResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  List<MedicalLawFaqModel> get data => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page')
  int get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;

  /// Serializes this MedicalLawFaqResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MedicalLawFaqResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicalLawFaqResponseCopyWith<MedicalLawFaqResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicalLawFaqResponseCopyWith<$Res> {
  factory $MedicalLawFaqResponseCopyWith(
    MedicalLawFaqResponse value,
    $Res Function(MedicalLawFaqResponse) then,
  ) = _$MedicalLawFaqResponseCopyWithImpl<$Res, MedicalLawFaqResponse>;
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<MedicalLawFaqModel> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class _$MedicalLawFaqResponseCopyWithImpl<
  $Res,
  $Val extends MedicalLawFaqResponse
>
    implements $MedicalLawFaqResponseCopyWith<$Res> {
  _$MedicalLawFaqResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicalLawFaqResponse
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
                      as List<MedicalLawFaqModel>,
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
abstract class _$$MedicalLawFaqResponseImplCopyWith<$Res>
    implements $MedicalLawFaqResponseCopyWith<$Res> {
  factory _$$MedicalLawFaqResponseImplCopyWith(
    _$MedicalLawFaqResponseImpl value,
    $Res Function(_$MedicalLawFaqResponseImpl) then,
  ) = __$$MedicalLawFaqResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool status,
    int code,
    String msg,
    List<MedicalLawFaqModel> data,
    int total,
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class __$$MedicalLawFaqResponseImplCopyWithImpl<$Res>
    extends
        _$MedicalLawFaqResponseCopyWithImpl<$Res, _$MedicalLawFaqResponseImpl>
    implements _$$MedicalLawFaqResponseImplCopyWith<$Res> {
  __$$MedicalLawFaqResponseImplCopyWithImpl(
    _$MedicalLawFaqResponseImpl _value,
    $Res Function(_$MedicalLawFaqResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MedicalLawFaqResponse
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
      _$MedicalLawFaqResponseImpl(
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
                  as List<MedicalLawFaqModel>,
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
class _$MedicalLawFaqResponseImpl implements _MedicalLawFaqResponse {
  const _$MedicalLawFaqResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    required final List<MedicalLawFaqModel> data,
    required this.total,
    @JsonKey(name: 'current_page') required this.currentPage,
    @JsonKey(name: 'last_page') required this.lastPage,
    @JsonKey(name: 'per_page') required this.perPage,
  }) : _data = data;

  factory _$MedicalLawFaqResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicalLawFaqResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  final List<MedicalLawFaqModel> _data;
  @override
  List<MedicalLawFaqModel> get data {
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
    return 'MedicalLawFaqResponse(status: $status, code: $code, msg: $msg, data: $data, total: $total, currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicalLawFaqResponseImpl &&
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

  /// Create a copy of MedicalLawFaqResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicalLawFaqResponseImplCopyWith<_$MedicalLawFaqResponseImpl>
  get copyWith =>
      __$$MedicalLawFaqResponseImplCopyWithImpl<_$MedicalLawFaqResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicalLawFaqResponseImplToJson(this);
  }
}

abstract class _MedicalLawFaqResponse implements MedicalLawFaqResponse {
  const factory _MedicalLawFaqResponse({
    required final bool status,
    required final int code,
    required final String msg,
    required final List<MedicalLawFaqModel> data,
    required final int total,
    @JsonKey(name: 'current_page') required final int currentPage,
    @JsonKey(name: 'last_page') required final int lastPage,
    @JsonKey(name: 'per_page') required final int perPage,
  }) = _$MedicalLawFaqResponseImpl;

  factory _MedicalLawFaqResponse.fromJson(Map<String, dynamic> json) =
      _$MedicalLawFaqResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  List<MedicalLawFaqModel> get data;
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

  /// Create a copy of MedicalLawFaqResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicalLawFaqResponseImplCopyWith<_$MedicalLawFaqResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

MedicalLawFaqModel _$MedicalLawFaqModelFromJson(Map<String, dynamic> json) {
  return _MedicalLawFaqModel.fromJson(json);
}

/// @nodoc
mixin _$MedicalLawFaqModel {
  int get id => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  @JsonKey(name: 'ans_description')
  String get answerDescription => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_on')
  String get createdOn => throw _privateConstructorUsedError;

  /// Serializes this MedicalLawFaqModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MedicalLawFaqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicalLawFaqModelCopyWith<MedicalLawFaqModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicalLawFaqModelCopyWith<$Res> {
  factory $MedicalLawFaqModelCopyWith(
    MedicalLawFaqModel value,
    $Res Function(MedicalLawFaqModel) then,
  ) = _$MedicalLawFaqModelCopyWithImpl<$Res, MedicalLawFaqModel>;
  @useResult
  $Res call({
    int id,
    String question,
    @JsonKey(name: 'ans_description') String answerDescription,
    String status,
    @JsonKey(name: 'created_on') String createdOn,
  });
}

/// @nodoc
class _$MedicalLawFaqModelCopyWithImpl<$Res, $Val extends MedicalLawFaqModel>
    implements $MedicalLawFaqModelCopyWith<$Res> {
  _$MedicalLawFaqModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicalLawFaqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? answerDescription = null,
    Object? status = null,
    Object? createdOn = null,
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
abstract class _$$MedicalLawFaqModelImplCopyWith<$Res>
    implements $MedicalLawFaqModelCopyWith<$Res> {
  factory _$$MedicalLawFaqModelImplCopyWith(
    _$MedicalLawFaqModelImpl value,
    $Res Function(_$MedicalLawFaqModelImpl) then,
  ) = __$$MedicalLawFaqModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String question,
    @JsonKey(name: 'ans_description') String answerDescription,
    String status,
    @JsonKey(name: 'created_on') String createdOn,
  });
}

/// @nodoc
class __$$MedicalLawFaqModelImplCopyWithImpl<$Res>
    extends _$MedicalLawFaqModelCopyWithImpl<$Res, _$MedicalLawFaqModelImpl>
    implements _$$MedicalLawFaqModelImplCopyWith<$Res> {
  __$$MedicalLawFaqModelImplCopyWithImpl(
    _$MedicalLawFaqModelImpl _value,
    $Res Function(_$MedicalLawFaqModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MedicalLawFaqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? answerDescription = null,
    Object? status = null,
    Object? createdOn = null,
  }) {
    return _then(
      _$MedicalLawFaqModelImpl(
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
class _$MedicalLawFaqModelImpl implements _MedicalLawFaqModel {
  const _$MedicalLawFaqModelImpl({
    required this.id,
    required this.question,
    @JsonKey(name: 'ans_description') required this.answerDescription,
    required this.status,
    @JsonKey(name: 'created_on') required this.createdOn,
  });

  factory _$MedicalLawFaqModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicalLawFaqModelImplFromJson(json);

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
  @JsonKey(name: 'created_on')
  final String createdOn;

  @override
  String toString() {
    return 'MedicalLawFaqModel(id: $id, question: $question, answerDescription: $answerDescription, status: $status, createdOn: $createdOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicalLawFaqModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.answerDescription, answerDescription) ||
                other.answerDescription == answerDescription) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    question,
    answerDescription,
    status,
    createdOn,
  );

  /// Create a copy of MedicalLawFaqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicalLawFaqModelImplCopyWith<_$MedicalLawFaqModelImpl> get copyWith =>
      __$$MedicalLawFaqModelImplCopyWithImpl<_$MedicalLawFaqModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicalLawFaqModelImplToJson(this);
  }
}

abstract class _MedicalLawFaqModel implements MedicalLawFaqModel {
  const factory _MedicalLawFaqModel({
    required final int id,
    required final String question,
    @JsonKey(name: 'ans_description') required final String answerDescription,
    required final String status,
    @JsonKey(name: 'created_on') required final String createdOn,
  }) = _$MedicalLawFaqModelImpl;

  factory _MedicalLawFaqModel.fromJson(Map<String, dynamic> json) =
      _$MedicalLawFaqModelImpl.fromJson;

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
  @JsonKey(name: 'created_on')
  String get createdOn;

  /// Create a copy of MedicalLawFaqModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicalLawFaqModelImplCopyWith<_$MedicalLawFaqModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
