// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CommunityState {
  AsyncValue<TestimonialResponse> get testimonialList =>
      throw _privateConstructorUsedError;
  AsyncValue<PeerForumResponse> get peerForumList =>
      throw _privateConstructorUsedError;
  AsyncValue<DoctorNoResponse> get referralLink =>
      throw _privateConstructorUsedError;
  bool get isCategoryLoading => throw _privateConstructorUsedError;
  String? get categoryError => throw _privateConstructorUsedError;
  List<IdNameOption> get categories => throw _privateConstructorUsedError;
  IdNameOption? get selectedCategory => throw _privateConstructorUsedError;
  bool get isSpecialityLoading => throw _privateConstructorUsedError;
  String? get specialityError => throw _privateConstructorUsedError;
  List<IdNameOption> get specialities => throw _privateConstructorUsedError;
  IdNameOption? get selectedSpeciality => throw _privateConstructorUsedError;
  bool get isDegreeLoading => throw _privateConstructorUsedError;
  String? get degreeError => throw _privateConstructorUsedError;
  List<IdNameOption> get degrees => throw _privateConstructorUsedError;
  List<IdNameOption> get selectedDegrees => throw _privateConstructorUsedError;
  AsyncValue<ReferDoctorResponse>? get addReferral =>
      throw _privateConstructorUsedError;
  AsyncValue<ReferredDoctorsResponse> get referralList =>
      throw _privateConstructorUsedError;

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityStateCopyWith<CommunityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityStateCopyWith<$Res> {
  factory $CommunityStateCopyWith(
    CommunityState value,
    $Res Function(CommunityState) then,
  ) = _$CommunityStateCopyWithImpl<$Res, CommunityState>;
  @useResult
  $Res call({
    AsyncValue<TestimonialResponse> testimonialList,
    AsyncValue<PeerForumResponse> peerForumList,
    AsyncValue<DoctorNoResponse> referralLink,
    bool isCategoryLoading,
    String? categoryError,
    List<IdNameOption> categories,
    IdNameOption? selectedCategory,
    bool isSpecialityLoading,
    String? specialityError,
    List<IdNameOption> specialities,
    IdNameOption? selectedSpeciality,
    bool isDegreeLoading,
    String? degreeError,
    List<IdNameOption> degrees,
    List<IdNameOption> selectedDegrees,
    AsyncValue<ReferDoctorResponse>? addReferral,
    AsyncValue<ReferredDoctorsResponse> referralList,
  });
}

