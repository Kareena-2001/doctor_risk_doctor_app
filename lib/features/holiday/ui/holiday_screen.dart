import 'package:Doctors_App/features/holiday/ui/view_model/holiday_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/widgets/common_empty_state.dart';
import '../../../core/widgets/common_error_state.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_theme.dart';
import '../../common/ui/widgets/loading.dart';
import '../../home/ui/view_model/home_view_model.dart';
import '../model/holiday_model.dart';

class HolidayScreen extends ConsumerStatefulWidget {
  const HolidayScreen({super.key});

  @override
  ConsumerState<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends ConsumerState<HolidayScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeState = ref.read(homeViewModelProvider);

      final designation = homeState.value?.data.designation;

      if (designation != null) {
        ref.read(holidayViewModelProvider.notifier).holidayList(designation);
      }
    });
  }

  Future<void> _onRefresh() async {
    final homeState = ref.read(homeViewModelProvider);
    final designation = homeState.value?.data.designation;

    if (designation != null) {
      await ref
          .read(holidayViewModelProvider.notifier)
          .holidayList(designation);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(holidayViewModelProvider);

    return Scaffold(
      appBar: CustomAppBar(title: 'Holiday List'),
      body: state.when(
        error: (e, stackTrace) => CommonErrorState(
          title: 'Something went wrong',
          icon: Icons.error,
          message: e.toString(),
        ),
        loading: () => const Loading(),
        data: (model) {
          if (model.holidayList.isEmpty) {
            return const CommonEmptyState(
              title: 'No Holiday List',
              icon: Icons.family_restroom_rounded,
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount: model.holidayList.length,
              itemBuilder: (context, index) {
                final holiday = model.holidayList[index];
                return _buildHolidayCard(holiday);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildHolidayCard(HolidayData holidayData) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.event, color: Color(0xFF8B5CF6), size: 22),
          ),
          width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  holidayData.title,
                  style: AppTheme.label14.copyWith(fontWeight: FontWeight.w600),
                ),
                height(2),
                Text(
                  holidayData.holidayDate,
                  style: AppTheme.label12.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
