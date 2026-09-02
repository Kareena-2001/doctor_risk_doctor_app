import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/dimensions.dart';
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

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Blogs'),
      body: Column(
        children: [
          height(Responsive.h(12)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
            child: Container(
              height: Responsive.h(48),
              padding: EdgeInsets.all(Responsive.w(4)),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(Responsive.w(14)),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  _buildTab(title: 'Peer Insights', index: 0),
                  _buildTab(title: 'My Blogs', index: 1),
                ],
              ),
            ),
          ),
          height(Responsive.h(14)),
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

  Widget _buildTab({required String title, required int index}) {
    final bool isSelected = _tabController.index == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(Responsive.w(11)),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            title,
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? AppColors.newPri : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
