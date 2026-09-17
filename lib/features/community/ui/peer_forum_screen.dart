import 'package:Doctors_App/features/community/model/forum_post.dart';
import 'package:Doctors_App/features/community/model/peer_forum_response.dart';
import 'package:Doctors_App/features/community/ui/view_model/community_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../theme/app_colors.dart';

class PeerForumTab extends ConsumerStatefulWidget {
  const PeerForumTab({super.key});

  @override
  ConsumerState<PeerForumTab> createState() => _PeerForumTabState();
}

class _PeerForumTabState extends ConsumerState<PeerForumTab> {
  ForumContentType? _filter;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(communityViewModelProvider.notifier).allPeerForumList();
    });
  }

  List<ForumPost> _convertPosts(List<PeerForumModel> items) {
    return items.map((item) {
      final type = item.type.toLowerCase() == 'news'
          ? ForumContentType.circular
          : ForumContentType.blog;

      return ForumPost(
        type: type,
        title: item.title,
        snippet: item.description,
        source: item.type.toLowerCase() == 'news'
            ? (item.source ?? 'Doctors Risk')
            : (item.author ?? 'Doctors Risk'),
        date: item.daysAgoLabel ?? '',
        likes: 0,
        likedByMe: false,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final peerForumState = ref.watch(
      communityViewModelProvider.select((state) => state.peerForumList),
    );

    return peerForumState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => _buildErrorState(error.toString()),
      data: (response) {
        final posts = _convertPosts(response.data);

        final filteredPosts = _filter == null
            ? posts
            : posts.where((post) => post.type == _filter).toList();

        return Column(
          children: [
            height(Responsive.h(14)),
            _buildFilterChips(),
            height(Responsive.h(10)),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return ref
                      .read(communityViewModelProvider.notifier)
                      .refreshPeerForumList();
                },
                child: filteredPosts.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: Responsive.h(300),
                            child: Center(
                              child: Text(
                                'No forum posts found.',
                                style: customTextStyle(
                                  fontSize: Responsive.sp(13),
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(
                          Responsive.w(16),
                          0,
                          Responsive.w(16),
                          Responsive.h(24),
                        ),
                        itemCount: filteredPosts.length,
                        separatorBuilder: (_, __) => height(Responsive.h(14)),
                        itemBuilder: (_, index) {
                          return _buildPostCard(filteredPosts[index]);
                        },
                      ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Responsive.w(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: Responsive.sp(40),
              color: Colors.grey,
            ),
            height(Responsive.h(10)),
            Text(
              'Something went wrong',
              style: customTextStyle(
                fontSize: Responsive.sp(14),
                fontWeight: FontWeight.w600,
              ),
            ),
            height(Responsive.h(6)),
            Text(
              error,
              textAlign: TextAlign.center,
              style: customTextStyle(
                fontSize: Responsive.sp(12),
                color: Colors.grey.shade600,
              ),
            ),
            height(Responsive.h(12)),
            OutlinedButton(
              onPressed: () {
                ref
                    .read(communityViewModelProvider.notifier)
                    .allPeerForumList();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: Responsive.h(36),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
        children: [
          _chip(
            label: 'All',
            selected: _filter == null,
            onTap: () {
              setState(() => _filter = null);
            },
          ),
          width(Responsive.w(8)),
          _chip(
            label: 'News',
            selected: _filter == ForumContentType.circular,
            color: Colors.orange,
            onTap: () {
              setState(() {
                _filter = ForumContentType.circular;
              });
            },
          ),
          width(Responsive.w(8)),
          _chip(
            label: 'Blog',
            selected: _filter == ForumContentType.blog,
            color: AppColors.newPri,
            onTap: () {
              setState(() {
                _filter = ForumContentType.blog;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    Color? color,
  }) {
    final chipColor = color ?? AppColors.newPri;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.w(14),
          vertical: Responsive.h(8),
        ),
        decoration: BoxDecoration(
          color: selected ? chipColor : Colors.white,
          borderRadius: BorderRadius.circular(Responsive.w(30)),
          border: Border.all(
            color: selected ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: customTextStyle(
            fontSize: Responsive.sp(12),
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _buildPostCard(ForumPost post) {
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
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(10),
                  vertical: Responsive.h(4),
                ),
                decoration: BoxDecoration(
                  color: post.type.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Responsive.w(20)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      post.type.icon,
                      size: Responsive.sp(12),
                      color: post.type.color,
                    ),
                    width(Responsive.w(4)),
                    Text(
                      post.type.label,
                      style: customTextStyle(
                        fontSize: Responsive.sp(10.5),
                        fontWeight: FontWeight.bold,
                        color: post.type.color,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (post.date.isNotEmpty)
                Text(
                  post.date,
                  style: customTextStyle(
                    fontSize: Responsive.sp(11),
                    color: Colors.grey.shade500,
                  ),
                ),
            ],
          ),

          height(Responsive.h(10)),

          Text(
            post.title,
            style: customTextStyle(
              fontSize: Responsive.sp(13),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor.withValues(alpha: 0.85),
            ),
          ),

          height(Responsive.h(6)),

          Text(
            post.snippet,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: customTextStyle(
              fontSize: Responsive.sp(12.5),
              color: Colors.grey.shade600,
            ).copyWith(height: 1.4),
          ),

          height(Responsive.h(12)),

          Row(
            children: [
              Expanded(
                child: Text(
                  post.source,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: customTextStyle(
                    fontSize: Responsive.sp(11.5),
                    fontWeight: FontWeight.w600,
                    color: AppColors.newPri,
                  ),
                ),
              ),

              width(Responsive.w(14)),

              Icon(
                Icons.arrow_forward_ios_rounded,
                size: Responsive.sp(12),
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
