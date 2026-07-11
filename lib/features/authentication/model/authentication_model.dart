import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_model.freezed.dart';

part 'authentication_model.g.dart';

@freezed
class AuthenticationModel with _$AuthenticationModel {
  const factory AuthenticationModel({
    required int status,
    required String msg,
    required LoginData data,
  }) = _AuthenticationModel;

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationModelFromJson(json);
}

@freezed
class LoginData with _$LoginData {
  const factory LoginData({required String token, required Customer customer}) =
      _LoginData;

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
}

@freezed
class Customer with _$Customer {
  const factory Customer({
    required String id,
    String? vendor_employee_code,
    required String full_name,
    String? email,
    required String mobile,
    String? application_status,
    String? ol_generate,
    String? photo,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
