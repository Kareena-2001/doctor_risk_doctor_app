import 'dart:io';

import 'package:Doctors_App/features/document_vault/model/doctor_document_response.dart';
import 'package:Doctors_App/features/document_vault/repository/document_vault_repository.dart';
import 'package:Doctors_App/features/document_vault/ui/state/document_vault_state.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'document_vault_view_model.g.dart';

typedef UploadResult = ({bool success, String message});

@Riverpod(keepAlive: true)
class DocumentVaultViewModel extends _$DocumentVaultViewModel {
  static const int _maxFileBytes = 10 * 1024 * 1024;

  DocumentVaultRepository get _repo =>
      ref.read(documentVaultRepositoryProvider);

  @override
  DocumentVaultState build() => const DocumentVaultState();

  Future<void> loadAll() =>
      Future.wait([loadUploadedDocs(), loadCompanyDocs()]);

  Future<void> loadUploadedDocs() async {
    if (state.uploadedDocs.isEmpty) {
      state = state.copyWith(isUploadedLoading: true, uploadedError: null);
    }
    try {
      final res = await _repo.getDocumentList();
      state = state.copyWith(
        uploadedDocs: res.data,
        isUploadedLoading: false,
        uploadedError: null,
      );
    } catch (e) {
      state = state.copyWith(
        isUploadedLoading: false,
        uploadedError: _errorMessage(e),
      );
    }
  }

  Future<void> loadCompanyDocs() async {
    if (state.companyDocs.isEmpty) {
      state = state.copyWith(isCompanyLoading: true, companyError: null);
    }
    try {
      final res = await _repo.getCompanyIssueDocs();
      state = state.copyWith(
        companyDocs: res.data,
        isCompanyLoading: false,
        companyError: null,
      );
    } catch (e) {
      state = state.copyWith(
        isCompanyLoading: false,
        companyError: _errorMessage(e),
      );
    }
  }

  Future<UploadResult> uploadDocument({
    required DoctorDocument doc,
    required File file,
  }) async {
    if (state.uploadingDocName != null) {
      return (success: false, message: 'Another upload is in progress');
    }
    if (file.lengthSync() > _maxFileBytes) {
      return (success: false, message: 'File size must be under 10 MB');
    }

    state = state.copyWith(uploadingDocName: doc.docName);
    try {
      final res = await _repo.uploadDocument(
        id: doc.id,
        docName: doc.docName,
        document: file,
      );

      if (!res.status) {
        return (success: false, message: res.msg);
      }

      await loadUploadedDocs();
      return (
        success: true,
        message: res.msg.isNotEmpty
            ? res.msg
            : 'Document uploaded successfully',
      );
    } catch (e) {
      return (success: false, message: _errorMessage(e));
    } finally {
      state = state.copyWith(uploadingDocName: null);
    }
  }

  String _errorMessage(Object e) {
    debugPrint('DocumentVaultViewModel error => $e');
    return 'Something went wrong. Please try again.';
  }
}
