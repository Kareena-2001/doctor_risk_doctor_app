import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';
import '../../../common/ui/widgets/primary_button.dart';
import '../view_model/help_view_model.dart';

class SuccessView extends ConsumerWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final helpState = ref.watch(helpViewModelProvider);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                size: 80,
                color: Colors.green,
              ),
            ),
            height(24),
            Text(
              'Query Submitted Successfully!',
              style: AppTheme.title20,
              textAlign: TextAlign.center,
            ),
            height(12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary),
              ),
              child: Text(
                'Ticket #${helpState.tktNumber ?? '-'}',
                style: AppTheme.label14,
              ),
            ),
            height(16),
            Text(
              'Our support team will review your query and get back to you shortly.',
              style: customTextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            height(32),
            PrimaryButton(
              onPressed: () => Navigator.pop(context),
              text: 'Back to Help',
              backgroundColor: AppColors.primary,
            ),
            // height(12),
            // TextButton(
            //   onPressed: () {
            //     context.push(Routes.myQueries);
            //   },
            //   child: Text(
            //     'View My Queries',
            //     style: customTextStyle(
            //       fontSize: 14,
            //       fontWeight: FontWeight.w600,
            //       color: AppColors.primary,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
