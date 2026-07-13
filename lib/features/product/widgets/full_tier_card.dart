import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/product/widgets/tier_helper.dart';
import 'package:flutter/material.dart';

import '../model/product_tier.dart';

class FullTierCard extends StatelessWidget {
  final TierPlan plan;
  final bool isSelected;
  final VoidCallback onSelect;

  const FullTierCard({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final s = plan.style;
    return GestureDetector(
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? s.accentColor : const Color(0xFFE2E8F0),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? s.accentColor.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: isSelected ? 24 : 8,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTop(s),
            _buildPriceBlock(s),
            _buildStats(s),
            _buildFeatures(s),
            _buildCTA(s),
          ],
        ),
      ),
    );
  }

  Widget _buildTop(TierStyle s) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: s.bgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(s.icon, color: s.accentColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      plan.name,
                      style: customTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: s.accentColor,
                      ).copyWith(letterSpacing: -0.4),
                    ),
                    if (plan.isBestValue) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: s.bgColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: s.accentColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 11,
                              color: s.accentColor,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              'Best value',
                              style: customTextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: s.accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  plan.tagline,
                  style: customTextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                  ).copyWith(height: 1.4),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isSelected ? s.accentColor : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? s.accentColor : const Color(0xFFCBD5E1),
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBlock(TierStyle s) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: s.bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sum insured',
                    style: customTextStyle(
                      fontSize: 11,
                      color: s.textColor.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${formatAmount(plan.sumInsured)}',
                    style: customTextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: s.accentColor,
                    ).copyWith(letterSpacing: -0.5, height: 1),
                  ),
                  Text(
                    'coverage',
                    style: customTextStyle(
                      fontSize: 11,
                      color: s.textColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: 52,
              color: s.accentColor.withValues(alpha: 0.15),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Premium',
                    style: customTextStyle(
                      fontSize: 11,
                      color: s.textColor.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '₹',
                          style: customTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: s.textColor,
                          ),
                        ),
                        TextSpan(
                          text: formatAmount(plan.premiumPerYear),
                          style: customTextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            color: s.accentColor,
                          ).copyWith(letterSpacing: -1.5, height: 1),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'per year',
                    style: customTextStyle(
                      fontSize: 11,
                      color: s.textColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats(TierStyle s) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        children: [
          StatPill(
            icon: Icons.people_rounded,
            value: '${plan.maxMembers} members',
            color: s.accentColor,
            bg: s.bgColor,
          ),
          const SizedBox(width: 8),
          StatPill(
            icon: Icons.calendar_month_rounded,
            value: '${plan.validityYears} yr validity',
            color: s.accentColor,
            bg: s.bgColor,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures(TierStyle s) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What's included",
            style: customTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64748B),
            ).copyWith(letterSpacing: 0.3),
          ),
          const SizedBox(height: 10),
          ...plan.features.map((f) => FeatureRow(feature: f, style: s)),
        ],
      ),
    );
  }

  Widget _buildCTA(TierStyle s) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
      child: SizedBox(
        width: double.infinity,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected ? s.accentColor : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? s.accentColor : const Color(0xFFCBD5E1),
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: s.accentColor.withValues(alpha: 0.28),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              onTap: onSelect,
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isSelected
                          ? '${plan.name} selected'
                          : 'Select ${plan.name}',
                      style: customTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF475569),
                      ).copyWith(letterSpacing: 0.2),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      isSelected
                          ? Icons.check_circle_rounded
                          : Icons.arrow_forward_rounded,
                      size: 16,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF94A3B8),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatPill extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;
  final Color bg;

  const StatPill({
    required this.icon,
    required this.value,
    required this.color,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 6),
          Text(
            value,
            style: customTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureRow extends StatelessWidget {
  final TierFeatureItem feature;
  final TierStyle style;

  const FeatureRow({required this.feature, required this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: feature.included
                  ? style.accentColor.withValues(alpha: 0.1)
                  : const Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              feature.included ? Icons.check_rounded : Icons.close_rounded,
              size: 12,
              color: feature.included
                  ? style.accentColor
                  : const Color(0xFFCBD5E1),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            feature.label,
            style:
                customTextStyle(
                  fontSize: 13,
                  color: feature.included
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFCBD5E1),
                  fontWeight: feature.included
                      ? FontWeight.w500
                      : FontWeight.w400,
                ).copyWith(
                  decoration: feature.included
                      ? TextDecoration.none
                      : TextDecoration.lineThrough,
                ),
          ),
        ],
      ),
    );
  }
}
