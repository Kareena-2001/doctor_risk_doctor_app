import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CommonErrorState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onRetry;

  const CommonErrorState({
    super.key,
    this.icon = Icons.error_outline,
    required this.title,
    required this.message,
    this.buttonText = "Retry",
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Colors.red.shade300),
            height(16),
            Text(title, style: AppTheme.title18),
            height(8),
            Text(message, textAlign: TextAlign.center, style: AppTheme.label14),
            height(24),
            if (onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(buttonText),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF16723),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
