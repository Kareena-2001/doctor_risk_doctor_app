import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/services/api_client.dart';
import '../model/blog_model.dart';

part 'delete_repository.g.dart';

@riverpod
DeleteRepository deleteRepository(DeleteRepositoryRef ref) {
  return DeleteRepository(ref.watch(apiClientProvider));
}

class DeleteRepository {
  final ApiClient _api;

  const DeleteRepository(this._api);

  Future<DeleteAcResponse> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    debugPrint(
      'Auth Token: ${token != null ? "EXISTS (${token.substring(0, 10)}...)" : "MISSING"}',
    );

    try {
      final response = await _api.post(
        url: 'delete_profile',
      );

      debugPrint(' API Response: $response');

      if (response['status'] == 200) {
        return DeleteAcResponse.fromJson(response);
      } else {
        final errorMessage = response['msg'] ?? 'Failed to fetch offer letter';
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint(' Error: $e');
      rethrow;
    }
  }
}
