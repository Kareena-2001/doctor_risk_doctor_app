import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
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
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(medicalLawFaqViewModelProvider.notifier).medicalLawFaqList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final faqState = ref.watch(medicalLawFaqViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(title: 'Medical Law 101'),
      body: faqState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text(error.toString(), textAlign: TextAlign.center)),
        data: (state) {
          return SingleChildScrollView(
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
                          color: Colors.grey[800],
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

                SocialLinkWidget(),
                height(50),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFaqTile(MedicalLawFaqModel faq, int index) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
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
              color: AppColors.textColor,
            ),
          ),
          children: [
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            height(12),
            Text(
              faq.answerDescription,
              style: customTextStyle(
                fontSize: 13,
                color: AppColors.textColor,
              ).copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
