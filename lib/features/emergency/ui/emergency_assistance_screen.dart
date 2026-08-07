import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';
import '../../home/ui/chat_panel.dart';
import '../model/emergency_scenario_model.dart';

class EmergencyAssistanceScreen extends ConsumerStatefulWidget {
  const EmergencyAssistanceScreen({super.key});

  @override
  ConsumerState<EmergencyAssistanceScreen> createState() =>
      _EmergencyAssistanceScreenState();
}

class _EmergencyAssistanceScreenState
    extends ConsumerState<EmergencyAssistanceScreen> {
  bool _isOpen = false;

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  void _showChecklistBottomSheet(
    BuildContext context,
    EmergencyScenarioModel scenario,
    bool isDark,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1A1A1D) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Responsive.w(20)),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            Responsive.w(20),
            Responsive.h(16),
            Responsive.w(20),
            Responsive.h(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: Responsive.w(40),
                  height: Responsive.h(4),
                  decoration: BoxDecoration(
                    color: AppColors.fieldGrey,
                    borderRadius: BorderRadius.circular(Responsive.w(10)),
                  ),
                ),
              ),
              height(Responsive.h(16)),
              Text(
                scenario.title,
                style: customTextStyle(
                  fontSize: Responsive.sp(16),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor,
                ),
              ),
              height(Responsive.h(4)),
              Text(
                scenario.subtitle,
                style: customTextStyle(
                  fontSize: Responsive.sp(12),
                  color: AppColors.homeTextMuted,
                ),
              ),
              height(Responsive.h(20)),
              ...scenario.checklistSteps.asMap().entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(bottom: Responsive.h(12)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Responsive.w(22),
                        height: Responsive.w(22),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.newPri.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${entry.key + 1}',
                          style: customTextStyle(
                            fontSize: Responsive.sp(11),
                            fontWeight: FontWeight.w700,
                            color: AppColors.newPri,
                          ),
                        ),
                      ),
                      width(Responsive.w(12)),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: customTextStyle(
                            fontSize: Responsive.sp(12.5),
                            color: AppColors.textColor,
                          ).copyWith(height: 1.4),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0E0E10)
          : const Color(0xFFF6F7FB),
      appBar: CustomAppBar(
        title: 'Emergency Help',
        showBack: true,
        backgroundColor: isDark ? Colors.black : const Color(0xFFF8F9FA),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(Responsive.w(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmergencyCallHero(isDark),
            height(Responsive.h(24)),
            Text(
              'Immediate guidance',
              style: customTextStyle(
                fontSize: Responsive.sp(16),
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
              ),
            ),
            height(Responsive.h(4)),
            Text(
              'Tap a scenario for a step‑by‑step checklist, or download its SOP.',
              style: customTextStyle(
                fontSize: Responsive.sp(12),
                color: AppColors.homeTextMuted,
              ),
            ),
            height(Responsive.h(16)),
            ...emergencyScenariosList.map(
              (scenario) => _buildScenarioCard(context, scenario, isDark),
            ),
            height(Responsive.h(40)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyCallHero(bool isDark) {
    const emergencyRed = Color(0xFFE15C48);

    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: emergencyRed.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(color: emergencyRed.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: emergencyRed,
                size: Responsive.sp(22),
              ),
              width(Responsive.w(8)),
              Text(
                'Facing a medico‑legal emergency?',
                style: customTextStyle(
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.w700,
                  color: emergencyRed,
                ),
              ),
            ],
          ),
          height(Responsive.h(8)),
          Text(
            'Tap to connect instantly with our on‑call legal team. Available 24×7 for notices, police visits, media enquiries and negligence allegations.',
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              color: AppColors.textColor,
            ).copyWith(height: 1.4),
          ),
          height(Responsive.h(16)),
          Wrap(
            spacing: Responsive.w(8),
            runSpacing: Responsive.h(8),
            children: [
              _callActionButton(
                label: 'Call Legal Expert',
                icon: Icons.gavel_rounded,
                bgColor: emergencyRed,
                fgColor: Colors.white,
                onTap: () => _makePhoneCall('+9118001234567'),
              ),
              _callActionButton(
                label: 'Call Consultant',
                icon: Icons.phone_in_talk_rounded,
                bgColor: isDark ? const Color(0xFF2A2A2D) : Colors.white,
                fgColor: AppColors.textColor,
                onTap: () => _makePhoneCall('+9118009876543'),
              ),
              _callActionButton(
                label: 'Chat with Support',
                icon: Icons.chat_bubble_outline_rounded,
                bgColor: isDark ? const Color(0xFF2A2A2D) : Colors.white,
                fgColor: AppColors.textColor,
                onTap: () {
                  setState(() {
                    _isOpen = true;
                  });
                },
              ),
            ],
          ),
          height(Responsive.h(10)),
          Text(
            'Calls are placed through your phone\'s own carrier — standard call rates may apply.',
            style: customTextStyle(
              fontSize: Responsive.sp(10.5),
              color: AppColors.homeTextMuted,
            ),
          ),
          if (_isOpen)
            Positioned.fill(
              child: ChatPanel(
                onClose: () {
                  setState(() {
                    _isOpen = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _callActionButton({
    required String label,
    required IconData icon,
    required Color bgColor,
    required Color fgColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Responsive.w(8)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.w(12),
          vertical: Responsive.h(8),
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(Responsive.w(8)),
          border: Border.all(color: AppColors.fieldGrey.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: Responsive.sp(14), color: fgColor),
            width(Responsive.w(6)),
            Text(
              label,
              style: customTextStyle(
                fontSize: Responsive.sp(11.5),
                fontWeight: FontWeight.w600,
                color: fgColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScenarioCard(
    BuildContext context,
    EmergencyScenarioModel scenario,
    bool isDark,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.h(12)),
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1D) : Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: AppColors.fieldGrey.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            scenario.title,
            style: customTextStyle(
              fontSize: Responsive.sp(13.5),
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(4)),
          Text(
            scenario.subtitle,
            style: customTextStyle(
              fontSize: Responsive.sp(11.5),
              color: AppColors.homeTextMuted,
            ),
          ),
          height(Responsive.h(12)),
          Row(
            children: [
              InkWell(
                onTap: () =>
                    _showChecklistBottomSheet(context, scenario, isDark),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.checklist_rounded,
                      size: Responsive.sp(15),
                      color: AppColors.newPri,
                    ),
                    width(Responsive.w(4)),
                    Text(
                      'View checklist',
                      style: customTextStyle(
                        fontSize: Responsive.sp(12),
                        fontWeight: FontWeight.w700,
                        color: AppColors.newPri,
                      ),
                    ),
                  ],
                ),
              ),
              width(Responsive.w(16)),
              InkWell(
                onTap: () async {
                  final Uri url = Uri.parse(scenario.sopPdfUrl);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.download_rounded,
                      size: Responsive.sp(15),
                      color: AppColors.homeTextMuted,
                    ),
                    width(Responsive.w(4)),
                    Text(
                      'Download SOP',
                      style: customTextStyle(
                        fontSize: Responsive.sp(12),
                        fontWeight: FontWeight.w600,
                        color: AppColors.homeTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
