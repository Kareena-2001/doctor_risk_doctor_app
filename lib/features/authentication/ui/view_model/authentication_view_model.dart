import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:Doctors_App/features/authentication/model/register/register_request.dart';
import 'package:Doctors_App/features/authentication/ui/view_model/user_provider.dart';

import '../../repository/authentication_repository.dart';
import '../state/authentication_state.dart';

part 'authentication_view_model.g.dart';

class RegistrationValidationException implements Exception {
  final String message;

  const RegistrationValidationException(this.message);

  @override
  String toString() => message;
}

@Riverpod(keepAlive: true)
class AuthenticationViewModel extends _$AuthenticationViewModel {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController firstNameController;
  late final TextEditingController middleNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController mobileNoController;
  late final TextEditingController emailController;
  late final TextEditingController establishmentNameController;
  late final TextEditingController organizationCodeController;
  late final TextEditingController associateCodeController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  static const _prefixes = ['Dr.', 'Mr.', 'Mrs.', 'Ms.'];

  List<String> get availablePrefixes =>
      _current.registrationType == RegistrationType.professional
      ? const ['Dr.']
      : _prefixes;

  @override
  FutureOr<AuthenticationState> build() {
    firstNameController = TextEditingController();
    middleNameController = TextEditingController();
    lastNameController = TextEditingController();
    mobileNoController = TextEditingController();
    emailController = TextEditingController();
    establishmentNameController = TextEditingController();
    organizationCodeController = TextEditingController();
    associateCodeController = TextEditingController();
    passwordController = TextEditingController()
      ..addListener(_onPasswordChanged);
    confirmPasswordController = TextEditingController();

    ref.onDispose(() {
      firstNameController.dispose();
      middleNameController.dispose();
      lastNameController.dispose();
      mobileNoController.dispose();
      emailController.dispose();
      establishmentNameController.dispose();
      organizationCodeController.dispose();
      associateCodeController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
    });

    Future.microtask(() {
      categoryList();

      if (_current.registrationType == RegistrationType.professional) {
        degreeList();
      }
    });
    return const AuthenticationState();
  }

  AuthenticationState get _current =>
      state.valueOrNull ?? const AuthenticationState();

  void _set(AuthenticationState Function(AuthenticationState s) update) {
    state = AsyncData(update(_current));
  }

  void _onPasswordChanged() {
    _set((s) => s.copyWith(password: passwordController.text));
  }

  Future<void> selectRegistrationType(RegistrationType type) async {
    if (_current.registrationType == type) {
      return;
    }

    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    mobileNoController.clear();
    emailController.clear();
    establishmentNameController.clear();
    organizationCodeController.clear();
    associateCodeController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    _set(
      (s) => s.copyWith(
        registrationType: type,

        selectedPrefix: type == RegistrationType.professional ? 'Dr.' : 'Mr.',

        selectedCategory: null,
        selectedSpeciality: null,
        specialities: const [],

        selectedDegrees: const [],

        categoryError: null,
        specialityError: null,
        degreeError: null,

        password: '',
        isPasswordVisible: false,
        isConfirmPasswordVisible: false,

        agreeTerms: false,
        captchaToken: null,
        captchaNonce: s.captchaNonce + 1,

        isSubmitting: false,
      ),
    );

    await categoryList();
  }

  void selectPrefix(String prefix) =>
      _set((s) => s.copyWith(selectedPrefix: prefix));

  void togglePasswordVisibility() =>
      _set((s) => s.copyWith(isPasswordVisible: !s.isPasswordVisible));

  void toggleConfirmPasswordVisibility() => _set(
    (s) => s.copyWith(isConfirmPasswordVisible: !s.isConfirmPasswordVisible),
  );

  void setAgreeTerms(bool value) => _set((s) => s.copyWith(agreeTerms: value));

  void setCaptchaToken(String? token) =>
      _set((s) => s.copyWith(captchaToken: token));

  void resetCaptcha() => _set(
    (s) => s.copyWith(captchaToken: null, captchaNonce: s.captchaNonce + 1),
  );

