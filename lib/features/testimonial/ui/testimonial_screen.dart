import 'package:Doctors_App/features/testimonial/ui/widget/community_testimonial_list.dart';
import 'package:Doctors_App/features/testimonial/ui/widget/experience_list_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';

enum TestimonialMode { text, video }

class TestimonialScreen extends StatefulWidget {
  const TestimonialScreen({super.key});

  @override
  State<TestimonialScreen> createState() => _TestimonialScreenState();
}

class _TestimonialScreenState extends State<TestimonialScreen>
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
          Expanded(child: ExperienceListScreen()),

          // Container(
          //   color: Colors.white,
          //   padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
          //   child: TabBar(
          //     controller: _tabController,
          //     indicatorColor: AppColors.newPri,
          //     labelColor: AppColors.newPri,
          //     unselectedLabelColor: Colors.grey.shade500,
          //     labelStyle: customTextStyle(
          //       fontSize: Responsive.sp(13),
          //       fontWeight: FontWeight.bold,
          //     ),
          //     tabs: const [
          //       // Tab(text: 'Share Testimonial'),
          //       // Tab(text: 'Community Stories'),
          //       Tab(text: 'Experience'),
          //       Tab(text: 'Testimonial'),
          //     ],
          //   ),
          // ),
          // Expanded(
          //   child: TabBarView(
          //     controller: _tabController,
          //     children: const [
          //       ExperienceListScreen(),
          //       CommunityTestimonialsList(),
          //     ],
          //   ),
          // ),
          height(100),
        ],
      ),
    );
  }
}
