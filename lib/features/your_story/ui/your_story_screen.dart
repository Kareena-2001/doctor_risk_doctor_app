import 'package:Doctors_App/features/your_story/ui/widget/testimonial_list_screen.dart';
import 'package:Doctors_App/features/your_story/ui/widget/experience_list_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';

enum YourStoryMode { text, video, document }

class YourStoryScreen extends StatefulWidget {
  const YourStoryScreen({super.key});

  @override
  State<YourStoryScreen> createState() => _YourStoryScreenState();
}

class _YourStoryScreenState extends State<YourStoryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: CustomAppBar(title: 'Your Story', showBack: false),
      body: Column(
        children: [
          // Expanded(child: ExperienceListScreen()),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.newPri,
              labelColor: AppColors.newPri,
              unselectedLabelColor: Colors.grey.shade500,
              labelStyle: customTextStyle(
                fontSize: Responsive.sp(13),
                fontWeight: FontWeight.bold,
              ),
              tabs: const [
                Tab(text: 'Experience'),
                Tab(text: 'Testimonial'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ExperienceListScreen(),
                TestimonialListScreen(),
              ],
            ),
          ),
          height(100),
        ],
      ),
    );
  }
}
