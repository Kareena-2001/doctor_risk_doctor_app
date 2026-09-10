import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_seachbar.dart';
import 'package:Doctors_App/features/home/ui/widgets/social_link_widget.dart';
import 'package:Doctors_App/features/news_advisiories/ui/viewmodel/news_advisory_view_model.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/news_advisory_model.dart';

class NewsAdvisoryScreen extends ConsumerStatefulWidget {
  const NewsAdvisoryScreen({super.key});

  @override
  ConsumerState<NewsAdvisoryScreen> createState() => _NewsAdvisoryScreenState();
}

class _NewsAdvisoryScreenState extends ConsumerState<NewsAdvisoryScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();

    Future.microtask(() {
      ref.read(newsAdvisoryViewModelProvider.notifier).newsList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsState = ref.watch(newsAdvisoryViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(title: 'News & Advisories'),
      body: newsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: customTextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
          ),
        ),
        data: (state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: CustomSearchBar(
                  controller: _searchController,
                  hint: 'Search news, court rulings, NMC...',
                  onChanged: (value) {
                    ref
                        .read(newsAdvisoryViewModelProvider.notifier)
                        .searchNews(value);
                  },
                ),
              ),

              Expanded(
                child: state.news.isEmpty
                    ? Center(
                        child: Text(
                          'No news advisories found.',
                          style: customTextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        itemCount: state.news.length + 1,
                        separatorBuilder: (_, index) {
                          if (index == state.news.length - 1) {
                            return const SizedBox(height: 24);
                          }

                          return const SizedBox(height: 12);
                        },
                        itemBuilder: (context, index) {
                          if (index == state.news.length) {
                            return Column(
                              children: [SocialLinkWidget(), height(50)],
                            );
                          }

                          return _buildNewsCard(state.news[index]);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNewsCard(NewsAdvisoryModel item) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _openSource(item.sourceUrl),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.newsSource,
                    overflow: TextOverflow.ellipsis,
                    style: customTextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.newPri,
                    ),
                  ),
                ),

                width(8),

                Text(
                  _formatDate(item.sourceDate),
                  style: customTextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.newPri,
                  ),
                ),
              ],
            ),
            height(14),
            Text(
              item.title,
              style: customTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ).copyWith(height: 1.35),
            ),
            height(9),
            Text(
              item.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: customTextStyle(
                fontSize: 11.5,
                color: Colors.grey.shade700,
              ).copyWith(height: 1.5),
            ),

            height(14),

            Row(
              children: [
                Text(
                  item.sourceUrl.isNotEmpty ? 'Read source' : '',
                  style: customTextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.newPri,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 15,
                  color: AppColors.newPri,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);

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

      return '${parsedDate.day.toString().padLeft(2, '0')} '
          '${months[parsedDate.month - 1]} '
          '${parsedDate.year}';
    } catch (_) {
      return date;
    }
  }

  Future<void> _openSource(String url) async {
    if (url.isEmpty) {
      return;
    }

    final uri = Uri.tryParse(url);

    if (uri == null) {
      return;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open the source website')),
        );
      }
    } catch (e) {
      debugPrint('Could not launch URL: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open the source website')),
        );
      }
    }
  }
}
