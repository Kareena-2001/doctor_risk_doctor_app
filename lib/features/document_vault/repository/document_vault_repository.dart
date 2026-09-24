import 'dart:io';

import 'package:Doctors_App/features/document_vault/model/company_document_response.dart';
import 'package:Doctors_App/features/document_vault/model/doctor_document_response.dart';
import 'package:Doctors_App/features/document_vault/model/document_upload_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/credentials_storage_provider.dart';
import '../../../core/services/credentials_storage_service.dart';

part 'document_vault_repository.g.dart';

@Riverpod(keepAlive: true)
DocumentVaultRepository documentVaultRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final credentialsStorage = ref.watch(credentialsStorageServiceProvider);
  return DocumentVaultRepository(
    apiClient: apiClient,
    credentialsStorage: credentialsStorage,
  );
}

class DocumentVaultRepository {
  final ApiClient _apiClient;
  final CredentialsStorageService _credentialsStorage;

  const DocumentVaultRepository({
    required ApiClient apiClient,
    required CredentialsStorageService credentialsStorage,
  }) : _apiClient = apiClient,
       _credentialsStorage = credentialsStorage;

  Future<DoctorDocumentResponse> getDocumentList() async {
    final response = await _apiClient.get(
      url: 'doctor/docuploaded',
      includeAuth: true,
    );
    debugPrint('document Upload RESPONSE => $response');

    return DoctorDocumentResponse.fromJson(response);
  }

  Future<CompanyDocumentResponse> getCompanyIssueDocs() async {
    final response = await _apiClient.get(
      url: 'doctor/doccompanyissue',
      includeAuth: true,
    );
    debugPrint('document Upload RESPONSE => $response');

    return CompanyDocumentResponse.fromJson(response);
  }

  Future<DocumentUploadResponse> uploadDocument({
    int? id,
    required String docName,
    File? document,
  }) async {
    final Map<String, String> fields = {
      if (id != null) 'id': id.toString(),
      'doc_name': docName,
    };

    final Map<String, File> files = {};

    if (document != null) {
      files['document'] = document;
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
      url: 'doctor/docupload',
      fields: fields,
      files: files,
      includeAuth: true,
    );

    debugPrint('document Upload RESPONSE => $response');

    return DocumentUploadResponse.fromJson(response);
  }
}
