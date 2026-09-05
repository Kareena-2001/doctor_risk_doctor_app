import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/product/ui/state/plan_finder_state.dart';
import 'package:Doctors_App/features/product/ui/view_model/plan_finder_view_model.dart';
import 'package:Doctors_App/features/product/ui/widgets/plan_comparison_tool.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/values/app_text_style.dart';
import '../model/plan_finder_models.dart';
import '../model/product_model.dart';

class PlanFinderView extends ConsumerWidget {
  final String? orgName;
  final String? staffCode;
  final ProductType category;

  const PlanFinderView({
    super.key,
    this.orgName,
    this.staffCode,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = PlanFinderArgs(
      orgName: orgName,
      staffCode: staffCode,
      category: category,
    );

    final state = ref.watch(planFinderViewModelProvider(args));
    final vm = ref.read(planFinderViewModelProvider(args).notifier);

    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: CustomAppBar(title: 'Browse Plans'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.orgName != null) _OrgBanner(state: state),
              if (state.hasActivePolicy) ...[
                height(12),
                _ActivePolicyWarning(category: state.category),
              ],
              height(16),
              _FilterCard(
                state: state,
                vm: vm,
                onChangeCategory: () => Navigator.pop(context),
              ),
              height(16),
              LayoutBuilder(
                builder: (context, c) {
                  final isNarrow = c.maxWidth < 640;

                  final left = state.quote != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _QuoteResultCard(state: state),
                            height(16),
                            _OtherPlansStrip(state: state, vm: vm),
                          ],
                        )
                      : const _IntroCard();

                  final right = _ComparePlansCard(vm: vm);

                  if (isNarrow) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [left, height(16), right],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: left),
                      width(16),
                      Expanded(child: right),
                    ],
                  );
                },
              ),
              if (state.showComparison) ...[
                height(16),
                PlanComparisonTool(
                  initialMembership: state.membership ?? MembershipType.basic,
                  onSelect: (membership, plan, duration, sumAssured) =>
                      vm.applyFromComparison(
                        membership: membership,
                        plan: plan,
                        duration: duration,
                        sumAssured: sumAssured,
                      ),
                  onClose: vm.toggleComparison,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OrgBanner extends StatelessWidget {
  final PlanFinderState state;

  const _OrgBanner({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.home_work_outlined, size: 16, color: AppColors.newPri),
          width(8),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: customTextStyle(
                  fontSize: 12,
                  color: const Color(0xFF065F46),
                ),
                children: [
                  const TextSpan(text: "You're viewing plans for "),
                  TextSpan(
                    text: state.orgName,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  if (state.staffCode != null)
                    TextSpan(text: ' (Code: ${state.staffCode})'),
                  const TextSpan(text: ' as their associated member.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivePolicyWarning extends StatelessWidget {
  final ProductType category;

  const _ActivePolicyWarning({required this.category});

  @override
  Widget build(BuildContext context) {
    final label = category == ProductType.individual
        ? 'Professional'
        : 'Medical Establishment';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            size: 16,
            color: Color(0xFFB45309),
          ),
          width(8),
          Expanded(
            child: Text(
              'You already hold an active $label Membership under this ID. Only one '
              '$label plan is allowed per Membership ID, and an active policy cannot '
              'be replaced or purchased again. You can still browse and get a quote '
              'below for reference, but "Secure Coverage Now" will stay disabled '
              'until your current policy lapses.',
              style: customTextStyle(
                fontSize: 12,
                color: const Color(0xFF92400E),
              ).copyWith(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterCard extends StatelessWidget {
  final PlanFinderState state;
  final PlanFinderViewModel vm;
  final VoidCallback onChangeCategory;

  const _FilterCard({
    required this.state,
    required this.vm,
    required this.onChangeCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, c) {
              final isNarrow = c.maxWidth < 640;
              final fields = [
                CustomDropdownField<MembershipType>(
                  label: 'Membership',
                  hint: 'Select Membership',
                  value: state.membership,
                  items: MembershipType.values,
                  itemBuilder: (m) => m.label,
                  onChanged: vm.selectMembership,
                  isRequired: true,
                ),
                CustomDropdownField<PlanTier>(
                  label: 'Plan',
                  hint: 'Select Plan',
                  value: state.plan,
                  items: PlanTier.values,
                  itemBuilder: (p) => p.label,
                  onChanged: vm.selectPlan,
                  isRequired: true,
                ),
                CustomDropdownField<PolicyDuration>(
                  label: 'Duration',
                  hint: 'Select Duration',
                  value: state.duration,
                  items: PolicyDuration.values,
                  itemBuilder: (d) => d.label,
                  onChanged: vm.selectDuration,
                  isRequired: true,
                ),
                CustomDropdownField<SumAssured>(
                  label: 'Sum Assured',
                  hint: 'Select Sum Assured',
                  value: state.sumAssured,
                  items: SumAssured.values,
                  itemBuilder: (s) => s.label,
                  onChanged: vm.selectSumAssured,
                  isRequired: true,
                ),
              ];

              if (isNarrow) {
                return Column(
                  children: [
                    for (final f in fields) ...[f, height(12)],
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final f in fields) ...[Expanded(child: f), width(12)],
                ],
              );
            },
          ),
          height(16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              SizedBox(
                width: 120,
                child: PrimaryButton(
                  height: 40,
                  borderRadius: 25,
                  fontSize: 14,
                  text: 'Search',
                  gradientColors: [
                    AppColors.buttonColor1,
                    AppColors.buttonColor2,
                  ],
                  onPressed: state.canSearch ? vm.search : null,
                ),
              ),
              SizedBox(
                width: 120,
                child: PrimaryButton(
                  borderColor: AppColors.border,
                  height: 40,
                  borderRadius: 25,
                  fontSize: 14,
                  onPressed: vm.clear,
                  backgroundColor: AppColors.white,
                  text: '',
                  child: const Text('Clear'),
                ),
              ),
              TextButton.icon(
                onPressed: onChangeCategory,
                style: TextButton.styleFrom(
                  side: BorderSide(color: AppColors.border),
                ),
                icon: Icon(
                  Icons.arrow_back,
                  size: 15,
                  color: AppColors.textColor,
                ),
                label: Text(
                  'Change category',
                  style: TextStyle(color: AppColors.textColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Shown on the left while no quote has been fetched yet.
class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text.rich(
        TextSpan(
          style: customTextStyle(
            fontSize: 13,
            color: const Color(0xFF475569),
          ).copyWith(height: 1.6),
          children: [
            const TextSpan(
              text:
                  "Welcome! We're excited that you're considering securing your membership.\n\n",
            ),
            const TextSpan(
              text:
                  'Select the plan, duration and sum assured above, then click ',
            ),
            const TextSpan(
              text: 'Search',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const TextSpan(text: ". Once you've found the right fit, click "),
            const TextSpan(
              text: 'Secure Coverage Now',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const TextSpan(text: ' to continue.\n\n'),
            const TextSpan(
              text:
                  "You'll be asked to confirm a few personal and practice details, then "
                  'proceed to secure your payment. A confirmation email follows automatically.',
            ),
          ],
        ),
      ),
    );
  }
}

/// Always visible — before AND after a quote is found — so the user can
/// jump into the full comparison tool at any point in the flow.
class _ComparePlansCard extends StatelessWidget {
  final PlanFinderViewModel vm;

  const _ComparePlansCard({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Not sure which plan to choose?',
            style: customTextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          height(6),
          Text(
            'Compare all three plans side by side, or check Recommended Plans based on your speciality.',
            style: customTextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
            ).copyWith(height: 1.4),
          ),
          height(12),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              height: 40,
              borderRadius: 20,
              fontSize: 13,
              text: 'Compare Plans',
              backgroundColor: AppColors.newPri,
              onPressed: vm.toggleComparison,
            ),
          ),
        ],
      ),
    );
  }
}

/// Shown below the quote card once a plan is found — lets the user switch
/// between the other tiers (Starter / Standard / Premium) within the same
/// membership without leaving the page or opening the full comparison tool.
class _OtherPlansStrip extends StatelessWidget {
  final PlanFinderState state;
  final PlanFinderViewModel vm;

  const _OtherPlansStrip({required this.state, required this.vm});

  @override
  Widget build(BuildContext context) {
    final q = state.quote!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Other plans in ${q.membership.label} Membership',
            style: customTextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          height(4),
          Text(
            'Same duration and sum assured — tap to switch.',
            style: customTextStyle(
              fontSize: 11,
              color: const Color(0xFF94A3B8),
            ),
          ),
          height(12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: PlanTier.values.map((tier) {
              final selected = tier == q.plan;
              final premium = calculatePremium(
                membership: q.membership,
                plan: tier,
                duration: q.duration,
                sumAssured: q.sumAssured,
              );
              return GestureDetector(
                onTap: selected ? null : () => vm.switchPlan(tier),
                child: Container(
                  width: 150,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFFECFDF5) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected
                          ? AppColors.newPri
                          : const Color(0xFFE2E8F0),
                      width: selected ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tier.label,
                            style: customTextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textColor,
                            ),
                          ),
                          if (selected)
                            const Icon(
                              Icons.check_circle_rounded,
                              size: 16,
                              color: Color(0xFF059669),
                            ),
                        ],
                      ),
                      height(4),
                      Text(
                        '₹${formatRupees(premium)} / yr',
                        style: customTextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.newPri,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _QuoteResultCard extends StatelessWidget {
  final PlanFinderState state;

  const _QuoteResultCard({required this.state});

  @override
  Widget build(BuildContext context) {
    final q = state.quote!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${q.membership.label} Membership — ${q.plan.label} Plan',
            style: customTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textColor,
            ),
          ),
          height(14),
          _SummaryRow(label: 'Duration', value: q.duration.label),
          _SummaryRow(
            label: 'Sum Assured',
            value: '₹${formatRupees(q.sumAssured.amount)}',
            valueColor: AppColors.newPri,
          ),
          _SummaryRow(
            label: 'Premium Amount',
            value: '₹${formatRupees(q.premium)}',
            valueColor: AppColors.newPri,
            bold: true,
          ),
          height(14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CONSULTATION ACCESS',
                  style: customTextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF94A3B8),
                  ).copyWith(letterSpacing: 0.5),
                ),
                height(6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check, size: 14, color: Color(0xFF059669)),
                    width(6),
                    Expanded(
                      child: Text(
                        q.plan.consultationAccess(q.membership),
                        style: customTextStyle(
                          fontSize: 12,
                          color: const Color(0xFF475569),
                        ).copyWith(height: 1.4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          height(16),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              height: 46,
              borderRadius: 12,
              fontSize: 14,
              text: 'Secure Coverage Now!',
              backgroundColor: state.hasActivePolicy
                  ? const Color(0xFFA7C4B5)
                  : AppColors.newPri,
              onPressed: state.hasActivePolicy
                  ? null
                  : () {
                      context.push(Routes.purchaseWizard);
                    },
            ),
          ),
          if (state.hasActivePolicy) ...[
            height(6),
            Text(
              "You already have an active ${state.category == ProductType.individual ? 'Individual' : 'Establishment'} "
              "policy — this can't be purchased again until it lapses.",
              style: customTextStyle(
                fontSize: 11,
                color: const Color(0xFFDC2626),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool bold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: customTextStyle(
              fontSize: 13,
              color: const Color(0xFF64748B),
            ),
          ),
          Text(
            value,
            style: customTextStyle(
              fontSize: bold ? 16 : 13,
              fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
              color: valueColor ?? AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
