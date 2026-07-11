import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/services/api_client.dart';
import '../model/add_request_resp.dart';
import '../model/query_detail_model.dart';
import '../model/query_list_model.dart';

part 'help_repository.g.dart';

@riverpod
HelpRepository helpRepository(HelpRepositoryRef ref) {
  return HelpRepository(ref.watch(apiClientProvider));
}

class HelpRepository {
  final ApiClient _api;

  const HelpRepository(this._api);

  Future<AddRequestResp> addRequest({
    required String category,
    required String question,
    required String description,
    File? userAttachment,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    debugPrint(
      'Auth Token: ${token != null ? "EXISTS (${token.substring(0, 10)}...)" : "MISSING"}',
    );

    try {
      final Map<String, String> fields = {
        'category': category,
        'question': question,
        'description': description,
      };

      final Map<String, File> files = {};

      if (userAttachment != null) {
        files['user_attachment'] = userAttachment;
      }
      debugPrint('================ API REQUEST DEBUG ================');

      debugPrint(' Fields:');
      fields.forEach((key, value) {
        debugPrint('  $key = $value');
      });

      if (files.isEmpty) {
        debugPrint('📎 Files: none');
      } else {
        debugPrint('📎 Files:');
        files.forEach((key, file) {
          debugPrint(
            '  $key → ${file.path.split('/').last} '
            '(${file.lengthSync()} bytes)',
          );
        });
      }

      debugPrint('===================================================');

      final response = await _api.postMultipart(
        url: 'send_request',
        fields: fields,
        files: files,
      );

      debugPrint('API Response: $response');

      if (response['status'] == 200) {
        return AddRequestResp.fromJson(response);
      } else {
        final errorMessage = response['msg'] ?? 'Failed to submit request';
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }

  Future<QueryListModel> fetchQueries() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    debugPrint(
      'Auth Token: ${token != null ? "EXISTS (${token.substring(0, 10)}...)" : "MISSING"}',
    );

    try {
      final response = await _api.get(url: 'query_list');
      debugPrint('API Response: $response');

      if (response['status'] == 200) {
        final queriesResponse = QueryListModel.fromJson(response);
        return queriesResponse;
      } else {
        final errorMessage = response['msg'] ?? 'Failed to fetch request';
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint(' Error: $e');
      rethrow;
    }
  }

  Future<QueryDetailModel> fetchQueryDetail(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    debugPrint(
      'Auth Token: ${token != null ? "EXISTS (${token.substring(0, 10)}...)" : "MISSING"}',
    );

    try {
      final response = await _api.get(url: 'query_details?id=$id');

      debugPrint('API Response: $response');

      if (response['status'] == 200) {
        final queriesResponse = QueryDetailModel.fromJson(response);
        return queriesResponse;
      } else {
        final errorMessage = response['msg'] ?? 'Failed to fetch Data';
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint(' Error: $e');
      rethrow;
    }
  }
}
