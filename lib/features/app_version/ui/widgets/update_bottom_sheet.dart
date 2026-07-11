import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../extensions/build_context_extension.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';

class UpdateBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final String? whatsNew;
  final bool isForceUpdate;
  final VoidCallback onUpdate;
  final VoidCallback? onSkip;

  const UpdateBottomSheet({
    super.key,
    required this.title,
    required this.message,
    this.whatsNew,
    required this.isForceUpdate,
    required this.onUpdate,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !isForceUpdate,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.primaryBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isForceUpdate)
                Center(
                  child: Container(
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              if (!isForceUpdate) const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    isForceUpdate ? Icons.warning : Icons.system_update,
                    color: isForceUpdate ? Colors.orange : AppColors.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Update Available',
                      style: customTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'A new version of the app is available. Please update to continue.',
                style: AppTheme.label14,
              ),
              if (whatsNew?.isNotEmpty == true) ...[
                height(16),
                Text(
                  "What's New",
                  style: AppTheme.label16.copyWith(fontWeight: FontWeight.w600),
                ),
                height(8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Html(
                    data: whatsNew!,
                    style: {
                      "body": Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        fontSize: FontSize(14),
                      ),
                      "li": Style(margin: Margins.only(bottom: 6)),
                    },
                  ),
                ),
              ],
              if (isForceUpdate) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.orange.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'This update is mandatory to continue using the app',
                          style: customTextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              height(24),
              Row(
                children: [
                  if (!isForceUpdate && onSkip != null) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onSkip,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: Colors.grey.shade400),
                        ),
                        child: const Text('Later'),
                      ),
                    ),
                    width(12),
                  ],
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onUpdate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Update Now',
                        style: customTextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
