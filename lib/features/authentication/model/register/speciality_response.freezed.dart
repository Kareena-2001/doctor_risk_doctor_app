// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speciality_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SpecialityResponse _$SpecialityResponseFromJson(Map<String, dynamic> json) {
  return _SpecialityResponse.fromJson(json);
}

/// @nodoc
mixin _$SpecialityResponse {
  bool get status => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  List<SpecialityModel> get data => throw _privateConstructorUsedError;

  /// Serializes this SpecialityResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpecialityResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpecialityResponseCopyWith<SpecialityResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpecialityResponseCopyWith<$Res> {
  factory $SpecialityResponseCopyWith(
    SpecialityResponse value,
    $Res Function(SpecialityResponse) then,
  ) = _$SpecialityResponseCopyWithImpl<$Res, SpecialityResponse>;
  @useResult
  $Res call({bool status, int code, String msg, List<SpecialityModel> data});
}

/// @nodoc
class _$SpecialityResponseCopyWithImpl<$Res, $Val extends SpecialityResponse>
    implements $SpecialityResponseCopyWith<$Res> {
  _$SpecialityResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpecialityResponse
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
                      as List<SpecialityModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SpecialityResponseImplCopyWith<$Res>
    implements $SpecialityResponseCopyWith<$Res> {
  factory _$$SpecialityResponseImplCopyWith(
    _$SpecialityResponseImpl value,
    $Res Function(_$SpecialityResponseImpl) then,
  ) = __$$SpecialityResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, int code, String msg, List<SpecialityModel> data});
}

/// @nodoc
class __$$SpecialityResponseImplCopyWithImpl<$Res>
    extends _$SpecialityResponseCopyWithImpl<$Res, _$SpecialityResponseImpl>
    implements _$$SpecialityResponseImplCopyWith<$Res> {
  __$$SpecialityResponseImplCopyWithImpl(
    _$SpecialityResponseImpl _value,
    $Res Function(_$SpecialityResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SpecialityResponse
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
      _$SpecialityResponseImpl(
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
                  as List<SpecialityModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SpecialityResponseImpl implements _SpecialityResponse {
  const _$SpecialityResponseImpl({
    required this.status,
    required this.code,
    required this.msg,
    required final List<SpecialityModel> data,
  }) : _data = data;

  factory _$SpecialityResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpecialityResponseImplFromJson(json);

  @override
  final bool status;
  @override
  final int code;
  @override
  final String msg;
  final List<SpecialityModel> _data;
  @override
  List<SpecialityModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'SpecialityResponse(status: $status, code: $code, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecialityResponseImpl &&
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

  /// Create a copy of SpecialityResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpecialityResponseImplCopyWith<_$SpecialityResponseImpl> get copyWith =>
      __$$SpecialityResponseImplCopyWithImpl<_$SpecialityResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SpecialityResponseImplToJson(this);
  }
}

abstract class _SpecialityResponse implements SpecialityResponse {
  const factory _SpecialityResponse({
    required final bool status,
    required final int code,
    required final String msg,
    required final List<SpecialityModel> data,
  }) = _$SpecialityResponseImpl;

  factory _SpecialityResponse.fromJson(Map<String, dynamic> json) =
      _$SpecialityResponseImpl.fromJson;

  @override
  bool get status;
  @override
  int get code;
  @override
  String get msg;
  @override
  List<SpecialityModel> get data;

  /// Create a copy of SpecialityResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpecialityResponseImplCopyWith<_$SpecialityResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SpecialityModel _$SpecialityModelFromJson(Map<String, dynamic> json) {
  return _SpecialityModel.fromJson(json);
}

/// @nodoc
mixin _$SpecialityModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this SpecialityModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpecialityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpecialityModelCopyWith<SpecialityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpecialityModelCopyWith<$Res> {
  factory $SpecialityModelCopyWith(
    SpecialityModel value,
    $Res Function(SpecialityModel) then,
  ) = _$SpecialityModelCopyWithImpl<$Res, SpecialityModel>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$SpecialityModelCopyWithImpl<$Res, $Val extends SpecialityModel>
    implements $SpecialityModelCopyWith<$Res> {
  _$SpecialityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpecialityModel
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
abstract class _$$SpecialityModelImplCopyWith<$Res>
    implements $SpecialityModelCopyWith<$Res> {
  factory _$$SpecialityModelImplCopyWith(
    _$SpecialityModelImpl value,
    $Res Function(_$SpecialityModelImpl) then,
  ) = __$$SpecialityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$SpecialityModelImplCopyWithImpl<$Res>
    extends _$SpecialityModelCopyWithImpl<$Res, _$SpecialityModelImpl>
    implements _$$SpecialityModelImplCopyWith<$Res> {
  __$$SpecialityModelImplCopyWithImpl(
    _$SpecialityModelImpl _value,
    $Res Function(_$SpecialityModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SpecialityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$SpecialityModelImpl(
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
class _$SpecialityModelImpl implements _SpecialityModel {
  const _$SpecialityModelImpl({required this.id, required this.name});

  factory _$SpecialityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpecialityModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'SpecialityModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecialityModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of SpecialityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpecialityModelImplCopyWith<_$SpecialityModelImpl> get copyWith =>
      __$$SpecialityModelImplCopyWithImpl<_$SpecialityModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SpecialityModelImplToJson(this);
  }
}

abstract class _SpecialityModel implements SpecialityModel {
  const factory _SpecialityModel({
    required final int id,
    required final String name,
  }) = _$SpecialityModelImpl;

  factory _SpecialityModel.fromJson(Map<String, dynamic> json) =
      _$SpecialityModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of SpecialityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpecialityModelImplCopyWith<_$SpecialityModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
