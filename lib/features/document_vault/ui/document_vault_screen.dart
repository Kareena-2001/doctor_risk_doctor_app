import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/document_vault/ui/view_model/document_vault_view_model.dart';
import 'package:Doctors_App/features/document_vault/ui/widgets/company_documents_section.dart';
import 'package:Doctors_App/features/document_vault/ui/widgets/uploaded_documents_section.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/document_url_helper.dart';

class DocumentVaultScreen extends ConsumerStatefulWidget {
  const DocumentVaultScreen({super.key});

  @override
  ConsumerState<DocumentVaultScreen> createState() =>
      _DocumentVaultScreenState();
}

class _DocumentVaultScreenState extends ConsumerState<DocumentVaultScreen> {
  static const _faqUrl = 'https://medicolegalsupport.in/doctor/faqs';

  late final TapGestureRecognizer _faqTap;

  @override
  void initState() {
    super.initState();
    _faqTap = TapGestureRecognizer()..onTap = () => openUrl(context, _faqUrl);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(documentVaultViewModelProvider.notifier).loadAll();
    });
  }

  @override
  void dispose() {
    _faqTap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      appBar: CustomAppBar(title: 'Document Vault', showBack: true),
      body: RefreshIndicator(
        onRefresh: ref.read(documentVaultViewModelProvider.notifier).loadAll,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: EdgeInsets.all(Responsive.w(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UploadedDocumentsSection(),
              height(Responsive.h(24)),
              const CompanyDocumentsSection(),
              height(Responsive.h(8)),
              _buildFooterNote(context),
              height(Responsive.h(40)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterNote(BuildContext context) {
    final base = customTextStyle(
      fontSize: Responsive.sp(10.5),
      color: AppColors.homeTextMuted,
    );

    return Text.rich(
      TextSpan(
        style: base,
        children: [
          const TextSpan(
            text:
            'Each Establishment cover gets its own Client ID suffix (‑A, ‑B, …) in sequence of purchase — this makes it easy to identify which certificate belongs to which facility when corresponding with your insurer. Your individual Professional cover doesn\'t need a suffix, since only one is allowed per Membership ID. Wondering why a multi‑year membership gets more than one certificate? See "Will I get one certificate or several?" in ',
          ),
          TextSpan(
            text: 'FAQs',
            recognizer: _faqTap,
            style: base.copyWith(
              color: context.primaryTextColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}