// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_version_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppVersionResponse _$AppVersionResponseFromJson(Map<String, dynamic> json) {
  return _AppVersionResponse.fromJson(json);
}

/// @nodoc
mixin _$AppVersionResponse {
  int get status => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  AppVersionData get data => throw _privateConstructorUsedError;

  /// Serializes this AppVersionResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppVersionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppVersionResponseCopyWith<AppVersionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppVersionResponseCopyWith<$Res> {
  factory $AppVersionResponseCopyWith(
    AppVersionResponse value,
    $Res Function(AppVersionResponse) then,
  ) = _$AppVersionResponseCopyWithImpl<$Res, AppVersionResponse>;
  @useResult
  $Res call({int status, String msg, AppVersionData data});

  $AppVersionDataCopyWith<$Res> get data;
}

/// @nodoc
class _$AppVersionResponseCopyWithImpl<$Res, $Val extends AppVersionResponse>
    implements $AppVersionResponseCopyWith<$Res> {
  _$AppVersionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppVersionResponse
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
                      as AppVersionData,
          )
          as $Val,
    );
  }

  /// Create a copy of AppVersionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppVersionDataCopyWith<$Res> get data {
    return $AppVersionDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppVersionResponseImplCopyWith<$Res>
    implements $AppVersionResponseCopyWith<$Res> {
  factory _$$AppVersionResponseImplCopyWith(
    _$AppVersionResponseImpl value,
    $Res Function(_$AppVersionResponseImpl) then,
  ) = __$$AppVersionResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String msg, AppVersionData data});

  @override
  $AppVersionDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$AppVersionResponseImplCopyWithImpl<$Res>
    extends _$AppVersionResponseCopyWithImpl<$Res, _$AppVersionResponseImpl>
    implements _$$AppVersionResponseImplCopyWith<$Res> {
  __$$AppVersionResponseImplCopyWithImpl(
    _$AppVersionResponseImpl _value,
    $Res Function(_$AppVersionResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppVersionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? msg = null, Object? data = null}) {
    return _then(
      _$AppVersionResponseImpl(
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
                  as AppVersionData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppVersionResponseImpl implements _AppVersionResponse {
  const _$AppVersionResponseImpl({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory _$AppVersionResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppVersionResponseImplFromJson(json);

  @override
  final int status;
  @override
  final String msg;
  @override
  final AppVersionData data;

  @override
  String toString() {
    return 'AppVersionResponse(status: $status, msg: $msg, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppVersionResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, msg, data);

  /// Create a copy of AppVersionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppVersionResponseImplCopyWith<_$AppVersionResponseImpl> get copyWith =>
      __$$AppVersionResponseImplCopyWithImpl<_$AppVersionResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppVersionResponseImplToJson(this);
  }
}

abstract class _AppVersionResponse implements AppVersionResponse {
  const factory _AppVersionResponse({
    required final int status,
    required final String msg,
    required final AppVersionData data,
  }) = _$AppVersionResponseImpl;

  factory _AppVersionResponse.fromJson(Map<String, dynamic> json) =
      _$AppVersionResponseImpl.fromJson;

  @override
  int get status;
  @override
  String get msg;
  @override
  AppVersionData get data;

  /// Create a copy of AppVersionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppVersionResponseImplCopyWith<_$AppVersionResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppVersionData _$AppVersionDataFromJson(Map<String, dynamic> json) {
  return _AppVersionData.fromJson(json);
}

/// @nodoc
mixin _$AppVersionData {
  @JsonKey(name: 'show_update_modal')
  bool get showUpdateModal => throw _privateConstructorUsedError;
  @JsonKey(name: 'force_update')
  bool get forceUpdate => throw _privateConstructorUsedError;
  @JsonKey(name: 'latest_version')
  String get latestVersion => throw _privateConstructorUsedError;
  @JsonKey(name: 'update_title')
  String? get updateTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'update_message')
  String? get updateMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'whats_new')
  String? get whatsNew => throw _privateConstructorUsedError;

  /// Serializes this AppVersionData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppVersionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppVersionDataCopyWith<AppVersionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppVersionDataCopyWith<$Res> {
  factory $AppVersionDataCopyWith(
    AppVersionData value,
    $Res Function(AppVersionData) then,
  ) = _$AppVersionDataCopyWithImpl<$Res, AppVersionData>;
  @useResult
  $Res call({
    @JsonKey(name: 'show_update_modal') bool showUpdateModal,
    @JsonKey(name: 'force_update') bool forceUpdate,
    @JsonKey(name: 'latest_version') String latestVersion,
    @JsonKey(name: 'update_title') String? updateTitle,
    @JsonKey(name: 'update_message') String? updateMessage,
    @JsonKey(name: 'whats_new') String? whatsNew,
  });
}

/// @nodoc
class _$AppVersionDataCopyWithImpl<$Res, $Val extends AppVersionData>
    implements $AppVersionDataCopyWith<$Res> {
  _$AppVersionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppVersionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showUpdateModal = null,
    Object? forceUpdate = null,
    Object? latestVersion = null,
    Object? updateTitle = freezed,
    Object? updateMessage = freezed,
    Object? whatsNew = freezed,
  }) {
    return _then(
      _value.copyWith(
            showUpdateModal: null == showUpdateModal
                ? _value.showUpdateModal
                : showUpdateModal // ignore: cast_nullable_to_non_nullable
                      as bool,
            forceUpdate: null == forceUpdate
                ? _value.forceUpdate
                : forceUpdate // ignore: cast_nullable_to_non_nullable
                      as bool,
            latestVersion: null == latestVersion
                ? _value.latestVersion
                : latestVersion // ignore: cast_nullable_to_non_nullable
                      as String,
            updateTitle: freezed == updateTitle
                ? _value.updateTitle
                : updateTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            updateMessage: freezed == updateMessage
                ? _value.updateMessage
                : updateMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            whatsNew: freezed == whatsNew
                ? _value.whatsNew
                : whatsNew // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppVersionDataImplCopyWith<$Res>
    implements $AppVersionDataCopyWith<$Res> {
  factory _$$AppVersionDataImplCopyWith(
    _$AppVersionDataImpl value,
    $Res Function(_$AppVersionDataImpl) then,
  ) = __$$AppVersionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'show_update_modal') bool showUpdateModal,
    @JsonKey(name: 'force_update') bool forceUpdate,
    @JsonKey(name: 'latest_version') String latestVersion,
    @JsonKey(name: 'update_title') String? updateTitle,
    @JsonKey(name: 'update_message') String? updateMessage,
    @JsonKey(name: 'whats_new') String? whatsNew,
  });
}

/// @nodoc
class __$$AppVersionDataImplCopyWithImpl<$Res>
    extends _$AppVersionDataCopyWithImpl<$Res, _$AppVersionDataImpl>
    implements _$$AppVersionDataImplCopyWith<$Res> {
  __$$AppVersionDataImplCopyWithImpl(
    _$AppVersionDataImpl _value,
    $Res Function(_$AppVersionDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppVersionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showUpdateModal = null,
    Object? forceUpdate = null,
    Object? latestVersion = null,
    Object? updateTitle = freezed,
    Object? updateMessage = freezed,
    Object? whatsNew = freezed,
  }) {
    return _then(
      _$AppVersionDataImpl(
        showUpdateModal: null == showUpdateModal
            ? _value.showUpdateModal
            : showUpdateModal // ignore: cast_nullable_to_non_nullable
                  as bool,
        forceUpdate: null == forceUpdate
            ? _value.forceUpdate
            : forceUpdate // ignore: cast_nullable_to_non_nullable
                  as bool,
        latestVersion: null == latestVersion
            ? _value.latestVersion
            : latestVersion // ignore: cast_nullable_to_non_nullable
                  as String,
        updateTitle: freezed == updateTitle
            ? _value.updateTitle
            : updateTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        updateMessage: freezed == updateMessage
            ? _value.updateMessage
            : updateMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        whatsNew: freezed == whatsNew
            ? _value.whatsNew
            : whatsNew // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppVersionDataImpl implements _AppVersionData {
  const _$AppVersionDataImpl({
    @JsonKey(name: 'show_update_modal') required this.showUpdateModal,
    @JsonKey(name: 'force_update') required this.forceUpdate,
    @JsonKey(name: 'latest_version') required this.latestVersion,
    @JsonKey(name: 'update_title') this.updateTitle,
    @JsonKey(name: 'update_message') this.updateMessage,
    @JsonKey(name: 'whats_new') this.whatsNew,
  });

  factory _$AppVersionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppVersionDataImplFromJson(json);

  @override
  @JsonKey(name: 'show_update_modal')
  final bool showUpdateModal;
  @override
  @JsonKey(name: 'force_update')
  final bool forceUpdate;
  @override
  @JsonKey(name: 'latest_version')
  final String latestVersion;
  @override
  @JsonKey(name: 'update_title')
  final String? updateTitle;
  @override
  @JsonKey(name: 'update_message')
  final String? updateMessage;
  @override
  @JsonKey(name: 'whats_new')
  final String? whatsNew;

  @override
  String toString() {
    return 'AppVersionData(showUpdateModal: $showUpdateModal, forceUpdate: $forceUpdate, latestVersion: $latestVersion, updateTitle: $updateTitle, updateMessage: $updateMessage, whatsNew: $whatsNew)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppVersionDataImpl &&
            (identical(other.showUpdateModal, showUpdateModal) ||
                other.showUpdateModal == showUpdateModal) &&
            (identical(other.forceUpdate, forceUpdate) ||
                other.forceUpdate == forceUpdate) &&
            (identical(other.latestVersion, latestVersion) ||
                other.latestVersion == latestVersion) &&
            (identical(other.updateTitle, updateTitle) ||
                other.updateTitle == updateTitle) &&
            (identical(other.updateMessage, updateMessage) ||
                other.updateMessage == updateMessage) &&
            (identical(other.whatsNew, whatsNew) ||
                other.whatsNew == whatsNew));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    showUpdateModal,
    forceUpdate,
    latestVersion,
    updateTitle,
    updateMessage,
    whatsNew,
  );

  /// Create a copy of AppVersionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppVersionDataImplCopyWith<_$AppVersionDataImpl> get copyWith =>
      __$$AppVersionDataImplCopyWithImpl<_$AppVersionDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppVersionDataImplToJson(this);
  }
}

abstract class _AppVersionData implements AppVersionData {
  const factory _AppVersionData({
    @JsonKey(name: 'show_update_modal') required final bool showUpdateModal,
    @JsonKey(name: 'force_update') required final bool forceUpdate,
    @JsonKey(name: 'latest_version') required final String latestVersion,
    @JsonKey(name: 'update_title') final String? updateTitle,
    @JsonKey(name: 'update_message') final String? updateMessage,
    @JsonKey(name: 'whats_new') final String? whatsNew,
  }) = _$AppVersionDataImpl;

  factory _AppVersionData.fromJson(Map<String, dynamic> json) =
      _$AppVersionDataImpl.fromJson;

  @override
  @JsonKey(name: 'show_update_modal')
  bool get showUpdateModal;
  @override
  @JsonKey(name: 'force_update')
  bool get forceUpdate;
  @override
  @JsonKey(name: 'latest_version')
  String get latestVersion;
  @override
  @JsonKey(name: 'update_title')
  String? get updateTitle;
  @override
  @JsonKey(name: 'update_message')
  String? get updateMessage;
  @override
  @JsonKey(name: 'whats_new')
  String? get whatsNew;

  /// Create a copy of AppVersionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppVersionDataImplCopyWith<_$AppVersionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
