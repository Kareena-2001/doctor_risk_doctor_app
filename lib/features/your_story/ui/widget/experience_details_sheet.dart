import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/media_preview_tiles.dart';
import 'package:Doctors_App/features/your_story/model/experience_response.dart';
import 'package:Doctors_App/features/your_story/ui/widget/experience_card.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/formatters.dart';
import '../../../../core/widgets/info_row.dart';

Future<void> showExperienceDetailsSheet(
  BuildContext context,
  ExperienceData experience,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => ExperienceDetailsSheet(experience: experience),
  );
}

class ExperienceDetailsSheet extends StatelessWidget {
  const ExperienceDetailsSheet({super.key, required this.experience});

  final ExperienceData experience;

  @override
  Widget build(BuildContext context) {
    final status = resolveExperienceStatus(experience.approveStatus);
    final type = experience.experienceType.isEmpty
        ? 'text'
        : experience.experienceType.toLowerCase();
    final typeLabel = capitalizeFirst(type, fallback: 'Text');
    final file = experience.file?.trim() ?? '';

    // final subtitle = [
    //   experience.drName,
    //   experience.degree,
    //   experience.categoryName,
    //   experience.specialityName,
    // ].where((value) => value != null && value.trim().isNotEmpty).join(' · ');

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: EdgeInsets.fromLTRB(
        Responsive.w(18),
        Responsive.h(12),
        Responsive.w(18),
        Responsive.h(24),
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: Responsive.w(40),
                height: Responsive.h(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            height(Responsive.h(18)),
            Text(
              experience.title,
              style: customTextStyle(
                fontSize: Responsive.sp(18),
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),

            // if (subtitle.isNotEmpty) ...[
            //   height(Responsive.h(14)),
            //   Text(
            //     subtitle,
            //     style: customTextStyle(fontSize: Responsive.sp(11), color: Colors.grey.shade600),
            //   ),
            // ],
            if (type == 'video' && file.isNotEmpty) ...[
              height(Responsive.h(18)),
              VideoPreviewTile(videoUrl: file, title: experience.title),
            ] else if (type == 'document' && file.isNotEmpty) ...[
              height(Responsive.h(18)),
              DocumentPreviewTile(fileUrl: file, label: 'View attachment'),
            ],

            height(Responsive.h(18)),
            InfoRow(
              icon: Icons.description_outlined,
              label: 'Type',
              value: typeLabel,
            ),
            height(Responsive.h(10)),
            InfoRow(
              icon: Icons.verified_outlined,
              label: 'Status',
              value: status.label,
              valueColor: status.color,
              valueBackgroundColor: status.background,
            ),
            // height(Responsive.h(10)),
            // InfoRow(
            //   icon: Icons.stars_rounded,
            //   label: 'Points',
            //   value: '+15 Pts on Approval',
            //   valueColor: AppColors.newPri,
            // ),
            // height(Responsive.h(10)),
            // InfoRow(
            //   icon: Icons.calendar_today_outlined,
            //   label: 'Date',
            //   value: formatFriendlyDate(experience.createdOn),
            // ),
            height(Responsive.h(20)),
            // Divider(color: Colors.grey.shade200),
            // height(Responsive.h(16)),
            // Text(
            //   'Details',
            //   style: customTextStyle(
            //     fontSize: Responsive.sp(14),
            //     fontWeight: FontWeight.bold,
            //     color: AppColors.textColor,
            //   ),
            // ),
            // height(Responsive.h(8)),
            Text(
              experience.details.isEmpty
                  ? 'No details available.'
                  : experience.details,
              style: customTextStyle(
                fontSize: Responsive.sp(13),
                color: Colors.grey.shade700,
              ).copyWith(height: 1.6),
            ),

            if (type != 'document' && type != 'video' && file.isNotEmpty) ...[
              height(Responsive.h(18)),
              Text(
                'Attachment',
                style: customTextStyle(
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              height(Responsive.h(8)),
              DocumentPreviewTile(fileUrl: file, label: 'Open attachment'),
            ],
          ],
        ),
      ),
    );
  }
}
