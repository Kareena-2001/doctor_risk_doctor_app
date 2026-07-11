class AppConstants {
  AppConstants._();

  static const String tag = 'FMR';

  static const String supabaseLoginCallback =
      'com.areser.flutter_mvvm_riverpod://login-callback/';
  static const String supabaseProfileTable = 'profile';
  static const String googleEmailScope = 'email';
  static const String googleUserInfoScope =
      'https://www.googleapis.com/auth/userinfo.profi le';

  static const String defaultName = 'Ajay Nikam';

  static const String defaultEmail = 'namanh11611@gmail.com';

  static const String termOfService =
      'https://github.com/namanh11611/flutter_mvvm_riverpod';

  static const String privacyPolicy =
      'https://github.com/namanh11611/flutter_mvvm_riverpod';

  static const String aboutUs = 'https://github.com/namanh11611';

  static const String appStore =
      'https://apps.apple.com/us/developer/anh-nguyen/id1760383102';
  static const String playStore =
      'https://play.google.com/store/apps/details?id=com.mobisoftseo.patri_panjo&hl=en_IN';

  // SharedPreferences key
  static const String themeModeKey = 'theme_mode_key';
  static const String profileKey = 'profile_key';
  static const String isLoginKey = 'is_login_key';
  static const String isExistAccountKey = 'is_exist_account_key';
  static const String lastDayShowPremiumKey = 'last_day_show_premium_key';

  // API
  static const String apiBaseUrl = 'https://your-api-url.com/api/v1';
  static const int apiTimeout = 30000;

  // App Info
  static const String appName = 'Doctor Risk';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String keyToken = 'auth_token';
  static const String keyUser = 'user_data';
  static const String keyTheme = 'theme_mode';

  // Pagination
  static const int pageSize = 20;

  // File Upload
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedFileTypes = ['pdf', 'jpg', 'jpeg', 'png'];

  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String timeFormat = 'HH:mm';
}
