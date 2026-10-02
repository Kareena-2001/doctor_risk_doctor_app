import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/exceptions/exception_extension.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/pagination_footer.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/home/ui/widgets/social_link_widget.dart';
import 'package:Doctors_App/features/medical_law_faq/ui/view_model/medical_law_faq_view_model.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/medical_law_faq_response.dart';

class MedicoLegalFaqScreen extends ConsumerStatefulWidget {
  const MedicoLegalFaqScreen({super.key});

  @override
  ConsumerState<MedicoLegalFaqScreen> createState() =>
      _MedicoLegalFaqScreenState();
}

class _MedicoLegalFaqScreenState extends ConsumerState<MedicoLegalFaqScreen> {
  bool _loadingMore = false;
  String? _paginationError;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(medicalLawFaqViewModelProvider.notifier).medicalLawFaqList();
    });
  }

  Future<void> _loadMore() async {
    setState(() {
      _loadingMore = true;
      _paginationError = null;
    });
    try {
      await ref
          .read(medicalLawFaqViewModelProvider.notifier)
          .loadMoreMedicalFaqs();
    } catch (error) {
      _paginationError = error.readableMessage;
    } finally {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _loadingMore = false;
      _paginationError = null;
    });
    await ref.read(medicalLawFaqViewModelProvider.notifier).medicalLawFaqList();
  }

  @override
  Widget build(BuildContext context) {
    final faqState = ref.watch(medicalLawFaqViewModelProvider);

    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      appBar: const CustomAppBar(title: 'Medical Law 101'),
      body: faqState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => AppRefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const SizedBox(height: 120),
              Center(
                child: Text(error.readableMessage, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
        data: (state) {
          return AppRefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Common medico-legal questions, answered in plain language for Indian practice.',
                          style: customTextStyle(
                            fontSize: 13,
                            color: context.greyColor,
                            fontWeight: FontWeight.w600,
                          ).copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: state.faqs.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Text(
                                'No matching legal topics found.',
                                style: customTextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.faqs.length,
                            separatorBuilder: (_, __) => height(12),
                            itemBuilder: (context, index) {
                              return _buildFaqTile(state.faqs[index], index);
                            },
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: PaginationFooter(
                      hasMore: ref
                          .read(medicalLawFaqViewModelProvider.notifier)
                          .hasMore,
                      isLoading: _loadingMore,
                      errorMessage: _paginationError,
                      onLoadMore: _loadMore,
                    ),
                  ),

                  SocialLinkWidget(),
                  height(50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFaqTile(MedicalLawFaqModel faq, int index) {
    return Container(
      decoration: BoxDecoration(
        color: context.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: Text(
            '${index + 1}'.padLeft(2, '0'),
            style: customTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.newPri,
            ),
          ),
          title: Text(
            faq.question,
            style: customTextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: context.primaryTextColor,
            ),
          ),
          children: [
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            height(12),
            Text(
              faq.answerDescription,
              style: customTextStyle(
                fontSize: 13,
                color: context.secondaryTextColor,
              ).copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
