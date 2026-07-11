import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

void showComingSoonDialog(BuildContext context, String title) {
  showModalBottomSheet(
    backgroundColor: context.secondaryBackgroundColor,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.construction_rounded, size: 48, color: AppColors.primary),
          const SizedBox(height: 12),
          Text(title, style: AppTheme.title18),
          const SizedBox(height: 8),
          Text(
            'This feature is currently under development and will be available soon.',
            textAlign: TextAlign.center,
            style: AppTheme.title12,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    ),
  );
}
