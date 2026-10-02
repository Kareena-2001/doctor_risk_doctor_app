import 'package:Doctors_App/core/exceptions/exception_extension.dart';
import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/community/ui/state/community_state.dart';
import 'package:Doctors_App/features/community/ui/view_model/community_view_model.dart';
import 'package:Doctors_App/features/community/ui/widgets/refer_doctor_form.dart';
import 'package:Doctors_App/features/community/ui/widgets/referral_link_card.dart';
import 'package:Doctors_App/features/community/ui/widgets/referral_list.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/heading_widget.dart';
import '../../../theme/app_colors.dart';

class ReferAndGroupsTab extends ConsumerStatefulWidget {
  const ReferAndGroupsTab({super.key});

  @override
  ConsumerState<ReferAndGroupsTab> createState() => _ReferAndGroupsTabState();
}

class _ReferAndGroupsTabState extends ConsumerState<ReferAndGroupsTab> {
  bool _loadingMore = false;
  String? _paginationError;

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

  Future<void> _loadMoreReferrals() async {
    setState(() {
      _loadingMore = true;
      _paginationError = null;
    });
    try {
      await ref.read(communityViewModelProvider.notifier).loadMoreReferrals();
    } catch (error) {
      _paginationError = error.readableMessage;
    } finally {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  void _showReferDoctorForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(sheetContext).size.height * 0.9,
          ),
          decoration: BoxDecoration(
            color: Theme.of(sheetContext).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Responsive.w(24)),
            ),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: Responsive.h(12),
                      left: Responsive.w(20),
                      right: Responsive.w(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Refer a Doctor',
                            style: customTextStyle(
                              fontSize: Responsive.sp(17),
                              fontWeight: FontWeight.bold,
                              color: sheetContext.primaryTextColor,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(sheetContext),
                          icon: const Icon(Icons.close_rounded),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1),

                  Padding(
                    padding: EdgeInsets.all(Responsive.w(16)),
                    child: const ReferDoctorForm(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(communityViewModelProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showReferDoctorForm,
        backgroundColor: AppColors.newPri,
        foregroundColor: Colors.white,
        icon: Icon(Icons.person_add_alt_1_rounded, size: 18),
        label: Text(
          'Refer Colleague',
          style: customTextStyle(
            fontSize: Responsive.sp(12),
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: AppRefreshIndicator(
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
              height(Responsive.h(20)),
              // Text(
              //   'Your referrals',
              //   style: customTextStyle(
              //     fontSize: Responsive.sp(15),
              //     fontWeight: FontWeight.bold,
              //     color: context.primaryTextColor,
              //   ),
              // ),
              HeadingWidget(
                headingTitle: "Your Referrals",
                buttonText: "View All",
                onTap: () => context.push(Routes.referList),
              ),
              height(Responsive.h(10)),
              _buildReferralList(state),
              height(Responsive.h(100)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderBanner({int referredCount = 2}) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
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

              width(Responsive.w(12)),

              Expanded(
                child: Text(
                  'REFER & EARN',
                  style: customTextStyle(
                    fontSize: Responsive.sp(14),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(12),
                  vertical: Responsive.h(8),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(Responsive.w(14)),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$referredCount',
                      style: customTextStyle(
                        fontSize: Responsive.sp(16),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Peers referred',
                      style: customTextStyle(
                        fontSize: Responsive.sp(9),
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          height(Responsive.h(12)),

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
      loading: () => Padding(
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
      data: (response) => ReferralList(
        referrals: response.data,
        hasMore: response.currentPage < response.lastPage,
        isLoadingMore: _loadingMore,
        paginationError: _paginationError,
        onLoadMore: _loadMoreReferrals,
      ),
    );
  }
}
