import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/formatters.dart';
import 'package:Doctors_App/core/widgets/media_preview_tiles.dart';
import 'package:Doctors_App/features/community/model/testimonial_response.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../your_story/ui/widget/approval_status.dart';
import '../../../your_story/ui/widget/expandable_text.dart';

class TestimonialCard extends StatelessWidget {
  const TestimonialCard({super.key, required this.testimonial});

  final TestimonialData testimonial;

  @override
  Widget build(BuildContext context) {
    final status = resolveApprovalStatus(testimonial.approveStatus);
    final type = testimonial.testimonialType.isEmpty
        ? 'text'
        : testimonial.testimonialType.toLowerCase();
    final typeLabel = capitalizeFirst(type, fallback: 'Text');
    final file = testimonial.file?.trim() ?? '';

    final name = testimonial.drName?.trim().isNotEmpty == true
        ? testimonial.drName!.trim()
        : 'Doctor';

    final speciality = testimonial.specialityName?.trim().isNotEmpty == true
        ? testimonial.specialityName!.trim()
        : 'Medical Professional';

    final content = testimonial.details.trim();
    final detailsStyle = customTextStyle(
      fontSize: Responsive.sp(13),
      color: Colors.grey.shade700,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(Responsive.w(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(8),
                  vertical: Responsive.h(2),
                ),
                decoration: BoxDecoration(
                  color: status.background,
                  borderRadius: BorderRadius.circular(Responsive.w(6)),
                ),
                child: Text(
                  status.label,
                  style: customTextStyle(
                    fontSize: Responsive.sp(10),
                    fontWeight: FontWeight.w600,
                    color: status.color,
                  ),
                ),
              ),
              width(Responsive.w(8)),
              Text(
                typeLabel,
                style: customTextStyle(
                  fontSize: Responsive.sp(11),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
          height(Responsive.h(15)),
          if (type == 'video' && file.isNotEmpty)
            VideoPreviewTile(videoUrl: file, title: name)
          else if (type == 'document' && file.isNotEmpty)
            DocumentPreviewTile(fileUrl: file, label: 'Testimonial document')
          else
            ExpandableText(
              text: content.isEmpty
                  ? 'No testimonial details available.'
                  : content,
              maxLines: 4,
              style: detailsStyle.copyWith(height: 1.5),
              dialogTitle: name,
            ),
          height(Responsive.h(14)),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          height(Responsive.h(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: Responsive.w(14),
                    color: const Color(0xFF6B7280),
                  ),
                  width(Responsive.w(6)),
                  Text(
                    formatFriendlyDate(testimonial.createdOn),
                    style: customTextStyle(
                      fontSize: Responsive.sp(12),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(8),
                  vertical: Responsive.h(4),
                ),
                decoration: BoxDecoration(
                  color: AppColors.newPri.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(Responsive.w(8)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.stars_rounded,
                      size: Responsive.w(14),
                      color: AppColors.newPri,
                    ),
                    width(Responsive.w(4)),
                    Text(
                      pointsLabelFor(testimonial.approveStatus),
                      style: customTextStyle(
                        fontSize: Responsive.sp(11),
                        fontWeight: FontWeight.w700,
                        color: AppColors.newPri,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