  int get passwordStrengthScore {
    final pass = _current.password;
    if (pass.isEmpty) return 0;
    if (pass.length < 8) return 1;

    int score = 1;
    if (RegExp(r'[0-9]').hasMatch(pass)) score++;
    if (RegExp(r'[a-z]').hasMatch(pass) && RegExp(r'[A-Z]').hasMatch(pass)) {
      score++;
    }
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pass)) score++;
    return score;
  }

  String get passwordStrengthLabel {
    final pass = _current.password;
    if (pass.isEmpty) return '';
    if (pass.length < 8) return 'Weak — enter at least 8 characters';

    switch (passwordStrengthScore) {
      case 1:
        return 'Weak — add numbers or uppercase letters';
      case 2:
        return 'Fair — add symbols for better security';
      case 3:
        return 'Good — add special characters';
      case 4:
        return 'Strong password';
      default:
        return 'Weak';
    }
  }

  Color get passwordStrengthColor {
    final pass = _current.password;
    if (pass.isEmpty || pass.length < 8) return Colors.red;

    switch (passwordStrengthScore) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.amber.shade700;
      case 4:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  List<IdNameOption> _mapIdName(List<dynamic> items) => items
      .map((e) => IdNameOption(id: e.id as int, name: e.name as String))
      .toList();

  Future<void> categoryList() async {
    _set((s) => s.copyWith(isCategoryLoading: true, categoryError: null));
    try {
      final repository = ref.read(authenticationRepositoryProvider);
      final productTypeId =
          _current.registrationType == RegistrationType.professional
          ? '1'
          : '2';

      final response = await repository.categoryList(
        productTypeId: productTypeId,
      );
      _set(
        (s) => s.copyWith(
          isCategoryLoading: false,
          categories: _mapIdName(response.data),
        ),
      );
    } catch (error) {
      _set(
        (s) => s.copyWith(
          isCategoryLoading: false,
          categoryError: error.toString(),
        ),
      );
    }
  }

  void selectCategory(IdNameOption category) {
    _set(
      (s) => s.copyWith(
        selectedCategory: category,
        selectedSpeciality: null,
        specialities: const [],
      ),
    );
    specialityList(categoryId: category.id.toString());
  }

  Future<void> specialityList({required String categoryId}) async {
    _set((s) => s.copyWith(isSpecialityLoading: true, specialityError: null));
    try {
      final repository = ref.read(authenticationRepositoryProvider);
      final response = await repository.specialityList(categoryId: categoryId);
      _set(
        (s) => s.copyWith(
          isSpecialityLoading: false,
          specialities: _mapIdName(response.data),
        ),
      );
    } catch (error) {
      _set(
        (s) => s.copyWith(
          isSpecialityLoading: false,
          specialityError: error.toString(),
        ),
      );
    }
  }

  void selectSpeciality(IdNameOption speciality) =>
      _set((s) => s.copyWith(selectedSpeciality: speciality));

  Future<void> degreeList() async {
    _set((s) => s.copyWith(isDegreeLoading: true, degreeError: null));
    try {
      final repository = ref.read(authenticationRepositoryProvider);
      final response = await repository.degreeList();
      _set(
        (s) => s.copyWith(
          isDegreeLoading: false,
          degrees: _mapIdName(response.data),
        ),
      );
    } catch (error) {
      _set(
        (s) =>
            s.copyWith(isDegreeLoading: false, degreeError: error.toString()),
      );
    }
  }

  void setSelectedDegrees(List<IdNameOption> degrees) {
    debugPrint(
      'Selected degrees: ${degrees.map((e) => '${e.id}:${e.name}').join(', ')}',
    );

    _set((s) => s.copyWith(selectedDegrees: [...degrees]));
  }

  Future<void> login({
    required String login,
    required String password,
    required String deviceToken,
    required String fcmToken,
    required String deviceId,
    required String platform,
    bool rememberMe = false,
  }) async {
    _set((s) => s.copyWith(isSubmitting: true));
    try {
      final repository = ref.read(authenticationRepositoryProvider);
      final response = await repository.login(
        login: login,
        password: password,
        deviceToken: deviceToken,
        fcmToken: fcmToken,
        deviceId: deviceId,
        platform: platform,
        rememberMe: rememberMe,
      );
      await ref.read(userProviderProvider.notifier).refreshUserData();
      _set((s) => s.copyWith(isSubmitting: false, response: response));
    } catch (error, stackTrace) {
      _set((s) => s.copyWith(isSubmitting: false));
      state = AsyncError(error, stackTrace);
    }
  }

  Future<bool> submitRegistration() async {
    if (!(formKey.currentState?.validate() ?? false)) return false;

    final s = _current;

    if (passwordController.text != confirmPasswordController.text) {
      throw const RegistrationValidationException('Passwords do not match');
    }
    if (s.selectedCategory == null) {
      throw const RegistrationValidationException('Please select a category');
    }
    if (s.registrationType == RegistrationType.professional &&
        s.selectedSpeciality == null) {
      throw const RegistrationValidationException('Please select a speciality');
    }
    if (s.registrationType == RegistrationType.professional &&
        s.selectedDegrees.isEmpty) {
      throw const RegistrationValidationException(
        'Please select at least one degree',
      );
    }
    if (s.registrationType == RegistrationType.establishment &&
        establishmentNameController.text.trim().isEmpty) {
      throw const RegistrationValidationException(
        'Please enter the establishment name',
      );
    }
    if (!s.agreeTerms) {
      throw const RegistrationValidationException(
        'Please agree to the Terms & Conditions',
      );
    }
    if (s.captchaToken == null || s.captchaToken!.isEmpty) {
      throw const RegistrationValidationException(
        'Please complete the verification check',
      );
    }

    final request = RegisterRequest(
      productTypeId: s.registrationType == RegistrationType.professional
          ? '1'
          : '2',
      prefix: s.selectedPrefix,
      firstName: firstNameController.text.trim(),
      middleName: middleNameController.text.trim().isEmpty
          ? null
          : middleNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      mobileNo: mobileNoController.text.trim(),
      email: emailController.text.trim().isEmpty
          ? null
          : emailController.text.trim(),
      categoryId: s.selectedCategory!.id,
      specialityId: s.registrationType == RegistrationType.professional
          ? s.selectedSpeciality!.id
          : null,
      degree: s.registrationType == RegistrationType.professional
          ? s.selectedDegrees.map((d) => d.name).join(', ')
          : null,
      organizationName: s.registrationType == RegistrationType.establishment
          ? establishmentNameController.text.trim()
          : (organizationCodeController.text.trim().isEmpty
                ? null
                : organizationCodeController.text.trim()),
      source: associateCodeController.text.trim(),
      password: passwordController.text,
      termsPrivacyAccepted: s.agreeTerms,
    );

    _set((state) => state.copyWith(isSubmitting: true));

    try {
      final repository = ref.read(authenticationRepositoryProvider);
      final response = await repository.register(request);
      _set(
        (state) =>
            state.copyWith(isSubmitting: false, signUpResponse: response),
      );
      return true;
    } catch (error) {
      _set((state) => state.copyWith(isSubmitting: false));
      resetCaptcha();
      rethrow;
    }
  }

  void resetSignUpState() => _set((s) => s.copyWith(signUpResponse: null));

  Future<void> signOut() async {
    try {
      final repository = ref.read(authenticationRepositoryProvider);
      await repository.signOut();
      ref.read(userProviderProvider.notifier).clearUserData();
      state = const AsyncData(AuthenticationState());
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  void resetForm() {
    formKey.currentState?.reset();

    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    mobileNoController.clear();
    emailController.clear();
    establishmentNameController.clear();
    organizationCodeController.clear();
    associateCodeController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    _set(
      (s) => s.copyWith(
        response: null,
        signUpResponse: null,
        registrationType: RegistrationType.professional,
        selectedPrefix: 'Dr.',
        selectedCategory: null,
        selectedSpeciality: null,
        specialities: const [],
        selectedDegrees: const [],
        isPasswordVisible: false,
        isConfirmPasswordVisible: false,
        password: '',
        agreeTerms: false,
        captchaToken: null,
        captchaNonce: s.captchaNonce + 1,
        isSubmitting: false,
      ),
    );
  }
}
