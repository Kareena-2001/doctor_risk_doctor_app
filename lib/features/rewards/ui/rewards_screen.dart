import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../theme/app_colors.dart';
import '../model/rewards_model.dart';

class RewardsScreen extends ConsumerWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(Responsive.w(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPointsHeroCard(isDark),
          height(Responsive.h(24)),
          Text(
            'Points History',
            style: customTextStyle(
              fontSize: Responsive.sp(16),
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(4)),
          Text(
            'Track points earned through community contributions and referrals.',
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              color: AppColors.homeTextMuted,
            ),
          ),
          height(Responsive.h(16)),
          ...rewardsData.transactions.map(
            (tx) => _buildTransactionTile(tx, isDark),
          ),
          height(Responsive.h(40)),
        ],
      ),
    );
  }

  Widget _buildPointsHeroCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(20)),
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [AppColors.white],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AVAILABLE BALANCE',
                style: customTextStyle(
                  fontSize: Responsive.sp(11),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor,
                ).copyWith(letterSpacing: 1.0),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(10),
                  vertical: Responsive.h(4),
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE6C878), Color(0xFFB8912F)],
                  ),
                  borderRadius: BorderRadius.circular(Responsive.w(20)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: Responsive.sp(13),
                      color: Colors.white,
                    ),
                    width(Responsive.w(4)),
                    Text(
                      'Gold Tier',
                      style: customTextStyle(
                        fontSize: Responsive.sp(11),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          height(Responsive.h(8)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${rewardsData.availablePoints}',
                style: customTextStyle(
                  fontSize: Responsive.sp(32),
                  fontWeight: FontWeight.w800,
                  color: AppColors.textColorGrey,
                ),
              ),
              width(Responsive.w(6)),
              Text(
                'points available',
                style: customTextStyle(
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          height(Responsive.h(16)),
          Divider(color: Colors.white.withValues(alpha: 0.12), height: 1),
          height(Responsive.h(16)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: Responsive.sp(16),
                color: AppColors.textColor,
              ),
              width(Responsive.w(8)),
              Expanded(
                child: Text(
                  'Redeem your points at checkout — toward a membership renewal, a new plan purchase, or a paid event — from the Payment Gateway\'s "Redeem Reward Points" toggle.',
                  style: customTextStyle(
                    fontSize: Responsive.sp(11.5),
                    color: AppColors.textColorGrey,
                  ).copyWith(height: 1.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(RewardTransactionModel tx, bool isDark) {
    final isPositive = tx.type == TransactionType.earn;

    return Container(
      margin: EdgeInsets.only(bottom: Responsive.h(12)),
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1D) : Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: AppColors.fieldGrey.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   padding: EdgeInsets.all(Responsive.w(8)),
          //   decoration: BoxDecoration(
          //     color: const Color(0xFF57C97E).withValues(alpha: 0.12),
          //     shape: BoxShape.circle,
          //   ),
          //   child: Icon(
          //     Icons.add_rounded,
          //     color: const Color(0xFF57C97E),
          //     size: Responsive.sp(18),
          //   ),
          // ),
          // width(Responsive.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: customTextStyle(
                    fontSize: Responsive.sp(11),
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ).copyWith(height: 1.3),
                ),
                height(Responsive.h(4)),
                Text(
                  tx.date,
                  style: customTextStyle(
                    fontSize: Responsive.sp(9),
                    color: AppColors.homeTextMuted,
                  ),
                ),
              ],
            ),
          ),
          width(Responsive.w(8)),
          Text(
            '${isPositive ? '+' : '-'}${_formatNumber(tx.points)} Pts',
            style: customTextStyle(
              fontSize: Responsive.sp(10),
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
