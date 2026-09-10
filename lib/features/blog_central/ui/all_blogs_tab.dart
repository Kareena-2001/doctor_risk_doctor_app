import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/blog_central/ui/viewmodel/blog_view_model.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/routes.dart';
import '../../home/ui/widgets/social_link_widget.dart';

class AllBlogsTab extends ConsumerStatefulWidget {
  const AllBlogsTab({super.key});

  @override
  ConsumerState<AllBlogsTab> createState() => _AllBlogsTabState();
}

class _AllBlogsTabState extends ConsumerState<AllBlogsTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(blogViewModelProvider.notifier).fetchBlogList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final blogListAsync = ref.watch(
      blogViewModelProvider.select((s) => s.blogList),
    );

    return blogListAsync.when(
      loading: () => const Center(child: Loading()),
      error: (e, st) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Failed to load blogs: $e'),
            TextButton(
              onPressed: () =>
                  ref.read(blogViewModelProvider.notifier).refreshBlogList(),
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
                ref.read(blogViewModelProvider.notifier).refreshBlogList(),
            child: ListView(
              children: const [
                SizedBox(height: 120),
                Center(child: Text('No blogs yet')),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () =>
              ref.read(blogViewModelProvider.notifier).refreshBlogList(),
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(
              Responsive.w(16),
              0,
              Responsive.w(16),
              Responsive.h(24),
            ),
            itemCount: blogs.length + 1,
            separatorBuilder: (_, __) => height(Responsive.h(14)),
            itemBuilder: (context, index) {
              if (index == blogs.length) {
                return Column(
                  children: [
                    const SocialLinkWidget(),
                    height(Responsive.h(30)),
                  ],
                );
              }

              final blog = blogs[index];
              return _buildBlogCard(context, blog);
            },
          ),
        );
      },
    );
  }

  Widget _buildBlogCard(BuildContext context, dynamic blog) {
    final keywords = (blog.keywords as List?) ?? [];

    return InkWell(
      onTap: () =>
          context.push(Routes.blogCentralDetails, extra: blog.id.toString()),
      borderRadius: BorderRadius.circular(Responsive.w(16)),
      child: Container(
        padding: EdgeInsets.all(Responsive.w(16)),
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (keywords.isNotEmpty) ...[
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: keywords
                    .map(
                      (k) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.w(10),
                          vertical: Responsive.h(4),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(Responsive.w(20)),
                        ),
                        child: Text(
                          k.toString(),
                          style: customTextStyle(
                            fontSize: Responsive.sp(9.5),
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              height(Responsive.h(10)),
            ],
            Text(
              blog.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: customTextStyle(
                fontSize: Responsive.sp(14),
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ).copyWith(height: 1.35),
            ),

            height(Responsive.h(14)),
            Divider(height: 1, thickness: 1, color: Colors.grey.shade100),
            height(Responsive.h(12)),

            // Author row + reads count
            Row(
              children: [
                _AuthorAvatar(name: blog.drName ?? ''),
                width(Responsive.w(10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${blog.drName ?? ''}'
                        '${(blog.degree ?? '').toString().isNotEmpty ? ', ${blog.degree}' : ''}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: Responsive.sp(11.5),
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                      Text(
                        blog.specialityName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: Responsive.sp(10),
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                width(Responsive.w(8)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: Responsive.sp(13),
                      color: AppColors.newPri,
                    ),
                    width(Responsive.w(4)),
                    Text(
                      '${blog.viewCount ?? '0'} Peer Reads',
                      style: customTextStyle(
                        fontSize: Responsive.sp(10),
                        fontWeight: FontWeight.w600,
                        color: AppColors.newPri,
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
}

class _AuthorAvatar extends StatelessWidget {
  final String name;

  const _AuthorAvatar({required this.name});

  String get _initials {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: Responsive.w(16),
      backgroundColor: AppColors.newPri.withValues(alpha: 0.12),
      child: Text(
        _initials,
        style: customTextStyle(
          fontSize: Responsive.sp(11),
          fontWeight: FontWeight.bold,
          color: AppColors.newPri,
        ),
      ),
    );
  }
}
