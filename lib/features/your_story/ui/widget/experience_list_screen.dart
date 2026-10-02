import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/exceptions/exception_extension.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/core/widgets/common_error_state.dart';
import 'package:Doctors_App/core/widgets/pagination_footer.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/your_story/model/experience_response.dart';
import 'package:Doctors_App/features/your_story/ui/viewmodel/your_story_view_model.dart';
import 'package:Doctors_App/features/your_story/ui/widget/experience_card.dart';
import 'package:Doctors_App/features/your_story/ui/widget/share_experience_form.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExperienceListScreen extends ConsumerStatefulWidget {
  const ExperienceListScreen({super.key});

  @override
  ConsumerState<ExperienceListScreen> createState() =>
      _ExperienceListScreenState();
}

class _ExperienceListScreenState extends ConsumerState<ExperienceListScreen> {
  int? _deletingExperienceId;
  bool _loadingMore = false;
  String? _paginationError;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(yourStoryViewModelProvider.notifier).experienceList(),
    );
  }

  Future<void> _openExperienceForm({ExperienceData? experience}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ShareExperienceForm(experience: experience),
      ),
    );

    if (!mounted) return;
    await ref.read(yourStoryViewModelProvider.notifier).refreshExperienceList();
  }

  Future<void> _confirmDelete(ExperienceData experience) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Delete experience?'),
        content: Text(
          '“${experience.title.trim().isEmpty ? 'Untitled experience' : experience.title.trim()}” will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _deletingExperienceId = experience.id);

    try {
      await ref
          .read(yourStoryViewModelProvider.notifier)
          .deleteExperience(experience.id);

      if (!mounted) return;
      context.showSuccessSnackBar('Experience deleted successfully');
      await ref
          .read(yourStoryViewModelProvider.notifier)
          .refreshExperienceList();
    } catch (error) {
      if (mounted) {
        context.showErrorSnackBar(error);
      }
    } finally {
      if (mounted) {
        setState(() => _deletingExperienceId = null);
      }
    }
  }

  Future<void> _loadMore() async {
    setState(() {
      _loadingMore = true;
      _paginationError = null;
    });
    try {
      await ref.read(yourStoryViewModelProvider.notifier).loadMoreExperiences();
    } catch (error) {
      _paginationError = error.readableMessage;
    } finally {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final experiencesAsync = ref.watch(
      yourStoryViewModelProvider.select((s) => s.experienceList),
    );

    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      floatingActionButton: FloatingActionButton(
        heroTag: 'addExperience',
        backgroundColor: AppColors.newPri,
        foregroundColor: Colors.white,
        elevation: 5,
        shape: const CircleBorder(),
        onPressed: () => _openExperienceForm(),
        child: Icon(Icons.add_rounded, size: Responsive.sp(26)),
      ),
      body: experiencesAsync.when(
        loading: () => const Center(child: Loading()),
        error: (error, _) => Center(
          child: CommonErrorState(
            title: 'Failed to load your experiences',
            message: error.readableMessage,
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
                        color: context.secondaryTextColor,
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
              itemCount:
                  experiences.length +
                  ((response?.currentPage ?? 1) < (response?.lastPage ?? 1)
                      ? 1
                      : 0),
              separatorBuilder: (_, __) => height(Responsive.h(14)),
              itemBuilder: (context, index) {
                if (index == experiences.length) {
                  return PaginationFooter(
                    hasMore: true,
                    isLoading: _loadingMore,
                    errorMessage: _paginationError,
                    onLoadMore: _loadMore,
                  );
                }
                final experience = experiences[index];
                return ExperienceCard(
                  experience: experience,
                  isDeleting: _deletingExperienceId == experience.id,
                  onEdit: () => _openExperienceForm(experience: experience),
                  onDelete: () => _confirmDelete(experience),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
