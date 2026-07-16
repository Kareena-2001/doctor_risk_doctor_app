import 'dart:async';

import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/home/ui/view_model/home_view_model.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/assets.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/heading_widget.dart';
import '../../../routing/routes.dart';
import '../../events/ui/event_register_screen.dart';
import '../../notification/ui/viewmodel/notification_view_model.dart';
import '../model/policy_model.dart';
import 'floating_chat_bubble.dart';

final policyModel = PolicyModel(
  title: 'Policy Details',
  planName: 'Medico Legal Services',
  policyType: 'Professional Indemnity',
  coverageAmount: 'Rs. 50,000,000',
  policyNumber: '03303387333412',
  duration: '1 Year',
  validFrom: '01/09/2024',
  validTo: '31/08/2025',
  status: PolicyStatus.expired,
);

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

  static const String _instagramUrl = 'https://instagram.com/doctorsrisk';
  static const String _facebookUrl = 'https://facebook.com/doctorsrisk';
  static const String _youtubeUrl = 'https://youtube.com/@doctorsrisk';
  static const String _linkedin = 'https://facebook.com/doctorsrisk';

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

  Future<void> _launchSocialUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not open link')));
      }
    } catch (e) {
      debugPrint('Failed to launch $url: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not open link')));
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Scaffold(
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
                    _buildCompactProfileHeader(isDark, policyModel),
                    height(Responsive.h(20)),
                    _buildMainContent(isDark, policyModel),
                    height(Responsive.h(100)),
                  ],
                ),
              ),
            ),
          ),
        ),
        const FloatingChatBubble(),
      ],
    );
  }

  Widget _buildCompactProfileHeader(bool isDark, PolicyModel policy) {
    final status = policy.status;

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
          InkWell(
            onTap: () => context.push(Routes.editProfile),
            child: Container(
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
              gradient: LinearGradient(colors: status.gradient),
              borderRadius: BorderRadius.circular(Responsive.w(20)),
              boxShadow: [
                BoxShadow(
                  color: status.color.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(status.icon, size: Responsive.sp(13), color: Colors.white),
                width(Responsive.w(4)),
                Text(
                  status.label,
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

  Widget _buildMainContent(bool isDark, PolicyModel policyModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicyCard(policyModel),
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
          height(Responsive.h(24)),
          _buildSocialLinks(),
          height(Responsive.h(30)),
        ],
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(20),
        vertical: Responsive.h(22),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Responsive.w(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Connect With Us',
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(6)),
          Text(
            'Follow for updates, news & legal advisories',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(11.5),
              color: AppColors.homeTextMuted,
            ),
          ),
          height(Responsive.h(16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIconButton(
                icon: FontAwesomeIcons.instagram,
                bgColors: [
                  const Color(0xFFF58529),
                  const Color(0xFFDD2A7B),
                  const Color(0xFF8134AF),
                ],
                onTap: () => _launchSocialUrl(_instagramUrl),
              ),
              width(Responsive.w(18)),
              _socialIconButton(
                icon: FontAwesomeIcons.facebook,
                bgColors: [const Color(0xFF1877F2), const Color(0xFF1877F2)],
                onTap: () => _launchSocialUrl(_facebookUrl),
              ),
              width(Responsive.w(18)),
              _socialIconButton(
                icon: FontAwesomeIcons.youtube,
                bgColors: [const Color(0xFFFF0000), const Color(0xFFFF0000)],
                onTap: () => _launchSocialUrl(_youtubeUrl),
              ),
              width(Responsive.w(18)),
              _socialIconButton(
                icon: FontAwesomeIcons.linkedin,
                bgColors: [const Color(0xFF0A66C2), const Color(0xFF0A66C2)],
                // LinkedIn Brand Blue
                onTap: () => _launchSocialUrl(_linkedin),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialIconButton({
    required IconData icon,
    required List<Color> bgColors,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(Responsive.w(30)),
      onTap: onTap,
      child: Container(
        width: Responsive.w(40),
        height: Responsive.w(48),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: bgColors,
          ),
          boxShadow: [
            BoxShadow(
              color: bgColors.last.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: Responsive.sp(20)),
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

  Widget _buildPolicyCard(PolicyModel policy) {
    final status = policy.status;

    return ClipRRect(
      borderRadius: BorderRadius.circular(Responsive.w(28)),
      child: Container(
        padding: EdgeInsets.all(Responsive.w(20)),
        decoration: BoxDecoration(
          // 1. Give the gradient a premium diagonal direction
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: status.gradient,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.20),
              // Slightly softer shadow
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 2. Translucent white circles for elegant contrast (instead of more status color)
            Positioned(
              top: -Responsive.w(40),
              right: -Responsive.w(30),
              child: IgnorePointer(
                child: Container(
                  width: Responsive.w(140),
                  height: Responsive.w(140),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.10),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -Responsive.w(50),
              left: -Responsive.w(40),
              child: IgnorePointer(
                child: Container(
                  width: Responsive.w(150),
                  height: Responsive.w(150),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
              ),
            ),
            // Faint watermark shield icon for a "certified membership" feel
            Positioned(
              right: Responsive.w(4),
              bottom: Responsive.h(4),
              child: IgnorePointer(
                child: Icon(
                  Icons.shield_moon_outlined,
                  size: Responsive.sp(90),
                  color: Colors.white.withValues(
                    alpha: 0.08,
                  ), // Slightly more visible
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            policy.title.toUpperCase(),
                            style: customTextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              // Smoother than white70
                              fontSize: Responsive.sp(11),
                              fontWeight: FontWeight.w700,
                            ).copyWith(letterSpacing: 1.2),
                          ),
                          height(Responsive.h(6)),
                          Text(
                            policy.planName,
                            style: customTextStyle(
                              color: Colors.white,
                              fontSize: Responsive.sp(14),
                              // Slightly larger for hierarchy
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 3. Glassmorphism Status Ribbon so it stands out against the card
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.w(10),
                        vertical: Responsive.h(6),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        // Translucent overlay
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          // Subtle shine
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(Responsive.w(20)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            status.icon,
                            size: Responsive.sp(12),
                            color: Colors.white,
                          ),
                          width(Responsive.w(4)),
                          Text(
                            status.name[0].toUpperCase() +
                                status.name.substring(1),
                            style: customTextStyle(
                              color: Colors.white,
                              fontSize: Responsive.sp(11),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                height(Responsive.h(4)),
                Text(
                  policy.policyType,
                  style: customTextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: Responsive.sp(12.5),
                  ),
                ),
                height(Responsive.h(22)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: Responsive.w(25),
                      height: Responsive.w(25),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE6C878), Color(0xFFB8912F)],
                        ),
                        borderRadius: BorderRadius.circular(Responsive.w(6)),
                      ),
                    ),
                    width(Responsive.w(12)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'POLICY NUMBER',
                            style: customTextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: Responsive.sp(9.5),
                              fontWeight: FontWeight.w600,
                            ).copyWith(letterSpacing: 1.1),
                          ),
                          height(Responsive.h(3)),
                          Text(
                            policy.policyNumber,
                            style: customTextStyle(
                              color: Colors.white,
                              fontSize: Responsive.sp(12),
                              fontWeight: FontWeight.w600,
                            ).copyWith(letterSpacing: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                height(Responsive.h(20)),
                Container(
                  height: 1,
                  color: Colors.white.withValues(
                    alpha: 0.15,
                  ), // Slightly brighter divider
                ),
                height(Responsive.h(18)),

                Row(
                  children: [
                    Expanded(
                      child: _cardStat(
                        icon: Icons.security_rounded,
                        label: 'Coverage',
                        value: policy.coverageAmount,
                      ),
                    ),
                    Expanded(
                      child: _cardStat(
                        icon: Icons.timelapse_rounded,
                        label: 'Duration',
                        value: policy.duration,
                      ),
                    ),
                  ],
                ),
                height(Responsive.h(16)),
                Row(
                  children: [
                    Expanded(
                      child: _cardStat(
                        icon: Icons.calendar_today_rounded,
                        label: 'Valid From',
                        value: policy.validFrom,
                      ),
                    ),
                    Expanded(
                      child: _cardStat(
                        icon: Icons.event_busy_rounded,
                        label: 'Valid To',
                        value: policy.validTo,
                      ),
                    ),
                  ],
                ),

                if (policy.canRenew) ...[
                  height(Responsive.h(22)),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      height: Responsive.h(44),
                      text: status == PolicyStatus.expired
                          ? 'Renew Now'
                          : 'Renew Early',
                      fontSize: Responsive.sp(13),
                      fontWeight: FontWeight.w700,
                      backgroundColor: Colors.white,
                      textColor: status.gradient.last,
                      onPressed: () => context.push(Routes.myPlans),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardStat({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: Responsive.sp(15), color: Colors.white38),
        width(Responsive.w(8)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: customTextStyle(
                  color: Colors.white70,
                  fontSize: Responsive.sp(9.5),
                  fontWeight: FontWeight.w600,
                ).copyWith(letterSpacing: 0.8),
              ),
              height(Responsive.h(3)),
              Text(
                value,
                style: customTextStyle(
                  color: Colors.white,
                  fontSize: Responsive.sp(13),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFAQCard() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(20),
        vertical: Responsive.h(25),
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
              size: Responsive.sp(25),
            ),
          ),
          height(Responsive.h(10)),
          Text(
            'Frequently Asked Questions',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(8)),
          Text(
            'Need help with legal compliance?',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(12),
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
      height: Responsive.h(265),
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EventRegisterScreen(event: {}),
                                  ),
                                );
                              },
                              height: Responsive.h(42),
                              backgroundColor: avail
                                  ? AppColors.newPri
                                  : AppColors.homeBorder,
                              borderRadius: Responsive.w(10),
                            ),
                          ),
                          width(Responsive.w(10)),
                          InkWell(
                            onTap: () => Share.share(
                              'Check out this event: ${c['title']} on '
                              '${c['day']} ${c['month']}, ${c['time']}',
                            ),
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
