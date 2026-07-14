import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/helpdesk/ui/registery_query_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import 'legal_support_screen.dart';

class SupportHubScreen extends StatelessWidget {
  const SupportHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Support Hub'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How can we help you?', style: AppTheme.title16),
            height(4),
            Text(
              'Choose an option below to get started',
              style: AppTheme.label12,
            ),
            height(20),
            _SupportCard(
              icon: Icons.support_agent_rounded,
              title: 'Register / Request a Query',
              subtitle:
                  'Raise a Medico Legal or Legal query, consultation, notice or pre-existing case',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterQueryScreen()),
              ),
            ),
            height(16),
            _SupportCard(
              icon: Icons.gavel_rounded,
              title: 'Legal Support',
              subtitle: 'Book an appointment or get expert support on call',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LegalSupportScreen()),
              ),
            ),

            height(24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => context.push(Routes.myQueries),
                icon: Icon(Icons.list_alt_rounded, color: AppColors.textColor),
                label: Text(
                  'View My Queries',
                  style: customTextStyle(fontSize: 14),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SupportCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: isDark ? Colors.grey.shade800 : Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.newPri),
              ),
              width(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTheme.title14),
                    height(4),
                    Text(subtitle, style: AppTheme.label12),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
