import 'package:Doctors_App/features/authentication/model/register/category_response.dart';
import 'package:Doctors_App/features/authentication/model/register/register_request.dart';
import 'package:Doctors_App/features/authentication/model/register/sign_up_response.dart';
import 'package:Doctors_App/features/authentication/model/register/speciality_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/values/app_constants.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/credentials_storage_provider.dart';
import '../../../core/services/credentials_storage_service.dart';
import '../model/login/login_response.dart';

part 'authentication_repository.g.dart';

@Riverpod(keepAlive: true)
AuthenticationRepository authenticationRepository(
  AuthenticationRepositoryRef ref,
) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
  return AuthenticationRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class AuthenticationRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const AuthenticationRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<LoginResponse> login({
    required String login,
    required String password,
    required String deviceToken,
    required String fcmToken,
    required String deviceId,
    required String platform,
    bool rememberMe = false,
  }) async {
    final response = await _apiClient.post(
      url: 'doctor/login',
      formData: {
        'login': login,
        'password': password,
        'device_token': deviceToken,
        'fcm_token': fcmToken,
        'device_id': deviceId,
        'platform': platform,
      },
      includeAuth: false,
    );

    final loginResponse = LoginResponse.fromJson(response);

    await saveToken(loginResponse.data.accessToken);
    await setIsLogin(true);

    if (rememberMe) {
      await _credentialsStorage.saveCredentials(
        login: login,
        password: password,
      );
    } else {
      await _credentialsStorage.clearCredentials();
    }

    return loginResponse;
  }

  Future<SignUpResponse> register(RegisterRequest request) async {
    final response = await _apiClient.post(
      url: 'doctor/register',
      formData: request.toJson().map((k, v) => MapEntry(k, v.toString())),
      includeAuth: false,
    );

    return SignUpResponse.fromJson(response);
  }

  Future<CategoryResponse> categoryList() async {
    final response = await _apiClient.post(
      url: 'doctor/categorylist',
      includeAuth: false,
    );

    return CategoryResponse.fromJson(response);
  }

  Future<SpecialityModel> specialityList({required String categoryId}) async {
    final response = await _apiClient.post(
      url: 'doctor/speciality',
      formData: {'categoryId': categoryId},
      includeAuth: false,
    );

    return SpecialityModel.fromJson(response);
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await setIsLogin(false);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.isLoginKey) ?? false;
  }

  Future<void> setIsLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.isLoginKey, value);
  }

  Future<SavedCredentials?> getSavedCredentials() async {
    return await _credentialsStorage.getSavedCredentials();
  }
}
