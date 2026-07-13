import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/values/app_constants.dart';
import '../../../core/services/api_client.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/services/credentials_storage_provider.dart';
import '../../../core/services/credentials_storage_service.dart';
import '../model/authentication_model.dart';

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

  Future<AuthenticationModel> login({
    required String mobile,
    required String password,
    required String fcmToken,
    required String deviceToken,
    required String platform,
    bool rememberMe = false,
  }) async {
    try {
      final data = await _apiClient.post(
        url: 'login',
        formData: {
          'mobile': mobile,
          'password': password,
          'fcm_token': fcmToken,
          'device_token': deviceToken,
          'platform': platform,
        },
        includeAuth: false,
      );

      if (data['status'] == 200) {
        final authModel = AuthenticationModel.fromJson(data);
        await _saveAuthData(authModel.data);

        if (rememberMe) {
          await _credentialsStorage.saveCredentials(
            mobile: mobile,
            password: password,
          );
        } else {
          await _credentialsStorage.clearCredentials();
        }

        return authModel;
      } else {
        throw Exception(data['msg'] ?? 'Login failed');
      }
    } catch (e) {
      if (e is ApiException) {
        throw Exception(e.message);
      }
      rethrow;
    }
  }

  Future<void> _saveAuthData(LoginData data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', data.token);
    await prefs.setString('user_id', data.customer.id);
    if (data.customer.vendor_employee_code != null) {
      await prefs.setString(
        'user_vendor_employee_code',
        data.customer.vendor_employee_code!,
      );
    }
    await prefs.setString('user_name', data.customer.full_name);
    await prefs.setString('user_email', data.customer.email ?? '');
    await prefs.setString('user_mobile', data.customer.mobile);
    if (data.customer.photo != null && data.customer.photo!.isNotEmpty) {
      await prefs.setString('user_image', data.customer.photo!);
    }
    if (data.customer.application_status != null) {
      await prefs.setString(
        'user_application_status',
        data.customer.application_status!,
      );
    }
    if (data.customer.ol_generate != null) {
      await prefs.setString('user_ol_generate', data.customer.ol_generate!);
    }
    await setIsLogin(true);
  }

  Future<void> updateApplicationStatus(String newStatus) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_application_status', newStatus);
    await prefs.reload();
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_id');
    await prefs.remove('user_vendor_employee_code');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await prefs.remove('user_mobile');
    await prefs.remove('user_image');
    await prefs.remove('user_application_status');
    await prefs.remove('user_ol_generate');
    await setIsLogin(false);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<Customer?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId == null) return null;

    return Customer(
      id: userId,
      vendor_employee_code: prefs.getString('user_vendor_employee_code'),
      full_name: prefs.getString('user_name') ?? '',
      email: prefs.getString('user_email') ?? '',
      mobile: prefs.getString('user_mobile') ?? '',
      photo: prefs.getString('user_image'),
      application_status: prefs.getString('user_application_status'),
      ol_generate: prefs.getString('user_ol_generate'),
    );
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
