import 'dart:io';

import 'package:Doctors_App/core/services/credentials_storage_provider.dart';
import 'package:Doctors_App/core/services/credentials_storage_service.dart';
import 'package:Doctors_App/features/blog_central/model/blog_list_detail.dart';
import 'package:Doctors_App/features/blog_central/model/blog_submit_response_model.dart';
import 'package:Doctors_App/features/blog_central/model/my_submission_list_model.dart';
import 'package:Doctors_App/features/blog_central/model/my_submission_list_view_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/api_client.dart';

part 'your_story_repository.g.dart';

@Riverpod(keepAlive: true)
YourStoryRepository yourStoryRepository(YourStoryRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
  return YourStoryRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class YourStoryRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const YourStoryRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;


}
