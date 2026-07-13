import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/common_empty_state.dart';
import '../../../theme/app_colors.dart';
import '../controller/product_view_model.dart';
import '../model/product_model.dart';
import '../widgets/tier_bottom_sheet_widget.dart';
import '../widgets/tier_helper.dart';
import '../widgets/tier_summary_row.dart';

class ProductView extends ConsumerStatefulWidget {
  const ProductView({super.key});

  @override
  ConsumerState<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends ConsumerState<ProductView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  int? _expandedId;
  String _searchQuery = '';
  bool _showSearch = false;
  final _searchCtrl = TextEditingController();

  static const _tabTypes = [
    ProductType.individual,
    ProductType.medicalEstablishment,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging ||
          _tabController.index != _tabController.previousIndex) {
        setState(() {});
      }
    });
  }

  List<Product> _byType(ProductType type) {
    final sampleProducts = ref
        .read(productViewModelProvider.notifier)
        .sampleProducts;
    final base = sampleProducts.where((p) => p.type == type);
    if (_searchQuery.isEmpty) return base.toList();
    final q = _searchQuery.toLowerCase();
    return base.where((p) {
      return p.productNames.any((n) => n.toLowerCase().contains(q)) ||
          p.shortDescription.toLowerCase().contains(q);
    }).toList();
  }

  void _openTierSheet(Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TierBottomSheet(product: product),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("ProductView opened");
    final individualCount = _byType(ProductType.individual).length;
    final establishmentCount = _byType(ProductType.medicalEstablishment).length;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Products',
        showSearch: true,
        onSearch: () {
          setState(() {
            _showSearch = !_showSearch;
            if (!_showSearch) {
              _searchQuery = '';
              _searchCtrl.clear();
            }
          });
        },
        showFilter: true,
        onFilter: () {},
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_showSearch) _buildSearchBar(),
            _buildTypeTabs(individualCount, establishmentCount),
            _buildListHeader(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _tabTypes.map((type) {
                  final items = _byType(type);
                  return items.isEmpty
                      ? _buildEmpty()
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                          itemCount: items.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (_, i) {
                            final p = items[i];
                            return _ProductRow(
                              product: p,
                              isExpanded: _expandedId == p.id,
                              onToggle: () => setState(() {
                                _expandedId = _expandedId == p.id ? null : p.id;
                              }),
                              onViewTiers: () => _openTierSheet(p),
                            );
                          },
                        );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: TextField(
        controller: _searchCtrl,
        autofocus: true,
        onChanged: (v) => setState(() => _searchQuery = v),
        decoration: InputDecoration(
          hintText: 'Search products...',
          hintStyle: customTextStyle(color: Color(0xFFCBD5E1), fontSize: 14),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF94A3B8),
            size: 20,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Color(0xFF94A3B8),
                    size: 18,
                  ),
                  onPressed: () => setState(() {
                    _searchQuery = '';
                    _searchCtrl.clear();
                  }),
                )
              : null,
          filled: true,
          fillColor: const Color(0xFFF8F9FC),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeTabs(int individualCount, int establishmentCount) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Responsive.w(16),
        Responsive.h(14),
        Responsive.w(16),
        0,
      ),
      child: Container(
        height: Responsive.h(44),
        padding: EdgeInsets.all(Responsive.w(4)),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(Responsive.w(14)),
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildTabSegment(
                index: 0,
                icon: Icons.shield_rounded,
                label: 'Individual',
                count: individualCount,
              ),
            ),
            Expanded(
              child: _buildTabSegment(
                index: 1,
                icon: Icons.local_hospital_rounded,
                label: 'Establishment',
                count: establishmentCount,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSegment({
    required int index,
    required IconData icon,
    required String label,
    required int count,
  }) {
    final isSelected = _tabController.index == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _tabController.animateTo(index)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Responsive.w(10)),
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: index == 0
                      ? [AppColors.newPri, AppColors.newPri]
                      : [const Color(0xFF10B981), const Color(0xFF059669)],
                )
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color:
                        (index == 0
                                ? AppColors.accent
                                : const Color(0xFF10B981))
                            .withValues(alpha: 0.3),
                    blurRadius: Responsive.w(8),
                    offset: Offset(0, Responsive.h(2)),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: Responsive.sp(15),
              color: isSelected ? Colors.white : const Color(0xFF64748B),
            ),
            SizedBox(width: Responsive.w(6)),
            Text(
              label,
              style: customTextStyle(
                fontSize: Responsive.sp(13),
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
              ),
            ),
            SizedBox(width: Responsive.w(6)),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.w(6),
                vertical: Responsive.h(1.5),
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.25)
                    : Colors.white,
                borderRadius: BorderRadius.circular(Responsive.w(20)),
                border: isSelected
                    ? null
                    : Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Text(
                '$count',
                style: customTextStyle(
                  fontSize: Responsive.sp(10.5),
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListHeader() {
    final type = _tabTypes[_tabController.index];
    final count = _byType(type).length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          Text(
            '$count product${count != 1 ? 's' : ''}',
            style: customTextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF94A3B8),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sort_rounded, size: 14, color: Color(0xFF64748B)),
                SizedBox(width: 4),
                Text(
                  'Newest first',
                  style: customTextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return CommonEmptyState(
      title: 'No products found',
      message: 'Try a different search term',
      onPressed: () {},
    );
  }
}

class _ProductRow extends StatelessWidget {
  final Product product;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onViewTiers;

  const _ProductRow({
    required this.product,
    required this.isExpanded,
    required this.onToggle,
    required this.onViewTiers,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isExpanded
              ? AppColors.accent.withValues(alpha: 0.4)
              : const Color(0xFFE2E8F0),
          width: isExpanded ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isExpanded ? 0.07 : 0.03),
            blurRadius: isExpanded ? 20 : 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [_buildHeader(), if (isExpanded) _buildExpandedBody()],
      ),
    );
  }

  Widget _buildHeader() {
    final isEstab = product.type == ProductType.individual;
    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isEstab
                      ? [
                          Color(0xFF10B981).withValues(alpha: 0.5),
                          const Color(0xFF059669),
                        ]
                      : [
                          AppColors.orange.withValues(alpha: 0.5),
                          AppColors.orange,
                        ],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                isEstab ? Icons.local_hospital_rounded : Icons.shield_rounded,
                color: Colors.white,
                size: 14,
              ),
            ),
            width(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 6,
                    children: product.productNames.map((n) {
                      return Text(
                        n,
                        style: customTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ).copyWith(letterSpacing: -0.2),
                      );
                    }).toList(),
                  ),
                  height(3),
                  Text(
                    product.shortDescription,
                    style: customTextStyle(
                      fontSize: 12,
                      color: Color(0xFF94A3B8),
                    ).copyWith(height: 1.3),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 5,
                    children: product.tiers.map((t) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: t.style.bgColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: t.style.accentColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          t.name,
                          style: customTextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: t.style.accentColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatDate(product.createdDate),
                  style: customTextStyle(fontSize: 10, color: AppColors.grey),
                ),
                height(6),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: isExpanded
                          ? AppColors.orange.withValues(alpha: 0.1)
                          : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 16,
                      color: isExpanded ? AppColors.orange : AppColors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedBody() {
    return Column(
      children: [
        const Divider(height: 1, color: Color(0xFFF1F5F9)),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 15,
                      color: Color(0xFF6366F1),
                    ),
                    width(8),
                    Expanded(
                      child: Text(
                        product.fullDescription,
                        style: customTextStyle(
                          fontSize: 12,
                          color: Color(0xFF475569),
                        ).copyWith(height: 1.6),
                      ),
                    ),
                  ],
                ),
              ),
              height(12),
              Row(
                children: [
                  Container(
                    width: 3,
                    height: 14,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  width(7),
                  Text(
                    'Available tiers',
                    style: customTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              height(10),
              ...product.tiers.map((t) => TierSummaryRow(tier: t)),
              height(10),
              PrimaryButton(
                height: 40,
                // prefix: Icon(Icons.layers_rounded),
                backgroundColor: AppColors.newPri,
                fontSize: 14,
                text: "View full tier details",
                onPressed: onViewTiers,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
