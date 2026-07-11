import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../extensions/build_context_extension.dart';
import '../../theme/app_colors.dart';
import '../constants/dimensions.dart';
import '../constants/values/app_text_style.dart';

class SectionCard extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final List<Widget> children;

  const SectionCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: context.secondaryWidgetColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.accent, size: 18),
              ),
              width(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: customTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: context.secondaryTextColor,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: customTextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textQuaternary(ref),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          height(16),
          Divider(height: 1, color: context.dividerColor),
          height(16),
          ...children,
        ],
      ),
    );
  }
}
