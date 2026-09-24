import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DocumentSectionBody<T> extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final List<T> items;
  final String emptyText;
  final VoidCallback onRetry;
  final Widget Function(T item) itemBuilder;

  const DocumentSectionBody({
    super.key,
    required this.isLoading,
    required this.error,
    required this.items,
    required this.emptyText,
    required this.onRetry,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: Responsive.h(24)),
        child: const Center(child: Loading()),
      );
    }

    if (error != null && items.isEmpty) {
      return _MessageBox(
        text: error!,
        action: TextButton(
          onPressed: onRetry,
          child: Text(
            'Retry',
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              fontWeight: FontWeight.w700,
              color: AppColors.newPri,
            ),
          ),
        ),
      );
    }

    if (items.isEmpty) return _MessageBox(text: emptyText);

    return Column(children: items.map(itemBuilder).toList());
  }
}

class _MessageBox extends StatelessWidget {
  final String text;
  final Widget? action;

  const _MessageBox({required this.text, this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: context.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: context.dividerColor),
      ),
      child: Column(
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              color: AppColors.homeTextMuted,
            ),
          ),
          if (action != null) ...[height(Responsive.h(6)), action!],
        ],
      ),
    );
  }
}
