import 'dart:io';

import 'package:Doctors_App/core/services/credentials_storage_provider.dart';
import 'package:Doctors_App/core/services/credentials_storage_service.dart';
import 'package:Doctors_App/features/your_story/model/experience_response.dart';
import 'package:Doctors_App/features/your_story/model/experience_submit_response.dart';
import 'package:Doctors_App/features/your_story/model/testimonial_response.dart';
import 'package:Doctors_App/features/your_story/model/testimonial_submit_response.dart';
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

  Future<ExperienceSubmitResponse> addOrEditExperience({
    int? id,
    required String title,
    required String experienceType,
    required String description,
    required String iAgreeAccepted,
    File? coverImage,
  }) async {
    final Map<String, String> fields = {
      if (id != null) 'id': id.toString(),
      'title': title,
      'experience_type': experienceType,
      'details': description,
      'i_agree_accepted': iAgreeAccepted,
    };

    final Map<String, File> files = {};

    if (coverImage != null) {
      files['file'] = coverImage;
    }

    debugPrint('Fields:');
    fields.forEach((key, value) {
      debugPrint('  $key = $value');
    });

    if (files.isEmpty) {
      debugPrint('Files: none');
    } else {
      debugPrint('Files:');
      files.forEach((key, file) {
        debugPrint(
          '  $key → ${file.path.split('/').last} '
          '(${file.lengthSync()} bytes)',
        );
      });
    }

    final response = await _apiClient.postMultipart(
      url: 'doctor/addexperiance',
      fields: fields,
      files: files,
      includeAuth: true,
    );

    return ExperienceSubmitResponse.fromJson(response);
  }

  Future<ExperienceResponse> experienceList() async {
    final response = await _apiClient.get(
      url: 'doctor/myexperiencelist',
      includeAuth: true,
    );

    return ExperienceResponse.fromJson(response);
  }
  Future<TestimonialSubmitResponse> addOrEditTestimonial({
    int? id,
    required String testimonialType,
    required String description,
    required String iAgreeAccepted,
    File? file,
  }) async {
    final Map<String, String> fields = {
      if (id != null) 'id': id.toString(),
      'testimonial_type': testimonialType,
      'details': description,
      'i_agree_accepted': iAgreeAccepted,
    };

    final Map<String, File> files = {};

    if (file != null) {
      files['file'] = file;
    }

    debugPrint('Fields:');

    fields.forEach((key, value) {
      debugPrint('  $key = $value');
    });

    if (files.isEmpty) {
      debugPrint('Files: none');
    } else {
      debugPrint('Files:');

      files.forEach((key, file) {
        debugPrint(
          '  $key → ${file.path.split('/').last} '
              '(${file.lengthSync()} bytes)',
        );
      });
    }

    final response = await _apiClient.postMultipart(
      url: 'doctor/addtestimonial',
      fields: fields,
      files: files,
      includeAuth: true,
    );

    return TestimonialSubmitResponse.fromJson(response);
  }
  Future<TestimonialResponse> testimonialList() async {
    final response = await _apiClient.get(
      url: 'doctor/mytestimoniallist',
      includeAuth: true,
    );

    return TestimonialResponse.fromJson(response);
  }
}
