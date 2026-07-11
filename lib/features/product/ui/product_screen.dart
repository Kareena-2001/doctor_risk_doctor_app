import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/features/product/ui/state/product_state.dart';
import 'package:Doctors_App/features/product/ui/view_model/product_view_model.dart';
import 'package:Doctors_App/features/product/ui/widgets/my_plans_widgets.dart';
import 'package:Doctors_App/features/product/ui/widgets/plan_list_widgets.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/dimensions.dart';
import '../../../../../core/constants/values/app_text_style.dart';
import '../../../theme/app_colors.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(productViewModelProvider);

    return asyncState.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) =>
          Scaffold(body: Center(child: Text('Something went wrong: $err'))),
      data: (state) => Scaffold(
        backgroundColor: AppColors.newSec,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Products',
                style: customTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              height(4),
              Text(
                'Manage your medical indemnity insurance and protection plans.',
                style: customTextStyle(fontSize: 13, color: Colors.black54),
              ),
              height(16),
              _buildProfileCard(),
              height(16),
              _buildToggleTabs(state.isPlanListSelected),
              height(20),
              state.isPlanListSelected
                  ? const PlanListWidgets()
                  : const MyPlansWidgets(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onAddPlanPressed(context, state),
          backgroundColor: AppColors.newPri,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  void _onAddPlanPressed(BuildContext context, ProductState state) {
    // Adjust route name to whatever you register in routes.dart.
    // Passing the current tab context in case the add-plan flow
    // needs to know whether the user came from Plan List or My Plans.
    context.push(
      Routes.addPlanScreen,
      extra: {'fromPlanList': state.isPlanListSelected},
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.newPri,
            child: Icon(Icons.person, color: AppColors.white, size: 24),
          ),
          width(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dr. Paresh Mathur',
                style: customTextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Reg: 48578 • Gen. Physician',
                style: customTextStyle(fontSize: 12, color: AppColors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTabs(bool isPlanListSelected) {
    return Center(
      child: Container(
        height: Responsive.h(40),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTabItem(
              label: 'Plan List',
              isSelected: isPlanListSelected,
              onTap: () =>
                  ref.read(productViewModelProvider.notifier).changeTab(true),
            ),
            _buildTabItem(
              label: 'My Plans',
              isSelected: !isPlanListSelected,
              onTap: () =>
                  ref.read(productViewModelProvider.notifier).changeTab(false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.newPri : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: customTextStyle(
            color: isSelected ? Colors.white : Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
