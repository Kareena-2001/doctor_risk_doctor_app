import 'package:shared_preferences/shared_preferences.dart';

class CredentialsStorageService {
  static const String _keyRememberMe = 'remember_me';
  static const String _keySavedEmpId = 'saved_empid';
  static const String _keySavedPassword = 'saved_password';

  Future<void> saveCredentials({
    required String login,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRememberMe, true);
    await prefs.setString(_keySavedEmpId, login);
    await prefs.setString(_keySavedPassword, password);
  }

  Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRememberMe, false);
    await prefs.remove(_keySavedEmpId);
    await prefs.remove(_keySavedPassword);
  }

  Future<SavedCredentials?> getSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool(_keyRememberMe) ?? false;

    if (!rememberMe) return null;

    final login = prefs.getString(_keySavedEmpId);
    final password = prefs.getString(_keySavedPassword);

    if (login == null || password == null) return null;

    return SavedCredentials(login: login, password: password);
  }

  Future<bool> isRememberMeEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyRememberMe) ?? false;
  }
}

class SavedCredentials {
  final String login;
  final String password;

  SavedCredentials({required this.login, required this.password});
}
