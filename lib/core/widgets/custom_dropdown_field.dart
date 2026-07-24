import 'package:flutter/material.dart';
import '../../extensions/build_context_extension.dart';
import '../../theme/app_colors.dart';
import '../constants/dimensions.dart';
import '../constants/values/app_text_style.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String? label;
  final String? hint;
  final List<T> items;
  final T? value;
  final void Function(T?)? onChanged;
  final String Function(T)? itemBuilder;
  final IconData? icon;
  final TextEditingController? controller;
  final Color Function(T)? itemColor;
  final bool isRequired;
  final FormFieldValidator<String>? validator;
  final bool isEnabled;

  const CustomDropdownField({
    super.key,
    this.label,
    required this.items,
    this.hint,
    this.value,
    this.onChanged,
    this.itemBuilder,
    this.icon,
    this.controller,
    this.itemColor,
    this.isRequired = true,
    this.validator,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveValue = items.contains(value) ? value : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label ?? '',
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
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
          ],
        ),
        height(8),
        DropdownButtonFormField<T>(
          isExpanded: true,
          dropdownColor: context.primaryBackgroundColor,
          style: customTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          value: effectiveValue,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.brown,
              size: 22,
            ),
            prefixIcon: icon != null
                ? Icon(icon, color: const Color(0xFF1565C0), size: 20)
                : null,
            hintText: hint,
            hintStyle: customTextStyle(
              fontSize: 12,
              color: context.primaryTextColor,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            filled: true,
            fillColor: AppColors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.fieldBorder,
                // width: 1.5,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.fieldBorder,
                // width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemBuilder != null ? itemBuilder!(item) : item.toString(),
                style: customTextStyle(
                  fontSize: 12,
                  color: context.primaryTextColor,
                  fontWeight: FontWeight.w400,
                ),

              ),
            );
          }).toList(),
          onChanged: (val) {
            if (controller != null) controller!.text = val.toString();
            if (onChanged != null) onChanged!(val);
          },
          validator: (val) {
            if (!isRequired) return null;
            if (val == null || val.toString().isEmpty) {
              return 'Please select $label';
            }
            return null;
          },
        ),
      ],
    );
  }
}
