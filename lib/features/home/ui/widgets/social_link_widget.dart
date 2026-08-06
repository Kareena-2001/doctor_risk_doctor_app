import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/responsive.dart';

class SocialLinkWidget extends StatefulWidget {
  const SocialLinkWidget({super.key});

  @override
  State<SocialLinkWidget> createState() => _SocialLinkWidgetState();
}

class _SocialLinkWidgetState extends State<SocialLinkWidget> {

  static const String _instagramUrl = 'https://instagram.com/doctorsrisk';
  static const String _facebookUrl = 'https://facebook.com/doctorsrisk';
  static const String _youtubeUrl = 'https://youtube.com/@doctorsrisk';
  static const String _linkedin = 'https://facebook.com/doctorsrisk';

  @override
  Widget build(BuildContext context) {
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

  Future<void> _launchSocialUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && mounted) {
        context.showErrorSnackBar('Could not open link');
      }
    } catch (e) {
      debugPrint('Failed to launch $url: $e');
      if (mounted) {
        context.showErrorSnackBar('Could not open link');
      }
    }
  }
}
