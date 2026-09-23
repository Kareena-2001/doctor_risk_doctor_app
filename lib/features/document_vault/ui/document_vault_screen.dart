import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../theme/app_colors.dart';
import '../model/document_model.dart';

class DocumentVaultScreen extends ConsumerWidget {
  const DocumentVaultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      appBar: CustomAppBar(title: 'Document Vault', showBack: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(Responsive.w(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              context,
              'Your Uploaded Documents',
              'Required for registration and to activate policies where relevant.',
            ),
            height(Responsive.h(12)),
            ...userUploadedDocuments.map(
              (doc) => _buildUploadedDocTile(context, doc),
            ),
            height(Responsive.h(24)),
            _buildSectionHeader(
              context,
              'Company‑Issued Documents',
              'Issued by DoctorsRisk once your plan and payment are confirmed.',
            ),
            height(Responsive.h(12)),
            ...companyIssuedDocuments.map(
              (doc) => _buildIssuedDocTile(context, doc),
            ),
            height(Responsive.h(20)),
            _buildFaqBanner(context),
            height(Responsive.h(40)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: customTextStyle(
            fontSize: Responsive.sp(16),
            fontWeight: FontWeight.w700,
            color: context.primaryTextColor,
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

  Widget _buildUploadedDocTile(BuildContext context, DocumentItem doc) {
    final isUploaded = doc.status == DocumentStatus.uploaded;

    return Container(
      margin: EdgeInsets.only(bottom: Responsive.h(12)),
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: context.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: context.dividerColor),
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
                    color: context.primaryTextColor,
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

  Widget _buildIssuedDocTile(BuildContext context, DocumentItem doc) {
    final isIssued = doc.status == DocumentStatus.issued;

    return Container(
      margin: EdgeInsets.only(bottom: Responsive.h(12)),
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: context.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: context.dividerColor),
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
                    color: context.primaryTextColor,
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

  Widget _buildFaqBanner(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.secondaryColor.withValues(alpha: 0.18)
            : const Color(0xFFE4F0FA),
        borderRadius: BorderRadius.circular(Responsive.w(12)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.help_outline_rounded,
            color: context.isDarkMode
                ? AppColors.darkBrand500
                : AppColors.sky500,
            size: Responsive.sp(20),
          ),
          width(Responsive.w(10)),
          Expanded(
            child: Text(
              'Wondering why a multi‑year membership gets more than one certificate? See "Will I get one certificate or several?" in FAQs.',
              style: customTextStyle(
                fontSize: Responsive.sp(11.5),
                color: context.isDarkMode
                    ? AppColors.darkBrand500
                    : AppColors.sky500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
