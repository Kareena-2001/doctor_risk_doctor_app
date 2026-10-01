import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/community/ui/state/community_state.dart';
import 'package:Doctors_App/features/community/ui/view_model/community_view_model.dart';
import 'package:Doctors_App/features/community/ui/widgets/referral_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReferralListScreen extends ConsumerStatefulWidget {
  const ReferralListScreen({super.key});

  @override
  ConsumerState<ReferralListScreen> createState() => _ReferralListScreenState();
}

class _ReferralListScreenState extends ConsumerState<ReferralListScreen> {
  bool _loadingMore = false;
  String? _paginationError;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(communityViewModelProvider.notifier).referDoctorList(),
    );
  }

  Future<void> _refresh() async {
    await ref
        .read(communityViewModelProvider.notifier)
        .refreshReferDoctorList();
  }

  Future<void> _loadMoreReferrals() async {
    setState(() {
      _loadingMore = true;
      _paginationError = null;
    });
    try {
      await ref.read(communityViewModelProvider.notifier).loadMoreReferrals();
    } catch (error) {
      _paginationError = error.toString();
    } finally {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(communityViewModelProvider);

    return Scaffold(
      appBar: CustomAppBar(title: 'Your Referrals'),
      body: AppRefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(Responsive.w(16)),
          child: _buildList(state),
        ),
      ),
    );
  }

  Widget _buildList(CommunityState state) {
    return state.referralList.when(
      loading: () => Padding(
        padding: EdgeInsets.symmetric(vertical: Responsive.h(24)),
        child: const Center(child: Loading()),
      ),
      error: (error, stackTrace) => Column(
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
          TextButton(onPressed: _refresh, child: const Text('Retry')),
        ],
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
