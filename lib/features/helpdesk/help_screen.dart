import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/dimensions.dart';
import '../../core/constants/values/app_text_style.dart';
import '../../routing/routes.dart';
import '../../theme/app_colors.dart';

enum HelpAction { email, call, chat, faq, guide, feedback, report, about }

enum QueryStatus { pending, inProgress, resolved, closed }

class HelpScreen extends ConsumerStatefulWidget {
  const HelpScreen({super.key});

  @override
  ConsumerState<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends ConsumerState<HelpScreen> {
  final helpSections = [
    {
      'title': 'Contact Support',
      'items': [
        {
          'icon': Icons.email_rounded,
          'title': 'Email HR',
          'subtitle': 'support@kals360.com',
          'color': Colors.blue,
          'action': HelpAction.email,
        },
        {
          'icon': Icons.chat_rounded,
          'title': 'Live Chat',
          'subtitle': 'Chat with our support team',
          'color': Colors.purple,
          'action': HelpAction.chat,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height(10),
        _buildNeedHelp(isDark),
        height(24),
        ...helpSections.map((section) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(section['title'] as String, isDark),
              height(16),
              ...(section['items'] as List).map((item) {
                final itemMap = item as Map<String, dynamic>;
                return _buildAnimatedCard(
                  delay: (section['items'] as List).indexOf(item) * 50,
                  child: _buildItemContainers(isDark, itemMap),
                );
              }),
              height(24),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildItemContainers(bool isDark, itemMap) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _onHelpItemTap(itemMap['action']),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: (itemMap['color'] as Color).withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (itemMap['color'] as Color).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                itemMap['icon'] as IconData,
                size: 24,
                color: itemMap['color'] as Color,
              ),
            ),
            width(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemMap['title'] as String,
                    style: customTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  height(4),
                  Text(
                    itemMap['subtitle'] as String,
                    style: customTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeedHelp(bool isDark) {
    return InkWell(
      onTap: () {
        context.push(Routes.myQueries);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withValues(alpha: 0.15),
              AppColors.primary.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.support_agent_rounded,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            width(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Need Help?',
                    style: customTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  height(4),
                  Text(
                    'We\'re here to assist you 24/7',
                    style: customTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        width(12),
        Text(
          title,
          style: customTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ).copyWith(letterSpacing: 0.3),
        ),
      ],
    );
  }

  void _onHelpItemTap(HelpAction action) {
    switch (action) {
      case HelpAction.email:
        _launchEmail();
        break;
      case HelpAction.call:
        _launchCall();
        break;
      case HelpAction.about:
        _showAboutBottomSheet();
        break;
      case HelpAction.chat:
        context.push(Routes.liveChat);
        break;
      case HelpAction.faq:
        throw UnimplementedError();
      case HelpAction.guide:
        throw UnimplementedError();
      case HelpAction.feedback:
        throw UnimplementedError();
      case HelpAction.report:
        throw UnimplementedError();
    }
  }

  void _launchEmail() {
    final uri = Uri(
      scheme: 'mailto',
      path: 'support@kals360.com',
      query: 'subject=Support Request',
    );
    launchUrl(uri);
  }

  void _launchCall() {
    final uri = Uri(scheme: 'tel', path: '+911800123456');
    launchUrl(uri);
  }

  void _showAboutBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Kals HR',
                style: customTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              height(8),
              Text('Version 1.0.0', style: customTextStyle(color: Colors.grey)),
              height(16),
              Text(
                'A complete HR management solution for employees.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedCard({required int delay, required Widget child}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 500 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
    );
  }
}
