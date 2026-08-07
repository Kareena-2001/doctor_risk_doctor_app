import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';
import '../model/document_model.dart';

class DocumentVaultScreen extends ConsumerWidget {
  const DocumentVaultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0E0E10)
          : const Color(0xFFF6F7FB),

      appBar: CustomAppBar(
        title: 'Document Vault',
        showBack: true,
        backgroundColor: isDark ? Colors.black : const Color(0xFFF8F9FA),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(Responsive.w(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              'Your Uploaded Documents',
              'Required for registration and to activate policies where relevant.',
            ),
            height(Responsive.h(12)),
            ...userUploadedDocuments.map(
              (doc) => _buildUploadedDocTile(context, doc, isDark),
            ),
            height(Responsive.h(24)),
            _buildSectionHeader(
              'Company‑Issued Documents',
              'Issued by DoctorsRisk once your plan and payment are confirmed.',
            ),
            height(Responsive.h(12)),
            ...companyIssuedDocuments.map(
              (doc) => _buildIssuedDocTile(context, doc, isDark),
            ),
            height(Responsive.h(20)),
            _buildFaqBanner(isDark),
            height(Responsive.h(40)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: customTextStyle(
            fontSize: Responsive.sp(16),
            fontWeight: FontWeight.w700,
            color: AppColors.textColor,
          ),
        ),
        height(Responsive.h(4)),
        Text(
          subtitle,
          style: customTextStyle(
            fontSize: Responsive.sp(12),
            color: AppColors.homeTextMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadedDocTile(
    BuildContext context,
    DocumentItem doc,
    bool isDark,
  ) {
    final isUploaded = doc.status == DocumentStatus.uploaded;

    return Container(
      margin: EdgeInsets.only(bottom: Responsive.h(12)),
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1D) : Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: AppColors.fieldGrey.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            isUploaded ? Icons.task_sharp : Icons.upload_file_rounded,
            color: isUploaded
                ? const Color(0xFF57C97E)
                : const Color(0xFFE15C48),
            size: Responsive.sp(24),
          ),
          width(Responsive.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc.title,
                  style: customTextStyle(
                    fontSize: Responsive.sp(13),
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
                if (doc.fileName != null) ...[
                  height(Responsive.h(2)),
                  Text(
                    '${doc.fileName}${doc.uploadDate != null ? ' · Uploaded ${doc.uploadDate}' : ''}',
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: AppColors.homeTextMuted,
                    ),
                  ),
                ],
                if (doc.subtitle != null && doc.fileName == null) ...[
                  height(Responsive.h(2)),
                  Text(
                    doc.subtitle!,
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: AppColors.homeTextMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
          width(Responsive.w(8)),
          TextButton(
            onPressed: () {
              // Action handler for Upload / Replace
            },
            style: TextButton.styleFrom(
              foregroundColor: isUploaded
                  ? AppColors.newPri
                  : const Color(0xFFE15C48),
            ),
            child: Text(
              isUploaded ? 'Replace' : 'Upload',
              style: customTextStyle(
                fontSize: Responsive.sp(12),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssuedDocTile(
    BuildContext context,
    DocumentItem doc,
    bool isDark,
  ) {
    final isIssued = doc.status == DocumentStatus.issued;

    return Container(
      margin: EdgeInsets.only(bottom: Responsive.h(12)),
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1D) : Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: AppColors.fieldGrey.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            isIssued
                ? Icons.verified_user_rounded
                : Icons.hourglass_top_rounded,
            color: isIssued ? AppColors.newPri : AppColors.homeTextMuted,
            size: Responsive.sp(24),
          ),
          width(Responsive.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc.title,
                  style: customTextStyle(
                    fontSize: Responsive.sp(13),
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
                if (doc.subtitle != null) ...[
                  height(Responsive.h(2)),
                  Text(
                    '${doc.subtitle!}${doc.uploadDate != null ? ' · ${doc.uploadDate}' : ''}',
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: AppColors.homeTextMuted,
                    ),
                  ),
                ],
                if (doc.validityPeriod != null) ...[
                  height(Responsive.h(2)),
                  Text(
                    doc.validityPeriod!,
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: AppColors.homeTextMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
          width(Responsive.w(8)),
          if (isIssued)
            IconButton(
              icon: Icon(
                Icons.download_rounded,
                color: AppColors.newPri,
                size: Responsive.sp(22),
              ),
              onPressed: () {
                // Download file handler
              },
            )
          else
            Text(
              'Not yet issued',
              style: customTextStyle(
                fontSize: Responsive.sp(11),
                color: AppColors.homeTextMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFaqBanner(bool isDark) {
    return Container(
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: const Color(0xFFE4F0FA),
        borderRadius: BorderRadius.circular(Responsive.w(12)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.help_outline_rounded,
            color: const Color(0xFF3E8FD0),
            size: Responsive.sp(20),
          ),
          width(Responsive.w(10)),
          Expanded(
            child: Text(
              'Wondering why a multi‑year membership gets more than one certificate? See "Will I get one certificate or several?" in FAQs.',
              style: customTextStyle(
                fontSize: Responsive.sp(11.5),
                color: const Color(0xFF3E8FD0),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
