import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extensions/build_context_extension.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../constants/dimensions.dart';
import '../constants/values/app_text_style.dart';

class CustomTimePicker extends ConsumerWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final VoidCallback onTap;
  final bool isRequired;
  final FormFieldValidator<String>? validator;

  const CustomTimePicker({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.onTap,
    this.isRequired = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: customTextStyle(
                color: AppColors.labelColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: customTextStyle(
                  fontSize: Responsive.sp(13),
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
          ],
        ),
        height(8),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          validator:
              validator ??
              (value) {
                if (isRequired && (value == null || value.isEmpty)) {
                  return 'Please select time';
                }
                return null;
              },
          style: AppTheme.label12,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            hintText: hint,
            suffixIcon: Icon(
              Icons.access_time_outlined,
              size: 20,
              color: context.secondaryTextColor,
            ),
            hintStyle: customTextStyle(
              fontSize: 12,
              color: const Color(0xFFAAAAAA),
              fontWeight: FontWeight.w400,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.fieldBorder),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.fieldBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
