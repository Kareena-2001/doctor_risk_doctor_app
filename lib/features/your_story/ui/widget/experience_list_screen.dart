import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/core/widgets/common_error_state.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/your_story/model/experience_response.dart';
import 'package:Doctors_App/features/your_story/ui/viewmodel/your_story_view_model.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'addExperience',
        backgroundColor: AppColors.newPri,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Share Experience'),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ShareExperienceForm()),
          );

          await ref
              .read(yourStoryViewModelProvider.notifier)
              .refreshExperienceList();
        },
      ),
      body: experiencesAsync.when(
        loading: () => const Center(child: Loading()),
        error: (error, stackTrace) => Center(
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
                final experience = experiences[index];

                return _buildExperienceCard(context, experience);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildExperienceCard(BuildContext context, ExperienceData experience) {
    final rawStatus = (experience.approveStatus ?? 'awaiting_admin_approval')
        .toLowerCase()
        .trim();

    late final String statusLabel;
    late final Color statusColor;
    late final Color statusBgColor;

    switch (rawStatus) {
      case 'published':
      case 'approved':
      case 'published_to_forum':
      case 'published to forum':
        statusLabel = 'Published';
        statusColor = const Color(0xFF15803D);
        statusBgColor = const Color(0xFFDCFCE7);
        break;

      case 'rejected':
      case 'not_approved':
      case 'not approved':
        statusLabel = 'Not Approved';
        statusColor = const Color(0xFFB91C1C);
        statusBgColor = const Color(0xFFFEE2E2);
        break;

      case 'draft':
        statusLabel = 'Draft';
        statusColor = const Color(0xFF4B5563);
        statusBgColor = const Color(0xFFF3F4F6);
        break;

      case 'awaiting_admin_approval':
      case 'awaiting admin approval':
      default:
        statusLabel = 'Awaiting Admin Approval';
        statusColor = const Color(0xFFB45309);
        statusBgColor = const Color(0xFFFEF3C7);
        break;
    }

    final trimmedName = (experience.drName ?? '')
        .trim()
        .replaceFirst('Dr. ', '')
        .trim();

    final avatarLetter = trimmedName.isNotEmpty
        ? trimmedName.characters.first.toUpperCase()
        : '?';

    final isVideo = experience.experienceType.toLowerCase() == 'video';

    return Container(
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(14)),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor information
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: Responsive.w(18),
                backgroundColor: AppColors.newPri.withValues(alpha: 0.1),
                child: Text(
                  avatarLetter,
                  style: customTextStyle(
                    fontSize: Responsive.sp(13),
                    fontWeight: FontWeight.bold,
                    color: AppColors.newPri,
                  ),
                ),
              ),

              width(Responsive.w(10)),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.drName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: customTextStyle(
                        fontSize: Responsive.sp(13),
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),

                    height(Responsive.h(2)),

                    Text(
                      experience.specialityName ?? '',
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
                isVideo ? Icons.videocam_rounded : Icons.format_quote_rounded,
                color: AppColors.newPri,
                size: Responsive.sp(22),
              ),
            ],
          ),

          height(Responsive.h(12)),

          // Title
          Text(
            experience.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
            ).copyWith(height: 1.3),
          ),

          height(Responsive.h(10)),

          // Approval status
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(8),
              vertical: Responsive.h(4),
            ),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(Responsive.w(12)),
            ),
            child: Text(
              statusLabel,
              style: customTextStyle(
                fontSize: Responsive.sp(10.5),
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),

          height(Responsive.h(12)),

          Divider(height: 1, thickness: 1, color: const Color(0xFFF3F4F6)),

          height(Responsive.h(10)),

          // Experience content
          if (isVideo && experience.file != null)
            _buildVideoPlaceholder(experience)
          else
            Text(
              experience.details,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: customTextStyle(
                fontSize: Responsive.sp(13),
                color: Colors.grey.shade700,
              ).copyWith(height: 1.5),
            ),

          height(Responsive.h(12)),

          // Date
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: Responsive.sp(12),
                color: const Color(0xFF9CA3AF),
              ),
              width(Responsive.w(4)),
              Expanded(
                child: Text(
                  experience.createdOn ?? 'N/A',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: customTextStyle(
                    fontSize: Responsive.sp(11),
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlaceholder(ExperienceData experience) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Responsive.w(12)),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.black12,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(
                Icons.video_library_rounded,
                size: 60,
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
    );
  }
}
