// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StateResponse _$StateResponseFromJson(Map<String, dynamic> json) {
  return _StateResponse.fromJson(json);
}

/// @nodoc
mixin _$StateResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  List<StateModel> get data => throw _privateConstructorUsedError;

  /// Serializes this StateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StateResponseCopyWith<StateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StateResponseCopyWith<$Res> {
  factory $StateResponseCopyWith(
    StateResponse value,
    $Res Function(StateResponse) then,
  ) = _$StateResponseCopyWithImpl<$Res, StateResponse>;
  @useResult
  $Res call({bool status, int code, String msg, List<StateModel> data});
}

/// @nodoc
class _$StateResponseCopyWithImpl<$Res, $Val extends StateResponse>
    implements $StateResponseCopyWith<$Res> {
  _$StateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StateResponse
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
                      as List<StateModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StateResponseImplCopyWith<$Res>
    implements $StateResponseCopyWith<$Res> {
  factory _$$StateResponseImplCopyWith(
    _$StateResponseImpl value,
    $Res Function(_$StateResponseImpl) then,
  ) = __$$StateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, int code, String msg, List<StateModel> data});
}

/// @nodoc
class __$$StateResponseImplCopyWithImpl<$Res>
    extends _$StateResponseCopyWithImpl<$Res, _$StateResponseImpl>
    implements _$$StateResponseImplCopyWith<$Res> {
  __$$StateResponseImplCopyWithImpl(
    _$StateResponseImpl _value,
    $Res Function(_$StateResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StateResponse
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
      _$StateResponseImpl(
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
                  as List<StateModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StateResponseImpl implements _StateResponse {
  const _$StateResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    required final List<StateModel> data,
  }) : _data = data;

  factory _$StateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StateResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  final List<StateModel> _data;
  @override
  List<StateModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'StateResponse(status: $status, code: $code, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateResponseImpl &&
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

  /// Create a copy of StateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StateResponseImplCopyWith<_$StateResponseImpl> get copyWith =>
      __$$StateResponseImplCopyWithImpl<_$StateResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StateResponseImplToJson(this);
  }
}

abstract class _StateResponse implements StateResponse {
  const factory _StateResponse({
    required final bool status,
    required final int code,
    required final String msg,
    required final List<StateModel> data,
  }) = _$StateResponseImpl;

  factory _StateResponse.fromJson(Map<String, dynamic> json) =
      _$StateResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  List<StateModel> get data;

  /// Create a copy of StateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StateResponseImplCopyWith<_$StateResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StateModel _$StateModelFromJson(Map<String, dynamic> json) {
  return _StateModel.fromJson(json);
}

/// @nodoc
mixin _$StateModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this StateModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StateModelCopyWith<StateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StateModelCopyWith<$Res> {
  factory $StateModelCopyWith(
    StateModel value,
    $Res Function(StateModel) then,
  ) = _$StateModelCopyWithImpl<$Res, StateModel>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$StateModelCopyWithImpl<$Res, $Val extends StateModel>
    implements $StateModelCopyWith<$Res> {
  _$StateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StateModelImplCopyWith<$Res>
    implements $StateModelCopyWith<$Res> {
  factory _$$StateModelImplCopyWith(
    _$StateModelImpl value,
    $Res Function(_$StateModelImpl) then,
  ) = __$$StateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$StateModelImplCopyWithImpl<$Res>
    extends _$StateModelCopyWithImpl<$Res, _$StateModelImpl>
    implements _$$StateModelImplCopyWith<$Res> {
  __$$StateModelImplCopyWithImpl(
    _$StateModelImpl _value,
    $Res Function(_$StateModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$StateModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StateModelImpl implements _StateModel {
  const _$StateModelImpl({required this.id, required this.name});

  factory _$StateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StateModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'StateModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of StateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StateModelImplCopyWith<_$StateModelImpl> get copyWith =>
      __$$StateModelImplCopyWithImpl<_$StateModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StateModelImplToJson(this);
  }
}

abstract class _StateModel implements StateModel {
  const factory _StateModel({
    required final int id,
    required final String name,
  }) = _$StateModelImpl;

  factory _StateModel.fromJson(Map<String, dynamic> json) =
      _$StateModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of StateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StateModelImplCopyWith<_$StateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
