import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';

import 'package:Doctors_App/features/blog_central/ui/all_blogs_tab.dart';
import 'my_blogs_tab.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
      appBar: const CustomAppBar(title: 'Blogs'),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.newPri,
                labelColor: AppColors.newPri,
                unselectedLabelColor: Colors.grey.shade500,
                labelStyle: customTextStyle(
                  fontSize: Responsive.sp(13),
                  fontWeight: FontWeight.bold,
                ),
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(text: "All Blogs"),
                  Tab(text: "My Blogs"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [AllBlogsTab(), MyBlogsTab()],
            ),
          ),
        ],
      ),
    );
  }
}
