import 'package:Doctors_App/features/testimonial/model/experience_model.dart';
import 'package:Doctors_App/features/testimonial/ui/widget/share_testimonial_form.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';

class ExperienceListScreen extends StatefulWidget {
  const ExperienceListScreen({super.key});

  @override
  State<ExperienceListScreen> createState() => _ExperienceListScreenState();
}

class _ExperienceListScreenState extends State<ExperienceListScreen> {
  final List<ExperienceModel> experiences = [
    ExperienceModel(
      name: 'Dr. Paresh Mathur',
      speciality: 'Orthopedic Surgeon',
      experienceType: ExperienceType.text,
      experience:
          'Doctors Risk helped me handle a medico-legal issue professionally. Their guidance gave me confidence throughout the process.',
      addedOn: '15 Jul 2026',
    ),
    ExperienceModel(
      name: 'Dr. Neha Sharma',
      speciality: 'Dermatologist',
      experienceType: ExperienceType.video,
      experience: 'https://sample-videos.com/video123.mp4',
      addedOn: '10 Jul 2026',
    ),
  ];

  Future<void> _openShareForm() async {
    final result = await Navigator.push<ExperienceModel>(
      context,
      MaterialPageRoute(builder: (_) => const ShareTestimonialForm()),
    );

    // If ShareTestimonialForm returns the newly created testimonial,
    // add it to the list and refresh the UI.
    if (result != null) {
      setState(() {
        experiences.insert(0, result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'addExperience',
        backgroundColor: AppColors.newPri,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Share Experience'),
        onPressed: _openShareForm,
      ),

      body: experiences.isEmpty
          ? const Center(child: Text('No experiences shared yet'))
          : ListView.separated(
              padding: EdgeInsets.all(Responsive.w(16)),
              itemCount: experiences.length,
              separatorBuilder: (_, __) => height(Responsive.h(14)),
              itemBuilder: (_, index) => _buildCard(experiences[index]),
            ),
    );
  }
}

Widget _buildCard(ExperienceModel experience) {
  final isVideo = experience.experienceType == ExperienceType.video;

  // Guard against empty/blank names so `.characters.first` never throws.
  final trimmedName = experience.name.trim().replaceFirst('Dr. ', '').trim();
  final avatarLetter = trimmedName.isNotEmpty
      ? trimmedName.characters.first.toUpperCase()
      : '?';

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
                avatarLetter,
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
                    experience.name,
                    style: customTextStyle(
                      fontSize: Responsive.sp(13),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  Text(
                    '${experience.speciality} · ${experience.addedOn}',
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              experience.experienceType == ExperienceType.video
                  ? Icons.videocam_rounded
                  : Icons.format_quote_rounded,
              color: AppColors.newPri,
            ),
          ],
        ),
        height(Responsive.h(12)),
        if (isVideo)
          GestureDetector(
            onTap: () {
              // TODO: hook up video playback
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Responsive.w(14)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Icon(
                        Icons.video_library_rounded,
                        size: 70,
                        color: Colors.grey.shade300,
                      ),
                      const Center(
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.red,
                            size: 34,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        else
          Text(
            experience.experience,
            style: customTextStyle(
              fontSize: Responsive.sp(13),
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w400,
            ).copyWith(height: 1.5),
          ),
        height(Responsive.h(12)),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.share_rounded, size: 18),
            label: const Text('Share'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.newPri,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
