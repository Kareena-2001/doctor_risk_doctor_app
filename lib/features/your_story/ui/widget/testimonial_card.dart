import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/media_preview_tiles.dart';
import 'package:Doctors_App/features/your_story/model/testimonial_response.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/formatters.dart';

class TestimonialCard extends StatelessWidget {
  const TestimonialCard({super.key, required this.testimonial});

  final TestimonialData testimonial;

  String _initial(String name) {
    final cleanName = name.trim();
    if (cleanName.isEmpty) return 'D';

    final parts = cleanName.split(RegExp(r'\s+'));
    final target = parts.length >= 2 ? parts[1] : parts.first;
    return target.isEmpty ? 'D' : target.substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final type = testimonial.testimonialType.toLowerCase();
    final isVideo = type == 'video';
    final isDocument = type == 'document';

    final name = testimonial.drName?.trim().isNotEmpty == true
        ? testimonial.drName!.trim()
        : 'Doctor';

    final speciality = testimonial.specialityName?.trim().isNotEmpty == true
        ? testimonial.specialityName!.trim()
        : 'Medical Professional';

    final content = testimonial.details.trim();
    final date = formatFriendlyDate(testimonial.createdOn, emptyFallback: '');
    final file = testimonial.file?.trim() ?? '';

    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: Responsive.w(18),
                backgroundColor: AppColors.newPri.withValues(alpha: 0.1),
                child: Text(
                  _initial(name),
                  style: customTextStyle(
                    color: AppColors.newPri,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              width(Responsive.w(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: customTextStyle(
                        fontSize: Responsive.sp(13),
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    Text(
                      date.isEmpty ? speciality : '$speciality · $date',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: customTextStyle(
                        fontSize: Responsive.sp(11),
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                isVideo
                    ? Icons.videocam_rounded
                    : isDocument
                    ? Icons.picture_as_pdf_rounded
                    : Icons.format_quote_rounded,
                size: Responsive.sp(18),
                color: AppColors.newPri,
              ),
            ],
          ),
          height(Responsive.h(12)),
          if (isVideo)
            VideoPreviewTile(videoUrl: file, title: name)
          else if (isDocument)
            DocumentPreviewTile(fileUrl: file, label: 'Testimonial document')
          else if (content.isNotEmpty)
            Text(
              content,
              style: customTextStyle(
                fontSize: Responsive.sp(13),
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w400,
              ).copyWith(height: 1.5),
            )
          else
            Text(
              'No testimonial details available.',
              style: customTextStyle(
                fontSize: Responsive.sp(13),
                color: Colors.grey.shade500,
              ),
            ),
        ],
      ),
    );
  }
}
