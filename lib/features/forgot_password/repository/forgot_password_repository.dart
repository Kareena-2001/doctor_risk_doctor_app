import 'dart:io';

import 'package:Doctors_App/features/forgot_password/model/forgot_password_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/credentials_storage_provider.dart';
import '../../../core/services/credentials_storage_service.dart';
import '../model/new_password_model.dart';
import '../model/otp_model.dart';

part 'forgot_password_repository.g.dart';

@Riverpod(keepAlive: true)
ForgotPasswordRepository forgotPasswordRepository(
    ForgotPasswordRepositoryRef ref,
) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
  return ForgotPasswordRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class ForgotPasswordRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const ForgotPasswordRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<ForgotPasswordResponse> forgotPasswordRequest(String email) async {
    final response = await _apiClient.post(
      url: 'forgetpassword',
      formData: {'email': email},
      includeAuth: false,
    );

    debugPrint('forgot password request RESPONSE => $response');

    if (response['status'] == 200) {
      return ForgotPasswordResponse.fromJson(response);
    }

    debugPrint('forgot password request ERROR => ${response['msg']}');
    throw Exception(
      response['msg'] ?? 'Failed to send request for forgot password',
    );
  }

  Future<OtpResponse> otpVerification(String otp) async {
    final response = await _apiClient.post(
      url: 'otpverify',
      formData: {'otp': otp},
      includeAuth: true,
    );

    debugPrint('otpVerification request RESPONSE => $response');

    if (response['status'] == 200) {
      return OtpResponse.fromJson(response);
    }

    debugPrint('otpVerification request ERROR => ${response['msg']}');
    throw Exception(
      response['msg'] ?? 'Failed to send request for otpVerification',
    );
  }

  Future<NewPasswordResponse> createNewPassword(
    String id,
    String password,
  ) async {
    final response = await _apiClient.post(
      url: 'passwordupdate',
      formData: {'id': id, 'password': password},
      includeAuth: true,
    );

    debugPrint('createNew request RESPONSE => $response');

    if (response['status'] == 200) {
      return NewPasswordResponse.fromJson(response);
    }

    debugPrint('createNew request ERROR => ${response['msg']}');
    throw Exception(
      response['msg'] ?? 'Failed to send request for createNew password',
    );
  }
}
