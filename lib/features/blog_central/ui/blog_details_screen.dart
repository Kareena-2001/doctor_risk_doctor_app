import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/features/blog_central/ui/viewmodel/blog_view_model.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';

class BlogDetailsScreen extends ConsumerStatefulWidget {
  final String blogId;

  const BlogDetailsScreen({super.key, required this.blogId});

  @override
  ConsumerState<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends ConsumerState<BlogDetailsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
          () => ref
          .read(blogViewModelProvider.notifier)
          .fetchBlogDetails(widget.blogId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(
      blogViewModelProvider.select(
            (s) => s.blogDetails[widget.blogId] ?? const AsyncLoading(),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const CustomAppBar(title: 'Blog Details'),
      body: detailAsync.when(
        loading: () => const Center(child: Loading()),
        error: (error, stackTrace) =>
            Center(child: Text('Failed to load blog: $error')),
        data: (detail) {
          if (detail.data.isEmpty) {
            return const Center(child: Text('Blog not found'));
          }

          final blog = detail.data.first;
          final hasImage = blog.image != null && blog.image!.isNotEmpty;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasImage)
                  Image.network(
                    blog.image!,
                    width: double.infinity,
                    height: Responsive.h(220),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
                  ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (blog.categoryName != null &&
                              blog.categoryName!.isNotEmpty)
                            _buildBadge(
                              blog.categoryName!,
                              Colors.blue.shade50,
                              Colors.blue.shade800,
                            ),
                          if (blog.specialityName != null &&
                              blog.specialityName!.isNotEmpty) ...[
                            width(8),
                            _buildBadge(
                              blog.specialityName!,
                              Colors.teal.shade50,
                              Colors.teal.shade800,
                            ),
                          ],
                        ],
                      ),
                      height(12),
                      Text(
                        blog.title,
                        style: customTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff1F2937),
                        ).copyWith(height: 1.3),
                      ),
                      height(16),
                      _buildAuthorAndMetaCard(blog),
                      height(20),

                      const Divider(thickness: 1, color: Color(0xffE5E7EB)),
                      height(16),
                      Text(
                        'Content',
                        style: customTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff1F2937),
                        ),
                      ),
                      height(8),
                      Text(
                        blog.description,
                        style: customTextStyle(
                          fontSize: 13,
                          color: const Color(0xff4B5563),
                        ).copyWith(height: 1.7),
                      ),
                      height(24),

                      // Keywords Section
                      if (blog.keywords.isNotEmpty) ...[
                        const Divider(thickness: 1, color: Color(0xffE5E7EB)),
                        height(16),
                        Text(
                          'Keywords',
                          style: customTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff1F2937),
                          ),
                        ),
                        height(8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: blog.keywords
                              .map(
                                (kw) => Chip(
                              label: Text(
                                kw.keyword,
                                style: customTextStyle(
                                  fontSize: 11,
                                  color: const Color(0xff374151),
                                ),
                              ),
                              backgroundColor: const Color(0xffF3F4F6),
                              side: BorderSide.none,
                              visualDensity: VisualDensity.compact,
                            ),
                          )
                              .toList(),
                        ),
                        height(24),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildBadge(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: customTextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildAuthorAndMetaCard(dynamic blog) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffE5E7EB)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                  size: 22,
                ),
              ),
              width(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.drName != null && blog.drName!.isNotEmpty
                          ? 'Dr. ${blog.drName}'
                          : 'Doctor',
                      style: customTextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff1F2937),
                      ),
                    ),
                    if (blog.degree != null && blog.degree!.isNotEmpty) ...[
                      height(2),
                      Text(
                        blog.degree!,
                        style: customTextStyle(
                          fontSize: 11,
                          color: const Color(0xff6B7280),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(height: 1, color: Color(0xffF3F4F6)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: Color(0xff6B7280),
                  ),
                  width(4),
                  Text(
                    blog.createdOn ?? 'N/A',
                    style: customTextStyle(
                      fontSize: 11,
                      color: const Color(0xff6B7280),
                    ),
                  ),
                ],
              ),
              if (blog.viewCount != null)
                Row(
                  children: [
                    const Icon(
                      Icons.visibility_outlined,
                      size: 14,
                      color: Color(0xff6B7280),
                    ),
                    width(4),
                    Text(
                      '${blog.viewCount} views',
                      style: customTextStyle(
                        fontSize: 11,
                        color: const Color(0xff6B7280),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}