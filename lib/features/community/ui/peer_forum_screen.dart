import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/core/widgets/common_empty_state.dart';
import 'package:Doctors_App/core/widgets/common_error_state.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/community/model/peer_forum_response.dart';
import 'package:Doctors_App/features/community/ui/view_model/community_view_model.dart';
import 'package:Doctors_App/features/community/ui/widgets/peer_forum_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../theme/app_colors.dart';
import '../../your_story/ui/widget/expandable_text.dart';

class PeerForumTab extends ConsumerStatefulWidget {
  const PeerForumTab({super.key});

  @override
  ConsumerState<PeerForumTab> createState() => _PeerForumTabState();
}

class _PeerForumTabState extends ConsumerState<PeerForumTab> {
  static const List<_TabOption> _tabs = [
    _TabOption(label: 'All', value: null),
    _TabOption(label: 'News', value: 'news'),
    _TabOption(label: 'Experience', value: 'experience'),
    _TabOption(label: 'Blog', value: 'blog'),
    _TabOption(label: 'Circulars', value: 'circular'),
    _TabOption(label: 'Notifications', value: 'notification'),
  ];

  String? _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(communityViewModelProvider.notifier).allPeerForumList();
    });
  }

  void _onTabTap(String? tab) {
    if (_selectedTab == tab) return;
    setState(() => _selectedTab = tab);
    ref.read(communityViewModelProvider.notifier).allPeerForumList(tab: tab);
  }

  @override
  Widget build(BuildContext context) {
    final peerForumState = ref.watch(
      communityViewModelProvider.select((s) => s.peerForumList),
    );
    final selectedTime = ref.watch(
      communityViewModelProvider.select((s) => s.selectedPeerForumTime),
    );
    final searchQuery = ref.watch(
      communityViewModelProvider.select((s) => s.peerForumSearchQuery),
    );

    return Column(
      children: [
        height(Responsive.h(14)),
        _buildFilterChips(),
        height(Responsive.h(10)),
        PeerForumFilterBar(
          selectedTime: selectedTime,
          searchQuery: searchQuery,
          onTimeChanged: (time) => ref
              .read(communityViewModelProvider.notifier)
              .setPeerForumTime(time),
          onSearchChanged: (query) => ref
              .read(communityViewModelProvider.notifier)
              .setPeerForumSearch(query),
          onSearchCleared: () => ref
              .read(communityViewModelProvider.notifier)
              .clearPeerForumSearch(),
        ),
        height(Responsive.h(10)),
        Expanded(
          child: AppRefreshIndicator(
            onRefresh: () => ref
                .read(communityViewModelProvider.notifier)
                .refreshPeerForumList(),
            child: peerForumState.when(
              loading: () => Center(child: Loading()),
              error: (err, _) => _buildError(err.toString()),
              data: (response) {
                final posts = response.data;
                if (posts.isEmpty) {
                  return _buildEmpty();
                }
                return ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                    Responsive.w(16),
                    0,
                    Responsive.w(16),
                    Responsive.h(24),
                  ),
                  itemCount: posts.length,
                  separatorBuilder: (_, __) => height(Responsive.h(14)),
                  itemBuilder: (_, index) => _buildPostCard(posts[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildError(String message) {
    return CommonErrorState(
      title: 'Failed to load posts',
      message: '',
      onRetry: () => ref
          .read(communityViewModelProvider.notifier)
          .allPeerForumList(tab: _selectedTab),
    );
  }

  Widget _buildEmpty() {
    return CommonEmptyState(title: 'No posts yet', icon: Icons.forum_outlined);
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: Responsive.h(36),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
        children: [
          for (final tab in _tabs) ...[
            _chip(
              label: tab.label,
              selected: _selectedTab == tab.value,
              onTap: () => _onTabTap(tab.value),
            ),
            width(Responsive.w(8)),
          ],
        ],
      ),
    );
  }

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.w(14),
          vertical: Responsive.h(8),
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.newPri : Colors.white,
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

  Widget _buildPostCard(PeerForumModel post) {
    final typeColor = _typeColor(post.type);
    final typeIcon = _typeIcon(post.type);
    final dateLabel = post.daysAgoLabel ?? post.date ?? post.createdOn ?? '';
    final subtitle = post.author ?? post.source ?? '';

    final detailsStyle = customTextStyle(
      fontSize: Responsive.sp(13),
      color: Colors.grey.shade700,
    );

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
                  color: typeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Responsive.w(20)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(typeIcon, size: Responsive.sp(12), color: typeColor),
                    width(Responsive.w(4)),
                    Text(
                      post.typeLabel,
                      style: customTextStyle(
                        fontSize: Responsive.sp(10.5),
                        fontWeight: FontWeight.bold,
                        color: typeColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (dateLabel.isNotEmpty)
                Text(
                  dateLabel,
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
          ExpandableText(
            text: post.description.trim().isEmpty
                ? 'No description available.'
                : post.description.trim(),
            maxLines: 4,
            style: detailsStyle.copyWith(height: 1.5),
            dialogTitle: post.title,
          ),
          height(Responsive.h(12)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: Responsive.sp(11.5),
                          fontWeight: FontWeight.w600,
                          color: AppColors.newPri,
                        ),
                      ),
                    if ((post.degree != null && post.degree!.isNotEmpty) ||
                        (post.categoryName != null &&
                            post.categoryName!.isNotEmpty)) ...[
                      height(Responsive.h(3)),
                      Text(
                        [
                          if (post.categoryName != null &&
                              post.categoryName!.isNotEmpty)
                            post.categoryName!,
                          if (post.degree != null && post.degree!.isNotEmpty)
                            post.degree!,
                        ].join(', '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: Responsive.sp(10.5),
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _typeColor(String type) {
    switch (type.toLowerCase()) {
      case 'news':
        return Colors.blue;
      case 'experience':
        return Colors.orange;
      case 'blog':
        return AppColors.newPri;
      default:
        return Colors.grey;
    }
  }

  IconData _typeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'news':
        return Icons.article_rounded;
      case 'experience':
        return Icons.play_circle_outline_rounded;
      case 'blog':
        return Icons.edit_note_rounded;
      default:
        return Icons.forum_rounded;
    }
  }
}

class _TabOption {
  final String label;
  final String? value;

  const _TabOption({required this.label, required this.value});
}
