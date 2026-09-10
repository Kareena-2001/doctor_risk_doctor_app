import 'package:Doctors_App/features/authentication/model/login/login_response.dart';
import 'package:Doctors_App/features/authentication/model/register/sign_up_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_state.freezed.dart';

enum RegistrationType { professional, establishment }

class IdNameOption {
  final int id;
  final String name;

  const IdNameOption({required this.id, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is IdNameOption && other.id == id);

  @override
  int get hashCode => id.hashCode;
}

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    LoginResponse? response,
    SignUpResponse? signUpResponse,

    @Default(RegistrationType.professional) RegistrationType registrationType,
    @Default('Dr.') String selectedPrefix,

    @Default(false) bool isCategoryLoading,
    String? categoryError,
    @Default(<IdNameOption>[]) List<IdNameOption> categories,
    IdNameOption? selectedCategory,

    @Default(false) bool isSpecialityLoading,
    String? specialityError,
    @Default(<IdNameOption>[]) List<IdNameOption> specialities,
    IdNameOption? selectedSpeciality,

    @Default(false) bool isDegreeLoading,
    String? degreeError,
    @Default(<IdNameOption>[]) List<IdNameOption> degrees,
    @Default(<IdNameOption>[]) List<IdNameOption> selectedDegrees,

    @Default(false) bool isPasswordVisible,
    @Default(false) bool isConfirmPasswordVisible,
    @Default('') String password,
    @Default(false) bool agreeTerms,
    String? captchaToken,
    @Default(0) int captchaNonce,

    @Default(false) bool isSubmitting,
  }) = _AuthenticationState;
}