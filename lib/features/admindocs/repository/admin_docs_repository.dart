import 'dart:developer';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/api_client.dart';
import '../model/admin_docs.dart';

part 'admin_docs_repository.g.dart';

@Riverpod(keepAlive: true)
AdminDocsRepository adminDocsRepository(AdminDocsRepositoryRef ref) {
  return AdminDocsRepository(ref.watch(apiClientProvider));
}

class AdminDocsRepository {
  final ApiClient _api;

  const AdminDocsRepository(this._api);

  Future<AdminDocsResponse> getAdminAssignedDocs() async {
    final response = await _api.get(url: 'admin_docs_list', includeAuth: true);

    log(" API Response: $response");

    if (response['status'] == 200) {
      return AdminDocsResponse.fromJson(response);
    }

    throw Exception(response['msg'] ?? 'Failed to check version');
  }
}
