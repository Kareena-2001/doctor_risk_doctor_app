import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/product/ui/view_model/my_plans_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/common_empty_state.dart';
import '../../../theme/app_colors.dart';
import '../model/my_plan_model.dart';

class MyPlansView extends ConsumerWidget {
  const MyPlansView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(myPlansViewModelProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'My Plans'),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () =>
              ref.read(myPlansViewModelProvider.notifier).refresh(),
          child: plansAsync.when(
            data: (plans) => plans.isEmpty
                ? ListView(
                    children: const [
                      SizedBox(height: 120),
                      // CommonEmptyState(
                      //   title: 'No plans yet',
                      //   message: 'Your purchased plans will show up here',
                      // ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                    itemCount: plans.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => _MyPlanCard(plan: plans[i]),
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => ListView(
              children: [
                const SizedBox(height: 120),
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

  const _MyPlanCard({required this.plan});

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
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = _statusColor(plan.status);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  plan.planName,
                  style: customTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  plan.status.label,
                  style: customTextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          height(2),
          Text(
            'Policy No. ${plan.policyNumber}',
            style: customTextStyle(fontSize: 11, color: AppColors.grey),
          ),
          const Divider(height: 20, color: Color(0xFFF1F5F9)),
          Row(
            children: [
              _metaCol('Sum assured', _fmtMoney(plan.sumAssured)),
              _metaCol('Payable', _fmtMoney(plan.payable)),
              _metaCol('Duration', plan.duration),
            ],
          ),
          height(10),
          Row(
            children: [
              Icon(Icons.event_outlined, size: 14, color: AppColors.grey),
              const SizedBox(width: 4),
              Text(
                '${_fmtDate(plan.fromDate)} - ${_fmtDate(plan.toDate)}',
                style: customTextStyle(fontSize: 11, color: AppColors.grey),
              ),
            ],
          ),
          height(16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.file_download_outlined,
                color: Colors.white,
                size: 18,
              ),
              label: Text(
                'Download Policy',
                style: customTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          if (plan.isRenewable) ...[
            height(12),
            PrimaryButton(
              height: 38,
              text: 'Renew Now',
              fontSize: 13,
              backgroundColor: AppColors.newPri,
              onPressed: () =>
                  ref.read(myPlansViewModelProvider.notifier).renew(plan.id),
            ),
          ],
        ],
      ),
    );
  }

  Widget _metaCol(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: customTextStyle(fontSize: 10, color: AppColors.grey),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: customTextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }
}
