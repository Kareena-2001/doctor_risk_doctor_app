import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/your_story/model/experience_response.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/formatters.dart';

class ExperienceStatusInfo {
  const ExperienceStatusInfo(this.label, this.color, this.background);

  final String label;
  final Color color;
  final Color background;
}

ExperienceStatusInfo resolveExperienceStatus(String? rawStatus) {
  final status = (rawStatus ?? 'awaiting_admin_approval').toLowerCase().trim();

  switch (status) {
    case 'published':
    case 'approved':
    case 'published_to_forum':
    case 'published to forum':
      return const ExperienceStatusInfo(
        'Published',
        Color(0xFF16A34A),
        Color(0xFFF0FDF4),
      );

    case 'rejected':
    case 'not_approved':
    case 'not approved':
      return const ExperienceStatusInfo(
        'Not Approved',
        Color(0xFFDC2626),
        Color(0xFFFEF2F2),
      );

    case 'draft':
      return const ExperienceStatusInfo(
        'Draft',
        Color(0xFF4B5563),
        Color(0xFFF3F4F6),
      );

    case 'awaiting_admin_approval':
    case 'awaiting admin approval':
    default:
      return const ExperienceStatusInfo(
        'Awaiting Admin Approval',
        Color(0xFFD97706),
        Color(0xFFFFFBEB),
      );
  }
}

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({
    super.key,
    required this.experience,
    required this.onViewDetails,
  });

  final ExperienceData experience;
  final VoidCallback onViewDetails;

  @override
  Widget build(BuildContext context) {
    final status = resolveExperienceStatus(experience.approveStatus);
    final experienceType = experience.experienceType.isNotEmpty
        ? capitalizeFirst(experience.experienceType, fallback: 'Text')
        : 'Text';

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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onViewDetails,
          borderRadius: BorderRadius.circular(Responsive.w(16)),
          child: Padding(
            padding: EdgeInsets.all(Responsive.w(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
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
                                  borderRadius: BorderRadius.circular(
                                    Responsive.w(6),
                                  ),
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
                              SizedBox(width: Responsive.w(8)),
                              Text(
                                experienceType,
                                style: customTextStyle(
                                  fontSize: Responsive.sp(11),
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.h(8)),
                          Text(
                            experience.title.trim().isNotEmpty == true
                                ? experience.title.trim()
                                : '-',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: customTextStyle(
                              fontSize: Responsive.sp(15),
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF111827),
                            ).copyWith(height: 1.3),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: const Color(0xFF9CA3AF),
                      size: Responsive.w(20),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.h(16)),
                const Divider(height: 1, color: Color(0xFFF3F4F6)),
                SizedBox(height: Responsive.h(12)),
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
                        SizedBox(width: Responsive.w(6)),
                        Text(
                          formatFriendlyDate(experience.createdOn),
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
                          SizedBox(width: Responsive.w(4)),
                          Text(
                            '+15 Pts',
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
          ),
        ),
      ),
    );
  }
}