/// @nodoc
class _$CommunityStateCopyWithImpl<$Res, $Val extends CommunityState>
    implements $CommunityStateCopyWith<$Res> {
  _$CommunityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testimonialList = null,
    Object? peerForumList = null,
    Object? referralLink = null,
    Object? isCategoryLoading = null,
    Object? categoryError = freezed,
    Object? categories = null,
    Object? selectedCategory = freezed,
    Object? isSpecialityLoading = null,
    Object? specialityError = freezed,
    Object? specialities = null,
    Object? selectedSpeciality = freezed,
    Object? isDegreeLoading = null,
    Object? degreeError = freezed,
    Object? degrees = null,
    Object? selectedDegrees = null,
    Object? addReferral = freezed,
    Object? referralList = null,
  }) {
    return _then(
      _value.copyWith(
            testimonialList: null == testimonialList
                ? _value.testimonialList
                : testimonialList // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<TestimonialResponse>,
            peerForumList: null == peerForumList
                ? _value.peerForumList
                : peerForumList // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<PeerForumResponse>,
            referralLink: null == referralLink
                ? _value.referralLink
                : referralLink // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<DoctorNoResponse>,
            isCategoryLoading: null == isCategoryLoading
                ? _value.isCategoryLoading
                : isCategoryLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            categoryError: freezed == categoryError
                ? _value.categoryError
                : categoryError // ignore: cast_nullable_to_non_nullable
                      as String?,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<IdNameOption>,
            selectedCategory: freezed == selectedCategory
                ? _value.selectedCategory
                : selectedCategory // ignore: cast_nullable_to_non_nullable
                      as IdNameOption?,
            isSpecialityLoading: null == isSpecialityLoading
                ? _value.isSpecialityLoading
                : isSpecialityLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            specialityError: freezed == specialityError
                ? _value.specialityError
                : specialityError // ignore: cast_nullable_to_non_nullable
                      as String?,
            specialities: null == specialities
                ? _value.specialities
                : specialities // ignore: cast_nullable_to_non_nullable
                      as List<IdNameOption>,
            selectedSpeciality: freezed == selectedSpeciality
                ? _value.selectedSpeciality
                : selectedSpeciality // ignore: cast_nullable_to_non_nullable
                      as IdNameOption?,
            isDegreeLoading: null == isDegreeLoading
                ? _value.isDegreeLoading
                : isDegreeLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            degreeError: freezed == degreeError
                ? _value.degreeError
                : degreeError // ignore: cast_nullable_to_non_nullable
                      as String?,
            degrees: null == degrees
                ? _value.degrees
                : degrees // ignore: cast_nullable_to_non_nullable
                      as List<IdNameOption>,
            selectedDegrees: null == selectedDegrees
                ? _value.selectedDegrees
                : selectedDegrees // ignore: cast_nullable_to_non_nullable
                      as List<IdNameOption>,
            addReferral: freezed == addReferral
                ? _value.addReferral
                : addReferral // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<ReferDoctorResponse>?,
            referralList: null == referralList
                ? _value.referralList
                : referralList // ignore: cast_nullable_to_non_nullable
                      as AsyncValue<ReferredDoctorsResponse>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommunityStateImplCopyWith<$Res>
    implements $CommunityStateCopyWith<$Res> {
  factory _$$CommunityStateImplCopyWith(
    _$CommunityStateImpl value,
    $Res Function(_$CommunityStateImpl) then,
  ) = __$$CommunityStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AsyncValue<TestimonialResponse> testimonialList,
    AsyncValue<PeerForumResponse> peerForumList,
    AsyncValue<DoctorNoResponse> referralLink,
    bool isCategoryLoading,
    String? categoryError,
    List<IdNameOption> categories,
    IdNameOption? selectedCategory,
    bool isSpecialityLoading,
    String? specialityError,
    List<IdNameOption> specialities,
    IdNameOption? selectedSpeciality,
    bool isDegreeLoading,
    String? degreeError,
    List<IdNameOption> degrees,
    List<IdNameOption> selectedDegrees,
    AsyncValue<ReferDoctorResponse>? addReferral,
    AsyncValue<ReferredDoctorsResponse> referralList,
  });
}

/// @nodoc
class __$$CommunityStateImplCopyWithImpl<$Res>
    extends _$CommunityStateCopyWithImpl<$Res, _$CommunityStateImpl>
    implements _$$CommunityStateImplCopyWith<$Res> {
  __$$CommunityStateImplCopyWithImpl(
    _$CommunityStateImpl _value,
    $Res Function(_$CommunityStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testimonialList = null,
    Object? peerForumList = null,
    Object? referralLink = null,
    Object? isCategoryLoading = null,
    Object? categoryError = freezed,
    Object? categories = null,
    Object? selectedCategory = freezed,
    Object? isSpecialityLoading = null,
    Object? specialityError = freezed,
    Object? specialities = null,
    Object? selectedSpeciality = freezed,
    Object? isDegreeLoading = null,
    Object? degreeError = freezed,
    Object? degrees = null,
    Object? selectedDegrees = null,
    Object? addReferral = freezed,
    Object? referralList = null,
  }) {
    return _then(
      _$CommunityStateImpl(
        testimonialList: null == testimonialList
            ? _value.testimonialList
            : testimonialList // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<TestimonialResponse>,
        peerForumList: null == peerForumList
            ? _value.peerForumList
            : peerForumList // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<PeerForumResponse>,
        referralLink: null == referralLink
            ? _value.referralLink
            : referralLink // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<DoctorNoResponse>,
        isCategoryLoading: null == isCategoryLoading
            ? _value.isCategoryLoading
            : isCategoryLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        categoryError: freezed == categoryError
            ? _value.categoryError
            : categoryError // ignore: cast_nullable_to_non_nullable
                  as String?,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<IdNameOption>,
        selectedCategory: freezed == selectedCategory
            ? _value.selectedCategory
            : selectedCategory // ignore: cast_nullable_to_non_nullable
                  as IdNameOption?,
        isSpecialityLoading: null == isSpecialityLoading
            ? _value.isSpecialityLoading
            : isSpecialityLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        specialityError: freezed == specialityError
            ? _value.specialityError
            : specialityError // ignore: cast_nullable_to_non_nullable
                  as String?,
        specialities: null == specialities
            ? _value._specialities
            : specialities // ignore: cast_nullable_to_non_nullable
                  as List<IdNameOption>,
        selectedSpeciality: freezed == selectedSpeciality
            ? _value.selectedSpeciality
            : selectedSpeciality // ignore: cast_nullable_to_non_nullable
                  as IdNameOption?,
        isDegreeLoading: null == isDegreeLoading
            ? _value.isDegreeLoading
            : isDegreeLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        degreeError: freezed == degreeError
            ? _value.degreeError
            : degreeError // ignore: cast_nullable_to_non_nullable
                  as String?,
        degrees: null == degrees
            ? _value._degrees
            : degrees // ignore: cast_nullable_to_non_nullable
                  as List<IdNameOption>,
        selectedDegrees: null == selectedDegrees
            ? _value._selectedDegrees
            : selectedDegrees // ignore: cast_nullable_to_non_nullable
                  as List<IdNameOption>,
        addReferral: freezed == addReferral
            ? _value.addReferral
            : addReferral // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<ReferDoctorResponse>?,
        referralList: null == referralList
            ? _value.referralList
            : referralList // ignore: cast_nullable_to_non_nullable
                  as AsyncValue<ReferredDoctorsResponse>,
      ),
    );
  }
}

/// @nodoc

class _$CommunityStateImpl implements _CommunityState {
  const _$CommunityStateImpl({
    this.testimonialList = const AsyncLoading(),
    this.peerForumList = const AsyncLoading(),
    this.referralLink = const AsyncLoading(),
    this.isCategoryLoading = false,
    this.categoryError,
    final List<IdNameOption> categories = const <IdNameOption>[],
    this.selectedCategory,
    this.isSpecialityLoading = false,
    this.specialityError,
    final List<IdNameOption> specialities = const <IdNameOption>[],
    this.selectedSpeciality,
    this.isDegreeLoading = false,
    this.degreeError,
    final List<IdNameOption> degrees = const <IdNameOption>[],
    final List<IdNameOption> selectedDegrees = const <IdNameOption>[],
    this.addReferral,
    this.referralList = const AsyncLoading(),
  }) : _categories = categories,
       _specialities = specialities,
       _degrees = degrees,
       _selectedDegrees = selectedDegrees;

  @override
  @JsonKey()
  final AsyncValue<TestimonialResponse> testimonialList;
  @override
  @JsonKey()
  final AsyncValue<PeerForumResponse> peerForumList;
  @override
  @JsonKey()
  final AsyncValue<DoctorNoResponse> referralLink;
  @override
  @JsonKey()
  final bool isCategoryLoading;
  @override
  final String? categoryError;
  final List<IdNameOption> _categories;
  @override
  @JsonKey()
  List<IdNameOption> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final IdNameOption? selectedCategory;
  @override
  @JsonKey()
  final bool isSpecialityLoading;
  @override
  final String? specialityError;
  final List<IdNameOption> _specialities;
  @override
  @JsonKey()
  List<IdNameOption> get specialities {
    if (_specialities is EqualUnmodifiableListView) return _specialities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_specialities);
  }

  @override
  final IdNameOption? selectedSpeciality;
  @override
  @JsonKey()
  final bool isDegreeLoading;
  @override
  final String? degreeError;
  final List<IdNameOption> _degrees;
  @override
  @JsonKey()
  List<IdNameOption> get degrees {
    if (_degrees is EqualUnmodifiableListView) return _degrees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_degrees);
  }

  final List<IdNameOption> _selectedDegrees;
  @override
  @JsonKey()
  List<IdNameOption> get selectedDegrees {
    if (_selectedDegrees is EqualUnmodifiableListView) return _selectedDegrees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedDegrees);
  }

  @override
  final AsyncValue<ReferDoctorResponse>? addReferral;
  @override
  @JsonKey()
  final AsyncValue<ReferredDoctorsResponse> referralList;

  @override
  String toString() {
    return 'CommunityState(testimonialList: $testimonialList, peerForumList: $peerForumList, referralLink: $referralLink, isCategoryLoading: $isCategoryLoading, categoryError: $categoryError, categories: $categories, selectedCategory: $selectedCategory, isSpecialityLoading: $isSpecialityLoading, specialityError: $specialityError, specialities: $specialities, selectedSpeciality: $selectedSpeciality, isDegreeLoading: $isDegreeLoading, degreeError: $degreeError, degrees: $degrees, selectedDegrees: $selectedDegrees, addReferral: $addReferral, referralList: $referralList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityStateImpl &&
            (identical(other.testimonialList, testimonialList) ||
                other.testimonialList == testimonialList) &&
            (identical(other.peerForumList, peerForumList) ||
                other.peerForumList == peerForumList) &&
            (identical(other.referralLink, referralLink) ||
                other.referralLink == referralLink) &&
            (identical(other.isCategoryLoading, isCategoryLoading) ||
                other.isCategoryLoading == isCategoryLoading) &&
            (identical(other.categoryError, categoryError) ||
                other.categoryError == categoryError) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.isSpecialityLoading, isSpecialityLoading) ||
                other.isSpecialityLoading == isSpecialityLoading) &&
            (identical(other.specialityError, specialityError) ||
                other.specialityError == specialityError) &&
            const DeepCollectionEquality().equals(
              other._specialities,
              _specialities,
            ) &&
            (identical(other.selectedSpeciality, selectedSpeciality) ||
                other.selectedSpeciality == selectedSpeciality) &&
            (identical(other.isDegreeLoading, isDegreeLoading) ||
                other.isDegreeLoading == isDegreeLoading) &&
            (identical(other.degreeError, degreeError) ||
                other.degreeError == degreeError) &&
            const DeepCollectionEquality().equals(other._degrees, _degrees) &&
            const DeepCollectionEquality().equals(
              other._selectedDegrees,
              _selectedDegrees,
            ) &&
            (identical(other.addReferral, addReferral) ||
                other.addReferral == addReferral) &&
            (identical(other.referralList, referralList) ||
                other.referralList == referralList));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    testimonialList,
    peerForumList,
    referralLink,
    isCategoryLoading,
    categoryError,
    const DeepCollectionEquality().hash(_categories),
    selectedCategory,
    isSpecialityLoading,
    specialityError,
    const DeepCollectionEquality().hash(_specialities),
    selectedSpeciality,
    isDegreeLoading,
    degreeError,
    const DeepCollectionEquality().hash(_degrees),
    const DeepCollectionEquality().hash(_selectedDegrees),
    addReferral,
    referralList,
  );

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityStateImplCopyWith<_$CommunityStateImpl> get copyWith =>
      __$$CommunityStateImplCopyWithImpl<_$CommunityStateImpl>(
        this,
        _$identity,
      );
}

