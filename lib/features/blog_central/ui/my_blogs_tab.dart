// ui/my_blogs_tab.dart
import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/blog_central/ui/viewmodel/blog_view_model.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../home/ui/widgets/social_link_widget.dart';

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

    return mySubmissionsAsync.when(
      loading: () => const Center(child: Loading()),
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
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(blogViewModelProvider.notifier).refreshMySubmissions(),
            child: ListView(
              children: const [
                SizedBox(height: 120),
                Center(child: Text('You haven\'t submitted any blogs yet')),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () =>
              ref.read(blogViewModelProvider.notifier).refreshMySubmissions(),
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(
              Responsive.w(16),
              0,
              Responsive.w(16),
              Responsive.h(24),
            ),
            itemCount: blogs.length + 2, // +1 header, +1 social footer
            separatorBuilder: (_, index) =>
                index == 0 ? const SizedBox.shrink() : height(Responsive.h(14)),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildTableHeader();
              }

              final blogIndex = index - 1;

              if (blogIndex == blogs.length) {
                return Column(
                  children: [
                    const SocialLinkWidget(),
                    height(Responsive.h(30)),
                  ],
                );
              }

              final blog = blogs[blogIndex];
              return _buildBlogCard(context, blog);
            },
          ),
        );
      },
    );
  }

  // Grey uppercase column labels, mirroring the web table's
  // TITLE / STATUS / POINTS / DATE / ACTION header row.
  Widget _buildTableHeader() {
    final labelStyle = customTextStyle(
      fontSize: Responsive.sp(9.5),
      fontWeight: FontWeight.w700,
      color: Colors.grey.shade500,
    ).copyWith(letterSpacing: 0.4);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(4)),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text('STATUS', style: labelStyle)),
          Expanded(child: Text('POINTS', style: labelStyle)),
          Expanded(flex: 2, child: Text('DATE', style: labelStyle)),
          SizedBox(
            width: Responsive.w(46),
            child: Text(
              'ACTION',
              style: labelStyle,
              textAlign: TextAlign.right,
            ),
          ),
        ],
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

  // ui/my_blogs_tab.dart — _buildBlogCard replaced entirely, rest of file unchanged
  Widget _buildBlogCard(BuildContext context, dynamic blog) {
    final String approveStatus =
        blog.approveStatus ?? 'awaiting_admin_approval';

    late final String statusLabel;
    late final Color statusColor;
    switch (approveStatus) {
      case 'approved':
        statusLabel = 'Approved';
        statusColor = const Color(0xFF10B981);
        break;
      case 'rejected':
        statusLabel = 'Not Approved';
        statusColor = const Color(0xFFEF4444);
        break;
      case 'awaiting_admin_approval':
      default:
        statusLabel = 'Awaiting Admin Approval';
        statusColor = const Color(0xFFF59E0B);
    }

    final isRejected = approveStatus == 'rejected';

    final valueStyle = customTextStyle(
      fontSize: Responsive.sp(11.5),
      fontWeight: FontWeight.w600,
      color: Colors.grey.shade700,
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Responsive.w(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title — same as the web's TITLE column, but full width since
            // titles are long and this is a narrower viewport.
            Text(
              blog.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: customTextStyle(
                fontSize: Responsive.sp(14),
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ).copyWith(height: 1.4),
            ),
            if ((blog.description ?? '').toString().isNotEmpty) ...[
              height(Responsive.h(6)),
              Text(
                blog.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: customTextStyle(
                  fontSize: Responsive.sp(11),
                  color: Colors.grey.shade600,
                ).copyWith(height: 1.45),
              ),
            ],
            height(Responsive.h(12)),
            Divider(height: 1, thickness: 1, color: Colors.grey.shade100),
            height(Responsive.h(10)),

            // Data row — STATUS / POINTS / DATE / ACTION, aligned to the
            // header row's column widths above.
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    statusLabel,
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                    ),
                  ),
                ),
                Expanded(child: Text(_pointsText(blog), style: valueStyle)),
                Expanded(
                  flex: 2,
                  child: Text(
                    (blog.createdOn ?? '').toString(),
                    style: valueStyle,
                  ),
                ),
                SizedBox(
                  width: Responsive.w(46),
                  child: GestureDetector(
                    onTap: () => context.push(Routes.addBlog),
                    child: Text(
                      'Edit',
                      textAlign: TextAlign.right,
                      style: customTextStyle(
                        fontSize: Responsive.sp(11.5),
                        fontWeight: FontWeight.w700,
                        color: AppColors.brandGreen,
                      ).copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),

            // Extra mobile-only context the web table doesn't show —
            // kept below the table row so it doesn't disrupt the match.
            if ((blog.viewCount ?? 0).toString() != '0') ...[
              height(Responsive.h(10)),
              Row(
                children: [
                  Icon(
                    Icons.remove_red_eye_outlined,
                    size: Responsive.sp(13),
                    color: Colors.grey.shade500,
                  ),
                  width(Responsive.w(5)),
                  Text(
                    '${blog.viewCount ?? '0'} views',
                    style: customTextStyle(
                      color: Colors.grey.shade600,
                      fontSize: Responsive.sp(10.5),
                    ),
                  ),
                ],
              ),
            ],
            if ((blog.keywords as List?)?.isNotEmpty ?? false) ...[
              height(Responsive.h(10)),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: (blog.keywords as List)
                    .map(
                      (k) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.w(9),
                          vertical: Responsive.h(4),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.newPri.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(Responsive.w(20)),
                        ),
                        child: Text(
                          k.keyword?.toString() ?? '', // KeywordModel.keyword
                          style: customTextStyle(
                            fontSize: Responsive.sp(9.5),
                            color: AppColors.newPri,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
            if (isRejected) ...[
              height(Responsive.h(14)),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.refresh_rounded,
                        size: Responsive.sp(16),
                        color: Colors.white,
                      ),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: Size(double.infinity, Responsive.h(40)),
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.w(12),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Responsive.w(10)),
                        ),
                      ),
                      label: Text(
                        'Resubmit',
                        style: customTextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.sp(11),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
