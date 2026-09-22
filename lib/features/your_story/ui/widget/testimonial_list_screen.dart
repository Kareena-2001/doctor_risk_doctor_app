import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/your_story/ui/viewmodel/your_story_view_model.dart';
import 'package:Doctors_App/features/your_story/ui/widget/add_testimonial_form.dart';
import 'package:Doctors_App/features/your_story/ui/widget/testimonial_card.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestimonialListScreen extends ConsumerStatefulWidget {
  const TestimonialListScreen({super.key});

  @override
  ConsumerState<TestimonialListScreen> createState() =>
      _TestimonialListScreenState();
}

class _TestimonialListScreenState extends ConsumerState<TestimonialListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(yourStoryViewModelProvider.notifier).testimonialList(),
    );
  }

  Future<void> _openShareForm() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddTestimonialForm()),
    );

    if (!mounted) return;
    await ref
        .read(yourStoryViewModelProvider.notifier)
        .refreshTestimonialList();
  }

  @override
  Widget build(BuildContext context) {
    final testimonialState = ref.watch(
      yourStoryViewModelProvider.select((s) => s.testimonialList),
    );

    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      body: testimonialState.when(
        loading: () => const Center(child: Loading()),
        error: (error, _) => _buildError(error),
        data: (response) {
          final testimonials = response?.data ?? [];

          if (testimonials.isEmpty) {
            return _buildEmpty();
          }

          return RefreshIndicator(
            onRefresh: () => ref
                .read(yourStoryViewModelProvider.notifier)
                .refreshTestimonialList(),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(Responsive.w(16)),
              itemCount: testimonials.length,
              separatorBuilder: (_, __) => height(Responsive.h(14)),
              itemBuilder: (_, index) =>
                  TestimonialCard(testimonial: testimonials[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addExperience',
        backgroundColor: AppColors.newPri,
        foregroundColor: Colors.white,
        elevation: 5,
        shape: const CircleBorder(),
        onPressed: _openShareForm,
        child: Icon(Icons.add_rounded, size: Responsive.sp(26)),
      ),
    );
  }

  Widget _buildError(Object error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Responsive.w(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: Responsive.sp(42),
              color: AppColors.cardRed,
            ),
            height(Responsive.h(12)),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: customTextStyle(
                fontSize: Responsive.sp(13),
                color: context.secondaryTextColor,
              ),
            ),
            height(Responsive.h(16)),
            OutlinedButton(
              onPressed: () => ref
                  .read(yourStoryViewModelProvider.notifier)
                  .testimonialList(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return RefreshIndicator(
      onRefresh: () => ref
          .read(yourStoryViewModelProvider.notifier)
          .refreshTestimonialList(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: Responsive.h(180)),
          Icon(
            Icons.format_quote_rounded,
            size: Responsive.sp(52),
            color: AppColors.newPri.withValues(alpha: 0.35),
          ),
          height(Responsive.h(14)),
          Center(
            child: Text(
              'No testimonials yet',
              style: customTextStyle(
                fontSize: Responsive.sp(16),
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
          ),
          height(Responsive.h(6)),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.w(40)),
              child: Text(
                'Be the first to share your experience with the DoctorsRisk community.',
                textAlign: TextAlign.center,
                style: customTextStyle(
                  fontSize: Responsive.sp(12.5),
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
