import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/formatters.dart';
import 'package:Doctors_App/core/widgets/media_preview_tiles.dart';
import 'package:Doctors_App/features/your_story/model/experience_response.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

import 'approval_status.dart';
import 'expandable_text.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({super.key, required this.experience});

  final ExperienceData experience;

  @override
  Widget build(BuildContext context) {
    final status = resolveApprovalStatus(experience.approveStatus);
    final type = experience.experienceType.isEmpty
        ? 'text'
        : experience.experienceType.toLowerCase();
    final typeLabel = capitalizeFirst(type, fallback: 'Text');
    final file = experience.file?.trim() ?? '';
    final title = experience.title.trim().isNotEmpty
        ? experience.title.trim()
        : '-';

    final detailsStyle = customTextStyle(
      fontSize: Responsive.sp(13),
      color: context.secondaryTextColor,
    );

    return Container(
      decoration: BoxDecoration(
        color: context.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(color: context.dividerColor),
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
                  color: context.secondaryTextColor,
                ),
              ),
            ],
          ),
          height(Responsive.h(8)),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: customTextStyle(
              fontSize: Responsive.sp(13),
              fontWeight: FontWeight.w500,
              color: context.primaryTextColor,
            ).copyWith(height: 1.3),
          ),
          height(Responsive.h(12)),

          if (type == 'video' && file.isNotEmpty)
            VideoPreviewTile(videoUrl: file, title: title)
          else if (type == 'document' && file.isNotEmpty)
            DocumentPreviewTile(fileUrl: file, label: 'View attachment')
          else
            ExpandableText(
              text: experience.details.trim().isEmpty
                  ? 'No details available.'
                  : experience.details.trim(),
              maxLines: 4,
              style: detailsStyle.copyWith(height: 1.5),
              dialogTitle: title,
            ),

          height(Responsive.h(14)),
          Divider(height: 1, color: context.dividerColor),
          height(Responsive.h(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: Responsive.w(14),
                    color: context.secondaryTextColor,
                  ),
                  width(Responsive.w(6)),
                  Text(
                    formatFriendlyDate(experience.createdOn),
                    style: customTextStyle(
                      fontSize: Responsive.sp(12),
                      fontWeight: FontWeight.w500,
                      color: context.secondaryTextColor,
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
                      pointsLabelFor(experience.approveStatus),
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
