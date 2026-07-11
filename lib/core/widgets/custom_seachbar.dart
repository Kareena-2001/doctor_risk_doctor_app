import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_colors.dart';
import '../constants/dimensions.dart';
import '../constants/values/app_text_style.dart';

import '../../../core/constants/languages.dart';
import '../../../core/constants/values/app_constants.dart';

class CustomSearchBar extends ConsumerWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hint;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.hint = 'Search...',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: customTextStyle(
        fontSize: 14,
        color: AppColors.textQuaternary(ref),
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.fieldGrey, width: 2),
        ),
        hintText: hint,
        hintStyle: customTextStyle(
          fontSize: 14,
          color: const Color(0xFFAAAAAA),
        ),
        prefixIcon: const Icon(Icons.search, color: Color(0xFF757575)),
        filled: true,
        fillColor: AppColors.cardBackground(ref),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
