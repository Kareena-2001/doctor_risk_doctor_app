import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/features/home/ui/widgets/social_link_widget.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/values/app_text_style.dart';
import '../../../routing/routes.dart';
import '../model/product_model.dart';

class PlanCategoryView extends StatelessWidget {
  final String? orgName;
  final String? staffCode;

  const PlanCategoryView({super.key, this.orgName, this.staffCode});

  void _select(BuildContext context, ProductType type) {
    context.push(
      Routes.planFinder,
      extra: {'orgName': orgName, 'staffCode': staffCode, 'category': type},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(title: 'Browse Plans'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (orgName != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFA7F3D0)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFFD1FAE5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.home_work_outlined,
                          size: 16,
                          color: AppColors.newPri,
                        ),
                      ),
                      width(12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            style: customTextStyle(
                              fontSize: 12,
                              color: const Color(0xFF065F46),
                            ),
                            children: [
                              const TextSpan(
                                text: "You're viewing plans as a ",
                              ),
                              TextSpan(
                                text: orgName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const TextSpan(text: ' member.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                height(24),
              ],
              Text(
                'STEP 2 · WHO IS THIS COVER FOR?',
                style: customTextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF64748B),
                ).copyWith(letterSpacing: 1.0),
              ),
              // height(8),
              // Text(
              //   'Select coverage type',
              //   style: customTextStyle(
              //     fontSize: 22,
              //     fontWeight: FontWeight.w800,
              //     color: AppColors.textColor,
              //   ),
              // ),
              height(20),
              _CategoryCard(
                icon: Icons.person_outline_rounded,
                title: 'Professional',
                subtitle:
                    'Individual doctors & consultants — personal indemnity cover',
                badgeText: 'INDIVIDUAL',
                onTap: () => _select(context, ProductType.individual),
              ),
              height(16),
              _CategoryCard(
                icon: Icons.local_hospital_outlined,
                title: 'Medical Establishment',
                subtitle:
                    'Clinics & hospitals — institutional & staff liability cover',
                badgeText: 'ESTABLISHMENT',
                onTap: () => _select(context, ProductType.medicalEstablishment),
              ),

              height(16),
              SocialLinkWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String badgeText;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        highlightColor: AppColors.newPri.withValues(alpha: 0.05),
        splashColor: AppColors.newPri.withValues(alpha: 0.1),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: AppColors.newPri, size: 24),
                  ),
                  Container(
                    padding:  EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      badgeText,
                      style: customTextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                      ).copyWith(letterSpacing: 0.5),
                    ),
                  ),
                ],
              ),
              height(16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: customTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textColor,
                          ),
                        ),
                        height(6),
                        Text(
                          subtitle,
                          style: customTextStyle(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ).copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  width(12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: Color(0xFF94A3B8),
                    ),
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
