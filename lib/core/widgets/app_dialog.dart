import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../constants/dimensions.dart';
import '../constants/values/app_text_style.dart';

enum DialogType { success, error, warning, info, confirm }

class AppDialog {
  static Future<void> _show({
    required BuildContext context,
    required String title,
    required String message,
    required DialogType type,
    String primaryButtonText = 'OK',
    VoidCallback? onPrimaryPressed,
    String? secondaryButtonText,
    VoidCallback? onSecondaryPressed,
    bool barrierDismissible = true,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final _DialogConfig config = _getConfig(type);

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => AlertDialog(
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(config.icon, color: config.color),
            width(10),
            Expanded(
              child: Text(
                title,
                style: customTextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: customTextStyle(
            fontSize: 14,
            color: isDark ? Colors.grey.shade300 : Colors.black87,
          ),
        ),
        actions: [
          if (secondaryButtonText != null)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onSecondaryPressed?.call();
              },
              child: Text(
                secondaryButtonText,
                style: customTextStyle(color: Colors.grey),
              ),
            ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onPrimaryPressed?.call();
            },
            child: Text(
              primaryButtonText,
              style: customTextStyle(color: config.color),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> success({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    return _show(
      context: context,
      title: title,
      message: message,
      type: DialogType.success,
      primaryButtonText: buttonText,
      onPrimaryPressed: onPressed,
    );
  }

  static Future<void> error({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'Retry',
    VoidCallback? onPressed,
  }) {
    return _show(
      context: context,
      title: title,
      message: message,
      type: DialogType.error,
      primaryButtonText: buttonText,
      onPrimaryPressed: onPressed,
    );
  }

  static Future<void> info({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'Got it',
  }) {
    return _show(
      context: context,
      title: title,
      message: message,
      type: DialogType.info,
      primaryButtonText: buttonText,
    );
  }

  static Future<void> confirm({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    return _show(
      context: context,
      title: title,
      message: message,
      type: DialogType.confirm,
      primaryButtonText: confirmText,
      secondaryButtonText: cancelText,
      onPrimaryPressed: onConfirm,
      onSecondaryPressed: onCancel,
      barrierDismissible: false,
    );
  }


  static Future<void> bottomSheet({
    required BuildContext context,
    required String title,
    required String message,
    required DialogType type,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    final config = _getConfig(type);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(config.icon, size: 40, color: config.color),
            height(12),
            Text(
              title,
              style: customTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            height(8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: customTextStyle(fontSize: 14),
            ),
            height(20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onPressed?.call();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: config.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================
  // CONFIG MAP
  // =====================

  static _DialogConfig _getConfig(DialogType type) {
    switch (type) {
      case DialogType.success:
        return _DialogConfig(
          icon: Icons.check_circle_rounded,
          color: Colors.green,
        );
      case DialogType.error:
        return _DialogConfig(icon: Icons.error_rounded, color: Colors.red);
      case DialogType.warning:
        return _DialogConfig(
          icon: Icons.warning_amber_rounded,
          color: Colors.orange,
        );
      case DialogType.info:
        return _DialogConfig(
          icon: Icons.info_outline_rounded,
          color: AppColors.primary,
        );
      case DialogType.confirm:
        return _DialogConfig(
          icon: Icons.help_outline_rounded,
          color: AppColors.primary,
        );
    }
  }
}

class _DialogConfig {
  final IconData icon;
  final Color color;

  const _DialogConfig({required this.icon, required this.color});
}
