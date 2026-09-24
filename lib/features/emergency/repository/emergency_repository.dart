import 'package:Doctors_App/features/emergency/model/sop_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/api_client.dart';
import '../../../core/services/credentials_storage_provider.dart';
import '../../../core/services/credentials_storage_service.dart';

part 'emergency_repository.g.dart';

@Riverpod(keepAlive: true)
EmergencyRepository emergencyRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(
    credentialsStorageServiceProvider,
  );

  return EmergencyRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class EmergencyRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const EmergencyRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  })  : _apiClient = apiClient,
        _credentialsStorage = credentialsStorage;

  Future<SopResponse> getSopList() async {
    final response = await _apiClient.get(
      url: 'doctor/dosopdlist',
      includeAuth: true,
    );

    debugPrint('SOP RESPONSE => $response');

    return SopResponse.fromJson(response);
  }
}