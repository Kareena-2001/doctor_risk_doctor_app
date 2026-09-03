import 'dart:async';
import 'dart:ui';

import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_seachbar.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/features/home/ui/view_model/home_view_model.dart';
import 'package:Doctors_App/features/home/ui/widgets/social_link_widget.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/assets.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/heading_widget.dart';
import '../../../routing/routes.dart';
import '../../events/ui/event_register_screen.dart';
import '../../notification/ui/viewmodel/notification_view_model.dart';
import '../model/policy_model.dart';
import 'floating_chat_bubble.dart';

const legalNotifications = [
  QuickActionNotification(
    title: 'New reply on ticket LS-2026-0139',
    description:
        'Our legal team has escalated your urgent on-call request — a specialist will call shortly.',
  ),
  QuickActionNotification(
    title: 'Ticket LS-2026-0142 moved to In Progress',
    description:
        'Your Legal Support ticket "Book Appointment — Case Discussion" is now being worked on.',
  ),
  QuickActionNotification(
    title: 'New advisory posted: Continuity Options When Switching Insurers',
    description:
        'DoctorsRisk Compliance Desk has shared guidance on maintaining coverage continuity — now in Peer Forum.',
  ),
];

const appointmentNotifications = [
  QuickActionNotification(
    title: 'Appointment reminder: tomorrow at 3:00 PM',
    description:
        '"Case Discussion" (Video Call) is scheduled for tomorrow. Join link available in Appointments.',
  ),
  QuickActionNotification(
    title: 'Reschedule request confirmed',
    description: 'Your requested new time slot has been confirmed by our team.',
  ),
];
final policyModel = PolicyModel(
  title: 'Policy Details',
  planName: 'Medico Legal Services',
  policyType: 'Professional Indemnity',
  coverageAmount: 'Rs. 50,000,000',
  policyNumber: '03303387333412',
  duration: '1 Year',
  validFrom: '01/09/2024',
  validTo: '31/08/2025',
  status: PolicyStatus.renewal,
);

const PolicyStatus kCurrentDashboardStatus = PolicyStatus.active;

final List<PolicyModel> personalPlansList = [
  const PolicyModel(
    title: 'Personal Plan',
    planName: 'Doctor Indemnity Cover',
    policyType: 'Professional Indemnity',
    coverageAmount: '₹ 50,00,000',
    policyNumber: '03303387333412',
    duration: '1 Year',
    validFrom: '01/09/2024',
    validTo: '31/08/2025',
    status: PolicyStatus.active,
  ),
  const PolicyModel(
    title: 'Personal Plan',
    planName: 'Clinic Liability Cover',
    policyType: 'Medical Establishment',
    coverageAmount: '₹ 25,00,000',
    policyNumber: '03303387998821',
    duration: '1 Year',
    validFrom: '01/08/2024',
    validTo: '31/07/2025',
    status: PolicyStatus.renewal,
  ),
  const PolicyModel(
    title: 'Personal Plan',
    planName: 'Locum Cover',
    policyType: 'Medical Establishment',
    coverageAmount: '₹ 10,00,000',
    policyNumber: '03303387112233',
    duration: '1 Year',
    validFrom: '01/06/2023',
    validTo: '31/05/2024',
    status: PolicyStatus.expired,
  ),
];

class QuickActionNotification {
  final String title;
  final String description;

  const QuickActionNotification({
    required this.title,
    required this.description,
  });
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey _legalKey = GlobalKey();
  final GlobalKey _appointmentsKey = GlobalKey();
  OverlayEntry? _openDropdown;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // OverlayEntry? _openDropdown;
  late final String userId;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _sessionTimer;

  final PageController _planPageController = PageController();
  int _currentPlanPage = 0;

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

  void _closeDropdown() {
    _openDropdown?.remove();
    _openDropdown = null;
  }

  @override
  void dispose() {
    _closeDropdown();
    _animationController.dispose();
    _sessionTimer?.cancel();
    _planPageController.dispose();
    super.dispose();
  }

