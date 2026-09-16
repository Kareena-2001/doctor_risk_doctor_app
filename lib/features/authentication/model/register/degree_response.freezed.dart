// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'degree_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DegreeResponse _$DegreeResponseFromJson(Map<String, dynamic> json) {
  return _DegreeResponse.fromJson(json);
}

/// @nodoc
mixin _$DegreeResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  List<DegreeModel> get data => throw _privateConstructorUsedError;

  /// Serializes this DegreeResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DegreeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DegreeResponseCopyWith<DegreeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DegreeResponseCopyWith<$Res> {
  factory $DegreeResponseCopyWith(
    DegreeResponse value,
    $Res Function(DegreeResponse) then,
  ) = _$DegreeResponseCopyWithImpl<$Res, DegreeResponse>;
  @useResult
  $Res call({bool status, int code, String msg, List<DegreeModel> data});
}

/// @nodoc
class _$DegreeResponseCopyWithImpl<$Res, $Val extends DegreeResponse>
    implements $DegreeResponseCopyWith<$Res> {
  _$DegreeResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DegreeResponse
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
                      as List<DegreeModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DegreeResponseImplCopyWith<$Res>
    implements $DegreeResponseCopyWith<$Res> {
  factory _$$DegreeResponseImplCopyWith(
    _$DegreeResponseImpl value,
    $Res Function(_$DegreeResponseImpl) then,
  ) = __$$DegreeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, int code, String msg, List<DegreeModel> data});
}

/// @nodoc
class __$$DegreeResponseImplCopyWithImpl<$Res>
    extends _$DegreeResponseCopyWithImpl<$Res, _$DegreeResponseImpl>
    implements _$$DegreeResponseImplCopyWith<$Res> {
  __$$DegreeResponseImplCopyWithImpl(
    _$DegreeResponseImpl _value,
    $Res Function(_$DegreeResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DegreeResponse
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
      _$DegreeResponseImpl(
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
                  as List<DegreeModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DegreeResponseImpl implements _DegreeResponse {
  const _$DegreeResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    required final List<DegreeModel> data,
  }) : _data = data;

  factory _$DegreeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DegreeResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  final List<DegreeModel> _data;
  @override
  List<DegreeModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'DegreeResponse(status: $status, code: $code, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DegreeResponseImpl &&
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

  /// Create a copy of DegreeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DegreeResponseImplCopyWith<_$DegreeResponseImpl> get copyWith =>
      __$$DegreeResponseImplCopyWithImpl<_$DegreeResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DegreeResponseImplToJson(this);
  }
}

abstract class _DegreeResponse implements DegreeResponse {
  const factory _DegreeResponse({
    required final bool status,
    required final int code,
    required final String msg,
    required final List<DegreeModel> data,
  }) = _$DegreeResponseImpl;

  factory _DegreeResponse.fromJson(Map<String, dynamic> json) =
      _$DegreeResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  List<DegreeModel> get data;

  /// Create a copy of DegreeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DegreeResponseImplCopyWith<_$DegreeResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DegreeModel _$DegreeModelFromJson(Map<String, dynamic> json) {
  return _DegreeModel.fromJson(json);
}

/// @nodoc
mixin _$DegreeModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this DegreeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DegreeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DegreeModelCopyWith<DegreeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DegreeModelCopyWith<$Res> {
  factory $DegreeModelCopyWith(
    DegreeModel value,
    $Res Function(DegreeModel) then,
  ) = _$DegreeModelCopyWithImpl<$Res, DegreeModel>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$DegreeModelCopyWithImpl<$Res, $Val extends DegreeModel>
    implements $DegreeModelCopyWith<$Res> {
  _$DegreeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DegreeModel
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
abstract class _$$DegreeModelImplCopyWith<$Res>
    implements $DegreeModelCopyWith<$Res> {
  factory _$$DegreeModelImplCopyWith(
    _$DegreeModelImpl value,
    $Res Function(_$DegreeModelImpl) then,
  ) = __$$DegreeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$DegreeModelImplCopyWithImpl<$Res>
    extends _$DegreeModelCopyWithImpl<$Res, _$DegreeModelImpl>
    implements _$$DegreeModelImplCopyWith<$Res> {
  __$$DegreeModelImplCopyWithImpl(
    _$DegreeModelImpl _value,
    $Res Function(_$DegreeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DegreeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$DegreeModelImpl(
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
class _$DegreeModelImpl implements _DegreeModel {
  const _$DegreeModelImpl({required this.id, required this.name});

  factory _$DegreeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DegreeModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'DegreeModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DegreeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of DegreeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DegreeModelImplCopyWith<_$DegreeModelImpl> get copyWith =>
      __$$DegreeModelImplCopyWithImpl<_$DegreeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DegreeModelImplToJson(this);
  }
}

abstract class _DegreeModel implements DegreeModel {
  const factory _DegreeModel({
    required final int id,
    required final String name,
  }) = _$DegreeModelImpl;

  factory _DegreeModel.fromJson(Map<String, dynamic> json) =
      _$DegreeModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of DegreeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DegreeModelImplCopyWith<_$DegreeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
