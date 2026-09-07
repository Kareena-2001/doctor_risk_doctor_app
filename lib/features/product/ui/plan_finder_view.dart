import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/product/ui/state/plan_finder_state.dart';
import 'package:Doctors_App/features/product/ui/view_model/plan_finder_view_model.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/values/app_text_style.dart';
import '../model/plan_finder_models.dart';
import '../model/product_model.dart';
import '../model/product_tier.dart';
import '../widgets/tier_helper.dart';

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

  void _showComparisonSheet(
    BuildContext context,
    PlanFinderState state,
    PlanFinderViewModel vm,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ComparisonBottomSheet(
        initialMembership: state.membership ?? MembershipType.basic,
        initialDuration: state.duration ?? PolicyDuration.oneYear,
        initialSumAssured: state.sumAssured ?? SumAssured.l25,
        onSelect: (membership, plan, duration, sumAssured) {
          vm.applyFromComparison(
            membership: membership,
            plan: plan,
            duration: duration,
            sumAssured: sumAssured,
          );
          Navigator.pop(context);
        },
        onClose: () => Navigator.pop(context),
      ),
    );
  }

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
                      ? _QuoteResultCard(state: state)
                      : const _IntroCard();

                  final right = _ComparePlansCard(
                    onTap: () => _showComparisonSheet(context, state, vm),
                  );

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

class _ComparePlansCard extends StatelessWidget {
  final VoidCallback onTap;

  const _ComparePlansCard({required this.onTap});

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
              width: 150,
              height: 40,
              borderRadius: 20,
              fontSize: 13,
              text: 'Compare Plans',
              textColor: Colors.black,
              borderColor: AppColors.border,
              backgroundColor: AppColors.white,
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonBottomSheet extends StatefulWidget {
  final MembershipType initialMembership;
  final PolicyDuration initialDuration;
  final SumAssured initialSumAssured;
  final void Function(MembershipType, PlanTier, PolicyDuration, SumAssured)
  onSelect;
  final VoidCallback onClose;

  const _ComparisonBottomSheet({
    required this.initialMembership,
    required this.initialDuration,
    required this.initialSumAssured,
    required this.onSelect,
    required this.onClose,
  });

  @override
  State<_ComparisonBottomSheet> createState() => _ComparisonBottomSheetState();
}

class _ComparisonBottomSheetState extends State<_ComparisonBottomSheet> {
  late MembershipType _membership;
  late PolicyDuration _duration;
  late SumAssured _sumAssured;

