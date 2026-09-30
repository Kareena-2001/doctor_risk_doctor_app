import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/support_hub/ui/state/support_state.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LegalCategoryChips extends StatelessWidget {
  final LegalCategory selected;
  final ValueChanged<LegalCategory> onSelected;

  const LegalCategoryChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: LegalCategory.values.map((c) {
          final isSelected = c == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              checkmarkColor: Colors.white,
              label: Text(c.label),
              selected: isSelected,
              backgroundColor: Colors.white,
              selectedColor: AppColors.primary.withValues(alpha: 0.9),
              labelStyle: customTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.textColor,
              ),
              side: BorderSide(
                color: isSelected ? AppColors.primary : Colors.grey.shade300,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              pressElevation: 0,
              onSelected: (_) => onSelected(c),
            ),
          );
        }).toList(),
      ),
    );
  }
}