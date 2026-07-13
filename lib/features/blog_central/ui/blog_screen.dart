import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blogs = [
      (
        title: 'Why Every Doctor Needs Professional Indemnity Insurance',
        category: 'Insurance',
        date: '12 Jan 2026',
      ),
      (
        title: '5 Ways to Reduce Medico-Legal Risks in Your Practice',
        category: 'Medico Legal',
        date: '20 Jan 2026',
      ),
      (
        title: 'Common Reasons Why Insurance Claims Get Rejected',
        category: 'Claims',
        date: '28 Jan 2026',
      ),
      (
        title: 'Digital Medical Records: Best Practices for Doctors',
        category: 'Practice Management',
        date: '05 Feb 2026',
      ),
      (
        title: 'How to Handle a Legal Notice from a Patient',
        category: 'Legal',
        date: '10 Feb 2026',
      ),
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Blogs'),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: blogs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (_, index) {
          final blog = blogs[index];

          return InkWell(
            onTap: () {
              context.push(Routes.blogCentralDetails);
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      'https://picsum.photos/600/300?random=$index',
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blog.category,
                          style: customTextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        height(8),
                        Text(
                          blog.title,
                          style: customTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ).copyWith(height: 1.4),
                        ),
                        height(10),
                        Text(
                          blog.date,
                          style: customTextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
