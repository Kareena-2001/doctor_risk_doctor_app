import 'dart:io';

import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/document_vault/model/doctor_document_response.dart';
import 'package:Doctors_App/features/document_vault/ui/view_model/document_vault_view_model.dart';
import 'package:Doctors_App/features/document_vault/ui/widgets/document_section_body.dart';
import 'package:Doctors_App/features/document_vault/ui/widgets/document_section_header.dart';
import 'package:Doctors_App/features/document_vault/ui/widgets/document_tile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/document_url_helper.dart';

class UploadedDocumentsSection extends ConsumerWidget {
  const UploadedDocumentsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(documentVaultViewModelProvider);
    final vm = ref.read(documentVaultViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DocumentSectionHeader(
          title: 'Your Uploaded Documents',
          subtitle:
              'Required for registration and to activate policies where relevant.',
        ),
        height(Responsive.h(12)),
        DocumentSectionBody<DoctorDocument>(
          isLoading: state.isUploadedLoading,
          error: state.uploadedError,
          items: state.uploadedDocs,
          emptyText: 'No documents required yet.',
          onRetry: vm.loadUploadedDocs,
          itemBuilder: (doc) {
            final fileName = documentFileName(doc.documents);
            final isUploaded = fileName != null;
            final isUploading = state.uploadingDocName == doc.docName;
            final isBusy = state.uploadingDocName != null;

            return DocumentTile(
              title: doc.docName,
              subtitle: fileName ?? 'Required for identity verification',
              badge: DocumentStatusBadge(
                label: isUploaded ? 'Uploaded' : 'Not uploaded',
                color: isUploaded ? kDocGreen : kDocOrange,
              ),
              actions: [
                if (isUploaded)
                  DocumentActionButton(
                    label: 'View',
                    onPressed: isBusy
                        ? null
                        : () => openUrl(context, doc.documents),
                  ),
                DocumentActionButton(
                  label: isUploaded ? 'Replace' : 'Upload',
                  filled: !isUploaded,
                  isLoading: isUploading,
                  onPressed: isBusy
                      ? null
                      : () => _pickAndUpload(context, ref, doc),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Future<void> _pickAndUpload(
    BuildContext context,
    WidgetRef ref,
    DoctorDocument doc,
  ) async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png'],
    );
    final path = picked?.files.single.path;
    if (path == null) return;

    final result = await ref
        .read(documentVaultViewModelProvider.notifier)
        .uploadDocument(doc: doc, file: File(path));

    if (!context.mounted) return;
    if (result.success) {
      context.showSuccessSnackBar(result.message);
    } else {
      context.showErrorSnackBar(result.message);
    }
  }
}
