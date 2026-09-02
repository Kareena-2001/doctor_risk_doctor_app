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
    const heroBg = Color(0xFFFFF5F5);
    const primaryButtonColor = Color(0xFF0F9D58);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(24),
        vertical: Responsive.h(32),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.withValues(alpha: 0.5)),
        color: isDark ? const Color(0xFF1E1616) : heroBg,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Responsive.w(72),
            height: Responsive.w(72),
            decoration: const BoxDecoration(
              color: Color(0xFFE55B48),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.phone_in_talk_rounded,
              color: Colors.white,
              size: Responsive.sp(32),
            ),
          ),
          height(Responsive.h(20)),
          Text(
            'Facing a medico‑legal emergency?',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2C3E50),
            ),
          ),
          height(Responsive.h(8)),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Text(
              'Tap to connect instantly with our on‑call legal team. Available 24×7 for notices, police visits, media enquiries and negligence allegations.',
              textAlign: TextAlign.center,
              style: customTextStyle(
                fontSize: Responsive.sp(12.5),
                color: AppColors.textColor,
              ).copyWith(height: 1.4),
            ),
          ),
          height(Responsive.h(20)),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: Responsive.w(12),
            runSpacing: Responsive.h(12),
            children: [
              _callActionButton(
                label: 'Call Legal Expert',
                icon: null,
                bgColor: primaryButtonColor,
                fgColor: Colors.white,
                onTap: () => _makePhoneCall('+9118001234567'),
              ),
              _callActionButton(
                label: 'Call Consultant',
                icon: null,
                bgColor: Colors.white,
                fgColor: AppColors.textColor,
                showBorder: true,
                onTap: () => _makePhoneCall('+9118009876543'),
              ),
              _callActionButton(
                label: 'Chat with Support',
                icon: null,
                bgColor: Colors.white,
                fgColor: AppColors.textColor,
                showBorder: true,
                onTap: () {
                  setState(() {
                    _isOpen = true;
                  });
                },
              ),
            ],
          ),
          height(Responsive.h(16)),
          Text(
            'Calls are placed through your phone\'s own carrier — standard call rates may apply.',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(11),
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _callActionButton({
    required String label,
    IconData? icon,
    required Color bgColor,
    required Color fgColor,
    bool showBorder = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Responsive.w(25)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.w(20),
          vertical: Responsive.h(10),
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(Responsive.w(25)),
          border: showBorder ? Border.all(color: Colors.grey.shade300) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: customTextStyle(
                fontSize: Responsive.sp(12),
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
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1D) : Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(Responsive.w(8)),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(Responsive.w(8)),
                ),
                child: Icon(
                  Icons.shield_outlined,
                  size: Responsive.sp(18),
                  color: const Color(0xFF2E7D32),
                ),
              ),
              width(Responsive.w(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scenario.title,
                      style: customTextStyle(
                        fontSize: Responsive.sp(12),
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
                  ],
                ),
              ),
            ],
          ),
          height(Responsive.h(16)),
          Wrap(
            spacing: Responsive.w(16),
            runSpacing: Responsive.h(8),
            children: [
              InkWell(
                onTap: () =>
                    _showChecklistBottomSheet(context, scenario, isDark),
                borderRadius: BorderRadius.circular(Responsive.w(4)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Responsive.h(4),
                    horizontal: Responsive.w(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.fact_check_outlined,
                        size: Responsive.sp(15),
                        color: AppColors.textColor,
                      ),
                      width(Responsive.w(6)),
                      Text(
                        'View checklist',
                        style: customTextStyle(
                          fontSize: Responsive.sp(12),
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  final Uri url = Uri.parse(scenario.sopPdfUrl);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                borderRadius: BorderRadius.circular(Responsive.w(4)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Responsive.h(4),
                    horizontal: Responsive.w(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.file_download_outlined,
                        size: Responsive.sp(15),
                        color: AppColors.textColor,
                      ),
                      width(Responsive.w(6)),
                      Text(
                        'Download SOP',
                        style: customTextStyle(
                          fontSize: Responsive.sp(12),
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
