import 'package:flutter/material.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import 'service_support_screen.dart';
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
              icon: Icons.gavel_rounded,
              title: 'Legal Support',
              subtitle:
                  'Medico‑legal queries, notices, negligence allegations, consultations and appointment booking',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LegalSupportScreen()),
              ),
            ),
            height(16),
            _SupportCard(
              icon: Icons.support_agent_rounded,
              title: 'Service Support',
              subtitle:
                  'Admin & customer service — renewals, documents, payments, endorsements and upgrades',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ServiceSupportScreen()),
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
