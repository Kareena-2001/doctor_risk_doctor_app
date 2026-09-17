import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/common_error_state.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/community/ui/view_model/community_view_model.dart';
import 'package:Doctors_App/features/community/ui/widgets/testimonial_card.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllTestimonialListScreen extends ConsumerStatefulWidget {
  const AllTestimonialListScreen({super.key});

  @override
  ConsumerState<AllTestimonialListScreen> createState() =>
      _AllTestimonialListScreenState();
}

class _AllTestimonialListScreenState
    extends ConsumerState<AllTestimonialListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(communityViewModelProvider.notifier).allTestimonialList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final testimonialState = ref.watch(
      communityViewModelProvider.select((s) => s.testimonialList),
    );

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      body: testimonialState.when(
        loading: () => const Center(child: Loading()),
        error: (error, _) => _buildError(error),
        data: (response) {
          final testimonials = response.data ?? [];

          if (testimonials.isEmpty) {
            return _buildEmpty();
          }

          return RefreshIndicator(
            onRefresh: () => ref
                .read(communityViewModelProvider.notifier)
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
    );
  }

  Widget _buildError(Object error) {
    return Center(
      child: CommonErrorState(
        title: 'Failed to load your testimonial',
        message: error.toString(),
        onRetry: () {
          ref.read(communityViewModelProvider.notifier).refreshPeerForumList();
        },
      ),
    );
  }

  Widget _buildEmpty() {
    return RefreshIndicator(
      onRefresh: () => ref
          .read(communityViewModelProvider.notifier)
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
