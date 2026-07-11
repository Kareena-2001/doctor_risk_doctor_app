import 'package:shared_preferences/shared_preferences.dart';

class CredentialsStorageService {
  static const String _keyRememberMe = 'remember_me';
  static const String _keySavedMobile = 'saved_mobile';
  static const String _keySavedPassword = 'saved_password';

  Future<void> saveCredentials({
    required String mobile,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRememberMe, true);
    await prefs.setString(_keySavedMobile, mobile);
    await prefs.setString(_keySavedPassword, password);
  }

  Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRememberMe, false);
    await prefs.remove(_keySavedMobile);
    await prefs.remove(_keySavedPassword);
  }

  Future<SavedCredentials?> getSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool(_keyRememberMe) ?? false;

    if (!rememberMe) return null;

    final mobile = prefs.getString(_keySavedMobile);
    final password = prefs.getString(_keySavedPassword);

    if (mobile == null || password == null) return null;

    return SavedCredentials(mobile: mobile, password: password);
  }

  Future<bool> isRememberMeEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyRememberMe) ?? false;
  }
}

class SavedCredentials {
  final String mobile;
  final String password;

  SavedCredentials({required this.mobile, required this.password});
}
