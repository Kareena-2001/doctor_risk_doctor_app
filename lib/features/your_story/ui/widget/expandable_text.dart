import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatelessWidget {
  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 4,
    this.style,
    this.dialogTitle,
  });

  final String text;
  final int maxLines;
  final TextStyle? style;
  final String? dialogTitle;

  bool _overflows(double maxWidth) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
    return painter.didExceedMaxLines;
  }

  void _showFullText(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Responsive.w(16)),
        ),
        title: dialogTitle != null
            ? Text(
                dialogTitle!,
                style: customTextStyle(
                  fontSize: Responsive.sp(12),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              )
            : null,
        content: SingleChildScrollView(
          child: Text(
            text,
            style:
                style?.copyWith(height: 1.6) ??
                customTextStyle(
                  fontSize: Responsive.sp(12),
                  color: Colors.grey.shade700,
                ).copyWith(height: 1.6),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: customTextStyle(
                color: AppColors.newPri,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final overflows = text.isNotEmpty && _overflows(constraints.maxWidth);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: style,
            ),
            if (overflows) ...[
              SizedBox(height: Responsive.h(4)),
              GestureDetector(
                onTap: () => _showFullText(context),
                child: Text(
                  'Show more',
                  style: customTextStyle(
                    fontSize: Responsive.sp(12),
                    fontWeight: FontWeight.w600,
                    color: AppColors.newPri,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