abstract class _CommunityState implements CommunityState {
  const factory _CommunityState({
    final AsyncValue<TestimonialResponse> testimonialList,
    final AsyncValue<PeerForumResponse> peerForumList,
    final AsyncValue<DoctorNoResponse> referralLink,
    final bool isCategoryLoading,
    final String? categoryError,
    final List<IdNameOption> categories,
    final IdNameOption? selectedCategory,
    final bool isSpecialityLoading,
    final String? specialityError,
    final List<IdNameOption> specialities,
    final IdNameOption? selectedSpeciality,
    final bool isDegreeLoading,
    final String? degreeError,
    final List<IdNameOption> degrees,
    final List<IdNameOption> selectedDegrees,
    final AsyncValue<ReferDoctorResponse>? addReferral,
    final AsyncValue<ReferredDoctorsResponse> referralList,
  }) = _$CommunityStateImpl;

  @override
  AsyncValue<TestimonialResponse> get testimonialList;
  @override
  AsyncValue<PeerForumResponse> get peerForumList;
  @override
  AsyncValue<DoctorNoResponse> get referralLink;
  @override
  bool get isCategoryLoading;
  @override
  String? get categoryError;
  @override
  List<IdNameOption> get categories;
  @override
  IdNameOption? get selectedCategory;
  @override
  bool get isSpecialityLoading;
  @override
  String? get specialityError;
  @override
  List<IdNameOption> get specialities;
  @override
  IdNameOption? get selectedSpeciality;
  @override
  bool get isDegreeLoading;
  @override
  String? get degreeError;
  @override
  List<IdNameOption> get degrees;
  @override
  List<IdNameOption> get selectedDegrees;
  @override
  AsyncValue<ReferDoctorResponse>? get addReferral;
  @override
  AsyncValue<ReferredDoctorsResponse> get referralList;

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityStateImplCopyWith<_$CommunityStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
