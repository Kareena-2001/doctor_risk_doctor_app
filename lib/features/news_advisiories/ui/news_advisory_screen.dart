import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';

class NewsAdvisoryScreen extends StatefulWidget {
  const NewsAdvisoryScreen({super.key});

  @override
  State<NewsAdvisoryScreen> createState() => _NewsAdvisoryScreenState();
}

class _NewsAdvisoryScreenState extends State<NewsAdvisoryScreen> {
  final List<_NewsItem> _news = const [
    _NewsItem(
      title:
          'Medical Negligence in Post-Operative Care: Supreme Court Issues Fresh Guidelines',
      date: 'Jan 2026',
      category: 'Legal Update',
      icon: Icons.gavel_rounded,
    ),
    _NewsItem(
      title:
          'NMC Revises Professional Ethics Guidelines for Registered Medical Practitioners',
      date: 'Feb 2026',
      category: 'Policy Watch',
      icon: Icons.policy_outlined,
    ),
    _NewsItem(
      title:
          'Professional Indemnity Insurance: Important Changes Every Doctor Should Know',
      date: 'Mar 2026',
      category: 'Insurance',
      icon: Icons.shield_outlined,
    ),
    _NewsItem(
      title: 'How to Avoid Common Documentation Errors During Claim Submission',
      date: 'Apr 2026',
      category: 'Claims',
      icon: Icons.description_outlined,
    ),
    _NewsItem(
      title: 'Medical Council Issues Advisory on Digital Consultation Records',
      date: 'May 2026',
      category: 'Advisory',
      icon: Icons.health_and_safety_outlined,
    ),
    _NewsItem(
      title:
          'Cyber Security Advisory for Hospitals and Independent Practitioners',
      date: 'Jun 2026',
      category: 'Security',
      icon: Icons.security_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'News & Advisories'),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _news.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _news[index];

          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              context.push(Routes.newsAdvisoryDetails);
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: AppColors.newPri.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(item.icon, color: AppColors.newPri),
                  ),
                  width(14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: customTextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        height(8),
                        Text(
                          '${item.date} • ${item.category}',
                          style: customTextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NewsItem {
  final String title;
  final String date;
  final String category;
  final IconData icon;

  const _NewsItem({
    required this.title,
    required this.date,
    required this.category,
    required this.icon,
  });
}
