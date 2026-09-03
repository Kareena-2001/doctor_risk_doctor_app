import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
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
      appBar: CustomAppBar(title: 'My Products'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Products',
                style: customTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              height(4),
              Text(
                'Everything covered under your medico-legal membership.',
                style: customTextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
              height(16),
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
                      onTap: () => context.push(Routes.productList),
                    ),
                  ),
                  width(12),
                  Expanded(
                    child: _EntryCard(
                      icon: Icons.access_time_rounded,
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
                  color: const Color(0xFF0F172A),
                ),
              ),
              height(12),

              // Services Grid (App vertical icon card structure + Web items)
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
                    icon: Icons.access_time,
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Icon Badge
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF10B981), size: 20),
          ),
          height(10),
          Text(
            title,
            style: customTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          height(4),
          Text(
            subtitle,
            style: customTextStyle(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ).copyWith(height: 1.3),
          ),
          height(14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: isPrimaryButton
                    ? const Color(0xFF065F46) // Dark green background
                    : Colors.white,
                foregroundColor: isPrimaryButton
                    ? Colors
                          .white // Text color set to White
                    : const Color(0xFF1E293B),
                side: isPrimaryButton
                    ? BorderSide.none
                    : const BorderSide(color: Color(0xFFE2E8F0)),
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                buttonText,
                style: customTextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isPrimaryButton
                      ? Colors.white
                      : const Color(0xFF1E293B),
                ),
              ),
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
            // Circular light green icon container on top
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFECFDF5),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF10B981), size: 18),
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
                color: const Color(0xFF475569),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
