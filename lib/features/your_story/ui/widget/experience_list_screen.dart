import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/core/widgets/common_error_state.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/your_story/ui/viewmodel/your_story_view_model.dart';
import 'package:Doctors_App/features/your_story/ui/widget/experience_card.dart';
import 'package:Doctors_App/features/your_story/ui/widget/share_experience_form.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExperienceListScreen extends ConsumerStatefulWidget {
  const ExperienceListScreen({super.key});

  @override
  ConsumerState<ExperienceListScreen> createState() =>
      _ExperienceListScreenState();
}

class _ExperienceListScreenState extends ConsumerState<ExperienceListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(yourStoryViewModelProvider.notifier).experienceList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final experiencesAsync = ref.watch(
      yourStoryViewModelProvider.select((s) => s.experienceList),
    );

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addExperience',
        backgroundColor: AppColors.newPri,
        foregroundColor: Colors.white,
        elevation: 5,
        shape: const CircleBorder(),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ShareExperienceForm()),
          );

          await ref
              .read(yourStoryViewModelProvider.notifier)
              .refreshExperienceList();
        },
        child: Icon(Icons.add_rounded, size: Responsive.sp(26)),
      ),
      body: experiencesAsync.when(
        loading: () => const Center(child: Loading()),
        error: (error, _) => Center(
          child: CommonErrorState(
            title: 'Failed to load your experiences',
            message: error.toString(),
            onRetry: () {
              ref
                  .read(yourStoryViewModelProvider.notifier)
                  .refreshExperienceList();
            },
          ),
        ),
        data: (response) {
          final experiences = response?.data ?? [];

          if (experiences.isEmpty) {
            return AppRefreshIndicator(
              onRefresh: () => ref
                  .read(yourStoryViewModelProvider.notifier)
                  .refreshExperienceList(),
              child: ListView(
                children: [
                  SizedBox(height: Responsive.h(120)),
                  Center(
                    child: Text(
                      'You haven\'t shared any experiences yet',
                      style: customTextStyle(
                        fontSize: Responsive.sp(13),
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return AppRefreshIndicator(
            onRefresh: () => ref
                .read(yourStoryViewModelProvider.notifier)
                .refreshExperienceList(),
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(
                Responsive.w(16),
                Responsive.h(16),
                Responsive.w(16),
                Responsive.h(24),
              ),
              itemCount: experiences.length,
              separatorBuilder: (_, __) => height(Responsive.h(14)),
              itemBuilder: (context, index) {
                return ExperienceCard(experience: experiences[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
