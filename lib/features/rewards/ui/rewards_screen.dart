import 'package:Doctors_App/core/widgets/common_empty_state.dart';
import 'package:Doctors_App/core/widgets/common_error_state.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/rewards/model/reward_points_model.dart';
import 'package:Doctors_App/features/rewards/ui/state/rewards_state.dart';
import 'package:Doctors_App/features/rewards/ui/view_model/rewards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../extensions/date_time_extension.dart';
import '../../../theme/app_colors.dart';

class RewardsScreen extends ConsumerStatefulWidget {
  const RewardsScreen({super.key});

  @override
  ConsumerState<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends ConsumerState<RewardsScreen> {
  final ScrollController _scrollController = ScrollController();

  static const _green = Color(0xFF2E9E5B);

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(rewardsViewModelProvider.notifier).loadRewards();
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200) {
      final state = ref.read(rewardsViewModelProvider);

      if (state.hasMore && !state.isLoadingMore && !state.isLoading) {
        ref.read(rewardsViewModelProvider.notifier).loadMoreRewards();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rewardsState = ref.watch(rewardsViewModelProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppBar(title: 'Rewards'),
      body: _buildBody(rewardsState, isDark),
    );
  }

  Widget _buildBody(RewardsState rewardsState, bool isDark) {
    final rewardsData = rewardsState.rewardsData;
    if (rewardsData == null && rewardsState.isLoading) {
      return const Center(child: Loading());
    }
    if (rewardsData == null && rewardsState.errorMessage != null) {
      return _buildError(rewardsState.errorMessage!);
    }
    if (rewardsData == null) {
      return const SizedBox.shrink();
    }
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(rewardsViewModelProvider.notifier).loadRewards();
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        padding: EdgeInsets.fromLTRB(
          Responsive.w(16),
          Responsive.h(12),
          Responsive.w(16),
          Responsive.h(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPointsHeroCard(rewardsData),

            height(Responsive.h(20)),

            _buildHistoryHeader(rewardsData),

            height(Responsive.h(12)),

            if (rewardsData.rewardPoints.isEmpty)
              _buildEmptyState()
            else
              ...rewardsData.rewardPoints.map(
                (reward) => _buildTransactionTile(reward, isDark),
              ),

            if (rewardsState.isLoadingMore)
              Padding(
                padding: EdgeInsets.symmetric(vertical: Responsive.h(12)),
                child: const Center(child: Loading()),
              ),

            // Bottom breathing space
            height(Responsive.h(20)),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: CommonErrorState(
        title: 'Failed to load rewards',
        message: message,
        onRetry: () {
          ref.read(rewardsViewModelProvider.notifier).loadRewards();
        },
      ),
    );
  }

  Widget _buildPointsHeroCard(RewardPointsData data) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Responsive.w(16)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.secondaryBackgroundColor,
          borderRadius: BorderRadius.circular(Responsive.w(16)),
          border: Border.all(color: context.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 2.5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE6C878), Color(0xFFB8912F)],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Responsive.w(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.workspace_premium_rounded,
                        size: Responsive.sp(14),
                        color: Color(0xFFB8912F),
                      ),
                      width(Responsive.w(6)),
                      Text(
                        'AVAILABLE BALANCE',
                        style: customTextStyle(
                          fontSize: Responsive.sp(10),
                          fontWeight: FontWeight.w700,
                          color: context.secondaryTextColor,
                        ).copyWith(letterSpacing: 1.2),
                      ),
                    ],
                  ),
                  height(Responsive.h(6)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        _formatNumber(data.availablePoints),
                        style: customTextStyle(
                          fontSize: Responsive.sp(30),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFD99A00),
                        ),
                      ),
                      width(Responsive.w(6)),
                      Text(
                        'points',
                        style: customTextStyle(
                          fontSize: Responsive.sp(13),
                          fontWeight: FontWeight.w600,
                          color: context.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  height(Responsive.h(12)),
                  Divider(height: 1, thickness: 1, color: context.borderColor),
                  height(Responsive.h(12)),
                  Row(
                    children: [
                      Expanded(
                        child: _heroStat(
                          'Total Earned',
                          data.totalEarnedPoints,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: Responsive.h(28),
                        color: context.borderColor,
                      ),
                      width(Responsive.w(16)),
                      Expanded(
                        child: _heroStat(
                          'Total Redeemed',
                          data.totalRedeemedPoints,
                        ),
                      ),
                    ],
                  ),
                  height(Responsive.h(12)),
                  Divider(height: 1, thickness: 1, color: context.borderColor),
                  height(Responsive.h(10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: Responsive.sp(13),
                        color: context.secondaryTextColor,
                      ),
                      width(Responsive.w(8)),
                      Expanded(
                        child: Text(
                          'Redeem your points at checkout — toward a membership renewal, a new plan purchase, or a paid event — from the Payment Gateway\'s "Redeem Reward Points" toggle.',
                          style: customTextStyle(
                            fontSize: Responsive.sp(10.5),
                            color: context.secondaryTextColor,
                          ).copyWith(height: 1.35),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heroStat(String label, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _formatNumber(value),
          style: customTextStyle(
            fontSize: Responsive.sp(16),
            fontWeight: FontWeight.w800,
            color: context.primaryTextColor,
          ),
        ),
        height(Responsive.h(1)),
        Text(
          label,
          style: customTextStyle(
            fontSize: Responsive.sp(10.5),
            color: context.secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryHeader(RewardPointsData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Points History',
          style: customTextStyle(
            fontSize: Responsive.sp(15),
            fontWeight: FontWeight.w700,
            color: context.primaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionTile(RewardPointModel reward, bool isDark) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: Responsive.h(8)),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(12),
        vertical: Responsive.h(10),
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1D) : Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(14)),
        border: Border.all(color: AppColors.fieldGrey.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.w(36),
            height: Responsive.w(36),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.article_rounded,
              color: AppColors.primary,
              size: Responsive.sp(17),
            ),
          ),
          width(Responsive.w(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward.text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: customTextStyle(
                    fontSize: Responsive.sp(12.5),
                    fontWeight: FontWeight.w600,
                    color: context.primaryTextColor,
                  ).copyWith(height: 1.3),
                ),
                height(Responsive.h(3)),
                Text(
                  '${reward.rewardPointType}  •  ${_formatDate(reward.date)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: customTextStyle(
                    fontSize: Responsive.sp(10.5),
                    color: AppColors.homeTextMuted,
                  ),
                ),
              ],
            ),
          ),
          width(Responsive.w(8)),
          Text(
            '+${_formatNumber(reward.points)}',
            style: customTextStyle(
              fontSize: Responsive.sp(15),
              fontWeight: FontWeight.w800,
              color: _green,
            ),
          ),
          width(Responsive.w(2)),
          Text(
            'pts',
            style: customTextStyle(
              fontSize: Responsive.sp(10),
              fontWeight: FontWeight.w600,
              color: _green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return CommonEmptyState(
      title: 'No reward points yet',
      icon: Icons.shield_outlined,
    );
  }

  String _formatDate(String raw) {
    final date = DateTime.tryParse(raw);

    if (date == null) {
      return raw;
    }

    return date.toEventDate();
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
