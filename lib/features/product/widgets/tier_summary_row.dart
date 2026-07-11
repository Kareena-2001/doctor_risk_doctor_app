import 'package:Doctors_App/features/product/widgets/tier_helper.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/values/app_text_style.dart';
import '../model/product_tier.dart';

class TierSummaryRow extends StatelessWidget {
  final TierPlan tier;

  const TierSummaryRow({super.key, required this.tier});

  @override
  Widget build(BuildContext context) {
    final s = tier.style;
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: s.bgColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: s.accentColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(s.icon, size: 16, color: s.accentColor),
          const SizedBox(width: 8),
          Text(
            tier.name,
            style: customTextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: s.accentColor,
            ),
          ),
          if (tier.isBestValue) ...[
            SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: s.accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Best value',
                style: customTextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: s.accentColor,
                ),
              ),
            ),
          ],
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${formatAmount(tier.premiumPerYear)}/yr',
                style: customTextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                'Cover: ₹${formatAmount(tier.sumInsured)}',
                style: customTextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
