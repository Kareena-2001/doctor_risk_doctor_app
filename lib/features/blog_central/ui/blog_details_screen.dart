import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';

class BlogDetailsScreen extends StatelessWidget {
  const BlogDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Blog'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://picsum.photos/800/450',
              width: double.infinity,
              height: Responsive.h(240),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Insurance',
                      style: customTextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  height(16),
                  Text(
                    'Why Every Doctor Needs Professional Indemnity Insurance',
                    style: customTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ).copyWith(height: 1.4),
                  ),
                  height(14),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '12 January 2026',
                        style: customTextStyle(color: Colors.grey),
                      ),
                      Spacer(),
                      Icon(Icons.person_outline, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        'Doctor Risk Team',
                        style: customTextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  height(30),
                  Text(
                    'Professional indemnity insurance is one of the most important safeguards for healthcare professionals. Even experienced doctors may face allegations of medical negligence during their careers.\n\n'
                    'A comprehensive indemnity policy helps protect doctors against legal expenses, compensation claims, and professional liabilities arising from their medical practice.\n\n'
                    'Maintaining proper patient documentation, obtaining informed consent, and following standard clinical protocols can significantly reduce medico-legal risks. However, insurance provides an additional layer of financial protection when unexpected situations occur.\n\n'
                    'Doctors should periodically review their policy coverage, sum insured, exclusions, and renewal dates to ensure adequate protection as their practice grows.\n\n'
                    'Choosing the right insurance policy not only offers financial security but also allows healthcare professionals to focus on delivering quality patient care with confidence.',
                    style: customTextStyle(
                      fontSize: 12,
                      color: Color(0xff374151),
                    ).copyWith(height: 1.8),
                  ),
                  height(28),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _chip('Insurance'),
                      _chip('Doctors'),
                      _chip('Professional Indemnity'),
                      _chip('Risk Management'),
                      _chip('Healthcare'),
                    ],
                  ),
                  height(28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _chip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(text, style: customTextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
