import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/features/community/ui/peer_forum_screen.dart';
import 'package:Doctors_App/features/community/ui/refer_group_screen.dart';
import 'package:Doctors_App/features/community/ui/widgets/all_testimonial_list_screen.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.newBg,
      appBar: const CustomAppBar(title: 'Community', showBack: false),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: AppColors.newPri,
              labelColor: AppColors.newPri,
              unselectedLabelColor: Colors.grey.shade500,
              labelStyle: customTextStyle(
                fontSize: Responsive.sp(13),
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(text: 'Peer Forum'),
                Tab(text: 'Testimonials'),
                Tab(text: 'Refer & Groups'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                PeerForumTab(),
                AllTestimonialListScreen(),
                ReferAndGroupsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
