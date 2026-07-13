import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';

class NewsAdvisoryDetailsScreen extends StatelessWidget {
  const NewsAdvisoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'News & Advisory'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=1200',
              width: double.infinity,
              height: Responsive.h(220),
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Legal Update",
                      style: customTextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  height(16),

                  Text(
                    "Medical Negligence in Post-Operative Care: Supreme Court Issues Fresh Guidelines",
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
                        "15 January 2026",
                        style: customTextStyle(color: Colors.grey),
                      ),
                      Spacer(),
                      Icon(Icons.person_outline, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        "Doctor Risk Team",
                        style: customTextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  height(32),

                  Text(
                    "The Supreme Court has recently issued fresh guidelines regarding medical negligence in post-operative care. These guidelines emphasize the importance of maintaining complete patient records, ensuring timely follow-up consultations, and adhering to accepted standards of clinical practice.\n\n"
                    "Healthcare professionals are advised to maintain clear documentation of diagnosis, treatment plans, informed consent, discharge summaries, and post-operative instructions. Proper documentation can significantly reduce legal disputes while improving patient outcomes.\n\n"
                    "Medical practitioners should also ensure that patients receive adequate counselling regarding possible complications, medication schedules, and emergency contact procedures after surgery.\n\n"
                    "Experts recommend reviewing existing professional indemnity insurance policies to ensure adequate coverage against medico-legal risks. Hospitals and independent practitioners should periodically update their internal protocols to remain compliant with the latest legal and regulatory requirements.\n\n"
                    "Doctor Risk will continue to monitor important legal developments and provide timely advisories to help healthcare professionals stay informed and protected.",
                    style: customTextStyle(
                      fontSize: 12,
                      color: Color(0xff374151),
                    ).copyWith(height: 1.8),
                  ),

                  height(24),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _tag("Medical Negligence"),
                      _tag("Legal"),
                      _tag("Insurance"),
                      _tag("Doctors"),
                      _tag("Supreme Court"),
                    ],
                  ),

                  height(30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(text, style: customTextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
