import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/features/community/ui/state/community_state.dart';
import 'package:Doctors_App/features/community/ui/view_model/community_view_model.dart';
import 'package:Doctors_App/features/community/ui/widgets/refer_doctor_form.dart';
import 'package:Doctors_App/features/community/ui/widgets/referral_link_card.dart';
import 'package:Doctors_App/features/community/ui/widgets/referral_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../theme/app_colors.dart';

class ReferAndGroupsTab extends ConsumerStatefulWidget {
  const ReferAndGroupsTab({super.key});

  @override
  ConsumerState<ReferAndGroupsTab> createState() => _ReferAndGroupsTabState();
}

class _ReferAndGroupsTabState extends ConsumerState<ReferAndGroupsTab> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(communityViewModelProvider.notifier).getDoctorNo();
      ref.read(communityViewModelProvider.notifier).referDoctorList();
    });
  }

  Future<void> _refresh() async {
    await Future.wait([
      ref.read(communityViewModelProvider.notifier).getDoctorNo(),
      ref.read(communityViewModelProvider.notifier).refreshReferDoctorList(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(communityViewModelProvider);

    return AppRefreshIndicator(
      onRefresh: _refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(Responsive.w(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderBanner(),
            height(Responsive.h(16)),

            state.referralLink.when(
              loading: () =>
                  const ReferralLinkCard(referralLink: '', isLoading: true),
              error: (error, stackTrace) =>
                  const ReferralLinkCard(referralLink: ''),
              data: (response) {
                final doctorNo = response.data.doctorNo;

                return ReferralLinkCard(referralLink: doctorNo);
              },
            ),
            height(Responsive.h(16)),
            const ReferDoctorForm(),
            height(Responsive.h(16)),

            Text(
              'Your referrals',
              style: customTextStyle(
                fontSize: Responsive.sp(15),
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            height(Responsive.h(10)),
            _buildReferralList(state),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBanner() {
    return Container(
      padding: EdgeInsets.all(Responsive.w(18)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Responsive.w(20)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.newPri, AppColors.newPri.withValues(alpha: 0.75)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.newPri.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(Responsive.w(10)),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(Responsive.w(14)),
                ),
                child: Icon(
                  Icons.card_giftcard_rounded,
                  color: Colors.white,
                  size: Responsive.sp(20),
                ),
              ),
              width(Responsive.w(14)),
              Text(
                'REFER & EARN',
                style: customTextStyle(
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          height(Responsive.h(10)),
          Text(
            'Invite a peer, earn reward points',
            style: customTextStyle(
              fontSize: Responsive.sp(12.5),
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          height(Responsive.h(6)),
          Text(
            'When a referred professional joins and secures a membership, '
            'you earn reward points — redeemable at your next renewal, '
            'new plan purchase, or a paid event.',
            style: customTextStyle(
              fontSize: Responsive.sp(11),
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralList(CommunityState state) {
    return state.referralList.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Container(
        width: double.infinity,
        padding: EdgeInsets.all(Responsive.w(20)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Responsive.w(16)),
        ),
        child: Column(
          children: [
            Text(
              'Failed to load referrals',
              style: customTextStyle(
                fontSize: Responsive.sp(12.5),
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            height(Responsive.h(8)),
            TextButton(
              onPressed: () => ref
                  .read(communityViewModelProvider.notifier)
                  .refreshReferDoctorList(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (response) => ReferralList(referrals: response.data),
    );
  }
}
