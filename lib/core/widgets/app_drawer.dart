import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/languages.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/global_loading.dart';
import '../../features/common/ui/widgets/common_dialog.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Responsive.init(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark
          ? const Color(0xFF0F0F12)
          : const Color(0xFFF8F9FA),

      width: MediaQuery.of(context).size.width * 0.85,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, isDark),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _tile(
                      context,
                      icon: Icons.support_agent_rounded,
                      title: 'Support Hub',
                      subtitle: 'Contact Support',
                      isDark: isDark,
                      onTap: () {
                        context.push(Routes.supportHub);
                      },
                    ),
                    _tile(
                      context,
                      icon: Icons.calendar_month_outlined,
                      title: 'My Appointments',
                      subtitle: 'View upcoming & past appointments',
                      isDark: isDark,
                      onTap: () {
                        context.push(Routes.viewAppointment);
                      },
                    ),
                    _tile(
                      context,
                      icon: Icons.quiz_outlined,
                      title: 'FAQ',
                      subtitle: 'Frequently Asked Questions',
                      isDark: isDark,
                      onTap: () {
                        context.push(Routes.faqScreen);
                      },
                    ),
                    _tile(
                      context,
                      icon: Icons.gavel_outlined,
                      title: 'Legal Consultant',
                      subtitle: 'View Legal Reports',
                      isDark: isDark,
                      onTap: () {
                        context.push(Routes.legalConsultant);
                      },
                    ),
                    _tile(
                      context,
                      icon: Icons.description_outlined,
                      title: 'Legal Notice',
                      subtitle: 'View Legal Notices',
                      isDark: isDark,
                      onTap: () {
                        context.push(Routes.legalNotice);
                      },
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 16),
                    //   child: Divider(
                    //     color: isDark
                    //         ? Colors.white10
                    //         : Colors.black87.withValues(alpha: 0.05),
                    //   ),
                    // ),
                    // _sectionLabel('GENERAL', isDark),
                    // _tile(
                    //   context,
                    //   icon: Icons.person_outline_rounded,
                    //   title: 'Edit Profile',
                    //   subtitle: 'Update your personal details',
                    //   isDark: isDark,
                    //   onTap: () => context.push(Routes.login),
                    // ),
                    // _tile(
                    //   context,
                    //   icon: Icons.settings_outlined,
                    //   title: 'Settings',
                    //   subtitle: 'Manage app preferences',
                    //   isDark: isDark,
                    //   onTap: () => context.push(Routes.login),
                    // ),
                    // _tile(
                    //   context,
                    //   icon: Icons.help_outline_rounded,
                    //   title: 'Help & Support',
                    //   subtitle: 'Get assistance and FAQ',
                    //   isDark: isDark,
                    //   onTap: () => context.push(Routes.login),
                    // ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: _logoutTile(context, ref, isDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, right: 16),
          child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.grey.shade100,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark ? Colors.white24 : Colors.grey.shade300,
                  ),
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: 22,
                  color: isDark ? Colors.white70 : AppColors.mono60,
                ),
              ),
            ),
          ),
        ),
        height(10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.newPri,
                AppColors.newPri.withValues(alpha: 0.85),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.newPri.withValues(alpha: 0.25),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Text(
                    "P",
                    style: customTextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.newPri,
                    ),
                  ),
                ),
              ),
              width(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. Paresh Mathur",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: customTextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    height(2),
                    Text(
                      "doctor@example.com",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: customTextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        shadowColor: Colors.black.withValues(alpha: 0.04),
        elevation: isDark ? 0 : 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.of(context).pop();
            onTap();
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.newPri.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 20, color: AppColors.newPri),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: customTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white54 : AppColors.textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: customTextStyle(
                          fontSize: 11.5,
                          color: isDark ? Colors.white38 : AppColors.mono60,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: isDark ? Colors.white24 : AppColors.mono40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logoutTile(BuildContext context, WidgetRef ref, bool isDark) {
    final color = isDark
        ? Colors.redAccent.shade200
        : Colors.redAccent.shade700;
    return Material(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _signOut(context, ref),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_rounded, size: 18, color: color),
              const SizedBox(width: 8),
              Text(
                "Log Out",
                style: customTextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signOut(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => CommonDialog(
        title: "Log out confirmation",
        content: "Are you sure you want to log out?",
        primaryButtonLabel: 'Logout',
        primaryButtonBackground: AppColors.rambutan100,
        secondaryButtonLabel: Languages.cancel,
        autoDismiss: false,
        primaryButtonAction: () async {
          Navigator.of(dialogContext).pop();
          context.pop();
          await Future.delayed(const Duration(milliseconds: 100));
          if (!context.mounted) return;
          Global.showLoading(context);

          try {
            if (!context.mounted) return;
            Global.hideLoading();
            context.go(Routes.login);
          } catch (e, st) {
            debugPrint('SIGN OUT ERROR: $e');
            debugPrintStack(stackTrace: st);
            if (context.mounted) {
              Global.hideLoading();
            }
          }
        },
        secondaryButtonAction: () {
          if (Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
          }
        },
      ),
    );
  }
}
