import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/features/blog_central/ui/viewmodel/blog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';

class BlogDetailsScreen extends ConsumerStatefulWidget {
  final String blogId;

  const BlogDetailsScreen({
    super.key,
    required this.blogId,
  });

  @override
  ConsumerState<BlogDetailsScreen> createState() =>
      _BlogDetailsScreenState();
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
            (s) =>
        s.blogDetails[widget.blogId] ??
            const AsyncLoading(),
      ),
    );

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Blog',
      ),
      body: detailAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            'Failed to load blog: $error',
          ),
        ),
        data: (detail) {
          if (detail == null || detail.data.isEmpty) {
            return const Center(
              child: Text('Blog not found'),
            );
          }

          final blog = detail.data.first;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  blog.image,
                  width: double.infinity,
                  height: Responsive.h(240),
                  fit: BoxFit.cover,
                  errorBuilder: (
                      context,
                      error,
                      stackTrace,
                      ) {
                    return SizedBox(
                      width: double.infinity,
                      height: Responsive.h(240),
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blog.title,
                        style: customTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ).copyWith(
                          height: 1.4,
                        ),
                      ),

                      height(14),

                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                            color: Colors.grey,
                          ),
                          width(6),
                          Text(
                            blog.createdOn,
                            style: customTextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      height(30),

                      Text(
                        blog.description,
                        style: customTextStyle(
                          fontSize: 12,
                          color: const Color(0xff374151),
                        ).copyWith(
                          height: 1.8,
                        ),
                      ),

                      height(28),
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
}