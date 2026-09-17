import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';

class ReferralLinkCard extends StatelessWidget {
  final String referralLink;
  final bool isLoading;

  const ReferralLinkCard({
    super.key,
    required this.referralLink,
    this.isLoading = false,
  });

  /// Formats the referral link into a complete display URL
  String get displayLink {
    if (referralLink.isEmpty) return '';
    if (referralLink.startsWith('http://') ||
        referralLink.startsWith('https://') ||
        referralLink.contains('doctorsrisk.in')) {
      return referralLink;
    }
    return 'doctorsrisk.in/join?ref=$referralLink';
  }

  Future<void> _copy(BuildContext context) async {
    final linkToCopy = displayLink;
    if (linkToCopy.isEmpty) return;

    await Clipboard.setData(ClipboardData(text: linkToCopy));

    if (!context.mounted) return;

    context.showSuccessSnackBar('Referral link copied');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your referral link',
            style: customTextStyle(
              fontSize: Responsive.sp(13),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(8)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(12),
              vertical: Responsive.h(10),
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(Responsive.w(10)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: isLoading
                      ? const SizedBox(
                          height: 18,
                          child: LinearProgressIndicator(),
                        )
                      : SelectableText(
                          displayLink.isEmpty
                              ? 'No referral link available'
                              : displayLink,
                          maxLines: 1,
                          style: customTextStyle(
                            fontSize: Responsive.sp(12),
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
                width(Responsive.w(8)),
                if (displayLink.isNotEmpty)
                  InkWell(
                    onTap: () => _copy(context),
                    borderRadius: BorderRadius.circular(Responsive.w(8)),
                    child: Padding(
                      padding: EdgeInsets.all(Responsive.w(4)),
                      child: Icon(
                        Icons.copy_rounded,
                        size: Responsive.sp(16),
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          height(Responsive.h(12)),
          Row(
            children: [
              Expanded(
                child: _buildShareButton(
                  label: 'WhatsApp',
                  icon: Icons.chat_rounded,
                  onTap: () => _shareVia('whatsapp', displayLink, context),
                ),
              ),
              width(Responsive.w(10)),
              Expanded(
                child: _buildShareButton(
                  label: 'Email',
                  icon: Icons.email_rounded,
                  onTap: () => _shareVia('email', displayLink, context),
                ),
              ),
              width(Responsive.w(10)),
              Expanded(
                child: _buildShareButton(
                  label: 'X',
                  icon: Icons.close_rounded,
                  onTap: () => _shareVia('x', displayLink, context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _shareVia(
    String channel,
    String link,
    BuildContext context,
  ) async {
    if (link.isEmpty) return;

    final fullMessage =
        "Join me on Doctors Risk — use my referral link to sign up: $link";
    final encodedMessage = Uri.encodeComponent(fullMessage);

    Uri? shareUri;

    switch (channel) {
      case 'whatsapp':
        shareUri = Uri.parse("https://wa.me/?text=$encodedMessage");
        break;
      case 'email':
        final subject = Uri.encodeComponent("Join me on Doctors Risk");
        shareUri = Uri.parse("mailto:?subject=$subject&body=$encodedMessage");
        break;
      case 'x':
        shareUri = Uri.parse(
          "https://twitter.com/intent/tweet?text=$encodedMessage",
        );
        break;
    }

    if (shareUri != null) {
      if (await canLaunchUrl(shareUri)) {
        await launchUrl(shareUri, mode: LaunchMode.externalApplication);
      } else if (context.mounted) {
        context.showSuccessSnackBar('Could not launch sharing app');
      }
    }
  }

  Widget _buildShareButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Responsive.w(10)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Responsive.h(10)),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(Responsive.w(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: Responsive.sp(16), color: AppColors.textColor),
            height(Responsive.h(4)),
            Text(
              label,
              style: customTextStyle(
                fontSize: Responsive.sp(10.5),
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
