import 'dart:async';
import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/home/ui/view_model/home_view_model.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/assets.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/heading_widget.dart';
import '../../../routing/routes.dart';
import '../../notification/ui/viewmodel/notification_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final String userId;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _sessionTimer;

  String get _referralCode => userId
      .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
      .toUpperCase()
      .padRight(6, '0')
      .substring(0, 6);

  String get _inviteLink => 'https://saarthi.app/invite/$_referralCode';

  String get _shareMessage =>
      'Hey! Join me on Saathi 🚴 Use my code $_referralCode and we both get 7 days of Premium free!\n$_inviteLink';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
    _startSessionCheck();
  }

  void _startSessionCheck() {
    _sessionTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      debugPrint('Checking session...');
      ref.invalidate(homeViewModelProvider);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _sessionTimer?.cancel();
    super.dispose();
  }

  Future<void> _refreshUserData() async {
    try {
      ref.invalidate(homeViewModelProvider);
      ref.invalidate(notificationViewModelProvider);
    } catch (e) {
      debugPrint('Refresh failed: $e');
    }
  }

  Future<void> _handleNotificationTap() async {
    final alertViewModel = ref.read(notificationAlertProvider.notifier);

    try {
      await alertViewModel.removeAlert();
    } catch (e) {
      debugPrint('Failed to remove notification alert: $e');
    }

    if (mounted) {
      context.push(Routes.notification, extra: true);
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isDark
          ? const Color(0xFF0E0E10)
          : const Color(0xFFF6F7FB),
      appBar: CustomAppBar(
        title: 'Dashboard',
        showBack: false,
        showDrawer: true,
        onDrawer: () {
          context.push(Routes.appDrawer);
        },
        backgroundColor: isDark ? Colors.black : const Color(0xFFF8F9FA),
        showNotification: true,
        onNotification: _handleNotificationTap,
      ),
      body: RefreshIndicator(
        color: AppColors.newPri,
        onRefresh: _refreshUserData,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                height(Responsive.h(8)),
                _buildCompactProfileHeader(isDark),
                height(Responsive.h(20)),
                _buildMainContent(isDark),
                height(Responsive.h(100)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactProfileHeader(bool isDark) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      padding: EdgeInsets.symmetric(
        vertical: Responsive.h(24),
        horizontal: Responsive.w(20),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Responsive.w(28)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF1A1A1D), const Color(0xFF232326)]
              : [Colors.white, const Color(0xFFF3F4FF)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.newPri.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.w(4)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.newPri, AppColors.primary],
              ),
            ),
            child: Hero(
              tag: 'user_avatar',
              child: CircleAvatar(
                radius: Responsive.w(38),
                backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
                child: CircleAvatar(
                  radius: Responsive.w(35),
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  backgroundImage: AssetImage(Assets.user),
                ),
              ),
            ),
          ),
          height(Responsive.h(12)),
          Text(
            'Dr. Paresh Mathur',
            style: customTextStyle(
              fontSize: Responsive.sp(20),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(8)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(14),
              vertical: Responsive.h(5),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.newPri, AppColors.primary],
              ),
              borderRadius: BorderRadius.circular(Responsive.w(20)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.newPri.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified,
                  size: Responsive.sp(13),
                  color: Colors.white,
                ),
                width(Responsive.w(4)),
                Text(
                  'Membership Active',
                  style: customTextStyle(
                    color: Colors.white,
                    fontSize: Responsive.sp(12),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          height(Responsive.h(14)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _metaChip(Icons.assignment_ind_outlined, 'Med Reg: 48578'),
              width(Responsive.w(10)),
              _metaChip(Icons.fingerprint, 'ID: 38765734112'),
            ],
          ),
          height(Responsive.h(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.gavel_outlined,
                size: Responsive.sp(16),
                color: AppColors.primary,
              ),
              width(Responsive.w(6)),
              Text(
                'Doctors Risk Medico Legal Services',
                style: customTextStyle(
                  color: AppColors.newPri,
                  fontSize: Responsive.sp(13),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metaChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(10),
        vertical: Responsive.h(6),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(Responsive.w(30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: Responsive.sp(14), color: Colors.grey.shade600),
          width(Responsive.w(4)),
          Text(
            label,
            style: customTextStyle(
              color: Colors.grey.shade600,
              fontSize: Responsive.sp(11.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicyCard(),
          height(Responsive.h(24)),
          HeadingWidget(
            headingTitle: 'My Products',
            buttonText: 'View All',
            onTap: () => context.push(Routes.productHub),
          ),
          height(Responsive.h(10)),
          InkWell(
            borderRadius: BorderRadius.circular(Responsive.w(18)),
            onTap: () => context.push(Routes.productHub),
            child: Container(
              padding: EdgeInsets.all(Responsive.w(16)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Responsive.w(18)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(Responsive.w(8)),
                    decoration: BoxDecoration(
                      color: AppColors.newPri.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(Responsive.w(12)),
                    ),
                    child: Icon(
                      Icons.grid_view_rounded,
                      color: AppColors.newPri,
                      size: Responsive.sp(20),
                    ),
                  ),
                  width(Responsive.w(12)),
                  Expanded(
                    child: Text(
                      'Browse plans, manage your policies & more',
                      style: customTextStyle(
                        fontSize: Responsive.sp(13),
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: Responsive.sp(14),
                    color: AppColors.homeTextMuted,
                  ),
                ],
              ),
            ),
          ),
          height(Responsive.h(28)),
          HeadingWidget(
            headingTitle: 'News & Advisories',
            buttonText: "View All",
            onTap: () {
              context.push(Routes.newsAdvisory);
            },
          ),
          height(Responsive.h(10)),
          _buildNewsTile(
            'Medical Negligence in Post-Operative Care: Supreme Court...',
            'Jan 2025 • Legal Update',
            Icons.gavel,
          ),
          _buildNewsTile(
            'NMC Junked Negligence Complaints Without Seeking...',
            'Aug 2025 • Policy Watch',
            Icons.cancel_outlined,
          ),
          height(Responsive.h(28)),
          HeadingWidget(
            headingTitle: 'Blog Central',
            buttonText: 'View All',
            onTap: () {
              context.push(Routes.blogCentral);
            },
          ),
          height(Responsive.h(10)),
          _buildKnowledgeHub(),
          height(Responsive.h(28)),
          HeadingWidget(
            headingTitle: 'Events & Learning',
            buttonText: "View All",
            onTap: () {
              context.push(Routes.eventsScreen);
            },
          ),
          height(Responsive.h(10)),
          _buildEvents(),
          height(Responsive.h(28)),
          _buildFAQCard(),
          height(Responsive.h(30)),
        ],
      ),
    );
  }

  Widget _buildKnowledgeHub() {
    final blogs = [
      {
        'title': 'Medical Negligence in Post-Operative Care',
        'category': 'Legal Update',
        'date': '12 Jul 2026',
        'read': '5 min',
        'image': 'assets/images/blog.png',
      },
      {
        'title': 'Understanding New NMC Guidelines for Doctors',
        'category': 'Compliance',
        'date': '08 Jul 2026',
        'read': '3 min',
        'image': 'assets/images/blog.png',
      },
      {
        'title': 'Professional Indemnity: Common Claim Mistakes',
        'category': 'Insurance',
        'date': '02 Jul 2026',
        'read': '6 min',
        'image': 'assets/images/blog.png',
      },
    ];

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: blogs.length,
      separatorBuilder: (_, __) => SizedBox(height: Responsive.h(14)),
      itemBuilder: (context, index) {
        final blog = blogs[index];

        return InkWell(
          borderRadius: BorderRadius.circular(Responsive.w(18)),
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(Responsive.w(12)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Responsive.w(18)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Responsive.w(14)),
                  child: Image.asset(
                    blog['image']!,
                    width: Responsive.w(90),
                    height: Responsive.w(90),
                    fit: BoxFit.cover,
                  ),
                ),
                width(Responsive.w(14)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.w(10),
                          vertical: Responsive.h(4),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.newPri.withValues(alpha: .10),
                          borderRadius: BorderRadius.circular(Responsive.w(30)),
                        ),
                        child: Text(
                          blog['category']!,
                          style: customTextStyle(
                            color: AppColors.newPri,
                            fontSize: Responsive.sp(10),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      height(Responsive.h(8)),
                      Text(
                        blog['title']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: Responsive.sp(12),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                      height(Responsive.h(10)),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_outlined,
                            size: Responsive.sp(14),
                            color: AppColors.homeTextMuted,
                          ),
                          width(Responsive.w(4)),
                          Text(
                            blog['read']!,
                            style: customTextStyle(
                              fontSize: Responsive.sp(11),
                              color: AppColors.homeTextMuted,
                            ),
                          ),
                          width(Responsive.w(12)),
                          Icon(
                            Icons.calendar_today_outlined,
                            size: Responsive.sp(14),
                            color: AppColors.homeTextMuted,
                          ),
                          width(Responsive.w(4)),
                          Text(
                            blog['date']!,
                            style: customTextStyle(
                              fontSize: Responsive.sp(11),
                              color: AppColors.homeTextMuted,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.all(Responsive.w(6)),
                            decoration: BoxDecoration(
                              color: AppColors.newPri.withValues(alpha: .10),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: Responsive.sp(14),
                              color: AppColors.newPri,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPolicyCard() {
    return Container(
      padding: EdgeInsets.all(Responsive.w(20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Responsive.w(26)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.newPri, AppColors.newPri.withValues(alpha: 0.75)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.newPri.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Policy Details',
                style: customTextStyle(
                  color: AppColors.white,
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
              PrimaryButton(
                height: Responsive.h(30),
                width: Responsive.w(120),
                text: 'Renew Now',
                fontSize: Responsive.sp(12),
                backgroundColor: Colors.white,
                textColor: AppColors.newPri,
                onPressed: () => context.push(Routes.myPlans),
              ),
            ],
          ),
          height(Responsive.h(10)),
          Text(
            'Medico Legal Services',
            style: customTextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: Responsive.sp(12),
            ),
          ),
          Text(
            'Professional Indemnity',
            style: customTextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: Responsive.sp(12),
            ),
          ),
          Divider(color: Colors.white24, height: Responsive.h(28)),
          _buildPolicyMeta(
            'Coverage Amount',
            'Rs. 50,000,000',
            crossAlign: CrossAxisAlignment.end,
          ),
          Divider(color: Colors.white24, height: Responsive.h(28)),
          _buildPolicyMeta('Policy Number', '03303387333412'),
          Divider(color: Colors.white24, height: Responsive.h(28)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPolicyMeta('Duration', '1 Year'),
              _buildPolicyMeta('Valid From', '01/09/2024'),
              _buildPolicyMeta('Valid To', '31/08/2025'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyMeta(
    String label,
    String value, {
    CrossAxisAlignment crossAlign = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        Text(
          label,
          style: customTextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: Responsive.sp(11),
          ),
        ),
        height(Responsive.h(2)),
        Text(
          value,
          style: customTextStyle(
            color: Colors.white,
            fontSize: Responsive.sp(13),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFAQCard() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(20),
        vertical: Responsive.h(28),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Responsive.w(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.w(12)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.newPri, AppColors.primary],
              ),
              borderRadius: BorderRadius.circular(Responsive.w(14)),
            ),
            child: Icon(
              Icons.help_outline,
              color: AppColors.white,
              size: Responsive.sp(28),
            ),
          ),
          height(Responsive.h(10)),
          Text(
            'Frequently Asked Questions',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(16),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(8)),
          Text(
            'Need help with legal compliance?',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(16)),
          PrimaryButton(
            text: 'Contact Us',
            fontSize: Responsive.sp(12),
            fontWeight: FontWeight.w700,
            onPressed: () {
              context.push(Routes.faqScreen);
            },
            height: Responsive.h(42),
            backgroundColor: AppColors.newPri,
            borderRadius: Responsive.w(20),
          ),
        ],
      ),
    );
  }

  Widget _buildEvents() {
    final cards = [
      {
        'name': 'Live Webinar',
        'desc':
            'Upcoming Webinar: Telemedicine Laws and How it Impacts Medical Practice?',
        'image': 'assets/images/events.jpg',
        'Know More': true,
      },
      {
        'name': 'Collaborate',
        'desc':
            'Upcoming Webinar: Telemedicine Laws and How it Impacts Medical Practice?',
        'image': 'assets/images/events.jpg',
        'Know More': false,
      },
      {
        'name': 'Your Story',
        'desc':
            'Upcoming Webinar: Telemedicine Laws and How it Impacts Medical Practice?',
        'image': 'assets/images/events.jpg',
        'Know More': false,
      },
    ];

    return SizedBox(
      height: Responsive.h(300),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: Responsive.w(2), right: Responsive.w(4)),
        itemCount: cards.length,
        separatorBuilder: (_, __) => SizedBox(width: Responsive.w(14)),
        itemBuilder: (context, index) {
          final c = cards[index];
          final bool avail = c['Know More'] as bool;
          return Container(
            width: Responsive.w(220),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(Responsive.w(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Responsive.w(20)),
                  ),
                  child: Image.asset(
                    c['image'] as String,
                    height: Responsive.h(130),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    Responsive.w(12),
                    Responsive.h(10),
                    Responsive.w(12),
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c['name'] as String,
                        style: customTextStyle(
                          fontSize: Responsive.sp(13),
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor,
                        ).copyWith(overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(height: Responsive.h(4)),
                      Text(
                        c['desc'] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: Responsive.sp(11),
                          color: AppColors.homeTextMuted,
                        ),
                      ),
                      SizedBox(height: Responsive.h(10)),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              text: avail ? 'Register to Join' : 'Know More',
                              fontWeight: FontWeight.w700,
                              fontSize: Responsive.sp(12),
                              onPressed: () {},
                              height: Responsive.h(42),
                              backgroundColor: avail
                                  ? AppColors.newPri
                                  : AppColors.homeBorder,
                              borderRadius: Responsive.w(10),
                            ),
                          ),
                          width(Responsive.w(10)),
                          InkWell(
                            onTap: () => Share.share(_shareMessage),
                            borderRadius: BorderRadius.circular(
                              Responsive.w(10),
                            ),
                            child: Container(
                              width: Responsive.w(42),
                              height: Responsive.h(42),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  Responsive.w(10),
                                ),
                                border: Border.all(color: AppColors.homeBorder),
                              ),
                              child: Icon(
                                Icons.share_outlined,
                                size: Responsive.sp(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewsTile(String title, String date, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.h(10)),
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: Responsive.w(20),
            backgroundColor: AppColors.newPri.withValues(alpha: 0.1),
            child: Icon(icon, color: AppColors.newPri, size: Responsive.sp(18)),
          ),
          width(Responsive.w(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: customTextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.mono100,
                    fontSize: Responsive.sp(12),
                  ),
                ),
                height(Responsive.h(4)),
                Text(
                  date,
                  style: customTextStyle(
                    color: Colors.grey.shade600,
                    fontSize: Responsive.sp(11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
