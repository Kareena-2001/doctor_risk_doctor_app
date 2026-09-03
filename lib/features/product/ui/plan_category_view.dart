import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (orgName != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.home_work_outlined, size: 16, color: AppColors.newPri),
                      width(8),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            style: customTextStyle(fontSize: 12, color: const Color(0xFF065F46)),
                            children: [
                              const TextSpan(text: "You're viewing plans as a "),
                              TextSpan(text: orgName, style: const TextStyle(fontWeight: FontWeight.w700)),
                              const TextSpan(text: ' member.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                height(16),
              ],
              Text(
                'STEP 2 · WHO IS THIS COVER FOR?',
                style: customTextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF94A3B8),
                ).copyWith(letterSpacing: 0.6),
              ),
              height(12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _CategoryCard(
                      icon: Icons.person_outline,
                      title: 'Professional',
                      subtitle: 'Individual doctors & consultants — personal indemnity cover',
                      onTap: () => _select(context, ProductType.individual),
                    ),
                  ),
                  width(12),
                  Expanded(
                    child: _CategoryCard(
                      icon: Icons.home_work_outlined,
                      title: 'Medical Establishment',
                      subtitle: 'Clinics & hospitals — institutional & staff liability cover',
                      onTap: () => _select(context, ProductType.medicalEstablishment),
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

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFECFDF5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.newPri, size: 20),
            ),
            height(10),
            Text(title, style: customTextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textColor)),
            height(4),
            Text(subtitle, style: customTextStyle(fontSize: 11, color: AppColors.grey).copyWith(height: 1.3)),
          ],
        ),
      ),
    );
  }
}