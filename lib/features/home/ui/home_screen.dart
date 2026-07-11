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
import '../model/user_profile_model.dart';

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
    final profileAsync = ref.watch(homeViewModelProvider);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.newSec,

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
        onRefresh: _refreshUserData,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                children: [
                  profileAsync.when(
                    data: (profileResponse) => _buildCompactProfileHeader(
                      isDark,
                      profileResponse?.data,
                    ),
                    loading: () => CircularProgressIndicator(),
                    error: (_, __) => _buildCompactProfileHeader(isDark, null),
                  ),
                  height(20),
                  _buildMainContent(isDark),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactProfileHeader(bool isDark, UserProfileModel? userData) {
    final userPhoto = userData?.photo;

    return Center(
      child: Container(
        // width: double.infinity,
        // margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        // decoration: BoxDecoration(
        //   color: isDark ? Colors.grey.shade900 : Colors.white,
        //   borderRadius: BorderRadius.circular(24),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.black.withValues(alpha: 0.04),
        //       blurRadius: 10,
        //       offset: const Offset(0, 4),
        //     ),
        //   ],
        // ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'user_avatar',
              child: CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                backgroundImage: userPhoto != null && userPhoto.isNotEmpty
                    ? NetworkImage(userPhoto)
                    : const AssetImage(Assets.user) as ImageProvider,
              ),
            ),
            height(12),
            Text(
              'Dr. Paresh Mathur',
              style: customTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            height(6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Membership Status: Active',
                style: customTextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            height(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.assignment_ind_outlined,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                width(4),
                Text(
                  'Med Reg: 48578',
                  style: customTextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
                width(16),
                Icon(Icons.fingerprint, size: 16, color: Colors.grey.shade600),
                width(4),
                Text(
                  'ID: 38765734112',
                  style: customTextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            height(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.gavel_outlined, size: 16, color: AppColors.primary),
                const SizedBox(width: 6),
                Text(
                  'Doctors Risk Medico Legal Services',
                  style: customTextStyle(
                    color: AppColors.newPri,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicyCard(),
          height(16),
          HeadingWidget(
            headingTitle: 'My Products',
            buttonText: 'View All',
            onTap: () => context.push(Routes.productHub),
          ),
          height(10),
// reuses the same _EntryCard row pattern as ProductHubView, or just:
          InkWell(
            onTap: () => context.push(Routes.productHub),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.homeBorder),
              ),
              child: Row(
                children: [
                  Icon(Icons.grid_view_rounded, color: AppColors.newPri),
                  width(10),
                  Expanded(
                    child: Text('Browse plans, manage your policies & more',
                        style: customTextStyle(fontSize: 13, color: AppColors.textColor)),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.homeTextMuted),
                ],
              ),
            ),
          ),
          height(24),
          HeadingWidget(
            headingTitle: 'Upcoming Appointments',
            buttonText: "View All",
            onTap: () {
              // context.push(Routes.nearbyRides);
            },
          ),
          height(10),
          _buildAppointmentTile(
            'Patient: Rahul Sharma',
            '10:30 AM • General Checkup',
            '12\nOCT',
          ),
          _buildAppointmentTile(
            'Patient: Priya Verma',
            '02:15 PM • Follow-up',
            '12\nOCT',
          ),
          height(24),
          HeadingWidget(
            headingTitle: 'News & Advisories',
            buttonText: "View All",
            onTap: () {
              // context.push(Routes.nearbyRides);
            },
          ),
          height(10),
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
          height(24),
          HeadingWidget(
            headingTitle: 'Blog Central',
            buttonText: 'View All',
            onTap: () {},
          ),
          height(10),
          _buildKnowledgeHub(),

          height(24),
          HeadingWidget(
            headingTitle: 'Events & Learning',
            buttonText: "View All",
            onTap: () {
              // context.push(Routes.nearbyRides);
            },
          ),
          height(10),
          _buildEvents(),
          height(24),
          _buildFAQCard(),
          height(30),
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
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final blog = blogs[index];

        return InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.homeBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    blog['image']!,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.newPri.withValues(alpha: .10),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          blog['category']!,
                          style: customTextStyle(
                            color: AppColors.newPri,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        blog['title']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Icon(
                            Icons.schedule_outlined,
                            size: 14,
                            color: AppColors.homeTextMuted,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            blog['read']!,
                            style: customTextStyle(
                              fontSize: 11,
                              color: AppColors.homeTextMuted,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: AppColors.homeTextMuted,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            blog['date']!,
                            style: customTextStyle(
                              fontSize: 11,
                              color: AppColors.homeTextMuted,
                            ),
                          ),

                          const Spacer(),

                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.newPri.withValues(alpha: .10),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.newPri.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Policy Details',
                    style: customTextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              PrimaryButton(
                height: 30,
                width: 120,
                text: 'Renew Now',
                fontSize: 12,
                backgroundColor: Colors.white,
                textColor: AppColors.newPri,
                onPressed: () => context.push(Routes.myPlans),
              ),
            ],
          ),
          height(10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Medico Legal Services',
                style: customTextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                ),
              ),
              Text(
                'Professional Indemnity',
                style: customTextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white24, height: 24),
          _buildPolicyMeta(
            'Coverage Amount',
            'Rs. 50,000,000',
            crossAlign: CrossAxisAlignment.end,
          ),
          const Divider(color: Colors.white24, height: 24),
          _buildPolicyMeta('Policy Number', '03303387333412'),
          const Divider(color: Colors.white24, height: 24),
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
            fontSize: 11,
          ),
        ),
        height(2),
        Text(value, style: customTextStyle(color: Colors.white, fontSize: 13)),
      ],
    );
  }

  Widget _buildFAQCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.20)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.newPri,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.help_outline,
              color: AppColors.white,
              size: 28,
            ),
          ),
          height(8),
          Text(
            'Frequently Asked Questions',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(16),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(8),
          Text(
            'Need help with legal compliance?',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            ),
          ),
          height(15),
          PrimaryButton(
            text: 'Contact Us',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            onPressed: () {},
            height: 40,
            backgroundColor: AppColors.newPri,
            borderRadius: 20,
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
      height: Responsive.h(280),
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
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.homeBorder, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      child: Image.asset(
                        c['image'] as String,
                        height: Responsive.h(130),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              c['name'] as String,
                              style: customTextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor,
                              ).copyWith(overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.h(4)),
                      Text(
                        c['desc'] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: 11,
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
                              fontSize: 12,
                              onPressed: () {},
                              height: 42,
                              backgroundColor: avail
                                  ? AppColors.newPri
                                  : AppColors.homeBorder,
                              borderRadius: 10,
                            ),
                          ),

                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () => Share.share(_shareMessage),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.homeBorder),
                              ),
                              child: const Icon(Icons.share_outlined, size: 20),
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

  Widget _buildAppointmentTile(String title, String subtitle, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              date,
              textAlign: TextAlign.center,
              style: customTextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          width(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: customTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  subtitle,
                  style: customTextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNewsTile(String title, String date, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: Icon(icon, color: AppColors.newPri),
          ),
          width(14),
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
                    fontSize: 13,
                  ),
                ),
                height(4),
                Text(
                  date,
                  style: customTextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
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
