// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'holiday_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HolidayResponse _$HolidayResponseFromJson(Map<String, dynamic> json) {
  return _HolidayResponse.fromJson(json);
}

/// @nodoc
mixin _$HolidayResponse {
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'msg')
  String get message => throw _privateConstructorUsedError;
  List<HolidayData> get data => throw _privateConstructorUsedError;

  /// Serializes this HolidayResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HolidayResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HolidayResponseCopyWith<HolidayResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HolidayResponseCopyWith<$Res> {
  factory $HolidayResponseCopyWith(
    HolidayResponse value,
    $Res Function(HolidayResponse) then,
  ) = _$HolidayResponseCopyWithImpl<$Res, HolidayResponse>;
  @useResult
  $Res call({
    int status,
    @JsonKey(name: 'msg') String message,
    List<HolidayData> data,
  });
}

/// @nodoc
class _$HolidayResponseCopyWithImpl<$Res, $Val extends HolidayResponse>
    implements $HolidayResponseCopyWith<$Res> {
  _$HolidayResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HolidayResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<HolidayData>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HolidayResponseImplCopyWith<$Res>
    implements $HolidayResponseCopyWith<$Res> {
  factory _$$HolidayResponseImplCopyWith(
    _$HolidayResponseImpl value,
    $Res Function(_$HolidayResponseImpl) then,
  ) = __$$HolidayResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int status,
    @JsonKey(name: 'msg') String message,
    List<HolidayData> data,
  });
}

/// @nodoc
class __$$HolidayResponseImplCopyWithImpl<$Res>
    extends _$HolidayResponseCopyWithImpl<$Res, _$HolidayResponseImpl>
    implements _$$HolidayResponseImplCopyWith<$Res> {
  __$$HolidayResponseImplCopyWithImpl(
    _$HolidayResponseImpl _value,
    $Res Function(_$HolidayResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HolidayResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _$HolidayResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<HolidayData>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HolidayResponseImpl implements _HolidayResponse {
  const _$HolidayResponseImpl({
    required this.status,
    @JsonKey(name: 'msg') required this.message,
    required final List<HolidayData> data,
  }) : _data = data;

  factory _$HolidayResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$HolidayResponseImplFromJson(json);

  @override
  final int status;
  @override
  @JsonKey(name: 'msg')
  final String message;
  final List<HolidayData> _data;
  @override
  List<HolidayData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'HolidayResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HolidayResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    message,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of HolidayResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HolidayResponseImplCopyWith<_$HolidayResponseImpl> get copyWith =>
      __$$HolidayResponseImplCopyWithImpl<_$HolidayResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HolidayResponseImplToJson(this);
  }
}

abstract class _HolidayResponse implements HolidayResponse {
  const factory _HolidayResponse({
    required final int status,
    @JsonKey(name: 'msg') required final String message,
    required final List<HolidayData> data,
  }) = _$HolidayResponseImpl;

  factory _HolidayResponse.fromJson(Map<String, dynamic> json) =
      _$HolidayResponseImpl.fromJson;

  @override
  int get status;
  @override
  @JsonKey(name: 'msg')
  String get message;
  @override
  List<HolidayData> get data;

  /// Create a copy of HolidayResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HolidayResponseImplCopyWith<_$HolidayResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HolidayData _$HolidayDataFromJson(Map<String, dynamic> json) {
  return _HolidayData.fromJson(json);
}

/// @nodoc
mixin _$HolidayData {
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'holiday_date')
  String get holidayDate => throw _privateConstructorUsedError;

  /// Serializes this HolidayData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HolidayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HolidayDataCopyWith<HolidayData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HolidayDataCopyWith<$Res> {
  factory $HolidayDataCopyWith(
    HolidayData value,
    $Res Function(HolidayData) then,
  ) = _$HolidayDataCopyWithImpl<$Res, HolidayData>;
  @useResult
  $Res call({String title, @JsonKey(name: 'holiday_date') String holidayDate});
}

/// @nodoc
class _$HolidayDataCopyWithImpl<$Res, $Val extends HolidayData>
    implements $HolidayDataCopyWith<$Res> {
  _$HolidayDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HolidayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? holidayDate = null}) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            holidayDate: null == holidayDate
                ? _value.holidayDate
                : holidayDate // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HolidayDataImplCopyWith<$Res>
    implements $HolidayDataCopyWith<$Res> {
  factory _$$HolidayDataImplCopyWith(
    _$HolidayDataImpl value,
    $Res Function(_$HolidayDataImpl) then,
  ) = __$$HolidayDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, @JsonKey(name: 'holiday_date') String holidayDate});
}

/// @nodoc
class __$$HolidayDataImplCopyWithImpl<$Res>
    extends _$HolidayDataCopyWithImpl<$Res, _$HolidayDataImpl>
    implements _$$HolidayDataImplCopyWith<$Res> {
  __$$HolidayDataImplCopyWithImpl(
    _$HolidayDataImpl _value,
    $Res Function(_$HolidayDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HolidayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? holidayDate = null}) {
    return _then(
      _$HolidayDataImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        holidayDate: null == holidayDate
            ? _value.holidayDate
            : holidayDate // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HolidayDataImpl implements _HolidayData {
  const _$HolidayDataImpl({
    required this.title,
    @JsonKey(name: 'holiday_date') required this.holidayDate,
  });

  factory _$HolidayDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$HolidayDataImplFromJson(json);

  @override
  final String title;
  @override
  @JsonKey(name: 'holiday_date')
  final String holidayDate;

  @override
  String toString() {
    return 'HolidayData(title: $title, holidayDate: $holidayDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HolidayDataImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.holidayDate, holidayDate) ||
                other.holidayDate == holidayDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, holidayDate);

  /// Create a copy of HolidayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HolidayDataImplCopyWith<_$HolidayDataImpl> get copyWith =>
      __$$HolidayDataImplCopyWithImpl<_$HolidayDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HolidayDataImplToJson(this);
  }
}

abstract class _HolidayData implements HolidayData {
  const factory _HolidayData({
    required final String title,
    @JsonKey(name: 'holiday_date') required final String holidayDate,
  }) = _$HolidayDataImpl;

  factory _HolidayData.fromJson(Map<String, dynamic> json) =
      _$HolidayDataImpl.fromJson;

  @override
  String get title;
  @override
  @JsonKey(name: 'holiday_date')
  String get holidayDate;

  /// Create a copy of HolidayData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HolidayDataImplCopyWith<_$HolidayDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
