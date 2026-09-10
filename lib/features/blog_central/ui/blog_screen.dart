import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/blog_central/ui/viewmodel/blog_view_model.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/theme/app_colors.dart';
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

  final List<String> filterCategories = [
    'All Topics',
    'Informed Consent Scenarios',
    'High Risk Diagnostics',
    'Defensive Documentation',
    'Cross Speciality & Referral Liability',
    'Reputation & Social Media Risk',
    'Regulatory & Compliance Updates',
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(blogViewModelProvider.notifier).fetchBlogList(),
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
      appBar: const CustomAppBar(title: 'Blog Central'),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(blogViewModelProvider.notifier).refreshBlogList(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.w(16),
            vertical: Responsive.h(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Breadcrumb/Subtitle bar
              Text(
                'Dashboard / Blog Central',
                style: customTextStyle(
                  fontSize: Responsive.sp(11),
                  color: Colors.grey.shade600,
                ),
              ),
              height(Responsive.h(10)),

              // 1. Hero Header Card
              _buildHeaderBanner(context),
              height(Responsive.h(20)),

              // 2. Peer Insights Section Title & Search Box
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

              // Search Bar
              TextField(
                controller: _searchController,
                style: customTextStyle(fontSize: Responsive.sp(12)),
                decoration: InputDecoration(
                  hintText: 'Search by keyword, specialty or author...',
                  hintStyle: customTextStyle(
                    fontSize: Responsive.sp(12),
                    color: Colors.grey.shade400,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade500,
                    size: Responsive.sp(18),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Responsive.h(10),
                    horizontal: Responsive.w(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Responsive.w(8)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Responsive.w(8)),
                    borderSide: BorderSide(color: AppColors.newPri),
                  ),
                ),
              ),
              height(Responsive.h(12)),

              // Sorting Dropdown
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.w(12),
                    vertical: Responsive.h(2),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Responsive.w(8)),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedSort,
                      isDense: true,
                      style: customTextStyle(
                        fontSize: Responsive.sp(12),
                        color: Colors.grey.shade800,
                      ),
                      items: ['Newest first', 'Most Read', 'Oldest first']
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => selectedSort = val);
                      },
                    ),
                  ),
                ),
              ),
              height(Responsive.h(12)),

              // Filter Category Chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: filterCategories.map((cat) {
                  final isSelected = selectedFilter == cat;
                  return ChoiceChip(
                    label: Text(
                      cat,
                      style: customTextStyle(
                        fontSize: Responsive.sp(10.5),
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isSelected ? Colors.white : Colors.grey.shade800,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: const Color(0xFF0F5A47),
                    backgroundColor: Colors.grey.shade100,
                    showCheckmark: false,
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.w(8),
                      vertical: Responsive.h(4),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Responsive.w(20)),
                      side: BorderSide(
                        color: isSelected
                            ? const Color(0xFF0F5A47)
                            : Colors.grey.shade300,
                      ),
                    ),
                    onSelected: (_) => setState(() => selectedFilter = cat),
                  );
                }).toList(),
              ),
              height(Responsive.h(18)),

              // 3. Blog List Grid / Content Section
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
                        onPressed: () => ref
                            .read(blogViewModelProvider.notifier)
                            .refreshBlogList(),
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
                      child: Center(child: Text('No blogs yet')),
                    );
                  }

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: Responsive.w(12),
                          mainAxisSpacing: Responsive.h(12),
                          mainAxisExtent: 220,
                        ),
                        itemCount: blogs.length,
                        itemBuilder: (context, index) {
                          return _buildBlogCard(context, blogs[index]);
                        },
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

  // Header Banner Component
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
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.lock_outline,
                  size: Responsive.sp(12),
                  color: Colors.grey.shade700,
                ),
                label: Text(
                  'My Submissions',
                  style: customTextStyle(
                    fontSize: Responsive.sp(11),
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          height(Responsive.h(6)),
          Text(
            'A private space for the DoctorsRisk consultation group — read how peers across specialties are navigating medico-legal risk, share your own experience to help someone facing the same situation, and earn recognition points every time your insight goes live.',
            style: customTextStyle(
              fontSize: Responsive.sp(10.5),
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
                      fontSize: Responsive.sp(9.5),
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          height(Responsive.h(14)),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F5A47),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.w(16),
                vertical: Responsive.h(10),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Responsive.w(8)),
              ),
              elevation: 0,
            ),
            icon: Icon(Icons.add, size: Responsive.sp(16)),
            label: Text(
              'Write a Blog',
              style: customTextStyle(
                fontSize: Responsive.sp(12),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Individual Card Component
  Widget _buildBlogCard(BuildContext context, dynamic blog) {
    final keywords = (blog.keywords as List?) ?? [];

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
          children: [
            // Keywords / Category Chips
            if (keywords.isNotEmpty) ...[
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: keywords.take(2).map((k) {
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
                      k.toString(),
                      style: customTextStyle(
                        fontSize: Responsive.sp(8.5),
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  );
                }).toList(),
              ),
              height(Responsive.h(8)),
            ],

            // Article Title
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

            const Spacer(),

            // Author Avatar & Meta Details
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
