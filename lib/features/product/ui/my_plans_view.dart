import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/features/product/ui/view_model/my_plans_view_model.dart';
import 'package:Doctors_App/features/product/ui/widgets/renew_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/common_empty_state.dart';
import '../model/my_plan_model.dart';
import 'my_plan_details_screen.dart';

class MyPlansView extends ConsumerWidget {
  const MyPlansView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(myPlansViewModelProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Plans',
        subTitle: 'All memberships secured under Membership ID DR‑2026‑084213',
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () =>
              ref.read(myPlansViewModelProvider.notifier).refresh(),
          child: plansAsync.when(
            data: (plans) => plans.isEmpty
                ? ListView(
                    children: [
                      height(120),
                      CommonEmptyState(
                        title: 'No plans yet',
                        message: 'Your purchased plans will show up here',
                      ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                    itemCount: plans.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final selectedPlan = plans[i];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MyPlanDetailsScreen(plan: selectedPlan),
                            ),
                          );
                          // context.push(Routes.myPlanDetails);
                        },
                        child: _MyPlanCard(plan: selectedPlan),
                      );
                    },
                  ),
            loading: () => Center(child: CircularProgressIndicator()),
            error: (e, _) => ListView(
              children: [
                height(120),
                CommonEmptyState(
                  title: 'Something went wrong',
                  message: 'Pull down to try again',
                  onPressed: () =>
                      ref.read(myPlansViewModelProvider.notifier).refresh(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MyPlanCard extends ConsumerWidget {
  final MyPlan plan;

  const _MyPlanCard({super.key, required this.plan});

  Color _statusColor(PlanStatus s) {
    switch (s) {
      case PlanStatus.active:
        return const Color(0xFF059669);
      case PlanStatus.expired:
        return const Color(0xFFDC2626);
      case PlanStatus.pendingRenewal:
        return const Color(0xFFD97706);
      case PlanStatus.inactive:
        return const Color(0xFF64748B);
    }
  }

  String _fmtMoney(double v) {
    final s = v.toStringAsFixed(0);
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromEnd = s.length - i;
      buf.write(s[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1 && i != 0) buf.write(',');
    }
    return '₹${buf.toString()}';
  }

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')} ${_getMonthAbbr(d.month)} ${d.year}';

  String _getMonthAbbr(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusColor = _statusColor(plan.status);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  plan.planType ?? 'Professional',
                  style: customTextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2563EB),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  plan.status.label,
                  style: customTextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            plan.planName,
            style: customTextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Client ID ${plan.policyNumber}',
            style: customTextStyle(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
          height(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _metaCol('DURATION', plan.duration),
              _metaCol('SUM ASSURED', _fmtMoney(plan.sumAssured)),
              _metaCol('PREMIUM PAID', _fmtMoney(plan.payable)),
              _metaCol('VALID TILL', _fmtDate(plan.toDate)),
            ],
          ),
          height(16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            children: [
              _outlinedActionButton(
                label: 'View',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyPlanDetailsScreen(plan: plan),
                    ),
                  );
                },
              ),
              _outlinedActionButton(label: 'Endorsement', onTap: () {}),
              PopupMenuButton<String>(
                onSelected: (value) => _downloadPolicy(value),
                itemBuilder: (context) => [
                  _buildMenuItem(
                    value: 'Policy Certificate',
                    icon: Icons.description_outlined,
                  ),
                  _buildMenuItem(
                    value: 'Medical Reg. Certificate',
                    icon: Icons.badge_outlined,
                  ),
                  _buildMenuItem(
                    value: 'Invoice',
                    icon: Icons.receipt_long_outlined,
                  ),
                  _buildMenuItem(
                    value: 'Company Agreement',
                    icon: Icons.handshake_outlined,
                  ),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Download',
                        style: customTextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 16,
                        color: Color(0xFF334155),
                      ),
                    ],
                  ),
                ),
              ),
              if (plan.isRenewable)
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RenewForm(plan: plan),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF047857),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'Renew',
                    style: customTextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem({
    required String value,
    required IconData icon,
  }) {
    return PopupMenuItem<String>(
      value: value,
      height: 40,
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF475569)),
          const SizedBox(width: 10),
          Text(
            value,
            style: customTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metaCol(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: customTextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: customTextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _outlinedActionButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF334155),
        side: const BorderSide(color: Color(0xFFCBD5E1)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(
        label,
        style: customTextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w500,
          color: Color(0xFF334155),
        ),
      ),
    );
  }

  Future<void> _downloadPolicy(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
