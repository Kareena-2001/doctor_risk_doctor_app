import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';

part 'register_request.g.dart';

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    @JsonKey(name: 'product_type_id') required String productTypeId,

    required String prefix,

    @JsonKey(name: 'first_name') required String firstName,

    @JsonKey(name: 'middle_name') String? middleName,

    @JsonKey(name: 'last_name') required String lastName,

    @JsonKey(name: 'mobile_no') required String mobileNo,

    String? email,

    @JsonKey(name: 'category_id') required int categoryId,

    @JsonKey(name: 'speciality_id') required int? specialityId,

    required String? degree,

    @JsonKey(name: 'organization_name') String? organizationName,

    required String source,

    required String password,

    @JsonKey(name: 'terms_privacy_accepted') required bool termsPrivacyAccepted,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}
