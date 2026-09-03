import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/product/ui/state/plan_finder_state.dart';
import 'package:Doctors_App/features/product/ui/view_model/plan_finder_view_model.dart';
import 'package:Doctors_App/features/product/ui/widgets/plan_comparison_tool.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(title: 'Browse Plans'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
              if (state.quote != null)
                _QuoteResultCard(state: state)
              else
                _EmptyHelperCard(vm: vm),
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
      padding: const EdgeInsets.all(16),
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
                _Dropdown<MembershipType>(
                  label: 'Membership',
                  hint: 'Select Membership',
                  value: state.membership,
                  items: MembershipType.values,
                  labelOf: (m) => m.label,
                  onChanged: vm.selectMembership,
                ),
                _Dropdown<PlanTier>(
                  label: 'Plan',
                  hint: 'Select Plan',
                  value: state.plan,
                  items: PlanTier.values,
                  labelOf: (p) => p.label,
                  onChanged: vm.selectPlan,
                ),
                _Dropdown<PolicyDuration>(
                  label: 'Duration',
                  hint: 'Select Duration',
                  value: state.duration,
                  items: PolicyDuration.values,
                  labelOf: (d) => d.label,
                  onChanged: vm.selectDuration,
                ),
                _Dropdown<SumAssured>(
                  label: 'Sum Assured',
                  hint: 'Select Sum Assured',
                  value: state.sumAssured,
                  items: SumAssured.values,
                  labelOf: (s) => s.label,
                  onChanged: vm.selectSumAssured,
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
                  height: 44,
                  borderRadius: 12,
                  fontSize: 14,
                  text: 'Search',
                  backgroundColor: AppColors.newPri,
                  onPressed: state.canSearch ? vm.search : null,
                ),
              ),
              OutlinedButton(
                onPressed: vm.clear,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                child: Text(
                  'Clear',
                  style: customTextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: onChangeCategory,
                icon: const Icon(Icons.arrow_back, size: 15),
                label: Text(
                  'Change category',
                  style: customTextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  final String label;
  final String hint;
  final T? value;
  final List<T> items;
  final String Function(T) labelOf;
  final ValueChanged<T?> onChanged;

  const _Dropdown({
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.labelOf,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: customTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF475569),
          ),
        ),
        height(6),
        DropdownButtonFormField<T>(
          value: value,
          hint: Text(
            hint,
            style: customTextStyle(
              fontSize: 13,
              color: const Color(0xFFCBD5E1),
            ),
          ),
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF94A3B8),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF8F9FC),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFF6366F1),
                width: 1.5,
              ),
            ),
          ),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(labelOf(e), style: customTextStyle(fontSize: 13)),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _EmptyHelperCard extends StatelessWidget {
  final PlanFinderViewModel vm;

  const _EmptyHelperCard({required this.vm});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final isNarrow = c.maxWidth < 640;
        final intro = Container(
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
                const TextSpan(
                  text: ". Once you've found the right fit, click ",
                ),
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
        final compare = Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFECFDF5),
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
                  color: const Color(0xFF64748B),
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
        if (isNarrow) return Column(children: [intro, height(16), compare]);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: intro),
            width(16),
            Expanded(child: compare),
          ],
        );
      },
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
                      // TODO: push into purchase wizard with this quote.
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
      padding: const EdgeInsets.symmetric(vertical: 6),
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
