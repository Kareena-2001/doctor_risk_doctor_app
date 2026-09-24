import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

const Color kDocGreen = Color(0xFF1E8E4E);
const Color kDocOrange = Color(0xFFE8912D);
const Color kDocUploadGreen = Color(
  0xFF0F6B45,
);

class DocumentTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final DocumentStatusBadge? badge;
  final List<Widget> actions;

  const DocumentTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.badge,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.h(12)),
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: context.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: context.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBox(),
              width(Responsive.w(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: customTextStyle(
                        fontSize: Responsive.sp(13),
                        fontWeight: FontWeight.w700,
                        color: context.primaryTextColor,
                      ),
                    ),
                    height(Responsive.h(3)),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: customTextStyle(
                        fontSize: Responsive.sp(11),
                        color: AppColors.homeTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
              if (badge != null) ...[width(Responsive.w(8)), badge!],
            ],
          ),
          if (actions.isNotEmpty) ...[
            height(Responsive.h(12)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (int i = 0; i < actions.length; i++) ...[
                  if (i > 0) width(Responsive.w(8)),
                  actions[i],
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.w(36),
      height: Responsive.w(36),
      decoration: BoxDecoration(
        color: kDocGreen.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(Responsive.w(8)),
      ),
      child: Icon(
        Icons.description_outlined,
        color: kDocGreen,
        size: Responsive.sp(18),
      ),
    );
  }
}

class DocumentStatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const DocumentStatusBadge({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(8),
        vertical: Responsive.h(3),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Responsive.w(6)),
      ),
      child: Text(
        label.toUpperCase(),
        style: customTextStyle(
          fontSize: Responsive.sp(9.5),
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class DocumentActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool filled;
  final bool isLoading;

  const DocumentActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.filled = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(Responsive.w(25));
    final minSize = Size(Responsive.w(84), Responsive.h(36));
    final padding = EdgeInsets.symmetric(horizontal: Responsive.w(16));

    final child = isLoading
        ? SizedBox(
            width: Responsive.w(16),
            height: Responsive.w(16),
            child: Loading(),
          )
        : Text(
            label,
            style: customTextStyle(
              color: filled ? Colors.white : context.primaryTextColor,
              fontSize: Responsive.sp(12),
              fontWeight: FontWeight.w700,
            ),
          );

    if (filled) {
      return ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kDocUploadGreen,
          foregroundColor: Colors.white,
          disabledBackgroundColor: kDocUploadGreen.withValues(alpha: 0.6),
          disabledForegroundColor: Colors.white,
          elevation: 0,
          minimumSize: minSize,
          padding: padding,
          shape: RoundedRectangleBorder(borderRadius: radius),
        ),
        child: child,
      );
    }

    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: context.primaryTextColor,
        side: BorderSide(color: context.dividerColor),
        minimumSize: minSize,
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: radius),
      ),
      child: child,
    );
  }
}
