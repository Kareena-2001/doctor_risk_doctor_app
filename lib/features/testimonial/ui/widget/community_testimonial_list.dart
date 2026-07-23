import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/community/ui/add_testimonial_form.dart';
import 'package:Doctors_App/theme/app_colors.dart';

import 'package:flutter/material.dart';

import '../../../../core/constants/responsive.dart';
import '../../model/experience_model.dart';

class CommunityTestimonialsList extends StatefulWidget {
  const CommunityTestimonialsList({super.key});

  @override
  State<CommunityTestimonialsList> createState() =>
      _CommunityTestimonialsListState();
}

class _CommunityTestimonialsListState extends State<CommunityTestimonialsList> {
  final List<ExperienceModel> experiences = [];

  static final List<Map<String, dynamic>> _testimonials = [
    {
      'name': 'Dr. Anjali Mehta',
      'speciality': 'Orthopedics',
      'type': 'text',
      'content':
          'When I received a legal notice over a case I didn\'t even remember, the team guided me through every step. Having this cover gave me real peace of mind.',
      'date': '3 days ago',
    },
    {
      'name': 'Dr. Rohan Kulkarni',
      'speciality': 'General Surgery',
      'type': 'video',
      'content': null,
      'date': '1 week ago',
    },
    {
      'name': 'Dr. Sneha Rao',
      'speciality': 'Gynaecology',
      'type': 'text',
      'content':
          'The consultation before signing a fresh policy helped me understand exactly what was and wasn\'t covered. No more guesswork.',
      'date': '2 weeks ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: EdgeInsets.all(Responsive.w(16)),
        itemCount: _testimonials.length,
        separatorBuilder: (_, __) => height(Responsive.h(14)),
        itemBuilder: (_, index) => _buildCard(_testimonials[index]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'addExperience',
        backgroundColor: AppColors.newPri,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Share Testimonial'),
        onPressed: _openShareForm,
      ),
    );
  }

  Future<void> _openShareForm() async {
    final result = await Navigator.push<ExperienceModel>(
      context,
      MaterialPageRoute(builder: (_) => const AddTestimonialForm()),
    );

    if (result != null) {
      setState(() {
        _testimonials.insert(0, {
          'name': result.name,
          'speciality': result.speciality,
          'type': result.experienceType == ExperienceType.video
              ? 'video'
              : 'text',
          'content': result.experience,
          'date': result.addedOn,
        });
      });
    }
  }

  Widget _buildCard(Map<String, dynamic> t) {
    final isVideo = t['type'] == 'video';

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
                  (t['name'] as String).substring(4, 5),
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
                      t['name'],
                      style: customTextStyle(
                        fontSize: Responsive.sp(13),
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    Text(
                      '${t['speciality']} · ${t['date']}',
                      style: customTextStyle(
                        fontSize: Responsive.sp(11),
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                isVideo ? Icons.videocam_rounded : Icons.format_quote_rounded,
                size: Responsive.sp(18),
                color: AppColors.newPri,
              ),
            ],
          ),
          height(Responsive.h(12)),
          if (isVideo)
            ClipRRect(
              borderRadius: BorderRadius.circular(Responsive.w(14)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.black87,
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_fill_rounded,
                      color: Colors.white,
                      size: 46,
                    ),
                  ),
                ),
              ),
            )
          else
            Text(
              t['content'],
              style: customTextStyle(
                fontSize: Responsive.sp(13),
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w400,
              ).copyWith(height: 1.5),
            ),
        ],
      ),
    );
  }
}
