import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/features/product/model/product_model.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/values/app_text_style.dart';
import '../../../routing/routes.dart';
import 'tier_helper.dart';
import 'full_tier_card.dart';

class TierBottomSheet extends StatefulWidget {
  final Product product;

  const TierBottomSheet({super.key, required this.product});

  @override
  State<TierBottomSheet> createState() => TierBottomSheetState();
}

class TierBottomSheetState extends State<TierBottomSheet> {
  late final PageController _pageCtrl;
  int _currentPage = 0;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.product.tiers.indexWhere((t) => t.isBestValue);
    if (_selectedIndex == -1) _selectedIndex = null;
    _pageCtrl = PageController(
      viewportFraction: 0.88,
      initialPage: _selectedIndex ?? 0,
    );
    _currentPage = _selectedIndex ?? 0;
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tiers = widget.product.tiers;
    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      maxChildSize: 0.96,
      minChildSize: 0.5,
      builder: (_, scrollCtrl) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF8F9FC),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 6),
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            _buildSheetHeader(),
            height(6),
            _buildDots(tiers.length),
            height(14),
            Expanded(
              child: PageView.builder(
                controller: _pageCtrl,
                itemCount: tiers.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: SingleChildScrollView(
                    controller: scrollCtrl,
                    child: FullTierCard(
                      plan: tiers[i],
                      isSelected: _selectedIndex == i,
                      onSelect: () => setState(() => _selectedIndex = i),
                    ),
                  ),
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSheetHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.productNames.first,
                  style: customTextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF94A3B8),
                  ).copyWith(letterSpacing: 0.6),
                ),
                height(2),
                Text(
                  'Choose your plan',
                  style: customTextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ).copyWith(letterSpacing: -0.5),
                ),
                Text(
                  'Swipe to compare · tap to select',
                  style: customTextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 18,
                color: Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDots(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = _currentPage == i;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 22 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: active ? const Color(0xFF6366F1) : const Color(0xFFCBD5E1),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }

  Widget _buildBottomBar() {
    final hasSel = _selectedIndex != null;
    final selPlan = hasSel ? widget.product.tiers[_selectedIndex!] : null;
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          if (hasSel && selPlan != null) ...[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: selPlan.style.accentColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${selPlan.name} plan selected',
                        style: customTextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: selPlan.style.accentColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '₹${formatAmount(selPlan.premiumPerYear)}/yr · Cover ₹${formatAmount(selPlan.sumInsured)}',
                    style: customTextStyle(
                      fontSize: 11,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            flex: hasSel ? 1 : 2,
            child: GestureDetector(
              onTap: hasSel
                  ? () {
                      context.push(
                        Routes.purchaseWizard,
                        extra: (
                          widget.product,
                          selPlan!,
                          '1 Year',
                          selPlan.sumInsured,
                          selPlan.premiumPerYear,
                        ),
                      );
                    }
                  : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: hasSel ? AppColors.secondary : const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: hasSel
                      ? [
                          BoxShadow(
                            color: const Color(
                              0xFF6366F1,
                            ).withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    hasSel ? 'Confirm & Continue' : 'Select a plan first',
                    style: customTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: hasSel ? Colors.white : const Color(0xFF94A3B8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
