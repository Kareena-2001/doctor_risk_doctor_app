import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/routes.dart';
import '../../home/ui/widgets/social_link_widget.dart';

class AllBlogsTab extends StatelessWidget {
  const AllBlogsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final blogs = [
      {
        'title':
            'Documenting Telemedicine Consults for Medico-Legal Defensibility',
        'content':
            'A practical guide to documenting telemedicine consultations clearly and safely while reducing medico-legal risks.',
        'date': '12 Jan 2026',
        'image': 'https://picsum.photos/600/300?random=1',
      },
      {
        'title': 'Handling Consent Discussions in Clinical Practice',
        'content':
            'Important points every doctor should consider while discussing informed consent with patients.',
        'date': '20 Jan 2026',
        'image': 'https://picsum.photos/600/300?random=2',
      },
      {
        'title': 'How to Maintain Better Medical Documentation',
        'content':
            'Simple documentation practices that can help doctors maintain accurate and useful medical records.',
        'date': '28 Jan 2026',
        'image': 'https://picsum.photos/600/300?random=3',
      },
      {
        'title': 'Managing Legal Notices from Patients',
        'content':
            'What doctors should know when they receive a legal notice and the steps they should consider taking.',
        'date': '05 Feb 2026',
        'image': 'https://picsum.photos/600/300?random=4',
      },
      {
        'title': 'Lessons Learned from a Difficult Patient Interaction',
        'content':
            'Sharing practical experience and learnings that may help other doctors handle similar situations.',
        'date': '10 Feb 2026',
        'image': 'https://picsum.photos/600/300?random=5',
      },
    ];

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        Responsive.w(16),
        0,
        Responsive.w(16),
        Responsive.h(24),
      ),
      itemCount: blogs.length + 1,
      separatorBuilder: (_, index) {
        return height(Responsive.h(14));
      },
      itemBuilder: (context, index) {
        if (index == blogs.length) {
          return Column(
            children: [SocialLinkWidget(), height(Responsive.h(30))],
          );
        }

        final blog = blogs[index];

        return _buildBlogCard(context, blog);
      },
    );
  }

  Widget _buildBlogCard(BuildContext context, Map<String, String> blog) {
    return InkWell(
      onTap: () {
        context.push(Routes.blogCentralDetails);
      },
      borderRadius: BorderRadius.circular(Responsive.w(16)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Responsive.w(16)),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Responsive.w(16)),
              ),
              child: Image.network(
                blog['image'] ?? '',
                width: double.infinity,
                height: Responsive.h(150),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: Responsive.h(150),
                    width: double.infinity,
                    color: Colors.grey.shade100,
                    child: Icon(
                      Icons.image_outlined,
                      size: Responsive.sp(40),
                      color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),

            // Blog Details
            Padding(
              padding: EdgeInsets.all(Responsive.w(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog['title'] ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: customTextStyle(
                      fontSize: Responsive.sp(14),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ).copyWith(height: 1.4),
                  ),

                  height(Responsive.h(8)),

                  Text(
                    blog['content'] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: Colors.grey.shade600,
                    ).copyWith(height: 1.45),
                  ),

                  height(Responsive.h(10)),

                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: Responsive.sp(13),
                        color: Colors.grey.shade500,
                      ),
                      width(Responsive.w(5)),
                      Text(
                        blog['date'] ?? '',
                        style: customTextStyle(
                          fontSize: Responsive.sp(10.5),
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
