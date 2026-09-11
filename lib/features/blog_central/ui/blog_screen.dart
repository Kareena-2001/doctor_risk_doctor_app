import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_seachbar.dart';
import 'package:Doctors_App/features/blog_central/model/blog_list_response.dart';
import 'package:Doctors_App/features/blog_central/ui/viewmodel/blog_view_model.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/custom_app_bar.dart';
import '../../../routing/routes.dart';

class BlogScreen extends ConsumerStatefulWidget {
  const BlogScreen({super.key});

  @override
  ConsumerState<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends ConsumerState<BlogScreen> {
  String selectedFilter = 'All Topics';
  String selectedSort = 'Newest first';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _fetchData());
  }

  void _fetchData() {
    ref
        .read(blogViewModelProvider.notifier)
        .fetchBlogList(
          query: _searchController.text.trim(),
          category: selectedFilter,
          sortBy: selectedSort,
        );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blogListAsync = ref.watch(
      blogViewModelProvider.select((s) => s.blogList),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  CustomAppBar(title: 'Blog Central'),
      body: AppRefreshIndicator(
        onRefresh: () async => _fetchData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.w(16),
            vertical: Responsive.h(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderBanner(context),
              height(Responsive.h(20)),
              Text(
                'Peer Insights',
                style: customTextStyle(
                  fontSize: Responsive.sp(16),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              Text(
                'What other doctors in the group are sharing.',
                style: customTextStyle(
                  fontSize: Responsive.sp(11.5),
                  color: Colors.grey.shade600,
                ),
              ),
              height(Responsive.h(12)),
              CustomSearchBar(
                controller: _searchController,
                hint: 'Search by keyword, specialty or author…',
                onChanged: (val) {
                  ref
                      .read(blogViewModelProvider.notifier)
                      .onSearchChanged(
                        val,
                        category: selectedFilter,
                        sortBy: selectedSort,
                      );
                },
              ),
              height(Responsive.h(10)),
              CustomDropdownField(
                isRequired: false,
                value: selectedSort,
                items: const ['Newest first', 'Most Read', 'Oldest first'],
                onChanged: (val) {
                  if (val != null) {
                    setState(() => selectedSort = val);
                    _fetchData();
                  }
                },
              ),
              height(Responsive.h(12)),
              blogListAsync.when(
                loading: () => const SizedBox(
                  height: 200,
                  child: Center(child: Loading()),
                ),
                error: (e, _) => Center(
                  child: Column(
                    children: [
                      Text('Failed to load blogs: $e'),
                      TextButton(
                        onPressed: _fetchData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
                data: (response) {
                  final blogs = response?.data ?? [];

                  if (blogs.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Text('No blogs found matching your criteria.'),
                      ),
                    );
                  }

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                      final spacing = Responsive.w(12);
                      final itemWidth = crossAxisCount == 1
                          ? constraints.maxWidth
                          : (constraints.maxWidth - spacing) / 2;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: Responsive.h(12),
                        children: blogs.map((blog) {
                          return SizedBox(
                            width: itemWidth,
                            child: _buildBlogCard(context, blog),
                          );
                        }).toList(),
                      );
                    },
                  );
                },
              ),
              height(Responsive.h(30)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8F5),
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: const Color(0xFFD4EADF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Blog Central – Your Private Peer Exchange',
                  style: customTextStyle(
                    fontSize: Responsive.sp(15),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              PrimaryButton(
                borderColor: AppColors.border,
                backgroundColor: AppColors.white,
                textColor: AppColors.newPri,
                text: 'My Submissions',
                width: 130,
                height: 35,
                fontSize: 11,
                onPressed: () {
                  context.push(Routes.mySubmission);
                },
                icon: Icons.menu,
              ),
            ],
          ),
          height(Responsive.h(6)),
          Text(
            'A private space for the DoctorsRisk consultation group — read how peers across specialties are navigating medico-legal risk, share your own experience to help someone facing the same situation, and earn recognition points every time your insight goes live.',
            style: customTextStyle(
              fontSize: Responsive.sp(11),
              color: Colors.grey.shade700,
            ).copyWith(height: 1.4),
          ),
          height(Responsive.h(12)),
          Container(
            padding: EdgeInsets.all(Responsive.w(10)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Responsive.w(8)),
              border: Border.all(color: const Color(0xFFE2EFE8)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  size: Responsive.sp(14),
                  color: Colors.grey.shade600,
                ),
                width(Responsive.w(8)),
                Expanded(
                  child: Text(
                    'Private to this consultation group. Nothing here is public or searchable outside DoctorsRisk unless you personally choose to export or share a specific article.',
                    style: customTextStyle(
                      fontSize: Responsive.sp(10),
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          height(Responsive.h(14)),
          PrimaryButton(
            gradientColors: [AppColors.newPri, AppColors.primary],
            textColor: AppColors.white,
            text: 'Write a Blog',
            width: 130,
            height: 50,
            borderRadius: 25,
            fontSize: 12,
            onPressed: () {
              context.push(Routes.addBlog);
            },
            icon: Icons.add,
          ),
        ],
      ),
    );
  }

  Widget _buildBlogCard(BuildContext context, BlogData blog) {
    final keywords = (blog.keywords as List?) ?? [];
    final formattedDate = _formatBlogDate(blog.date);
    final hasDate = formattedDate.isNotEmpty;

    return InkWell(
      onTap: () =>
          context.push(Routes.blogCentralDetails, extra: blog.id.toString()),
      borderRadius: BorderRadius.circular(Responsive.w(12)),
      child: Container(
        padding: EdgeInsets.all(Responsive.w(14)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Responsive.w(12)),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (keywords.isNotEmpty) ...[
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: keywords.take(2).map((keyword) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.w(6),
                      vertical: Responsive.h(2),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(Responsive.w(4)),
                    ),
                    child: Text(
                      keyword.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: customTextStyle(
                        fontSize: Responsive.sp(8.5),
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  );
                }).toList(),
              ),
              height(Responsive.h(6)),
            ],
            Text(
              blog.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: customTextStyle(
                fontSize: Responsive.sp(12.5),
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ).copyWith(height: 1.3),
            ),
            height(Responsive.h(8)),
            Row(
              children: [
                _AuthorAvatar(name: blog.drName ?? ''),
                width(Responsive.w(8)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Dr. ${blog.drName ?? ''}'
                        '${(blog.degree ?? '').toString().isNotEmpty ? ', ${blog.degree}' : ''}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: Responsive.sp(10.5),
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                      height(Responsive.h(1)),
                      Text(
                        blog.specialityName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: Responsive.sp(9),
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            height(Responsive.h(8)),
            Divider(color: AppColors.divider),
            height(Responsive.h(8)),
            Row(
              children: [
                Icon(
                  Icons.visibility_outlined,
                  size: Responsive.sp(13),
                  color: Colors.grey.shade600,
                ),
                width(Responsive.w(4)),
                Text(
                  '${blog.viewCount ?? '0'} Peer Reads',
                  style: customTextStyle(
                    fontSize: Responsive.sp(9),
                    color: Colors.grey.shade600,
                  ),
                ),
                if (hasDate) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Responsive.w(10)),
                    child: Container(
                      width: 1,
                      height: Responsive.h(14),
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: Responsive.sp(12),
                    color: Colors.grey.shade500,
                  ),
                  width(Responsive.w(4)),
                  Flexible(
                    child: Text(
                      formattedDate,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: customTextStyle(
                        fontSize: Responsive.sp(9),
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatBlogDate(String? value) {
    if (value == null || value.isEmpty) return '';
    try {
      final date = DateTime.parse(value);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (_) {
      return value;
    }
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
      radius: Responsive.w(12),
      backgroundColor: const Color(0xFFDFF1E9),
      child: Text(
        _initials,
        style: customTextStyle(
          fontSize: Responsive.sp(9.5),
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0F5A47),
        ),
      ),
    );
  }
}
