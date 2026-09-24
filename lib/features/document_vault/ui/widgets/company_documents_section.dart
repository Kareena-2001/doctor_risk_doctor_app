import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/features/document_vault/model/company_document_response.dart';
import 'package:Doctors_App/features/document_vault/ui/view_model/document_vault_view_model.dart';
import 'package:Doctors_App/features/document_vault/ui/widgets/document_section_body.dart';
import 'package:Doctors_App/features/document_vault/ui/widgets/document_section_header.dart';
import 'package:Doctors_App/features/document_vault/ui/widgets/document_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/document_url_helper.dart';

class CompanyDocumentsSection extends ConsumerWidget {
  const CompanyDocumentsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(documentVaultViewModelProvider);
    final vm = ref.read(documentVaultViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DocumentSectionHeader(
          title: 'Company‑Issued Documents',
          subtitle:
          'Issued by DoctorsRisk once your plan and payment are confirmed.',
        ),
        height(Responsive.h(12)),
        DocumentSectionBody<CompanyDocument>(
          isLoading: state.isCompanyLoading,
          error: state.companyError,
          items: state.companyDocs,
          emptyText: 'No documents issued yet.',
          onRetry: vm.loadCompanyDocs,
          itemBuilder: (doc) {
            final fileName = documentFileName(doc.documents);
            final isIssued = fileName != null;

            return DocumentTile(
              title: doc.docName,
              subtitle: fileName ?? 'Will be issued after plan confirmation',
              badge: isIssued
                  ? null
                  : const DocumentStatusBadge(
                label: 'Not issued',
                color: kDocOrange,
              ),
              actions: [
                if (isIssued)
                  DocumentActionButton(
                    label: 'Download',
                    onPressed: () => openUrl(context, doc.documents),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}