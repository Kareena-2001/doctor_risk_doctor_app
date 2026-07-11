import 'package:easy_localization/easy_localization.dart';

import '../generated/locale_keys.g.dart';

String? notEmptyNameValidator(String? value) {
  return value == null || value.trim().isEmpty
      ? LocaleKeys.validator_required_field.tr()
      : null;
}

String? notEmptyEmailOrPhoneValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return LocaleKeys.validator_required_field.tr();
  }

  if (!isValidEmailOrPhone(value.trim())) {
    return LocaleKeys.validator_invalid_email_or_phone_format.tr();
  }
  return null;
}

bool isValidEmailOrPhone(String value) {
  return isValidEmail(value) || isValidPhone(value);
}

String? notEmptyEmailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return LocaleKeys.validator_required_field.tr();
  }

  if (!isValidEmail(value.trim())) {
    return LocaleKeys.validator_invalid_email_format.tr();
  }

  return null;
}

bool isValidEmail(String email) {
  final regExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(\.[a-zA-Z]+)+$",
  );
  return regExp.hasMatch(email);
}

String? notEmptyPhoneValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return LocaleKeys.validator_required_field.tr();
  }

  if (!isValidPhone(value.trim())) {
    return LocaleKeys.validator_invalid_phone_format.tr();
  }
  return null;
}

bool isValidPhone(String phone) {
  final regExp = RegExp(r'^[6-9]\d{9}$');
  return regExp.hasMatch(phone);
}

String? confirmPasswordValidator(String? password, String? confirmPassword) {
  if (password == null ||
      password.isEmpty ||
      confirmPassword == null ||
      confirmPassword.isEmpty) {
    return LocaleKeys.validator_required_field.tr();
  }

  if (password != confirmPassword) {
    return LocaleKeys.validator_password_not_match.tr();
  }

  return null;
}
