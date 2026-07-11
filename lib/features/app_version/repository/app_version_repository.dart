import 'dart:developer';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/api_client.dart';
import '../model/app_version_model.dart';

part 'app_version_repository.g.dart';

@riverpod
AppVersionRepository appVersionRepository(AppVersionRepositoryRef ref) {
  return AppVersionRepository(ref.watch(apiClientProvider));
}

class AppVersionRepository {
  final ApiClient _api;

  const AppVersionRepository(this._api);

  Future<AppVersionResponse> checkForUpdate() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version; // 1.0.3
    final buildNumber = packageInfo.buildNumber; // 4

    log('App Version: $currentVersion ($buildNumber)');

    final response = await _api.post(
      url: 'check_version',
      formData: {"my_version": currentVersion},
      includeAuth: false,
    );
    log('Check Version API Response: $response');

    if (response['status'] == 200) {
      final model = AppVersionResponse.fromJson(response);

      log('Parsed Version Data: ${model.toJson()}');
      log('Latest Version: ${model.data.latestVersion}');
      log('Force Update: ${model.data.forceUpdate}');

      return model;
    }
    log('Check Version Failed: ${response['msg']}');
    throw Exception(response['msg'] ?? 'Failed to check version');
  }
}
