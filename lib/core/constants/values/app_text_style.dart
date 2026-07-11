import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../theme/app_colors.dart';

TextStyle customTextStyle({
  double fontSize = 12,
  FontWeight fontWeight = FontWeight.w400,
  Color? color,
  String fontFamily = 'Source Sans 3',
  TextColorType colorType = TextColorType.primary,
  WidgetRef? ref,
}) {
  final finalColor = color ?? _getColorFromAppColors(colorType, ref);

  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: finalColor,
    fontFamily: fontFamily,
  );
}

Color _getColorFromAppColors(TextColorType type, WidgetRef? ref) {
  switch (type) {
    case TextColorType.primary:
      return ref != null ? AppColors.textPrimary(ref) : AppColors.grey;
    case TextColorType.secondary:
      return ref != null ? AppColors.textSecondary(ref) : AppColors.grey;
    case TextColorType.tertiary:
      return ref != null ? AppColors.textTertiary(ref) : AppColors.grey;
    case TextColorType.appBar:
      return ref != null ? AppColors.appBarText(ref) : AppColors.grey;
    case TextColorType.success:
      return AppColors.greenAccent;
    case TextColorType.error:
      return AppColors.error;
    case TextColorType.warning:
      return AppColors.accent;
    case TextColorType.info:
      return AppColors.info;
  }
}

enum TextColorType {
  primary,
  secondary,
  tertiary,
  appBar,
  success,
  error,
  warning,
  info,
}
