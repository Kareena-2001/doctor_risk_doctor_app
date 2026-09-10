import 'package:Doctors_App/features/faq/ui/view_model/faq_view_model.dart';
import 'package:Doctors_App/features/home/ui/widgets/social_link_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_seachbar.dart';
import '../../../theme/app_colors.dart';

class FaqScreen extends ConsumerStatefulWidget {
  const FaqScreen({super.key});

  @override
  ConsumerState<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends ConsumerState<FaqScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(faqViewModelProvider.notifier).faqList();
    });
  }


  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    final faqState = ref.watch(faqViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "FAQ's"),
      body: faqState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text(error.toString(), textAlign: TextAlign.center)),
        data: (state) {
          if (state.faqs.isEmpty) {
            return const Center(child: Text('No FAQs available'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          'Common questions about your policy, membership and how DoctorsRisk works as a service.',
                          style: customTextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600,
                          ).copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),

                  _buildCommonQuestions(state.faqs),

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

  Widget _buildCommonQuestions(List faqs) {
    return Column(
      children: List.generate(faqs.length, (index) {
        final faq = faqs[index];

        return Column(
          children: [
            _buildQuesAns(
              '${index + 1}'.padLeft(2, '0'),
              faq.question,
              faq.answerDescription,
            ),
            if (index != faqs.length - 1) height(8),
          ],
        );
      }),
    );
  }

  Widget _buildQuesAns(String number, String question, String answer) {
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
            number,
            style: customTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.newPri,
            ),
          ),
          title: Text(
            question,
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
              answer,
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
