import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_colors.dart';
import '../constants/values/app_text_style.dart';

class CustomSearchBar extends ConsumerWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hint;
  final Widget? suffixIcon;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.hint = 'Search...',
    this.suffixIcon,
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
        hintText: hint,

        hintStyle: customTextStyle(
          fontSize: 13,
          color: const Color(0xFFAAAAAA),
        ),

        prefixIcon: const Icon(Icons.search, color: Color(0xFF757575)),

        suffixIcon: suffixIcon,

        filled: true,
        fillColor: AppColors.cardBackground(ref),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.fieldGrey),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.fieldBorder, width: 2),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.fieldBorder),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
