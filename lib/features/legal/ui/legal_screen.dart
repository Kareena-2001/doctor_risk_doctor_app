import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/features/legal/ui/legal_cases_view.dart';
import 'package:Doctors_App/features/legal/ui/legal_notice_view.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';

class LegalScreen extends StatefulWidget {
  const LegalScreen({super.key});

  @override
  State<LegalScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<LegalScreen>
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
      appBar: CustomAppBar(title: 'Legal'),
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
                  Tab(text: "Legal Notice"),
                  Tab(text: "Legal Cases"),
                ],
              ),
            ),
          ),
          height(16),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [LegalNoticeView(), LegalCasesView()],
            ),
          ),
        ],
      ),
    );
  }
}