  // --- replace _toggleQuickActionDropdown entirely ---
  void _toggleQuickActionDropdown({
    required BuildContext context,
    required GlobalKey anchorKey,
    required List<QuickActionNotification> items,
    required VoidCallback onViewAll,
  }) {
    if (_openDropdown != null) {
      _closeDropdown();
      return;
    }

    final renderBox =
        anchorKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final overlay = Overlay.of(context);
    final screenSize = MediaQuery.of(context).size;
    final screenPadding = MediaQuery.of(context).padding;

    final targetPosition = renderBox.localToGlobal(Offset.zero);
    final targetSize = renderBox.size;

    const panelWidth = 280.0;
    const edgeMargin = 12.0;

    // Anchor panel's right edge under the pill's right edge, then clamp
    // so it never runs off either side of the screen.
    double left = targetPosition.dx + targetSize.width - panelWidth;
    left = left.clamp(edgeMargin, screenSize.width - panelWidth - edgeMargin);

    double top = targetPosition.dy + targetSize.height + Responsive.h(8);
    final maxHeight = Responsive.h(360);

    if (top + maxHeight > screenSize.height - screenPadding.bottom) {
      final spaceAbove = targetPosition.dy - screenPadding.top;
      if (spaceAbove > maxHeight) {
        top = targetPosition.dy - maxHeight - Responsive.h(8);
      }
    }

    _openDropdown = OverlayEntry(
      builder: (overlayContext) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _closeDropdown,
                child: const SizedBox.shrink(),
              ),
            ),
            Positioned(
              left: left,
              top: top,
              width: panelWidth,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Responsive.w(16)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.w(14),
                            vertical: Responsive.h(12),
                          ),
                          itemCount: items.length,
                          separatorBuilder: (_, __) => Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Responsive.h(10),
                            ),
                            child: Divider(
                              height: 1,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          itemBuilder: (_, i) {
                            final item = items[i];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: customTextStyle(
                                    fontSize: Responsive.sp(12),
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textColor,
                                  ).copyWith(height: 1.3),
                                ),
                                height(Responsive.h(4)),
                                Text(
                                  item.description,
                                  style: customTextStyle(
                                    fontSize: Responsive.sp(11),
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.homeTextMuted,
                                  ).copyWith(height: 1.35),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(Responsive.w(16)),
                        ),
                        onTap: () {
                          _closeDropdown();
                          onViewAll();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: Responsive.h(12),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: Text(
                            'View all notifications',
                            textAlign: TextAlign.center,
                            style: customTextStyle(
                              fontSize: Responsive.sp(12),
                              fontWeight: FontWeight.w700,
                              color: AppColors.newPri,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_openDropdown!);
  }

  void _startSessionCheck() {
    _sessionTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      debugPrint('Checking session...');
      ref.invalidate(homeViewModelProvider);
    });
  }

  // --- update _buildQuickActionsRow: swap CompositedTransformTarget for keyed Container ---
  Widget _buildQuickActionsRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _emergencyPill(),
            width(Responsive.w(10)),
            Container(
              key: _legalKey,
              child: _shortcutPill(
                label: 'Legal',
                icon: Icons.gavel_rounded,
                badgeCount: 1,
                bg: const Color(0xFFE4F0FA),
                fg: const Color(0xFF3E8FD0),
                onTap: () => _toggleQuickActionDropdown(
                  context: context,
                  anchorKey: _legalKey,
                  items: legalNotifications,
                  onViewAll: () => context.push(Routes.notification),
                ),
              ),
            ),
            width(Responsive.w(10)),
            Container(
              key: _appointmentsKey,
              child: _shortcutPill(
                label: 'Appointments',
                icon: Icons.calendar_month_rounded,
                badgeCount: 1,
                bg: const Color(0xFFFCEFD9),
                fg: const Color(0xFFEF9F2E),
                onTap: () => _toggleQuickActionDropdown(
                  context: context,
                  anchorKey: _appointmentsKey,
                  items: appointmentNotifications,
                  onViewAll: () => context.push(Routes.notification),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(16),
        vertical: Responsive.h(11),
      ),
      child: RichText(
        text: TextSpan(
          style: customTextStyle(
            fontSize: Responsive.sp(12.5),
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ).copyWith(height: 1.4),
          children: [
            TextSpan(
              text: "Good morning, ",
              style: customTextStyle(
                fontSize: Responsive.sp(12.5),
                color: AppColors.mono60,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: "Dr. Paresh Mathur",
              style: customTextStyle(
                fontSize: Responsive.sp(12.5),
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
              ).copyWith(height: 1.4),
            ),
            TextSpan(
              text: " · here's your membership at a glance",
              style: customTextStyle(
                fontSize: Responsive.sp(12.5),
                color: AppColors.mono60,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBanner(PolicyStatus status) {
    final message = status.bannerMessage;
    if (message == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(16),
        vertical: Responsive.h(11),
      ),
      decoration: BoxDecoration(
        color: status.heroBg,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: status.heroBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            status.bannerIcon,
            size: Responsive.sp(16),
            color: status.bannerText,
          ),
          width(Responsive.w(10)),
          Expanded(
            child: Text(
              message,
              style: customTextStyle(
                fontSize: Responsive.sp(12.5),
                fontWeight: FontWeight.w600,
                color: status.bannerText,
              ).copyWith(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentPlans = _filterPlansByPriorityStatus(personalPlansList);

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
            showScan: true,
            onScan: () async {
              context.push(Routes.scanScreen);
            },
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Responsive.h(5),
                        horizontal: Responsive.w(20),
                      ),
                      child: CustomSearchBar(
                        controller: TextEditingController(),
                        hint: 'Search policies, blogs, FAQs, community...',
                      ),
                    ),
                    height(Responsive.h(8)),
                    _buildHeader(),
                    height(Responsive.h(4)),
                    _buildQuickActionsRow(),
                    height(Responsive.h(12)),
                    _buildStatusBanner(kCurrentDashboardStatus),
                    if (kCurrentDashboardStatus.bannerMessage != null)
                      height(Responsive.h(10)),
                    _buildCompactProfileHeader(isDark, kCurrentDashboardStatus),
                    height(Responsive.h(20)),
                    _buildMainContent(isDark, currentPlans),
                    height(Responsive.h(100)),
                  ],
                ),
              ),
            ),
          ),
        ),
        FloatingChatBubble(),
      ],
    );
  }

  Widget _emergencyPill() {
    const emergencyRed = Color(0xFFE15C48);
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () => context.push(Routes.emergency),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.w(16),
          vertical: Responsive.h(10),
        ),
        decoration: BoxDecoration(
          color: emergencyRed,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: emergencyRed.withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.phone_in_talk_rounded,
              size: Responsive.sp(13),
              color: Colors.white,
            ),
            width(Responsive.w(8)),
            Text(
              'Emergency',
              style: customTextStyle(
                fontSize: Responsive.sp(10.5),
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shortcutPill({
    required String label,
    required IconData icon,
    required int badgeCount,
    required Color bg,
    required Color fg,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: Responsive.h(6), right: Responsive.w(6)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.w(14),
            vertical: Responsive.h(10),
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: Responsive.sp(13), color: fg),
                  width(Responsive.w(6)),
                  Text(
                    label,
                    style: customTextStyle(
                      fontSize: Responsive.sp(10.5),
                      fontWeight: FontWeight.w700,
                      color: fg,
                    ),
                  ),
                ],
              ),
              if (badgeCount > 0)
                Positioned(
                  top: -Responsive.h(10),
                  right: -Responsive.w(8),
                  child: Container(
                    width: Responsive.w(17),
                    height: Responsive.w(17),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE15C48),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$badgeCount',
                      style: customTextStyle(
                        fontSize: Responsive.sp(9.5),
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactProfileHeader(bool isDark, PolicyStatus status) {
    final noPlan = status == PolicyStatus.noPlan;
    final radius = BorderRadius.circular(Responsive.w(28));

    return Container(
      margin: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: status.color.withValues(alpha: 0.10),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: isDark ? Colors.transparent : status.heroBorder,
              width: 1.2,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: isDark
                      ? const Color(0xFF1A1A1D)
                      : status.heroBg.withValues(alpha: 0.55),
                ),
              ),
              ..._heroBlobsForStatus(status),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: isDark ? 0.04 : 0.35),
                        Colors.white,
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Responsive.h(24),
                  horizontal: Responsive.w(20),
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
                          color: status.color.withValues(alpha: 0.5),
                        ),
                        child: Hero(
                          tag: 'user_avatar',
                          child: CircleAvatar(
                            radius: Responsive.w(38),
                            backgroundColor: isDark
                                ? Colors.grey.shade900
                                : Colors.white,
                            child: CircleAvatar(
                              radius: Responsive.w(35),
                              backgroundColor: AppColors.primary.withValues(
                                alpha: 0.1,
                              ),
                              backgroundImage: AssetImage(Assets.user),
                            ),
                          ),
                        ),
                      ),
                    ),
                    height(Responsive.h(12)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Dr. Paresh Mathur',
                            textAlign: TextAlign.center,
                            style: customTextStyle(
                              fontSize: Responsive.sp(16),
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                          ),
                        ),
                        if (!noPlan) ...[
                          width(Responsive.w(8)),
                          _pointsBadge('320'),
                        ],
                      ],
                    ),
                    height(Responsive.h(4)),
                    Text(
                      'General Practitioner · B.A.M.S.',
                      style: customTextStyle(
                        fontSize: Responsive.sp(11.5),
                        color: AppColors.homeTextMuted,
                      ),
                    ),
                    height(Responsive.h(12)),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: Responsive.w(8),
                      runSpacing: Responsive.h(8),
                      children: [
                        if (!noPlan) _tierBadge('Gold II · Premium'),
                        _statusTag(status),
                        _profileCompletionTag(noPlan ? '48' : '92'),
                      ],
                    ),
                    height(Responsive.h(18)),
                    _buildHeroMetaGrid(currentPlanForStatus(status), noPlan),
                    height(Responsive.h(14)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusBlob({
    required double size,
    required Color color,
    required double opacity,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: opacity),
          ),
        ),
      ),
    );
  }

  List<Widget> _heroBlobsForStatus(PolicyStatus status) {
    switch (status) {
      case PolicyStatus.active:
        return [
          _statusBlob(
            size: Responsive.w(210),
            color: const Color(0xFF57C97E),
            opacity: 0.28,
            top: -Responsive.h(80),
            left: -Responsive.w(50),
          ),
        ];
      case PolicyStatus.renewal:
        return [
          _statusBlob(
            size: Responsive.w(170),
            color: const Color(0xFFEF9F2E),
            opacity: 0.28,
            top: -Responsive.h(70),
            left: -Responsive.w(50),
          ),
        ];
      case PolicyStatus.expired:
        return [
          _statusBlob(
            size: Responsive.w(230),
            color: const Color(0xFFE15C48),
            opacity: 0.22,
            top: -Responsive.h(80),
            left: -Responsive.w(50),
          ),
        ];
      case PolicyStatus.noPlan:
        return [
          _statusBlob(
            size: Responsive.w(150),
            color: Colors.grey.shade400,
            opacity: 0.22,
            top: -Responsive.h(60),
            left: -Responsive.w(40),
          ),
        ];
    }
  }

  PolicyModel currentPlanForStatus(PolicyStatus status) {
    return personalPlansList.firstWhere(
      (p) => p.status == status,
      orElse: () => policyModel,
    );
  }

  Widget _pointsBadge(String points) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(10),
        vertical: Responsive.h(4),
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE6C878), Color(0xFFB8912F)],
        ),
        borderRadius: BorderRadius.circular(Responsive.w(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            size: Responsive.sp(13),
            color: AppColors.white,
          ),
          width(Responsive.w(3)),
          Text(
            '$points pts',
            style: customTextStyle(
              fontSize: Responsive.sp(11.5),
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tierBadge(String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(10),
        vertical: Responsive.h(5),
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE6C878), Color(0xFFB8912F)],
        ),
        borderRadius: BorderRadius.circular(Responsive.w(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.workspace_premium_rounded,
            size: Responsive.sp(13),
            color: Colors.white,
          ),
          width(Responsive.w(4)),
          Text(
            label,
            style: customTextStyle(
              fontSize: Responsive.sp(11),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusTag(PolicyStatus status) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(12),
        vertical: Responsive.h(5),
      ),
      decoration: BoxDecoration(
        color: status.lightBg,
        border: Border.all(color: status.lightBorder),
        borderRadius: BorderRadius.circular(Responsive.w(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: Responsive.sp(12), color: status.color),
          width(Responsive.w(4)),
          Text(
            status.label,
            style: customTextStyle(
              fontSize: Responsive.sp(11.5),
              fontWeight: FontWeight.w700,
              color: status.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileCompletionTag(String percent) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(12),
        vertical: Responsive.h(5),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.fieldGrey),
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(Responsive.w(20)),
      ),
      child: Text(
        'Profile $percent% complete',
        style: customTextStyle(
          fontSize: Responsive.sp(11.5),
          fontWeight: FontWeight.w700,
          color: AppColors.grey,
        ),
      ),
    );
  }

  Widget _buildHeroMetaGrid(PolicyModel policy, bool noPlan) {
    final items = <Widget>[
      if (!noPlan) ...[
        _heroMetaItem('Med. Reg. No.', '48578'),
        _heroMetaItem('Membership ID', 'DR-2026-084213'),
        _heroMetaItem('Coverage', policy.coverageAmount),
        _heroMetaItem(
          policy.status == PolicyStatus.expired ? 'Expired' : 'Renews',
          policy.validTo,
        ),
      ],
    ];
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: Responsive.w(22),
      runSpacing: Responsive.h(14),
      children: items,
    );
  }

  Widget _heroMetaItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: customTextStyle(
            fontSize: Responsive.sp(9.5),
            fontWeight: FontWeight.w600,
            color: AppColors.homeTextMuted,
          ).copyWith(letterSpacing: 0.6),
        ),
        height(Responsive.h(3)),
        Text(
          value,
          style: customTextStyle(
            fontSize: Responsive.sp(12.5),
            fontWeight: FontWeight.w700,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }

  List<PolicyModel> _filterPlansByPriorityStatus(List<PolicyModel> plans) {
    return plans.where((p) => p.status == kCurrentDashboardStatus).toList();
  }

  Widget _buildPolicyCard(List<PolicyModel> plans) {
    if (plans.isEmpty) return _buildNoPlanCard();

    final currentPlan = plans[_currentPlanPage];

    final bool isActive = currentPlan.status == PolicyStatus.active;

    final double cardHeight = isActive ? Responsive.h(280) : Responsive.h(350);

    return Column(
      children: [
        SizedBox(
          height: cardHeight,
          child: PageView.builder(
            controller: _planPageController,
            itemCount: plans.length,
            onPageChanged: (index) => setState(() => _currentPlanPage = index),
            itemBuilder: (context, index) {
              final plan = plans[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.w(2)),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: plan.status == PolicyStatus.noPlan
                      ? _buildNoPlanCard()
                      : _buildSinglePolicyCard(plan),
                ),
              );
            },
          ),
        ),
        if (plans.length > 1) ...[
          height(Responsive.h(10)),
          _buildPageDots(plans.length),
        ],
      ],
    );
  }

  Widget _buildPageDots(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == _currentPlanPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: Responsive.w(3)),
          width: active ? Responsive.w(18) : Responsive.w(6),
          height: Responsive.h(6),
          decoration: BoxDecoration(
            color: active ? AppColors.newPri : AppColors.homeBorder,
            borderRadius: BorderRadius.circular(Responsive.w(10)),
          ),
        );
      }),
    );
  }

  Widget _buildSinglePolicyCard(PolicyModel policy) {
    final status = policy.status;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(20)),
      decoration: BoxDecoration(
        color: status.lightBg,
        borderRadius: BorderRadius.circular(Responsive.w(28)),
        border: Border.all(color: status.lightBorder, width: 1.2),
      ),
      child: Column(
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
                        color: AppColors.textColorGrey,
                        fontSize: Responsive.sp(11),
                        fontWeight: FontWeight.w700,
                      ).copyWith(letterSpacing: 1.2),
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
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
              fontSize: Responsive.sp(12.5),
            ),
          ),
          height(Responsive.h(20)),
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
                        color: AppColors.homeTextMuted,
                        fontSize: Responsive.sp(9.5),
                        fontWeight: FontWeight.w600,
                      ).copyWith(letterSpacing: 1.1),
                    ),
                    height(Responsive.h(3)),
                    Text(
                      policy.policyNumber,
                      style: customTextStyle(
                        color: AppColors.textColor,
                        fontSize: Responsive.sp(12),
                        fontWeight: FontWeight.w600,
                      ).copyWith(letterSpacing: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          height(Responsive.h(18)),
          Divider(color: status.lightBorder, height: 1),
          height(Responsive.h(16)),
          Row(
            children: [
              Expanded(
                child: _cardStatLight(
                  icon: Icons.security_rounded,
                  label: 'Coverage',
                  value: policy.coverageAmount,
                  status: status,
                ),
              ),
              Expanded(
                child: _cardStatLight(
                  icon: Icons.timelapse_rounded,
                  label: 'Duration',
                  value: policy.duration,
                  status: status,
                ),
              ),
            ],
          ),
          height(Responsive.h(14)),
          Row(
            children: [
              Expanded(
                child: _cardStatLight(
                  icon: Icons.calendar_today_rounded,
                  label: 'Valid From',
                  value: policy.validFrom,
                  status: status,
                ),
              ),
              Expanded(
                child: _cardStatLight(
                  icon: Icons.event_busy_rounded,
                  label: 'Valid To',
                  value: policy.validTo,
                  status: status,
                ),
              ),
            ],
          ),
          if (policy.canRenew) ...[
            height(Responsive.h(20)),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                height: Responsive.h(44),
                text: status == PolicyStatus.expired
                    ? 'Renew Now'
                    : 'Renew Early',
                fontSize: Responsive.sp(13),
                fontWeight: FontWeight.w700,
                gradientColors: status.gradient,
                borderRadius: Responsive.w(20),
                onPressed: () => context.push(Routes.myPlans),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _cardStatLight({
    required IconData icon,
    required String label,
    required String value,
    required PolicyStatus status,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: Responsive.sp(15),
          color: status.color.withValues(alpha: 0.75),
        ),
        width(Responsive.w(8)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: customTextStyle(
                  color: AppColors.homeTextMuted,
                  fontSize: Responsive.sp(9.5),
                  fontWeight: FontWeight.w600,
                ).copyWith(letterSpacing: 0.8),
              ),
              height(Responsive.h(3)),
              Text(
                value,
                style: customTextStyle(
                  color: AppColors.textColor,
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

  Widget _buildNoPlanCard() {
    const status = PolicyStatus.noPlan;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(22)),
      decoration: BoxDecoration(
        color: status.lightBg,
        borderRadius: BorderRadius.circular(Responsive.w(28)),
        border: Border.all(color: status.lightBorder, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.w(12)),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(Responsive.w(14)),
            ),
            child: Icon(
              Icons.lock_outline_rounded,
              color: Colors.grey.shade600,
              size: Responsive.sp(24),
            ),
          ),
          height(Responsive.h(14)),
          Text(
            'No plan on file yet',
            style: customTextStyle(
              fontSize: Responsive.sp(15),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(6)),
          Text(
            "You're a registered member, but haven't secured coverage. "
            "Choose a plan to activate your Membership ID, coverage and "
            "policy documents.",
            style: customTextStyle(
              fontSize: Responsive.sp(12.5),
              fontWeight: FontWeight.w400,
              color: AppColors.homeTextMuted,
            ).copyWith(height: 1.5),
          ),
          height(Responsive.h(20)),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              height: Responsive.h(44),
              text: 'Secure Membership',
              fontSize: Responsive.sp(13),
              fontWeight: FontWeight.w700,
              gradientColors: [AppColors.newPri, AppColors.primary],
              borderRadius: Responsive.w(20),
              onPressed: () => context.push(Routes.productHub),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(bool isDark, List<PolicyModel> plans) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicyCard(plans),
          height(Responsive.h(20)),
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
                gradient: LinearGradient(
                  colors: [
                    AppColors.white.withValues(alpha: 0.22),
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(Responsive.w(18)),
                border: Border.all(
                  color: AppColors.iconPink.withValues(alpha: 0.10),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: Responsive.w(46),
                    height: Responsive.w(46),
                    decoration: BoxDecoration(
                      color: AppColors.homeProductBg,
                      borderRadius: BorderRadius.circular(Responsive.w(14)),
                    ),
                    child: Icon(
                      Icons.shield_outlined,
                      color: AppColors.homeProduct,
                      size: Responsive.sp(23),
                    ),
                  ),
                  width(Responsive.w(14)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Explore Your Protection',
                          style: customTextStyle(
                            fontSize: Responsive.sp(13.5),
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor,
                          ),
                        ),
                        height(Responsive.h(4)),
                        Text(
                          'Browse plans & manage your policies',
                          style: customTextStyle(
                            fontSize: Responsive.sp(12),
                            color: AppColors.homeTextMuted,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Responsive.w(32),
                    height: Responsive.w(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: Responsive.sp(17),
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          height(Responsive.h(28)),
          _buildFeatureWidgetsRow(),
          height(Responsive.h(24)),
          _buildSupportHubFeatureWidgetsRow(),
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
            source: 'Supreme Court of India',
            title:
                'Independent expert opinion now mandatory before prosecuting doctors',
            date: 'Jan 2025 • Legal Update',
            icon: Icons.gavel_rounded,
          ),
          _buildNewsTile(
            source: 'National Medical Commission',
            title: 'NMC Junked Negligence Complaints Without Seeking...',
            date: 'Aug 2025 • Policy Watch',
            icon: Icons.cancel_outlined,
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
          _buildBlogCentral(),
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
          height(Responsive.h(24)),
          _buildFAQCard(),
          height(Responsive.h(24)),
          SocialLinkWidget(),
          height(Responsive.h(30)),
        ],
      ),
    );
  }

  Widget _buildFeatureWidgetsRow() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _featureWidgetCard(
              icon: Icons.support_agent_rounded,
              iconBg: const Color(0xFFE9F7EC),
              iconFg: AppColors.brand800,
              title: 'Support Hub',
              subtitle: '2 open tickets · avg response 4 hrs',
              ctaLabel: 'Raise a query',
              ctaColor: AppColors.brand800,
              onTap: () => context.push(Routes.supportHub),
            ),
          ),
          width(Responsive.w(14)),
          Expanded(
            child: _featureWidgetCard(
              icon: Icons.folder_special_rounded,
              iconBg: const Color(0xFFE4F0FA),
              iconFg: const Color(0xFF3E8FD0),
              title: 'Document Vault',
              subtitle: '12 files · certificate expires in 34 days',
              ctaLabel: 'View documents',
              ctaColor: const Color(0xFF3E8FD0),
              onTap: () => context.push(Routes.documentVault),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportHubFeatureWidgetsRow() {
    return IntrinsicHeight(
      child: _featureWidgetCard(
        icon: Icons.star,
        iconBg: AppColors.secondary.withValues(alpha: 0.5),
        iconFg: AppColors.secondary,
        title: 'Rewards Points',
        subtitle:
            '320 pts · earn more by sharing experiences, testimonials, referrals & events',
        ctaLabel: 'Redeem at renewal or purchase',
        ctaColor: AppColors.brand800,
        onTap: () => context.push(Routes.supportHub),
      ),
    );
  }

  Widget _featureWidgetCard({
    required IconData icon,
    required Color iconBg,
    required Color iconFg,
    required String title,
    required String subtitle,
    required String ctaLabel,
    required Color ctaColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(Responsive.w(18)),
      onTap: onTap,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Responsive.w(38),
              height: Responsive.w(38),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(Responsive.w(11)),
              ),
              child: Icon(icon, size: Responsive.sp(18), color: iconFg),
            ),
            height(Responsive.h(12)),
            Text(
              title,
              style: customTextStyle(
                fontSize: Responsive.sp(13.5),
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
              ),
            ),
            height(Responsive.h(5)),
            Text(
              subtitle,
              style: customTextStyle(
                fontSize: Responsive.sp(11),
                color: AppColors.homeTextMuted,
              ).copyWith(height: 1.4),
            ),
            height(Responsive.h(12)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    ctaLabel,
                    style: customTextStyle(
                      fontSize: Responsive.sp(11.5),
                      fontWeight: FontWeight.w700,
                      color: ctaColor,
                    ),
                  ),
                ),
                width(Responsive.w(4)),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: Responsive.sp(13),
                  color: ctaColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogCentral() {
    final blogs = [
      {
        'title': 'Medical Negligence in Post-Operative Care',
        'description':
            'Key legal precedents, liability risks, and essential documentation protocols every operating surgeon must maintain.',
        'date': '12 Jul 2026',
        'read': '5 min',
        'image': 'assets/images/blog.png',
      },
      {
        'title': 'Understanding New NMC Guidelines for Doctors',
        'description':
            'A comprehensive breakdown of recent ethical codes, teleconsultation mandates, and compliance updates.',
        'date': '08 Jul 2026',
        'read': '3 min',
        'image': 'assets/images/blog.png',
      },
      {
        'title': 'Professional Indemnity: Common Claim Mistakes',
        'description':
            'Learn about avoidable errors during malpractice claims and how to properly report adverse clinical events.',
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
      separatorBuilder: (_, __) => SizedBox(height: Responsive.h(12)),
      itemBuilder: (context, index) {
        final blog = blogs[index];

        return InkWell(
          borderRadius: BorderRadius.circular(Responsive.w(20)),
          onTap: () => context.push(Routes.blogCentral),
          child: Container(
            padding: EdgeInsets.all(Responsive.w(12)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Responsive.w(20)),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.035),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
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
                    width: Responsive.w(84),
                    height: Responsive.w(84),
                    fit: BoxFit.cover,
                  ),
                ),
                width(Responsive.w(14)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        blog['title']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: Responsive.sp(13),
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor,
                        ).copyWith(height: 1.3),
                      ),
                      height(Responsive.h(4)),

                      // Description
                      Text(
                        blog['description']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: customTextStyle(
                          fontSize: Responsive.sp(11),
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ).copyWith(height: 1.3),
                      ),
                      height(Responsive.h(10)),

                      // Read time, Date & Action Arrow
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_outlined,
                            size: Responsive.sp(13),
                            color: AppColors.homeTextMuted,
                          ),
                          width(Responsive.w(4)),
                          Text(
                            blog['read']!,
                            style: customTextStyle(
                              fontSize: Responsive.sp(10.5),
                              color: AppColors.homeTextMuted,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          width(Responsive.w(10)),
                          Icon(
                            Icons.calendar_today_outlined,
                            size: Responsive.sp(13),
                            color: AppColors.homeTextMuted,
                          ),
                          width(Responsive.w(4)),
                          Text(
                            blog['date']!,
                            style: customTextStyle(
                              fontSize: Responsive.sp(10.5),
                              color: AppColors.homeTextMuted,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.all(Responsive.w(6)),
                            decoration: BoxDecoration(
                              color: AppColors.homeBlogBg,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              size: Responsive.sp(12),
                              color: AppColors.homeBlog,
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
                              gradientColors: avail
                                  ? [AppColors.newPri, AppColors.primary]
                                  : [AppColors.lightGray, AppColors.grey],
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

  Widget _buildNewsTile({
    required String source,
    required String title,
    required String date,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.h(12)),
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Responsive.w(18)),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(Responsive.w(18)),
        onTap: () => context.push(Routes.newsAdvisory),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    source,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      fontWeight: FontWeight.w700,
                      color: AppColors.newPri,
                    ),
                  ),
                ),
              ],
            ),
            height(Responsive.h(10)),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: customTextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.mono100,
                fontSize: Responsive.sp(12.5),
              ).copyWith(height: 1.3),
            ),
            height(Responsive.h(10)),
            Row(
              children: [
                Text(
                  date,
                  style: customTextStyle(
                    color: AppColors.homeTextMuted,
                    fontSize: Responsive.sp(10.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  'Read more',
                  style: customTextStyle(
                    fontSize: Responsive.sp(11),
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                width(Responsive.w(4)),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: Responsive.sp(13),
                  color: AppColors.homeNews,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