  @override
  void initState() {
    super.initState();
    _membership = widget.initialMembership;
    _duration = widget.initialDuration;
    _sumAssured = widget.initialSumAssured;
  }

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    return Container(
      height: sh * 0.88,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          height(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Plan Comparison Tool',
                    style: customTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: widget.onClose,
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Pick a membership, then compare Starter / Standard / Premium plans within it.',
              style: customTextStyle(
                fontSize: 12,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
          const Divider(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Membership:',
                        style: customTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569),
                        ),
                      ),
                      width(8),
                      Expanded(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: MembershipType.values
                              .map(
                                (m) => _SheetChip(
                                  label: m.label,
                                  selected: m == _membership,
                                  onTap: () => setState(() => _membership = m),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  height(6),
                  Text(
                    _membership.tagline,
                    style: customTextStyle(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  height(14),
                  Text(
                    'Compare at:',
                    style: customTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  height(6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: PolicyDuration.values
                        .map(
                          (d) => _SheetChip(
                            label: d.shortLabel,
                            selected: d == _duration,
                            onTap: () => setState(() => _duration = d),
                          ),
                        )
                        .toList(),
                  ),
                  height(14),
                  Text(
                    'Sum Assured:',
                    style: customTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  height(6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: SumAssured.values
                        .map(
                          (s) => _SheetChip(
                            label: s.label,
                            selected: s == _sumAssured,
                            onTap: () => setState(() => _sumAssured = s),
                          ),
                        )
                        .toList(),
                  ),
                  height(16),
                  _MobileComparisonTable(
                    membership: _membership,
                    duration: _duration,
                    sumAssured: _sumAssured,
                    onSelect: (plan) => widget.onSelect(
                      _membership,
                      plan,
                      _duration,
                      _sumAssured,
                    ),
                  ),
                  height(14),
                  _SheetAddOnsCallout(membership: _membership),
                  height(10),

                  Text(
                    'Base coverage — Professional/Establishment Indemnity, Defense Cost, Legal '
                    'Notice Replies, Documentation Audit, Retroactive Facility, Cashless Claims, '
                    'Social Media Defamation Support, PAN India Support and 24×7 Assistance — is '
                    'included at every membership and every plan. Legal matters existing before '
                    'your membership began remain chargeable separately, per our standard policy.',
                    style: customTextStyle(
                      fontSize: 10.5,
                      color: const Color(0xFF94A3B8),
                    ).copyWith(height: 1.4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SheetChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.newPri : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.newPri : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          label,
          style: customTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : const Color(0xFF475569),
          ),
        ),
      ),
    );
  }
}

class _MobileComparisonTable extends StatelessWidget {
  final MembershipType membership;
  final PolicyDuration duration;
  final SumAssured sumAssured;
  final ValueChanged<PlanTier> onSelect;

  const _MobileComparisonTable({
    required this.membership,
    required this.duration,
    required this.sumAssured,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    const featureW = 130.0;
    const planW = 110.0;
    const totalW = featureW + planW * 3;

    final headerStyle = customTextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF1E293B),
    );
    final labelStyle = customTextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF1E293B),
    ).copyWith(height: 1.4);
    final cellStyle = customTextStyle(
      fontSize: 11.5,
      color: const Color(0xFF334155),
    ).copyWith(height: 1.4);

    const p = EdgeInsets.symmetric(vertical: 10, horizontal: 8);

    Widget tc(Widget child, {Color? bg, bool center = false}) => TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        color: bg,
        padding: p,
        alignment: center ? Alignment.center : Alignment.centerLeft,
        child: child,
      ),
    );

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: totalW,
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(featureW),
              1: FixedColumnWidth(planW),
              2: FixedColumnWidth(planW),
              3: FixedColumnWidth(planW),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
              horizontalInside: BorderSide(
                color: const Color(0xFFF1F5F9),
                width: 1,
              ),
              bottom: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            children: [
              // ── Header ──────────────────────────────────────────────────
              TableRow(
                decoration: const BoxDecoration(color: Color(0xFFF8FAFC)),
                children: [
                  tc(Text('Feature', style: headerStyle)),
                  for (final p in PlanTier.values)
                    tc(Text(p.label, style: headerStyle)),
                ],
              ),

              // ── Premium ─────────────────────────────────────────────────
              TableRow(
                children: [
                  tc(Text('Premium (selected)', style: labelStyle)),
                  for (final plan in PlanTier.values)
                    tc(
                      Text(
                        '₹${formatRupees(calculatePremium(membership: membership, plan: plan, duration: duration, sumAssured: sumAssured))} / yr',
                        style: cellStyle,
                      ),
                    ),
                ],
              ),

              // ── Consultation access ──────────────────────────────────────
              TableRow(
                decoration: const BoxDecoration(color: Color(0xFFFAFAFA)),
                children: [
                  tc(Text('Consultation access', style: labelStyle)),
                  for (final plan in PlanTier.values)
                    tc(
                      Text(
                        plan.consultationAccess(membership),
                        style: cellStyle,
                      ),
                    ),
                ],
              ),

              // ── Free review ─────────────────────────────────────────────
              TableRow(
                children: [
                  tc(
                    Text(
                      'Free review of 1 pre-existing matter',
                      style: labelStyle,
                    ),
                  ),
                  for (final _ in PlanTier.values)
                    tc(Text('—', style: cellStyle)),
                ],
              ),

              // ── Select buttons ───────────────────────────────────────────
              TableRow(
                children: [
                  tc(const SizedBox.shrink()),
                  for (final plan in PlanTier.values)
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 8,
                        ),
                        child: OutlinedButton(
                          onPressed: () => onSelect(plan),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          child: Text(
                            'Select',
                            style: customTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.newPri,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Add-ons callout inside the bottom sheet ───────────────────────────────
class _SheetAddOnsCallout extends StatelessWidget {
  final MembershipType membership;

  const _SheetAddOnsCallout({required this.membership});

  @override
  Widget build(BuildContext context) {
    final addOns = membership.addOns;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${membership.label.toUpperCase()} MEMBERSHIP ADD-ONS (APPLY AT EVERY PLAN LEVEL)',
            style: customTextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF065F46),
            ).copyWith(letterSpacing: 0.3),
          ),
          height(8),
          if (addOns.isEmpty)
            _SheetAddOnRow(
              text: 'No proactive add-ons at this membership level',
              included: false,
            )
          else
            ...addOns.map((a) => _SheetAddOnRow(text: a, included: true)),
        ],
      ),
    );
  }
}

class _SheetAddOnRow extends StatelessWidget {
  final String text;
  final bool included;

  const _SheetAddOnRow({required this.text, required this.included});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            included ? Icons.check_rounded : Icons.close_rounded,
            size: 14,
            color: included ? const Color(0xFF059669) : const Color(0xFF94A3B8),
          ),
          width(6),
          Expanded(
            child: Text(
              text,
              style: customTextStyle(
                fontSize: 12,
                color: const Color(0xFF475569),
              ).copyWith(height: 1.4),
            ),
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
                    color: Color(0xFF94A3B8),
                  ).copyWith(letterSpacing: 0.5),
                ),
                height(6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check, size: 14, color: Color(0xFF059669)),
                    width(6),
                    Expanded(
                      child: Text(
                        q.plan.consultationAccess(q.membership),
                        style: customTextStyle(
                          fontSize: 12,
                          color: Color(0xFF475569),
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
                      final q = state.quote!;

                      final product = Product(
                        id: 1,
                        type: state.category,
                        productNames: [q.membership.label],
                        shortDescription:
                            '${q.membership.label} Membership Plan',
                        fullDescription:
                            '${q.membership.label} Membership with ${q.plan.label} tier.',
                        tiers: [],
                        createdDate: DateTime.now(),
                      );

                      // TierStyles.standard assign karein blank TierStyle() ki jagah
                      final tierPlan = TierPlan(
                        name: q.plan.label,
                        tagline: '${q.plan.label} Protection Plan',
                        premiumPerYear: q.premium,
                        sumInsured: q.sumAssured.amount,
                        maxMembers: 1,
                        validityYears: 1,
                        features: const [],
                        style: TierStyles.standard,
                      );

                      context.push(
                        Routes.purchaseWizard,
                        extra: (
                          product,
                          tierPlan,
                          q.duration.label,
                          q.sumAssured.amount,
                          q.premium,
                        ),
                      );
                    },
            ),
          ),
          if (state.hasActivePolicy) ...[
            height(6),
            Text(
              "You already have an active ${state.category == ProductType.individual ? 'Individual' : 'Establishment'} "
              "policy — this can't be purchased again until it lapses.",
              style: customTextStyle(fontSize: 11, color: Color(0xFFDC2626)),
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
            style: customTextStyle(fontSize: 13, color: Color(0xFF64748B)),
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
