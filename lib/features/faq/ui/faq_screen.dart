import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/home/ui/widgets/social_link_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_seachbar.dart';
import '../../../theme/app_colors.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "FAQ's"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSearchBar(
                      controller: TextEditingController(),
                      hint: 'Search FAQs...',
                    ),
                    height(8),
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
              _buildCommonQuestions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommonQuestions() {
    return Column(
      children: [
        _buildQuesAns(
          '01',
          'How can I purchase an insurance policy?',
          'Go to the Products section, select the policy that best suits your professional needs, review the coverage details, and complete the payment process to activate your policy.',
        ),
        height(8),
        _buildQuesAns(
          '02',
          'How do I raise a claim?',
          'Open Your Story, select the relevant policy, and tap "Raise Claim". Fill in the required details, upload supporting documents, and submit your claim for review.',
        ),
        height(8),
        _buildQuesAns(
          '03',
          'How can I renew my policy?',
          'You will receive a renewal reminder before your policy expires. Visit Your Story, choose your active policy, and tap "Renew Policy" to continue your coverage.',
        ),
        height(8),
        _buildQuesAns(
          '04',
          'How do I book an appointment with a legal expert?',
          'Navigate to Support Hub, select "Book Appointment", choose your preferred date and time, and submit your request. Our team will confirm your appointment.',
        ),
        height(8),
        _buildQuesAns(
          '05',
          'How can I contact customer support?',
          'Visit Support Hub and create a support request or use the chat support option. Our support team will respond as soon as possible.',
        ),
        height(8),
        _buildQuesAns(
          '06',
          'What documents are required while raising a claim?',
          'Depending on your claim, you may need to upload medical records, legal notices, identity proof, policy details, and any other supporting documents requested by our team.',
        ),
        height(8),
        _buildQuesAns(
          '07',
          'Can I track the status of my request?',
          'Yes. Open Support Hub and navigate to My Queries to view the latest status of your submitted requests and support tickets.',
        ),
        height(8),
        _buildQuesAns(
          '08',
          'How do I update my personal details?',
          'Go to your Profile section and update your personal or professional information. Some changes may require document verification.',
        ),
        SocialLinkWidget(),
        height(50),
        // _buildNeedHelpCard(),
      ],
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
            Divider(height: 1, color: Color(0xFFF1F5F9)),
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
