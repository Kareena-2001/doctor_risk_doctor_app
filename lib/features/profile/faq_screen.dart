import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_seachbar.dart';
import '../../theme/app_colors.dart';

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
              CustomSearchBar(
                controller: TextEditingController(),
                hint: 'Search FAQs...',
              ),
              SizedBox(height: Responsive.h(20)),
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
          'How can I purchase an insurance policy?',
          'Go to the Products section, select the policy that best suits your professional needs, review the coverage details, and complete the payment process to activate your policy.',
        ),
        height(8),
        _buildQuesAns(
          'How do I raise a claim?',
          'Open Your Story, select the relevant policy, and tap "Raise Claim". Fill in the required details, upload supporting documents, and submit your claim for review.',
        ),
        height(8),
        _buildQuesAns(
          'How can I renew my policy?',
          'You will receive a renewal reminder before your policy expires. Visit Your Story, choose your active policy, and tap "Renew Policy" to continue your coverage.',
        ),
        height(8),
        _buildQuesAns(
          'How do I book an appointment with a legal expert?',
          'Navigate to Support Hub, select "Book Appointment", choose your preferred date and time, and submit your request. Our team will confirm your appointment.',
        ),
        height(8),
        _buildQuesAns(
          'How can I contact customer support?',
          'Visit Support Hub and create a support request or use the chat support option. Our support team will respond as soon as possible.',
        ),
        height(8),
        _buildQuesAns(
          'What documents are required while raising a claim?',
          'Depending on your claim, you may need to upload medical records, legal notices, identity proof, policy details, and any other supporting documents requested by our team.',
        ),
        height(8),
        _buildQuesAns(
          'Can I track the status of my request?',
          'Yes. Open Support Hub and navigate to My Queries to view the latest status of your submitted requests and support tickets.',
        ),
        height(8),
        _buildQuesAns(
          'How do I update my personal details?',
          'Go to your Profile section and update your personal or professional information. Some changes may require document verification.',
        ),
        _buildNeedHelpCard(),
      ],
    );
  }

  Widget _buildQuesAns(String question, String answer) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: Color(0xFfBDC9C8)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 12),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        iconColor: const Color(0xFF4E2780),
        collapsedIconColor: Colors.black54,
        title: Text(
          question,
          style: customTextStyle(
            color: AppColors.textColor.withValues(alpha: 0.8),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: customTextStyle(
                color: const Color(0xFF475569),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeedHelpCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF008080).withValues(alpha: 0.05),
        border: Border.all(
          color: const Color(0xFF008080).withValues(alpha: 0.20),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Text(
            "Still need help?",
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(10),
          Text(
            "Our support team is available 24/7 to assist you with any issues.",
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            ),
          ),
          height(20),
          PrimaryButton(
            text: "Contact Support",
            fontSize: 14,
            iconAfterText: false,
            icon: Icons.support_agent,
            fontWeight: FontWeight.w700,
            onPressed: () {
              // context.push(/*AadharNoRegisterRoute*/());
            },
            height: 50,
            backgroundColor: Color(0xFF008080),
            borderRadius: 20,
          ),
        ],
      ),
    );
  }
}
