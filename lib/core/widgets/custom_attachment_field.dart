import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_colors.dart';
import '../constants/dimensions.dart';
import '../constants/values/app_text_style.dart';

class CustomAttachmentField extends ConsumerWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final VoidCallback onTap;
  final bool isRequired;

  const CustomAttachmentField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.onTap,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.cardBackground(ref),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.fieldBorder),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.attach_file,
                  color: Color(0xFFF16723),
                  size: 20,
                ),
                width(12),
                Expanded(
                  child: Text(
                    controller.text.isEmpty ? hint : controller.text,
                    style: customTextStyle(
                      fontSize: 12,
                      color: AppColors.textHint,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
