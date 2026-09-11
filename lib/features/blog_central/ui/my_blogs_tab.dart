import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/features/blog_central/ui/viewmodel/blog_view_model.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/custom_app_bar.dart';
import '../../home/ui/widgets/social_link_widget.dart';
import '../model/my_submission_list_model.dart';

class MyBlogsTab extends ConsumerStatefulWidget {
  const MyBlogsTab({super.key});

  @override
  ConsumerState<MyBlogsTab> createState() => _MyBlogsTabState();
}

class _MyBlogsTabState extends ConsumerState<MyBlogsTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(blogViewModelProvider.notifier).fetchMySubmissions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mySubmissionsAsync = ref.watch(
      blogViewModelProvider.select((s) => s.mySubmissions),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'My Submissions & Rewards',
        subTitle:
            'Only visible to you. Track your own articles through the approval workflow',
      ),
      body: mySubmissionsAsync.when(
        loading: () => Center(child: Loading()),
        error: (e, st) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Failed to load your blogs: $e'),
              TextButton(
                onPressed: () => ref
                    .read(blogViewModelProvider.notifier)
                    .refreshMySubmissions(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (response) {
          final blogs = response?.data ?? [];

          if (blogs.isEmpty) {
            return AppRefreshIndicator(
              onRefresh: () => ref
                  .read(blogViewModelProvider.notifier)
                  .refreshMySubmissions(),
              child: ListView(
                children: [
                  SizedBox(height: Responsive.h(120)),
                  Center(child: Text('You haven\'t submitted any blogs yet')),
                ],
              ),
            );
          }

          return AppRefreshIndicator(
            onRefresh: () =>
                ref.read(blogViewModelProvider.notifier).refreshMySubmissions(),
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(
                Responsive.w(16),
                Responsive.h(16),
                Responsive.w(16),
                Responsive.h(24),
              ),
              itemCount: blogs.length + 1,
              separatorBuilder: (_, index) => height(Responsive.h(14)),
              itemBuilder: (context, index) {
                if (index == blogs.length) {
                  return Column(
                    children: [
                      const SocialLinkWidget(),
                      height(Responsive.h(30)),
                    ],
                  );
                }
                final SubmissionModel blog = blogs[index];
                return _buildBlogCard(context, blog);
              },
            ),
          );
        },
      ),
    );
  }

  String _pointsText(dynamic blog) {
    try {
      final p = blog.points;
      if (p == null) return '—';
      return p.toString();
    } catch (_) {
      return '—';
    }
  }

  Widget _buildBlogCard(BuildContext context, SubmissionModel blog) {
    final String rawStatus = (blog.approveStatus ?? 'awaiting_admin_approval')
        .toString()
        .toLowerCase()
        .trim();

    final bool canEdit =
        rawStatus == 'draft' ||
        rawStatus == 'awaiting_admin_approval' ||
        rawStatus == 'awaiting admin approval';

    late final String statusLabel;
    late final Color statusColor;
    late final Color statusBgColor;

    switch (rawStatus) {
      case 'published_to_forum':
      case 'published to forum':
      case 'approved':
      case 'published':
        statusLabel = 'Published to Forum';
        statusColor = const Color(0xFF15803D);
        statusBgColor = const Color(0xFFDCFCE7);
        break;
      case 'draft':
        statusLabel = 'Draft';
        statusColor = const Color(0xFF4B5563);
        statusBgColor = const Color(0xFFF3F4F6);
        break;
      case 'rejected':
      case 'not_approved':
        statusLabel = 'Not Approved';
        statusColor = const Color(0xFFB91C1C);
        statusBgColor = const Color(0xFFFEE2E2);
        break;
      case 'awaiting_admin_approval':
      case 'awaiting admin approval':
      default:
        statusLabel = 'Awaiting Admin Approval';
        statusColor = const Color(0xFFB45309);
        statusBgColor = const Color(0xFFFEF3C7);
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Responsive.w(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    blog.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: customTextStyle(
                      fontSize: Responsive.sp(14),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ).copyWith(height: 1.3),
                  ),
                ),
                width(Responsive.w(8)),
                GestureDetector(
                  onTap: () {
                    debugPrint(
                      'Edit tapped — canEdit=$canEdit, id=${blog.id}, type=${blog.runtimeType}',
                    );
                    if (canEdit) {
                      context.push(Routes.addBlog, extra: blog);
                    } else {
                      _showSubmissionDetailsDialog(context, blog.id.toString());
                    }
                  },
                  child: Text(
                    canEdit ? 'Edit' : 'View',
                    style: customTextStyle(
                      fontSize: Responsive.sp(12),
                      fontWeight: FontWeight.w600,
                      color: AppColors.newPri,
                    ).copyWith(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            height(Responsive.h(10)),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.w(8),
                vertical: Responsive.h(3),
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
            Divider(height: 1, thickness: 1, color: Color(0xFFF3F4F6)),
            height(Responsive.h(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: Responsive.sp(12),
                      color: const Color(0xFF9CA3AF),
                    ),
                    width(Responsive.w(4)),
                    Text(
                      // rawStatus == 'draft' ||
                      //         rawStatus == 'awaiting_admin_approval'
                      //     ? 'Last edited ${blog.updatedOn ?? 'N/A'}'
                      //     : (blog.createdOn ?? 'N/A').toString(),
                      blog.createdOn,
                      style: customTextStyle(
                        fontSize: Responsive.sp(11),
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Points: ',
                      style: customTextStyle(
                        fontSize: Responsive.sp(11),
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                    Text(
                      _pointsText(blog),
                      style: customTextStyle(
                        fontSize: Responsive.sp(11),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF374151),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSubmissionDetailsDialog(BuildContext context, String blogId) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Responsive.w(16)),
          ),
          insetPadding: EdgeInsets.all(Responsive.w(16)),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.75,
            ),
            padding: EdgeInsets.all(Responsive.w(16)),
            child: FutureBuilder(
              future: ref
                  .read(blogViewModelProvider.notifier)
                  .fetchMySubmissionDetails(blogId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 150,
                    child: Center(child: Loading()),
                  );
                }

                if (snapshot.hasError || snapshot.data == null) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Failed to load submission details'),
                      height(Responsive.h(12)),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  );
                }

                final responseData = snapshot.data!;
                final data = responseData.data;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Submission Detail',
                          style: customTextStyle(
                            fontSize: Responsive.sp(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    Divider(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (data.image != null &&
                                data.image!.isNotEmpty) ...[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Responsive.w(8),
                                ),
                                child: Image.network(
                                  data.image!,
                                  width: double.infinity,
                                  height: Responsive.h(160),
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const SizedBox.shrink(),
                                ),
                              ),
                              height(Responsive.h(12)),
                            ],
                            Text(
                              'Title',
                              style: customTextStyle(
                                fontSize: Responsive.sp(11),
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            height(Responsive.h(4)),
                            Text(
                              data.title,
                              style: customTextStyle(
                                fontSize: Responsive.sp(15),
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            height(Responsive.h(10)),

                            Text(
                              'Description',
                              style: customTextStyle(
                                fontSize: Responsive.sp(11),
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            height(Responsive.h(4)),
                            Text(
                              data.description,
                              style: customTextStyle(
                                fontSize: Responsive.sp(12),
                                color: const Color(0xFF4B5563),
                              ).copyWith(height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
