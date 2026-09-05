import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/values/app_text_style.dart';
import '../../model/plan_finder_models.dart';

class PlanComparisonTool extends StatefulWidget {
  final MembershipType initialMembership;
  final void Function(MembershipType, PlanTier, PolicyDuration, SumAssured)
  onSelect;
  final VoidCallback onClose;

  const PlanComparisonTool({
    super.key,
    required this.initialMembership,
    required this.onSelect,
    required this.onClose,
  });

  @override
  State<PlanComparisonTool> createState() => _PlanComparisonToolState();
}

class _PlanComparisonToolState extends State<PlanComparisonTool> {
  late MembershipType _membership;
  PolicyDuration _duration = PolicyDuration.oneYear;
  SumAssured _sumAssured = SumAssured.l25;

  @override
  void initState() {
    super.initState();
    _membership = widget.initialMembership;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Plan Comparison Tool',
                  style: customTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              InkWell(
                onTap: widget.onClose,
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
          height(2),
          Text(
            'Pick a membership, then compare Starter / Standard / Premium plans within it.',
            style: customTextStyle(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          height(14),
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
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: MembershipType.values
                    .map(
                      (m) => _Chip(
                    label: m.label,
                    selected: m == _membership,
                    onTap: () => setState(() => _membership = m),
                  ),
                )
                    .toList(),
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
          height(16),
          LayoutBuilder(
            builder: (context, c) {
              final compareAt = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Compare at:',
                    style: customTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  width(8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: PolicyDuration.values
                        .map(
                          (d) => _Chip(
                        label: d.shortLabel,
                        selected: d == _duration,
                        onTap: () => setState(() => _duration = d),
                      ),
                    )
                        .toList(),
                  ),
                ],
              );

              final sumAssured = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sum Assured:',
                    style: customTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  width(8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: SumAssured.values
                        .map(
                          (s) => _Chip(
                        label: s.label,
                        selected: s == _sumAssured,
                        onTap: () => setState(() => _sumAssured = s),
                      ),
                    )
                        .toList(),
                  ),
                ],
              );

              if (c.maxWidth < 640) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [compareAt, height(10), sumAssured],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [compareAt, sumAssured],
              );
            },
          ),
          height(16),
          _ComparisonTable(
            membership: _membership,
            duration: _duration,
            sumAssured: _sumAssured,
            onSelect: (plan) =>
                widget.onSelect(_membership, plan, _duration, _sumAssured),
          ),
          height(14),
          _AddOnsCallout(membership: _membership),
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
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({
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

class _ComparisonTable extends StatelessWidget {
  final MembershipType membership;
  final PolicyDuration duration;
  final SumAssured sumAssured;
  final ValueChanged<PlanTier> onSelect;

  const _ComparisonTable({
    required this.membership,
    required this.duration,
    required this.sumAssured,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final headerStyle = customTextStyle(
      fontSize: 12.5,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF1E293B),
    );
    final labelStyle = customTextStyle(
      fontSize: 12.5,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF1E293B),
    ).copyWith(height: 1.4);
    final cellStyle = customTextStyle(
      fontSize: 12.5,
      color: const Color(0xFF334155),
    ).copyWith(height: 1.4);

    Widget cell(Widget child, {int flex = 1}) => Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: child,
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 560),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: Row(
                children: [
                  cell(Text('Feature', style: headerStyle), flex: 2),
                  for (final p in PlanTier.values)
                    cell(Text(p.label, style: headerStyle)),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
              ),
              child: Row(
                children: [
                  cell(
                    Text('Premium (selected)', style: labelStyle),
                    flex: 2,
                  ),
                  for (final p in PlanTier.values)
                    cell(
                      Text(
                        '₹${formatRupees(calculatePremium(membership: membership, plan: p, duration: duration, sumAssured: sumAssured))} / yr',
                        style: cellStyle,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
              ),
              child: Row(
                children: [
                  cell(Text('Consultation access', style: labelStyle), flex: 2),
                  for (final p in PlanTier.values)
                    cell(Text(p.consultationAccess(membership), style: cellStyle)),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
              ),
              child: Row(
                children: [
                  cell(
                    Text('Free review of 1 pre-existing matter', style: labelStyle),
                    flex: 2,
                  ),
                  for (final _ in PlanTier.values)
                    cell(Text('—', style: cellStyle)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  const Expanded(flex: 2, child: SizedBox()),
                  for (final p in PlanTier.values)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: OutlinedButton(
                          onPressed: () => onSelect(p),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          child: Text(
                            'Select',
                            style: customTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddOnsCallout extends StatelessWidget {
  final MembershipType membership;

  const _AddOnsCallout({required this.membership});

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
            _AddOnRow(
              text: 'No proactive add-ons at this membership level',
              included: false,
            )
          else
            ...addOns.map((a) => _AddOnRow(text: a, included: true)),
        ],
      ),
    );
  }
}

class _AddOnRow extends StatelessWidget {
  final String text;
  final bool included;

  const _AddOnRow({required this.text, required this.included});

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
            color: included
                ? const Color(0xFF059669)
                : const Color(0xFF94A3B8),
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