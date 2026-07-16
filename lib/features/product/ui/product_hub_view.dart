import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/values/app_text_style.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';

class ProductHubView extends StatelessWidget {
  const ProductHubView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Products'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _EntryCard(
                      icon: Icons.storefront_rounded,
                      title: 'Browse Plans',
                      subtitle: 'Explore & buy new plans',
                      color: AppColors.accent.withValues(alpha: 0.7),
                      onTap: () => context.push(Routes.productList),
                    ),
                  ),
                  width(12),
                  Expanded(
                    child: _EntryCard(
                      icon: Icons.shield_moon_rounded,
                      title: 'My Plans',
                      subtitle: 'View, renew & manage',
                      color: AppColors.newPri,
                      onTap: () => context.push(Routes.myPlans),
                    ),
                  ),
                ],
              ),
              height(24),
              Text(
                'Services',
                style: customTextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              height(12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
                children: const [
                  _ServiceIcon(
                    icon: Icons.description_outlined,
                    label: 'Auditing\nMedical Records',
                  ),
                  _ServiceIcon(
                    icon: Icons.share_outlined,
                    label: 'Social Media\nDefamation',
                  ),
                  _ServiceIcon(
                    icon: Icons.support_agent_outlined,
                    label: 'Person-to-Person\nConsultation',
                  ),
                  _ServiceIcon(
                    icon: Icons.folder_open_outlined,
                    label: 'Legal\nDocumentation',
                  ),
                  _ServiceIcon(
                    icon: Icons.security_outlined,
                    label: 'Defense Cost\nof Defending',
                  ),
                  _ServiceIcon(
                    icon: Icons.payments_outlined,
                    label: 'Bail Cost\nCoverage',
                  ),
                  _ServiceIcon(
                    icon: Icons.balance_outlined,
                    label: 'Pre-Litigation\nSupport',
                  ),
                  _ServiceIcon(
                    icon: Icons.handshake_outlined,
                    label: 'Out-of-Court\nSettlement',
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
  final Color color;
  final VoidCallback onTap;

  const _EntryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withValues(alpha: 0.85), color],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 26),
            height(10),
            Text(
              title,
              style: customTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            height(2),
            Text(
              subtitle,
              style: customTextStyle(
                fontSize: 11,
                color: Colors.white.withValues(alpha: 0.85),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
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
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.newPri.withValues(alpha: 0.08),
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
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
