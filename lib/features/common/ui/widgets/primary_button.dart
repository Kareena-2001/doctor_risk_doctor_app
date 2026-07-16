import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final Color? borderColor;
  final double borderWidth;
  final String text;
  final Widget? child;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double fontSize;
  final FontWeight fontWeight;
  final IconData? icon;
  final bool iconAfterText;
  final List<Color>? gradientColors;

  const PrimaryButton({
    super.key,
    this.borderColor,
    this.borderWidth = 1,
    required this.text,
    this.child,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 56,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 12,
    this.padding,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.icon,
    this.iconAfterText = true,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final txtColor = textColor ?? Colors.white;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: gradientColors != null
                ? LinearGradient(
              colors: gradientColors!,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )
                : null,
            color: gradientColors == null
                ? (backgroundColor ?? AppColors.primary)
                : null,
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth,
            ),
          ),
          child: InkWell(
            onTap: isLoading ? null : onPressed,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Center(
              child: isLoading
                  ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(txtColor),
                ),
              )
                  : child ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!iconAfterText && icon != null) ...[
                        Icon(icon, color: txtColor, size: fontSize),
                        const SizedBox(width: 8),
                      ],

                      Flexible(
                        child: Text(
                          text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: fontWeight,
                            color: txtColor,
                          ),
                        ),
                      ),

                      if (iconAfterText && icon != null) ...[
                        const SizedBox(width: 8),
                        Icon(icon, color: txtColor, size: fontSize),
                      ],
                    ],
                  )
            ),
          ),
        ),
      ),
    );
  }
}
