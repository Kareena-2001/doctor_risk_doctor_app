import 'package:Doctors_App/features/community/model/forum_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../theme/app_colors.dart';
import '../../testimonial/ui/widget/community_testimonial_list.dart';

class PeerForumTab extends ConsumerStatefulWidget {
  const PeerForumTab({super.key});

  @override
  ConsumerState<PeerForumTab> createState() => _PeerForumTabState();
}

class _PeerForumTabState extends ConsumerState<PeerForumTab> {
  ForumContentType? _filter;

  final List<ForumPost> _posts = [
    const ForumPost(
      type: ForumContentType.advisory,
      title: 'Supreme Court Ruling on Post-Operative Negligence Claims',
      snippet:
          'A recent judgment clarifies documentation standards expected during post-op monitoring...',
      source: 'Doctors Risk Advisory',
      date: '2 days ago',
      likes: 42,
    ),
    const ForumPost(
      type: ForumContentType.blog,
      title: 'Understanding New NMC Guidelines for Doctors',
      snippet:
          'A breakdown of what changed in the latest compliance circular and what it means for your practice...',
      source: 'Dr. Arun Sharma',
      date: '4 days ago',
      likes: 28,
      likedByMe: true,
    ),
    const ForumPost(
      type: ForumContentType.video,
      title: 'Telemedicine Laws Explained in 5 Minutes',
      snippet: 'Quick-watch summary from our last webinar session',
      source: 'Doctors Risk Team',
      date: '1 week ago',
      likes: 61,
    ),

    // const ForumPost(
    //   type: ForumContentType.testimonial,
    //   title: 'How the legal support team helped resolve my case',
    //   snippet:
    //       'When I received a legal notice over a case I didn\'t even remember, the team guided me through every step...',
    //   source: 'Dr. Anjali Mehta',
    //   date: '1 week ago',
    //   likes: 34,
    // ),
    // const ForumPost(
    //   type: ForumContentType.testimonial,
    //   title: 'Doctors Risk helped me handle a medico-legal issue',
    //   snippet:
    //   'Doctors Risk helped me handle a medico-legal issue professionally. Their guidance gave me confidence throughout the process.',
    //   source: 'Dr. Paresh Mathur',
    //   date: '15 Jul 2026',
    //   likes: 0,
    // ),
    //
    // const ForumPost(
    //   type: ForumContentType.testimonial,
    //   title: 'Video Testimonial',
    //   snippet: 'Watch my experience with Doctors Risk.',
    //   source: 'Dr. Neha Sharma',
    //   date: '10 Jul 2026',
    //   likes: 0,
    // ),
  ];

  List<ForumPost> get _filteredPosts {
    if (_filter == null) return _posts;
    return _posts.where((p) => p.type == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        height(Responsive.h(14)),
        _buildFilterChips(),
        height(Responsive.h(10)),
        // Expanded(
        //   child: _filter == ForumContentType.testimonial
        //       ? const CommunityTestimonialsList()
        //       : ListView.separated(
        //           padding: EdgeInsets.fromLTRB(
        //             Responsive.w(16),
        //             0,
        //             Responsive.w(16),
        //             Responsive.h(24),
        //           ),
        //           itemCount: _filteredPosts.length,
        //           separatorBuilder: (_, __) => height(Responsive.h(14)),
        //           itemBuilder: (_, index) =>
        //               _buildPostCard(_filteredPosts[index]),
        //         ),
        // ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(
              Responsive.w(16),
              0,
              Responsive.w(16),
              Responsive.h(24),
            ),
            itemCount: _filteredPosts.length,
            separatorBuilder: (_, __) => height(Responsive.h(14)),
            itemBuilder: (_, index) => _buildPostCard(_filteredPosts[index]),
          ),
        ),
      ],
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
            onTap: () => setState(() => _filter = null),
          ),
          width(Responsive.w(8)),
          ...ForumContentType.values.map(
            (type) => Padding(
              padding: EdgeInsets.only(right: Responsive.w(8)),
              child: _chip(
                label: type.label,
                selected: _filter == type,
                color: type.color,
                onTap: () => setState(() => _filter = type),
              ),
            ),
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
              Text(
                post.source,
                style: customTextStyle(
                  fontSize: Responsive.sp(11.5),
                  fontWeight: FontWeight.w600,
                  color: AppColors.newPri,
                ),
              ),
              const Spacer(),
              Icon(
                post.likedByMe
                    ? Icons.thumb_up_rounded
                    : Icons.thumb_up_outlined,
                size: Responsive.sp(15),
                color: post.likedByMe ? AppColors.newPri : Colors.grey.shade500,
              ),
              width(Responsive.w(4)),
              Text(
                '${post.likes}',
                style: customTextStyle(
                  fontSize: Responsive.sp(12),
                  color: Colors.grey.shade600,
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
