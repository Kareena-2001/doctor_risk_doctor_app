
import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';

class PlanSummaryCard extends StatelessWidget {
  final String productName;
  final String tierName;
  final String duration;
  final double sumAssured;
  final double premium;

  const PlanSummaryCard({super.key,
    required this.productName,
    required this.tierName,
    required this.duration,
    required this.sumAssured,
    required this.premium,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.orange.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.orange.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$productName · $tierName',
            style: customTextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
          height(8),
          Row(
            children: [
              _summaryChip('Duration', duration),
              width(8),
              _summaryChip('Sum assured', '₹${sumAssured.toStringAsFixed(0)}'),
              width(8),
              _summaryChip('Premium', '₹${premium.toStringAsFixed(0)}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryChip(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: customTextStyle(fontSize: 10, color: AppColors.grey),
          ),
          Text(
            value,
            style: customTextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}