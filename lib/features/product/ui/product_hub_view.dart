import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/values/app_text_style.dart';
import '../../../routing/routes.dart';

class ProductHubView extends StatelessWidget {
  const ProductHubView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        title: 'My Products',
        subTitle: 'Everything covered under your medico-legal membership.',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'My Products',
              //   style: customTextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.w700,
              //     color: const Color(0xFF0F172A),
              //   ),
              // ),
              // height(4),
              // Text(
              //   'Everything covered under your medico-legal membership.',
              //   style: customTextStyle(fontSize: 12, color: Color(0xFF64748B)),
              // ),
              // height(16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _EntryCard(
                      icon: Icons.add,
                      title: 'Buy New Plans',
                      subtitle:
                          'Compare coverage by sum assured and duration, then get instant premium quotes.',
                      buttonText: 'Browse Plan List',
                      isPrimaryButton: true,
                      onTap: () => context.push(Routes.productSource),
                    ),
                  ),
                  width(12),
                  Expanded(
                    child: _EntryCard(
                      icon: Icons.verified_sharp,
                      title: 'View My Plans',
                      subtitle:
                          'Track status, download certificates, and renew before they expire.',
                      buttonText: 'View My Plans',
                      isPrimaryButton: false,
                      onTap: () => context.push(Routes.myPlans),
                    ),
                  ),
                ],
              ),

              height(24),
              Text(
                "What's covered",
                style: customTextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor,
                ),
              ),
              height(12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.85,
                children: const [
                  _ServiceIcon(
                    icon: Icons.lock_outline,
                    label: 'Auditing\nMedical Records',
                  ),
                  _ServiceIcon(
                    icon: Icons.add_box,
                    label: 'Social Media\nDefamation',
                  ),
                  _ServiceIcon(
                    icon: Icons.article_outlined,
                    label: 'Phone / In-Person\nConsultation',
                  ),
                  _ServiceIcon(
                    icon: Icons.edit_outlined,
                    label: 'Legal\nDocumentation',
                  ),
                  _ServiceIcon(
                    icon: Icons.star_border,
                    label: 'Defense Cost\nof Defending',
                  ),
                  _ServiceIcon(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Bail Cost\nCoverage',
                  ),
                  _ServiceIcon(
                    icon: Icons.person_outline,
                    label: 'Pre-Litigation\nSupport',
                  ),
                  _ServiceIcon(
                    icon: Icons.check,
                    label: 'Out-of-Court\nSettlement',
                  ),
                  _ServiceIcon(
                    icon: Icons.access_time,
                    label: '24×7\nAssistance',
                  ),
                  _ServiceIcon(
                    icon: Icons.lock_outline,
                    label: 'PAN India\nSupport',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final bool isPrimaryButton;
  final VoidCallback onTap;

  const _EntryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.isPrimaryButton,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.newPri, size: 20),
          ),
          height(10),
          Text(
            title,
            style: customTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.textColor,
            ),
          ),
          height(4),
          Text(
            subtitle,
            style: customTextStyle(
              fontSize: 11,
              color: AppColors.grey,
            ).copyWith(height: 1.3),
          ),
          height(14),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onPressed: onTap,
              text: buttonText,
              height: 36,
              borderRadius: 20,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              gradientColors: isPrimaryButton
                  ? [AppColors.primary, AppColors.newPri]
                  : null,
              backgroundColor: isPrimaryButton ? null : Colors.white,
              textColor: isPrimaryButton
                  ? Colors.white
                  : const Color(0xFF1E293B),
              borderColor: isPrimaryButton
                  ? Colors.transparent
                  : const Color(0xFFE2E8F0),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ServiceIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.newPri.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.newPri, size: 18),
            ),
            height(6),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: customTextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
