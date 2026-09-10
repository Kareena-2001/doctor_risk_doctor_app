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
import '../model/blog_list_response.dart';

part 'blog_repository.g.dart';

@Riverpod(keepAlive: true)
BlogRepository blogRepository(BlogRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
  return BlogRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class BlogRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const BlogRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<BlogSubmitResponse> submitBlog({
    required String title,
    required String content,
    File? coverImage,
  }) async {
    final Map<String, File> files = {};

    if (coverImage != null) {
      files['image'] = coverImage;
    }

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

    final response = await _apiClient.postMultipart(
      url: 'doctor/addblog',
      fields: {'title': title, 'content': content},
      files: files,
      includeAuth: true,
    );

    return BlogSubmitResponse.fromJson(response);
  }

  Future<MySubmissionListModel> mySubmissionList() async {
    final response = await _apiClient.post(
      url: 'doctor/mysubmissionlist',
      includeAuth: true,
    );

    return MySubmissionListModel.fromJson(response);
  }

  Future<MySubmissionListViewResponse> mySubmissionView({
    required String id,
  }) async {
    final response = await _apiClient.get(
      url: 'doctor/mysubmissionshow/$id',
      includeAuth: true,
    );

    return MySubmissionListViewResponse.fromJson(response);
  }

  Future<BlogListResponse> blogsList() async {
    final response = await _apiClient.get(
      url: 'doctor/blogs',
      includeAuth: true,
    );

    return BlogListResponse.fromJson(response);
  }

  Future<BlogListDetail> blogListDetails({required String id}) async {
    final response = await _apiClient.get(
      url: 'doctor/blogdetails/$id',
      includeAuth: true,
    );

    return BlogListDetail.fromJson(response);
  }
}
