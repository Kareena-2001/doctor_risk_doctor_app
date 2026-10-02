import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/exceptions/exception_extension.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/core/widgets/pagination_footer.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/blog_central/ui/viewmodel/blog_view_model.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
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
  int? _deletingBlogId;
  bool _loadingMore = false;
  String? _paginationError;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(blogViewModelProvider.notifier).fetchMySubmissions(),
    );
  }

  Future<void> _loadMore() async {
    setState(() {
      _loadingMore = true;
      _paginationError = null;
    });
    try {
      await ref.read(blogViewModelProvider.notifier).loadMoreSubmissions();
    } catch (error) {
      _paginationError = error.readableMessage;
    } finally {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _loadingMore = false;
      _paginationError = null;
    });
    await ref.read(blogViewModelProvider.notifier).refreshMySubmissions();
  }

  @override
  Widget build(BuildContext context) {
    final mySubmissionsAsync = ref.watch(
      blogViewModelProvider.select((s) => s.mySubmissions),
    );

    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
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
              Text('Failed to load your blogs: ${e.readableMessage}'),
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
              onRefresh: _refresh,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount:
                    ref
                            .read(blogViewModelProvider.notifier)
                            .hasMoreSubmissions ||
                        _paginationError != null
                    ? 2
                    : 1,
                itemBuilder: (context, index) {
                  if (index == 1) {
                    return PaginationFooter(
                      hasMore: ref
                          .read(blogViewModelProvider.notifier)
                          .hasMoreSubmissions,
                      isLoading: _loadingMore,
                      errorMessage: _paginationError,
                      onLoadMore: _loadMore,
                    );
                  }
                  return SizedBox(
                    height: Responsive.h(200),
                    child: const Center(
                      child: Text('You haven\'t submitted any blogs yet'),
                    ),
                  );
                },
              ),
            );
          }

          return AppRefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(
                Responsive.w(16),
                Responsive.h(16),
                Responsive.w(16),
                Responsive.h(24),
              ),
              itemCount:
                  blogs.length +
                  (ref
                              .read(blogViewModelProvider.notifier)
                              .hasMoreSubmissions ||
                          _paginationError != null
                      ? 1
                      : 0) +
                  1,
              separatorBuilder: (_, index) => height(Responsive.h(14)),
              itemBuilder: (context, index) {
                final hasMore = ref
                    .read(blogViewModelProvider.notifier)
                    .hasMoreSubmissions;
                final hasFooter = hasMore || _paginationError != null;
                if (index == blogs.length && hasFooter) {
                  return PaginationFooter(
                    hasMore: hasMore,
                    isLoading: _loadingMore,
                    errorMessage: _paginationError,
                    onLoadMore: _loadMore,
                  );
                }
                if (index == blogs.length + (hasFooter ? 1 : 0)) {
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

  Future<void> _confirmAndDelete(SubmissionModel blog) async {
    final title = blog.title.trim().isEmpty
        ? 'Untitled blog'
        : blog.title.trim();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Delete blog?'),
        content: Text('“$title” will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text('Cancel'),
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

    setState(() => _deletingBlogId = blog.id);

    try {
      await ref.read(blogViewModelProvider.notifier).blogDelete(blog.id);

      if (!mounted) return;
      context.showSuccessSnackBar('Blog deleted successfully');
      await ref.read(blogViewModelProvider.notifier).refreshMySubmissions();
    } catch (error) {
      if (mounted) {
        context.showErrorSnackBar(error);
      }
    } finally {
      if (mounted) {
        setState(() => _deletingBlogId = null);
      }
    }
  }

  Widget _buildBlogCard(BuildContext context, SubmissionModel blog) {
    final String rawStatus = (blog.approveStatus ?? 'awaiting_admin_approval')
        .toString()
        .toLowerCase()
        .trim();

    final bool isDraft = rawStatus == 'draft';
    final bool isAwaiting =
        rawStatus == 'awaiting_admin_approval' ||
        rawStatus == 'awaiting admin approval';

    final bool canEdit = isDraft || (isAwaiting && blog.canEdit);
    final bool canDelete = isDraft;

    final bool showEdit = isDraft || (isAwaiting && blog.canEdit);
    final bool showDelete = isDraft;
    late final String statusLabel;
    late final Color statusColor;
    late final Color statusBgColor;

    final isDark = context.isDarkMode;

    switch (rawStatus) {
      case 'published_to_forum':
      case 'published to forum':
      case 'approved':
      case 'published':
        statusLabel = 'Published to Forum';
        statusColor = isDark
            ? const Color(0xFF57D485)
            : const Color(0xFF15803D);
        statusBgColor = isDark
            ? const Color(0xFF143522)
            : const Color(0xFFDCFCE7);
        break;

      case 'draft':
        statusLabel = 'Draft';
        statusColor = isDark ? AppColors.darkInk400 : const Color(0xFF4B5563);
        statusBgColor = isDark
            ? const Color(0xFF242A2D)
            : const Color(0xFFF3F4F6);
        break;

      case 'rejected':
      case 'not_approved':
        statusLabel = 'Not Approved';
        statusColor = isDark
            ? const Color(0xFFFF7777)
            : const Color(0xFFB91C1C);
        statusBgColor = isDark
            ? const Color(0xFF351B1D)
            : const Color(0xFFFEE2E2);
        break;

      case 'awaiting_admin_approval':
      case 'awaiting admin approval':
      default:
        statusLabel = 'Awaiting Admin Approval';
        statusColor = isDark
            ? const Color(0xFFFFC857)
            : const Color(0xFFB45309);
        statusBgColor = isDark
            ? const Color(0xFF352B17)
            : const Color(0xFFFEF3C7);
        break;
    }
    return Container(
      decoration: BoxDecoration(
        color: context.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: context.borderColor),
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
                    blog.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: customTextStyle(
                      fontSize: Responsive.sp(14),
                      fontWeight: FontWeight.bold,
                      color: context.primaryTextColor,
                    ).copyWith(height: 1.3),
                  ),
                ),
                width(Responsive.w(8)),
                if (showEdit)
                  GestureDetector(
                    onTap: () => context.push(Routes.addBlog, extra: blog),
                    child: Text(
                      'Edit',
                      style: customTextStyle(
                        fontSize: Responsive.sp(12),
                        fontWeight: FontWeight.w600,
                        color: AppColors.newPri,
                      ).copyWith(decoration: TextDecoration.underline),
                    ),
                  )
                else
                  GestureDetector(
                    onTap: () => _showSubmissionDetailsDialog(context, blog),
                    child: Text(
                      'View',
                      style: customTextStyle(
                        fontSize: Responsive.sp(12),
                        fontWeight: FontWeight.w600,
                        color: AppColors.newPri,
                      ).copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                if (showDelete) ...[
                  width(Responsive.w(12)),
                  GestureDetector(
                    onTap: _deletingBlogId == blog.id
                        ? null
                        : () => _confirmAndDelete(blog),
                    child: _deletingBlogId == blog.id
                        ? SizedBox(
                            width: Responsive.w(16),
                            height: Responsive.w(16),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Delete',
                            style: customTextStyle(
                              fontSize: Responsive.sp(12),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFB91C1C),
                            ).copyWith(decoration: TextDecoration.underline),
                          ),
                  ),
                ],
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
            Divider(height: 1, thickness: 1, color: context.borderColor),
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
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                    Text(
                      _pointsText(blog),
                      style: customTextStyle(
                        fontSize: Responsive.sp(11),
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF374151),
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

  void _showSubmissionDetailsDialog(
    BuildContext context,
    SubmissionModel blog,
  ) {
    final detailsFuture = ref
        .read(blogViewModelProvider.notifier)
        .fetchMySubmissionDetails(blog.id.toString());
    final keywords = blog.keywords
        .map((k) => k.keyword.trim())
        .where((k) => k.isNotEmpty)
        .toList();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: context.secondaryBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Responsive.w(16)),
          ),
          insetPadding: EdgeInsets.all(Responsive.w(16)),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(dialogContext).size.height * 0.8,
            ),
            padding: EdgeInsets.all(Responsive.w(16)),
            child: FutureBuilder(
              future: detailsFuture,
              builder: (_, snapshot) {
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
                      PrimaryButton(
                        text: 'Close',
                        height: Responsive.h(40),
                        fontSize: Responsive.sp(13),
                        borderRadius: Responsive.w(10),
                        backgroundColor: AppColors.newPri,
                        onPressed: () => Navigator.pop(dialogContext),
                      ),
                    ],
                  );
                }

                final data = snapshot.data!.data;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Submission Detail',
                            style: customTextStyle(
                              fontSize: Responsive.sp(16),
                              fontWeight: FontWeight.bold,
                              color: context.primaryTextColor,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          icon: const Icon(Icons.close),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    Divider(color: context.borderColor),

                    // Body
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (data.image != null &&
                                data.image!.isNotEmpty) ...[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Responsive.w(10),
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
                              height(Responsive.h(14)),
                            ],

                            // Title
                            Text(
                              data.title,
                              style: customTextStyle(
                                fontSize: Responsive.sp(16),
                                fontWeight: FontWeight.bold,
                                color: context.primaryTextColor,
                              ).copyWith(height: 1.3),
                            ),
                            height(Responsive.h(14)),

                            if (keywords.isNotEmpty) ...[
                              _sectionLabel(context, 'Keywords'),
                              height(Responsive.h(8)),
                              Wrap(
                                spacing: Responsive.w(8),
                                runSpacing: Responsive.h(8),
                                children: keywords
                                    .map(
                                      (k) => Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Responsive.w(10),
                                          vertical: Responsive.h(5),
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.newPri.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            Responsive.w(20),
                                          ),
                                        ),
                                        child: Text(
                                          k,
                                          style: customTextStyle(
                                            fontSize: Responsive.sp(11),
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.newPri,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              height(Responsive.h(16)),
                            ],

                            // Description
                            _sectionLabel(context, 'Description'),
                            height(Responsive.h(6)),
                            Text(
                              data.description,
                              style: customTextStyle(
                                fontSize: Responsive.sp(12.5),
                                color: context.primaryTextColor.withValues(
                                  alpha: 0.8,
                                ),
                              ).copyWith(height: 1.55),
                            ),
                          ],
                        ),
                      ),
                    ),

                    height(Responsive.h(14)),
                    PrimaryButton(
                      text: 'Close',
                      height: Responsive.h(42),
                      fontSize: Responsive.sp(13),
                      borderRadius: Responsive.w(10),
                      backgroundColor: AppColors.newPri,
                      onPressed: () => Navigator.pop(dialogContext),
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

  Widget _sectionLabel(BuildContext context, String text) {
    return Text(
      text.toUpperCase(),
      style: customTextStyle(
        fontSize: Responsive.sp(10.5),
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade600,
      ).copyWith(letterSpacing: 0.6),
    );
  }
}
