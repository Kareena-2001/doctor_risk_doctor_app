import 'package:Doctors_App/theme/app_colors.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/widgets/custom_app_bar.dart';

class AboutUsScreen extends StatelessWidget {
  final bool showBack;

  const AboutUsScreen({super.key, this.showBack = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'About Us',
        showRefresh: false,
        showBack: showBack,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(Assets.logo, height: 50, width: 50),
                  ),
                  height(20),
                  Text(
                    "Welcome to Kal's Enterprises: Your Complete HR Solution",
                    textAlign: TextAlign.center,
                    style: AppTheme.label16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  height(20),
                  Text(
                    "KALS360 is a powerful, all-in-one HRMS and the flagship product of KALS Enterprise. Designed to manage the complete employee lifecycle, it brings recruitment, onboarding, attendance, payroll, compliance, and HR operations onto a single, intuitive platform. Built with real staffing industry expertise, KALS360 delivers smarter automation, better control, and a true 360° view of your workforce..\n\n",
                    style: AppTheme.label12,
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
