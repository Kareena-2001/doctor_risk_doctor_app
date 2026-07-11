// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'help_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HelpState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get tktNumber => throw _privateConstructorUsedError;
  List<QueryListItem> get queries => throw _privateConstructorUsedError;
  bool get isFetchingQueries => throw _privateConstructorUsedError;
  QueryDetailItem? get queryDetail => throw _privateConstructorUsedError;
  bool get isFetchingQueryDetail => throw _privateConstructorUsedError;
  String? get queryDetailError => throw _privateConstructorUsedError;

  /// Create a copy of HelpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HelpStateCopyWith<HelpState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HelpStateCopyWith<$Res> {
  factory $HelpStateCopyWith(HelpState value, $Res Function(HelpState) then) =
      _$HelpStateCopyWithImpl<$Res, HelpState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isSuccess,
    String? error,
    String? tktNumber,
    List<QueryListItem> queries,
    bool isFetchingQueries,
    QueryDetailItem? queryDetail,
    bool isFetchingQueryDetail,
    String? queryDetailError,
  });

  $QueryDetailItemCopyWith<$Res>? get queryDetail;
}

/// @nodoc
class _$HelpStateCopyWithImpl<$Res, $Val extends HelpState>
    implements $HelpStateCopyWith<$Res> {
  _$HelpStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HelpState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? error = freezed,
    Object? tktNumber = freezed,
    Object? queries = null,
    Object? isFetchingQueries = null,
    Object? queryDetail = freezed,
    Object? isFetchingQueryDetail = null,
    Object? queryDetailError = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSuccess: null == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            tktNumber: freezed == tktNumber
                ? _value.tktNumber
                : tktNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            queries: null == queries
                ? _value.queries
                : queries // ignore: cast_nullable_to_non_nullable
                      as List<QueryListItem>,
            isFetchingQueries: null == isFetchingQueries
                ? _value.isFetchingQueries
                : isFetchingQueries // ignore: cast_nullable_to_non_nullable
                      as bool,
            queryDetail: freezed == queryDetail
                ? _value.queryDetail
                : queryDetail // ignore: cast_nullable_to_non_nullable
                      as QueryDetailItem?,
            isFetchingQueryDetail: null == isFetchingQueryDetail
                ? _value.isFetchingQueryDetail
                : isFetchingQueryDetail // ignore: cast_nullable_to_non_nullable
                      as bool,
            queryDetailError: freezed == queryDetailError
                ? _value.queryDetailError
                : queryDetailError // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of HelpState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueryDetailItemCopyWith<$Res>? get queryDetail {
    if (_value.queryDetail == null) {
      return null;
    }

    return $QueryDetailItemCopyWith<$Res>(_value.queryDetail!, (value) {
      return _then(_value.copyWith(queryDetail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HelpStateImplCopyWith<$Res>
    implements $HelpStateCopyWith<$Res> {
  factory _$$HelpStateImplCopyWith(
    _$HelpStateImpl value,
    $Res Function(_$HelpStateImpl) then,
  ) = __$$HelpStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isSuccess,
    String? error,
    String? tktNumber,
    List<QueryListItem> queries,
    bool isFetchingQueries,
    QueryDetailItem? queryDetail,
    bool isFetchingQueryDetail,
    String? queryDetailError,
  });

  @override
  $QueryDetailItemCopyWith<$Res>? get queryDetail;
}

/// @nodoc
class __$$HelpStateImplCopyWithImpl<$Res>
    extends _$HelpStateCopyWithImpl<$Res, _$HelpStateImpl>
    implements _$$HelpStateImplCopyWith<$Res> {
  __$$HelpStateImplCopyWithImpl(
    _$HelpStateImpl _value,
    $Res Function(_$HelpStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HelpState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? error = freezed,
    Object? tktNumber = freezed,
    Object? queries = null,
    Object? isFetchingQueries = null,
    Object? queryDetail = freezed,
    Object? isFetchingQueryDetail = null,
    Object? queryDetailError = freezed,
  }) {
    return _then(
      _$HelpStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSuccess: null == isSuccess
            ? _value.isSuccess
            : isSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        tktNumber: freezed == tktNumber
            ? _value.tktNumber
            : tktNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        queries: null == queries
            ? _value._queries
            : queries // ignore: cast_nullable_to_non_nullable
                  as List<QueryListItem>,
        isFetchingQueries: null == isFetchingQueries
            ? _value.isFetchingQueries
            : isFetchingQueries // ignore: cast_nullable_to_non_nullable
                  as bool,
        queryDetail: freezed == queryDetail
            ? _value.queryDetail
            : queryDetail // ignore: cast_nullable_to_non_nullable
                  as QueryDetailItem?,
        isFetchingQueryDetail: null == isFetchingQueryDetail
            ? _value.isFetchingQueryDetail
            : isFetchingQueryDetail // ignore: cast_nullable_to_non_nullable
                  as bool,
        queryDetailError: freezed == queryDetailError
            ? _value.queryDetailError
            : queryDetailError // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$HelpStateImpl implements _HelpState {
  const _$HelpStateImpl({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.tktNumber,
    final List<QueryListItem> queries = const [],
    this.isFetchingQueries = false,
    this.queryDetail,
    this.isFetchingQueryDetail = false,
    this.queryDetailError,
  }) : _queries = queries;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  final String? error;
  @override
  final String? tktNumber;
  final List<QueryListItem> _queries;
  @override
  @JsonKey()
  List<QueryListItem> get queries {
    if (_queries is EqualUnmodifiableListView) return _queries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_queries);
  }

  @override
  @JsonKey()
  final bool isFetchingQueries;
  @override
  final QueryDetailItem? queryDetail;
  @override
  @JsonKey()
  final bool isFetchingQueryDetail;
  @override
  final String? queryDetailError;

  @override
  String toString() {
    return 'HelpState(isLoading: $isLoading, isSuccess: $isSuccess, error: $error, tktNumber: $tktNumber, queries: $queries, isFetchingQueries: $isFetchingQueries, queryDetail: $queryDetail, isFetchingQueryDetail: $isFetchingQueryDetail, queryDetailError: $queryDetailError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HelpStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.tktNumber, tktNumber) ||
                other.tktNumber == tktNumber) &&
            const DeepCollectionEquality().equals(other._queries, _queries) &&
            (identical(other.isFetchingQueries, isFetchingQueries) ||
                other.isFetchingQueries == isFetchingQueries) &&
            (identical(other.queryDetail, queryDetail) ||
                other.queryDetail == queryDetail) &&
            (identical(other.isFetchingQueryDetail, isFetchingQueryDetail) ||
                other.isFetchingQueryDetail == isFetchingQueryDetail) &&
            (identical(other.queryDetailError, queryDetailError) ||
                other.queryDetailError == queryDetailError));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isSuccess,
    error,
    tktNumber,
    const DeepCollectionEquality().hash(_queries),
    isFetchingQueries,
    queryDetail,
    isFetchingQueryDetail,
    queryDetailError,
  );

  /// Create a copy of HelpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HelpStateImplCopyWith<_$HelpStateImpl> get copyWith =>
      __$$HelpStateImplCopyWithImpl<_$HelpStateImpl>(this, _$identity);
}

abstract class _HelpState implements HelpState {
  const factory _HelpState({
    final bool isLoading,
    final bool isSuccess,
    final String? error,
    final String? tktNumber,
    final List<QueryListItem> queries,
    final bool isFetchingQueries,
    final QueryDetailItem? queryDetail,
    final bool isFetchingQueryDetail,
    final String? queryDetailError,
  }) = _$HelpStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isSuccess;
  @override
  String? get error;
  @override
  String? get tktNumber;
  @override
  List<QueryListItem> get queries;
  @override
  bool get isFetchingQueries;
  @override
  QueryDetailItem? get queryDetail;
  @override
  bool get isFetchingQueryDetail;
  @override
  String? get queryDetailError;

  /// Create a copy of HelpState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HelpStateImplCopyWith<_$HelpStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
