import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/credentials_storage_provider.dart';
import '../../../core/services/credentials_storage_service.dart';
import '../model/change_password_model.dart';

part 'change_password_repository.g.dart';

@Riverpod(keepAlive: true)
ChangePasswordRepository changePasswordRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
  return ChangePasswordRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class ChangePasswordRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const ChangePasswordRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<ChangePasswordResponse> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _apiClient.post(
        url: 'change_password',
        formData: {'old_password': oldPassword, 'new_password': newPassword},
        includeAuth: true,
      );
      debugPrint('Change Password RESPONSE => $response');

      if (response['status'] == 200) {
        return ChangePasswordResponse.fromJson(response);
      }
      throw response['msg'] ?? 'Change password failed';
    } catch (e) {
      if (e is ApiException) {
        throw e.message;
      }
      rethrow;
    }
  }
}
