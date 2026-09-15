import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/your_story/model/testimonial_response.dart';
import 'package:Doctors_App/features/your_story/ui/viewmodel/your_story_view_model.dart';
import 'package:Doctors_App/features/your_story/ui/widget/add_testimonial_form.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
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

    Future.microtask(() {
      ref.read(yourStoryViewModelProvider.notifier).testimonialList();
    });
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
    final state = ref.watch(yourStoryViewModelProvider);
    final testimonialState = state.testimonialList;

    return Scaffold(
      body: testimonialState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _buildError(error),
        data: (response) {
          final testimonials = response?.data ?? [];

          if (testimonials.isEmpty) {
            return _buildEmpty();
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(yourStoryViewModelProvider.notifier)
                  .refreshTestimonialList();
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(Responsive.w(16)),
              itemCount: testimonials.length,
              separatorBuilder: (_, __) => height(Responsive.h(14)),
              itemBuilder: (_, index) {
                return _buildCard(testimonials[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'addTestimonial',
        backgroundColor: AppColors.newPri,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Share Testimonial'),
        onPressed: _openShareForm,
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
                color: Colors.grey.shade700,
              ),
            ),
            height(Responsive.h(16)),
            OutlinedButton(
              onPressed: () {
                ref.read(yourStoryViewModelProvider.notifier).testimonialList();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return RefreshIndicator(
      onRefresh: () async {
        await ref
            .read(yourStoryViewModelProvider.notifier)
            .refreshTestimonialList();
      },
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

  Widget _buildCard(TestimonialData testimonial) {
    final type = testimonial.testimonialType.toLowerCase();

    final isVideo = type == 'video';
    final isDocument = type == 'document';

    final name = testimonial.drName?.trim().isNotEmpty == true
        ? testimonial.drName!.trim()
        : 'Doctor';

    final speciality = testimonial.specialityName?.trim().isNotEmpty == true
        ? testimonial.specialityName!.trim()
        : 'Medical Professional';

    final content = testimonial.details.trim();

    final date = _formatDate(testimonial.createdOn);

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
                  _initial(name),
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
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: customTextStyle(
                        fontSize: Responsive.sp(13),
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    Text(
                      date.isEmpty ? speciality : '$speciality · $date',
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
                isVideo
                    ? Icons.videocam_rounded
                    : isDocument
                    ? Icons.picture_as_pdf_rounded
                    : Icons.format_quote_rounded,
                size: Responsive.sp(18),
                color: AppColors.newPri,
              ),
            ],
          ),
          height(Responsive.h(12)),
          if (isVideo)
            _buildVideoCard(testimonial)
          else if (isDocument)
            _buildDocumentCard(testimonial)
          else if (content.isNotEmpty)
            Text(
              content,
              style: customTextStyle(
                fontSize: Responsive.sp(13),
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w400,
              ).copyWith(height: 1.5),
            )
          else
            Text(
              'No testimonial details available.',
              style: customTextStyle(
                fontSize: Responsive.sp(13),
                color: Colors.grey.shade500,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(TestimonialData testimonial) {
    return GestureDetector(
      onTap: () {
        final file = testimonial.file;

        if (file == null || file.isEmpty) {
          return;
        }

        // Open video URL here if you have a video player screen.
      },
      child: ClipRRect(
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
      ),
    );
  }

  Widget _buildDocumentCard(TestimonialData testimonial) {
    return Container(
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.picture_as_pdf_rounded,
            color: Colors.red,
            size: Responsive.sp(30),
          ),
          width(Responsive.w(10)),
          Expanded(
            child: Text(
              'Testimonial document',
              style: customTextStyle(
                fontSize: Responsive.sp(12.5),
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ),
          if (testimonial.file?.isNotEmpty == true)
            Icon(
              Icons.open_in_new_rounded,
              size: Responsive.sp(18),
              color: AppColors.newPri,
            ),
        ],
      ),
    );
  }

  String _initial(String name) {
    final cleanName = name.trim();

    if (cleanName.isEmpty) {
      return 'D';
    }

    final parts = cleanName.split(RegExp(r'\s+'));

    if (parts.length >= 2) {
      return parts[1].substring(0, 1).toUpperCase();
    }

    return parts.first.substring(0, 1).toUpperCase();
  }

  String _formatDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '';
    }

    try {
      final date = DateTime.parse(value.replaceFirst(' ', 'T'));

      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (_) {
      return value;
    }
  }
}
