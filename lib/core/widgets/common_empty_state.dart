import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../constants/dimensions.dart';
import '../constants/values/app_text_style.dart';

class CommonEmptyState extends ConsumerWidget {
  final IconData? icon;
  final String? image;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onPressed;
  final Color primaryColor;

  const CommonEmptyState({
    super.key,
    this.icon,
    this.image,
    required this.title,
    this.message = '',
    this.buttonText = '',
    this.onPressed,
    this.primaryColor = AppColors.newPri,
  }) : assert(
         icon != null || image != null,
         'You must provide either an icon or an image',
       );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: _buildIconOrImage(),
          ),
          height(24),
          Text(title, style: AppTheme.label16, textAlign: TextAlign.center),
          height(8),
          Text(message, style: AppTheme.label14, textAlign: TextAlign.center),
          if (buttonText.isNotEmpty && onPressed != null) ...[
            height(24),
            ElevatedButton.icon(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: AppColors.cardBackground(ref),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.add),
              label: Text(
                buttonText,
                style: customTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIconOrImage() {
    if (image != null) {
      if (image!.endsWith(".svg")) {
        return SvgPicture.asset(image!, height: 50, width: 50);
      } else {
        return Image.asset(image!, height: 50, width: 50, fit: BoxFit.contain);
      }
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon ?? Icons.info_outline,
        size: 35,
        color: AppColors.primary,
      ),
    );
  }
}
