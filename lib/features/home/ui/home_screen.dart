import 'dart:async';

import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_seachbar.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/home/ui/view_model/home_view_model.dart';
import 'package:Doctors_App/features/home/ui/widgets/social_link_widget.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/assets.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/heading_widget.dart';
import '../../../routing/routes.dart';
import '../../events/ui/event_register_screen.dart';
import '../../notification/ui/viewmodel/notification_view_model.dart';
import '../model/policy_model.dart';
import 'floating_chat_bubble.dart';

final policyModel = PolicyModel(
  title: 'Policy Details',
  planName: 'Medico Legal Services',
  policyType: 'Professional Indemnity',
  coverageAmount: 'Rs. 50,000,000',
  policyNumber: '03303387333412',
  duration: '1 Year',
  validFrom: '01/09/2024',
  validTo: '31/08/2025',
  status: PolicyStatus.expired,
);

final List<PolicyModel> personalPlansList = [
  const PolicyModel(
    title: 'Personal Plan',
    planName: 'Doctor Indemnity Cover',
    policyType: 'Professional Indemnity',
    coverageAmount: '₹ 50,00,000',
    policyNumber: '03303387333412',
    duration: '1 Year',
    validFrom: '01/09/2024',
    validTo: '31/08/2025',
    status: PolicyStatus.active,
  ),
  const PolicyModel(
    title: 'Personal Plan',
    planName: 'Clinic Liability Cover',
    policyType: 'Clinical Establishment',
    coverageAmount: '₹ 25,00,000',
    policyNumber: '03303387998821',
    duration: '1 Year',
    validFrom: '01/08/2024',
    validTo: '31/07/2025',
    status: PolicyStatus.renewal,
  ),
  const PolicyModel(
    title: 'Personal Plan',
    planName: 'Locum Cover',
    policyType: 'Locum Indemnity',
    coverageAmount: '₹ 10,00,000',
    policyNumber: '03303387112233',
    duration: '1 Year',
    validFrom: '01/06/2023',
    validTo: '31/05/2024',
    status: PolicyStatus.expired,
  ),
];

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final String userId;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _sessionTimer;

  // Carousel state for the personal-plans pager inside _buildPolicyCard
  final PageController _planPageController = PageController();
  int _currentPlanPage = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
    _startSessionCheck();
  }

  void _startSessionCheck() {
    _sessionTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      debugPrint('Checking session...');
      ref.invalidate(homeViewModelProvider);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _sessionTimer?.cancel();
    _planPageController.dispose();
    super.dispose();
  }

  Future<void> _refreshUserData() async {
    try {
      ref.invalidate(homeViewModelProvider);
      ref.invalidate(notificationViewModelProvider);
    } catch (e) {
      debugPrint('Refresh failed: $e');
    }
  }

  Future<void> _handleNotificationTap() async {
    final alertViewModel = ref.read(notificationAlertProvider.notifier);

    try {
      await alertViewModel.removeAlert();
    } catch (e) {
      debugPrint('Failed to remove notification alert: $e');
    }

    if (mounted) {
      context.push(Routes.notification, extra: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: isDark
              ? const Color(0xFF0E0E10)
              : const Color(0xFFF6F7FB),

          appBar: CustomAppBar(
            title: 'Dashboard',
            showBack: false,
            showDrawer: true,
            showScan: true,
            onScan: () async {
              final result = await context.push(Routes.scanScreen);
              if (result != null) {
                debugPrint('Scanned: $result');
              }
            },
            onDrawer: () {
              context.push(Routes.appDrawer);
            },
            backgroundColor: isDark ? Colors.black : const Color(0xFFF8F9FA),
            showNotification: true,
            onNotification: _handleNotificationTap,
          ),
          body: RefreshIndicator(
            color: AppColors.newPri,
            onRefresh: _refreshUserData,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    height(Responsive.h(8)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Responsive.h(5),
                        horizontal: Responsive.w(20),
                      ),
                      child: CustomSearchBar(
                        controller: TextEditingController(),
                        hint: 'Search policies, blogs, FAQs, community...',
                      ),
                    ),
                    height(Responsive.h(8)),
                    _buildCompactProfileHeader(isDark, policyModel),
                    height(Responsive.h(20)),
                    _buildMainContent(isDark, policyModel),
                    height(Responsive.h(100)),
                  ],
                ),
              ),
            ),
          ),
        ),
        const FloatingChatBubble(),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════
  // HERO / COMPACT PROFILE HEADER — matches the prototype's
  // hero-left content: avatar, name, points, role, tier badge,
  // status tag, profile completion, and the Med Reg/Membership
  // ID/Coverage/Renews meta grid.
  // ═══════════════════════════════════════════════════════════
  Widget _buildCompactProfileHeader(bool isDark, PolicyModel policy) {
    final status = policy.status;
    final noPlan = status == PolicyStatus.noPlan;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      padding: EdgeInsets.symmetric(
        vertical: Responsive.h(24),
        horizontal: Responsive.w(20),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Responsive.w(28)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF1A1A1D), const Color(0xFF232326)]
              : [Colors.white, const Color(0xFFF3F4FF)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.newPri.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => context.push(Routes.editProfile),
            child: Container(
              padding: EdgeInsets.all(Responsive.w(4)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.newPri, AppColors.primary],
                ),
              ),
              child: Hero(
                tag: 'user_avatar',
                child: CircleAvatar(
                  radius: Responsive.w(38),
                  backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
                  child: CircleAvatar(
                    radius: Responsive.w(35),
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    backgroundImage: AssetImage(Assets.user),
                  ),
                ),
              ),
            ),
          ),
          height(Responsive.h(12)),

          // Name + points badge
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'Dr. Paresh Mathur',
                  textAlign: TextAlign.center,
                  style: customTextStyle(
                    fontSize: Responsive.sp(16),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              if (!noPlan) ...[width(Responsive.w(8)), _pointsBadge('320')],
            ],
          ),
          height(Responsive.h(4)),
          Text(
            'General Practitioner · B.A.M.S.',
            style: customTextStyle(
              fontSize: Responsive.sp(11.5),
              color: AppColors.homeTextMuted,
            ),
          ),
          height(Responsive.h(12)),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: Responsive.w(8),
            runSpacing: Responsive.h(8),
            children: [
              if (!noPlan) _tierBadge('Gold II · Premium'),
              _statusTag(status),
              _profileCompletionTag(noPlan ? '48' : '92'),
            ],
          ),
          height(Responsive.h(18)),
          _buildHeroMetaGrid(policy, noPlan),
          height(Responsive.h(14)),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Icon(
          //       Icons.gavel_outlined,
          //       size: Responsive.sp(16),
          //       color: AppColors.primary,
          //     ),
          //     width(Responsive.w(6)),
          //     Text(
          //       'Doctors Risk Medico Legal Services',
          //       style: customTextStyle(
          //         color: AppColors.newPri,
          //         fontSize: Responsive.sp(13),
          //         fontWeight: FontWeight.w700,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _pointsBadge(String points) {
    return Container(
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            size: Responsive.sp(13),

            color: AppColors.white,
          ),
          width(Responsive.w(3)),
          Text(
            '$points pts',
            style: customTextStyle(
              fontSize: Responsive.sp(11.5),
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tierBadge(String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(10),
        vertical: Responsive.h(5),
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE6C878), Color(0xFFB8912F)],
        ),
        borderRadius: BorderRadius.circular(Responsive.w(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.workspace_premium_rounded,
            size: Responsive.sp(13),
            color: Colors.white,
          ),
          width(Responsive.w(4)),
          Text(
            label,
            style: customTextStyle(
              fontSize: Responsive.sp(11),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Light-color status pill — green/red/yellow/white per status, as requested.
  Widget _statusTag(PolicyStatus status) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(12),
        vertical: Responsive.h(5),
      ),
      decoration: BoxDecoration(
        color: status.lightBg,
        border: Border.all(color: status.lightBorder),
        borderRadius: BorderRadius.circular(Responsive.w(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: Responsive.sp(12), color: status.color),
          width(Responsive.w(4)),
          Text(
            status.label,
            style: customTextStyle(
              fontSize: Responsive.sp(11.5),
              fontWeight: FontWeight.w700,
              color: status.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileCompletionTag(String percent) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(12),
        vertical: Responsive.h(5),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(Responsive.w(20)),
      ),
      child: Text(
        'Profile $percent% complete',
        style: customTextStyle(
          fontSize: Responsive.sp(11.5),
          fontWeight: FontWeight.w600,
          color: AppColors.homeTextMuted,
        ),
      ),
    );
  }

  Widget _buildHeroMetaGrid(PolicyModel policy, bool noPlan) {
    final items = <Widget>[
      _heroMetaItem('Med. Reg. No.', '48578'),
      if (!noPlan) ...[
        _heroMetaItem('Membership ID', 'DR-2026-084213'),
        _heroMetaItem('Coverage', policy.coverageAmount),
        _heroMetaItem(
          policy.status == PolicyStatus.expired ? 'Expired' : 'Renews',
          policy.validTo,
        ),
      ],
    ];
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: Responsive.w(22),
      runSpacing: Responsive.h(14),
      children: items,
    );
  }

  Widget _heroMetaItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: customTextStyle(
            fontSize: Responsive.sp(9.5),
            fontWeight: FontWeight.w600,
            color: AppColors.homeTextMuted,
          ).copyWith(letterSpacing: 0.6),
        ),
        height(Responsive.h(3)),
        Text(
          value,
          style: customTextStyle(
            fontSize: Responsive.sp(12.5),
            fontWeight: FontWeight.w700,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }

  List<PolicyModel> _filterPlansByPriorityStatus(List<PolicyModel> plans) {
    if (plans.isEmpty) return [];

    final expired = plans
        .where((p) => p.status == PolicyStatus.expired)
        .toList();

    if (expired.isNotEmpty) return expired;

    final renewal = plans
        .where((p) => p.status == PolicyStatus.renewal)
        .toList();

    if (renewal.isNotEmpty) return renewal;

    final active = plans.where((p) => p.status == PolicyStatus.active).toList();

    if (active.isNotEmpty) return active;

    return [];
  }

  // ═══════════════════════════════════════════════════════════
  // POLICY CARD — carousel + pagination when multiple plans.
  // Single static card when there's only one. Light-color card
  // per status (green/red/yellow/white), matching the prototype.
  // ═══════════════════════════════════════════════════════════
  Widget _buildPolicyCard(List<PolicyModel> plans) {
    if (plans.isEmpty) return _buildNoPlanCard();

    return Column(
      children: [
        SizedBox(
          height: Responsive.h(370),
          child: PageView.builder(
            controller: _planPageController,
            itemCount: plans.length,
            onPageChanged: (index) => setState(() => _currentPlanPage = index),
            itemBuilder: (context, index) {
              final plan = plans[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.w(2)),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: plan.status == PolicyStatus.noPlan
                      ? _buildNoPlanCard()
                      : _buildSinglePolicyCard(plan),
                ),
              );
            },
          ),
        ),
        if (plans.length > 1) ...[
          height(Responsive.h(10)),
          _buildPageDots(plans.length),
        ],
      ],
    );
  }

  Widget _buildPageDots(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == _currentPlanPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: Responsive.w(3)),
          width: active ? Responsive.w(18) : Responsive.w(6),
          height: Responsive.h(6),
          decoration: BoxDecoration(
            color: active ? AppColors.newPri : AppColors.homeBorder,
            borderRadius: BorderRadius.circular(Responsive.w(10)),
          ),
        );
      }),
    );
  }

  Widget _buildSinglePolicyCard(PolicyModel policy) {
    final status = policy.status;
    final isActive = policy.status == PolicyStatus.active;
    final isExpired = policy.status == PolicyStatus.expired;
    final noPlan = policy.status == PolicyStatus.noPlan;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(20)),
      decoration: BoxDecoration(
        color: status.lightBg,
        borderRadius: BorderRadius.circular(Responsive.w(28)),
        border: Border.all(color: status.lightBorder, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      policy.title.toUpperCase(),
                      style: customTextStyle(
                        color: AppColors.homeTextMuted,
                        fontSize: Responsive.sp(11),
                        fontWeight: FontWeight.w700,
                      ).copyWith(letterSpacing: 1.2),
                    ),
                    height(Responsive.h(6)),
                    Text(
                      policy.planName,
                      style: customTextStyle(
                        color: AppColors.textColor,
                        fontSize: Responsive.sp(15),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(10),
                  vertical: Responsive.h(6),
                ),
                decoration: BoxDecoration(
                  color: status.color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(Responsive.w(20)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      status.icon,
                      size: Responsive.sp(12),
                      color: status.color,
                    ),
                    width(Responsive.w(4)),
                    Text(
                      status.name[0].toUpperCase() + status.name.substring(1),
                      style: customTextStyle(
                        color: status.color,
                        fontSize: Responsive.sp(11),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          height(Responsive.h(4)),
          Text(
            policy.policyType,
            style: customTextStyle(
              color: AppColors.homeTextMuted,
              fontSize: Responsive.sp(12.5),
            ),
          ),
          height(Responsive.h(20)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Responsive.w(25),
                height: Responsive.w(25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE6C878), Color(0xFFB8912F)],
                  ),
                  borderRadius: BorderRadius.circular(Responsive.w(6)),
                ),
              ),
              width(Responsive.w(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'POLICY NUMBER',
                      style: customTextStyle(
                        color: AppColors.homeTextMuted,
                        fontSize: Responsive.sp(9.5),
                        fontWeight: FontWeight.w600,
                      ).copyWith(letterSpacing: 1.1),
                    ),
                    height(Responsive.h(3)),
                    Text(
                      policy.policyNumber,
                      style: customTextStyle(
                        color: AppColors.textColor,
                        fontSize: Responsive.sp(12),
                        fontWeight: FontWeight.w600,
                      ).copyWith(letterSpacing: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          height(Responsive.h(18)),
          Divider(color: status.lightBorder, height: 1),
          height(Responsive.h(16)),
          Row(
            children: [
              Expanded(
                child: _cardStatLight(
                  icon: Icons.security_rounded,
                  label: 'Coverage',
                  value: policy.coverageAmount,
                  status: status,
                ),
              ),
              Expanded(
                child: _cardStatLight(
                  icon: Icons.timelapse_rounded,
                  label: 'Duration',
                  value: policy.duration,
                  status: status,
                ),
              ),
            ],
          ),
          height(Responsive.h(14)),
          Row(
            children: [
              Expanded(
                child: _cardStatLight(
                  icon: Icons.calendar_today_rounded,
                  label: 'Valid From',
                  value: policy.validFrom,
                  status: status,
                ),
              ),
              Expanded(
                child: _cardStatLight(
                  icon: Icons.event_busy_rounded,
                  label: 'Valid To',
                  value: policy.validTo,
                  status: status,
                ),
              ),
            ],
          ),
          if (policy.canRenew) ...[
            height(Responsive.h(20)),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                height: Responsive.h(44),
                text: status == PolicyStatus.expired
                    ? 'Renew Now'
                    : 'Renew Early',
                fontSize: Responsive.sp(13),
                fontWeight: FontWeight.w700,
                gradientColors: status.gradient,
                borderRadius: Responsive.w(20),
                onPressed: () => context.push(Routes.myPlans),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _cardStatLight({
    required IconData icon,
    required String label,
    required String value,
    required PolicyStatus status,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: Responsive.sp(15),
          color: status.color.withValues(alpha: 0.75),
        ),
        width(Responsive.w(8)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: customTextStyle(
                  color: AppColors.homeTextMuted,
                  fontSize: Responsive.sp(9.5),
                  fontWeight: FontWeight.w600,
                ).copyWith(letterSpacing: 0.8),
              ),
              height(Responsive.h(3)),
              Text(
                value,
                style: customTextStyle(
                  color: AppColors.textColor,
                  fontSize: Responsive.sp(13),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNoPlanCard() {
    const status = PolicyStatus.noPlan;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(22)),
      decoration: BoxDecoration(
        color: status.lightBg,
        borderRadius: BorderRadius.circular(Responsive.w(28)),
        border: Border.all(color: status.lightBorder, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.w(12)),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(Responsive.w(14)),
            ),
            child: Icon(
              Icons.lock_outline_rounded,
              color: Colors.grey.shade600,
              size: Responsive.sp(24),
            ),
          ),
          height(Responsive.h(14)),
          Text(
            'No plan on file yet',
            style: customTextStyle(
              fontSize: Responsive.sp(15),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(6)),
          Text(
            "You're a registered member, but haven't secured coverage. "
            "Choose a plan to activate your Membership ID, coverage and "
            "policy documents.",
            style: customTextStyle(
              fontSize: Responsive.sp(12.5),
              fontWeight: FontWeight.w400,
              color: AppColors.homeTextMuted,
            ).copyWith(height: 1.5),
          ),
          height(Responsive.h(20)),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              height: Responsive.h(44),
              text: 'Secure Membership',
              fontSize: Responsive.sp(13),
              fontWeight: FontWeight.w700,
              gradientColors: [AppColors.newPri, AppColors.primary],
              borderRadius: Responsive.w(20),
              onPressed: () => context.push(Routes.productHub),
            ),
          ),
          height(Responsive.h(10)),
          Center(
            child: TextButton(
              onPressed: () => context.push(Routes.myPlans),
              child: Text(
                'View My Plans',
                style: customTextStyle(
                  fontSize: Responsive.sp(12.5),
                  fontWeight: FontWeight.w600,
                  color: AppColors.newPri,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(bool isDark, PolicyModel policyModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicyCard(_filterPlansByPriorityStatus(personalPlansList)),
          height(Responsive.h(24)),
          HeadingWidget(
            headingTitle: 'My Products',
            buttonText: 'View All',
            onTap: () => context.push(Routes.productHub),
          ),
          height(Responsive.h(10)),
          InkWell(
            borderRadius: BorderRadius.circular(Responsive.w(18)),
            onTap: () => context.push(Routes.productHub),
            child: Container(
              padding: EdgeInsets.all(Responsive.w(16)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Responsive.w(18)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(Responsive.w(8)),
                    decoration: BoxDecoration(
                      color: AppColors.newPri.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(Responsive.w(12)),
                    ),
                    child: Icon(
                      Icons.grid_view_rounded,
                      color: AppColors.newPri,
                      size: Responsive.sp(20),
                    ),
                  ),
                  width(Responsive.w(12)),
                  Expanded(
                    child: Text(
                      'Browse plans, manage your policies & more',
                      style: customTextStyle(
                        fontSize: Responsive.sp(13),
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: Responsive.sp(14),
                    color: AppColors.homeTextMuted,
                  ),
                ],
              ),
            ),
          ),
          height(Responsive.h(28)),
          HeadingWidget(
            headingTitle: 'News & Advisories',
            buttonText: "View All",
            onTap: () {
              context.push(Routes.newsAdvisory);
            },
          ),
          height(Responsive.h(10)),
          _buildNewsTile(
            'Medical Negligence in Post-Operative Care: Supreme Court...',
            'Jan 2025 • Legal Update',
            Icons.gavel,
          ),
          _buildNewsTile(
            'NMC Junked Negligence Complaints Without Seeking...',
            'Aug 2025 • Policy Watch',
            Icons.cancel_outlined,
          ),
          height(Responsive.h(28)),
          HeadingWidget(
            headingTitle: 'Blog Central',
            buttonText: 'View All',
            onTap: () {
              context.push(Routes.blogCentral);
            },
          ),
          height(Responsive.h(10)),
          _buildKnowledgeHub(),
          height(Responsive.h(28)),
          HeadingWidget(
            headingTitle: 'Events & Learning',
            buttonText: "View All",
            onTap: () {
              context.push(Routes.eventsScreen);
            },
          ),
          height(Responsive.h(10)),
          _buildEvents(),
          height(Responsive.h(28)),
          _buildFAQCard(),
          height(Responsive.h(24)),
          SocialLinkWidget(),
          height(Responsive.h(30)),
        ],
      ),
    );
  }

  Widget _socialIconButton({
    required IconData icon,
    required List<Color> bgColors,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(Responsive.w(30)),
      onTap: onTap,
      child: Container(
        width: Responsive.w(40),
        height: Responsive.w(48),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: bgColors,
          ),
          boxShadow: [
            BoxShadow(
              color: bgColors.last.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: Responsive.sp(20)),
      ),
    );
  }

  Widget _buildKnowledgeHub() {
    final blogs = [
      {
        'title': 'Medical Negligence in Post-Operative Care',
        'category': 'Legal Update',
        'date': '12 Jul 2026',
        'read': '5 min',
        'image': 'assets/images/blog.png',
      },
      {
        'title': 'Understanding New NMC Guidelines for Doctors',
        'category': 'Compliance',
        'date': '08 Jul 2026',
        'read': '3 min',
        'image': 'assets/images/blog.png',
      },
      {
        'title': 'Professional Indemnity: Common Claim Mistakes',
        'category': 'Insurance',
        'date': '02 Jul 2026',
        'read': '6 min',
        'image': 'assets/images/blog.png',
      },
    ];

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: blogs.length,
      separatorBuilder: (_, __) => SizedBox(height: Responsive.h(14)),
      itemBuilder: (context, index) {
        final blog = blogs[index];

        return InkWell(
          borderRadius: BorderRadius.circular(Responsive.w(18)),
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(Responsive.w(12)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Responsive.w(18)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Responsive.w(14)),
                  child: Image.asset(
                    blog['image']!,
                    width: Responsive.w(90),
                    height: Responsive.w(90),
                    fit: BoxFit.cover,
                  ),
                ),
                width(Responsive.w(14)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.w(10),
                          vertical: Responsive.h(4),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.newPri.withValues(alpha: .10),
                          borderRadius: BorderRadius.circular(Responsive.w(30)),
                        ),
                        child: Text(
                          blog['category']!,
                          style: customTextStyle(
                            color: AppColors.newPri,
                            fontSize: Responsive.sp(10),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      height(Responsive.h(8)),
                      Text(
                        blog['title']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: Responsive.sp(12),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                      height(Responsive.h(10)),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_outlined,
                            size: Responsive.sp(14),
                            color: AppColors.homeTextMuted,
                          ),
                          width(Responsive.w(4)),
                          Text(
                            blog['read']!,
                            style: customTextStyle(
                              fontSize: Responsive.sp(11),
                              color: AppColors.homeTextMuted,
                            ),
                          ),
                          width(Responsive.w(12)),
                          Icon(
                            Icons.calendar_today_outlined,
                            size: Responsive.sp(14),
                            color: AppColors.homeTextMuted,
                          ),
                          width(Responsive.w(4)),
                          Text(
                            blog['date']!,
                            style: customTextStyle(
                              fontSize: Responsive.sp(11),
                              color: AppColors.homeTextMuted,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.all(Responsive.w(6)),
                            decoration: BoxDecoration(
                              color: AppColors.newPri.withValues(alpha: .10),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: Responsive.sp(14),
                              color: AppColors.newPri,
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
      },
    );
  }

  Widget _buildFAQCard() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(20),
        vertical: Responsive.h(25),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Responsive.w(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.w(12)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.newPri, AppColors.primary],
              ),
              borderRadius: BorderRadius.circular(Responsive.w(14)),
            ),
            child: Icon(
              Icons.help_outline,
              color: AppColors.white,
              size: Responsive.sp(25),
            ),
          ),
          height(Responsive.h(10)),
          Text(
            'Frequently Asked Questions',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(8)),
          Text(
            'Need help with legal compliance?',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(16)),
          PrimaryButton(
            text: 'Contact Us',
            fontSize: Responsive.sp(12),
            fontWeight: FontWeight.w700,
            onPressed: () {
              context.push(Routes.faqScreen);
            },
            height: Responsive.h(42),
            backgroundColor: AppColors.newPri,
            borderRadius: Responsive.w(20),
          ),
        ],
      ),
    );
  }

  Widget _buildEvents() {
    final cards = [
      {
        'name': 'Live Webinar',
        'desc':
            'Upcoming Webinar: Telemedicine Laws and How it Impacts Medical Practice?',
        'image': 'assets/images/events.jpg',
        'Know More': true,
      },
      {
        'name': 'Collaborate',
        'desc':
            'Upcoming Webinar: Telemedicine Laws and How it Impacts Medical Practice?',
        'image': 'assets/images/events.jpg',
        'Know More': false,
      },
      {
        'name': 'Your Story',
        'desc':
            'Upcoming Webinar: Telemedicine Laws and How it Impacts Medical Practice?',
        'image': 'assets/images/events.jpg',
        'Know More': false,
      },
    ];

    return SizedBox(
      height: Responsive.h(265),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: Responsive.w(2), right: Responsive.w(4)),
        itemCount: cards.length,
        separatorBuilder: (_, __) => SizedBox(width: Responsive.w(14)),
        itemBuilder: (context, index) {
          final c = cards[index];
          final bool avail = c['Know More'] as bool;
          return Container(
            width: Responsive.w(220),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(Responsive.w(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Responsive.w(20)),
                  ),
                  child: Image.asset(
                    c['image'] as String,
                    height: Responsive.h(130),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    Responsive.w(12),
                    Responsive.h(10),
                    Responsive.w(12),
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c['name'] as String,
                        style: customTextStyle(
                          fontSize: Responsive.sp(13),
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor,
                        ).copyWith(overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(height: Responsive.h(4)),
                      Text(
                        c['desc'] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: Responsive.sp(11),
                          color: AppColors.homeTextMuted,
                        ),
                      ),
                      SizedBox(height: Responsive.h(10)),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              text: avail ? 'Register to Join' : 'Know More',
                              fontWeight: FontWeight.w700,
                              fontSize: Responsive.sp(12),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EventRegisterScreen(event: {}),
                                  ),
                                );
                              },
                              height: Responsive.h(42),
                              gradientColors: avail
                                  ? [AppColors.newPri, AppColors.primary]
                                  : [AppColors.lightGray, AppColors.grey],
                              borderRadius: Responsive.w(10),
                            ),
                          ),
                          width(Responsive.w(10)),
                          InkWell(
                            onTap: () => Share.share(
                              'Check out this event: ${c['title']} on '
                              '${c['day']} ${c['month']}, ${c['time']}',
                            ),
                            borderRadius: BorderRadius.circular(
                              Responsive.w(10),
                            ),
                            child: Container(
                              width: Responsive.w(42),
                              height: Responsive.h(42),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  Responsive.w(10),
                                ),
                                border: Border.all(color: AppColors.homeBorder),
                              ),
                              child: Icon(
                                Icons.share_outlined,
                                size: Responsive.sp(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewsTile(String title, String date, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.h(10)),
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: Responsive.w(20),
            backgroundColor: AppColors.newPri.withValues(alpha: 0.1),
            child: Icon(icon, color: AppColors.newPri, size: Responsive.sp(18)),
          ),
          width(Responsive.w(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: customTextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.mono100,
                    fontSize: Responsive.sp(12),
                  ),
                ),
                height(Responsive.h(4)),
                Text(
                  date,
                  style: customTextStyle(
                    color: Colors.grey.shade600,
                    fontSize: Responsive.sp(11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
