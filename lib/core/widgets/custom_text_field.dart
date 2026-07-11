import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../constants/values/app_text_style.dart';
import '../constants/dimensions.dart';

class CustomTextField extends ConsumerWidget {
  final String? label;
  final String? hint;
  final IconData? icon;
  final TextEditingController? controller;
  final String? value;
  final ValueChanged<String>? onChanged;
  final bool isRequired;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final int maxLines;
  final bool enabled;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final bool readOnly;

  const CustomTextField({
    super.key,
    this.label,
    this.icon,
    this.hint,
    this.controller,
    this.value,
    this.onChanged,
    this.isRequired = true,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.maxLines = 1,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: double.infinity),
              child: Text(label ?? '', style: AppTheme.label12, softWrap: true),
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
        TextFormField(
          textCapitalization: textCapitalization,
          maxLength: maxLength,
          controller: controller,
          initialValue: controller == null ? value : null,
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readOnly,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          enabled: enabled,
          textAlign: TextAlign.start,
          validator: (val) {
            if (isRequired && (val == null || val.trim().isEmpty)) {
              return '$label is required';
            }
            if (validator != null) return validator!(val);
            return null;
          },
          style: AppTheme.label12,
          decoration: InputDecoration(
            // prefixIcon: icon != null
            //     ? Icon(icon, color: const Color(0xFF1565C0), size: 20)
            //     : null,
            hintText: hint,
            hintStyle: customTextStyle(
              fontSize: 12,
              color: AppColors.textHint,
              fontWeight: FontWeight.w500,
            ),
            // filled: true,
            // fillColor: AppColors.cardBackground(ref),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(10),
            //   borderSide: BorderSide(color: AppColors.borderColor(ref)),
            // ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
