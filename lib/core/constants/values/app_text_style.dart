import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../theme/app_colors.dart';

TextStyle customTextStyle({
  double fontSize = 12,
  FontWeight fontWeight = FontWeight.w400,
  Color? color,
  String fontFamily = 'Nunito',
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

Color? _getColorFromAppColors(TextColorType type, WidgetRef? ref) {
  if (ref == null) {
    switch (type) {
      case TextColorType.primary:
      case TextColorType.secondary:
      case TextColorType.tertiary:
      case TextColorType.appBar:
        return null;
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

  switch (type) {
    case TextColorType.primary:
      return AppColors.textPrimary(ref);
    case TextColorType.secondary:
      return AppColors.textSecondary(ref);
    case TextColorType.tertiary:
      return AppColors.textTertiary(ref);
    case TextColorType.appBar:
      return AppColors.appBarText(ref);
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
