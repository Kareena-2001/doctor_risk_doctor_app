import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/emergency/model/sop_response.dart';
import 'package:Doctors_App/features/emergency/ui/state/emergency_state.dart';
import 'package:Doctors_App/features/emergency/ui/view_model/emergency_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';
import '../../common/ui/widgets/primary_button.dart';

class EmergencyAssistanceScreen extends ConsumerStatefulWidget {
  const EmergencyAssistanceScreen({super.key});

  @override
  ConsumerState<EmergencyAssistanceScreen> createState() =>
      _EmergencyAssistanceScreenState();
}

class _EmergencyAssistanceScreenState
    extends ConsumerState<EmergencyAssistanceScreen> {
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(emergencyViewModelProvider.notifier).loadSops();
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  Future<void> _downloadSop(String url) async {
    final uri = Uri.tryParse(url);

    if (uri == null) {
      if (mounted) {
        context.showErrorSnackBar('Invalid SOP URL');
      }
      return;
    }

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          context.showErrorSnackBar('Unable to open SOP');
        }
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar('Unable to open SOP');
      }
    }
  }

  void _showChecklistBottomSheet(
    BuildContext context,
    SopModel sop,
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
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Responsive.w(20),
              Responsive.h(16),
              Responsive.w(20),
              Responsive.h(24),
            ),
            child: SingleChildScrollView(
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
                  height(Responsive.h(14)),
                  Text(
                    sop.checklistTitle,
                    style: customTextStyle(
                      fontSize: Responsive.sp(15),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  ),
                  height(Responsive.h(12)),
                  Text(
                    sop.title,
                    style: customTextStyle(
                      fontSize: Responsive.sp(12),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  ),
                  height(Responsive.h(8)),
                  Html(
                    data: sop.checklistDescription,
                    style: {
                      'body': Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        color: AppColors.textColor,
                        fontSize: FontSize(Responsive.sp(12.5)),
                        lineHeight: LineHeight.number(1.45),
                      ),
                      'ol': Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.only(left: Responsive.w(20)),
                      ),
                      'li': Style(
                        margin: Margins.only(bottom: Responsive.h(10)),
                        color: AppColors.textColor,
                        fontSize: FontSize(Responsive.sp(12.5)),
                      ),
                    },
                  ),
                  height(Responsive.h(18)),
                  PrimaryButton(
                    text: 'Download full SOP',
                    onPressed: sop.downloadButtonVisible
                        ? () => _downloadSop(sop.sop ?? '')
                        : null,
                    icon: sop.downloadButtonVisible
                        ? Icons.file_download_outlined
                        : Icons.lock_outline_rounded,
                    height: Responsive.h(46),
                    borderRadius: Responsive.w(25),
                    fontSize: Responsive.sp(13),
                    backgroundColor: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final state = ref.watch(emergencyViewModelProvider);

    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      appBar: CustomAppBar(
        title: 'Emergency Help',
        showBack: true,
        backgroundColor: isDark ? Colors.black : const Color(0xFFF8F9FA),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return ref.read(emergencyViewModelProvider.notifier).loadSops();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
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
                'Tap a scenario for a step-by-step checklist, or download its SOP.',
                style: customTextStyle(
                  fontSize: Responsive.sp(12),
                  color: AppColors.homeTextMuted,
                ),
              ),
              height(Responsive.h(16)),
              _buildSopContent(context: context, state: state, isDark: isDark),
              height(Responsive.h(40)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSopContent({
    required BuildContext context,
    required EmergencyState state,
    required bool isDark,
  }) {
    if (state.isSopLoading && state.sops.isEmpty) {
      return _buildLoadingState();
    }

    if (state.sopError != null && state.sops.isEmpty) {
      return _buildErrorState(state.sopError!);
    }

    if (state.sops.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: state.sops
          .map((sop) => _buildScenarioCard(context, sop, isDark))
          .toList(),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: Responsive.h(40)),
      child: Column(
        children: [
          SizedBox(
            width: Responsive.w(28),
            height: Responsive.w(28),
            child: const CircularProgressIndicator(strokeWidth: 2.5),
          ),
          height(Responsive.h(12)),
          Text(
            'Loading emergency guidance...',
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              color: AppColors.homeTextMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(20)),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: Responsive.sp(30),
            color: Colors.red,
          ),
          height(Responsive.h(10)),
          Text(
            'Unable to load emergency guidance',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(13),
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(6)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(11.5),
              color: AppColors.homeTextMuted,
            ),
          ),
          height(Responsive.h(14)),
          TextButton.icon(
            onPressed: () {
              ref.read(emergencyViewModelProvider.notifier).loadSops();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try again'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: Responsive.h(40)),
      child: Column(
        children: [
          Icon(
            Icons.shield_outlined,
            size: Responsive.sp(40),
            color: AppColors.homeTextMuted,
          ),
          height(Responsive.h(12)),
          Text(
            'No emergency guidance available',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(13),
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyCallHero(bool isDark) {
    const heroBg = Color(0xFFFFF5F5);

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
            'Facing a medico-legal emergency?',
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF2C3E50),
            ),
          ),

          height(Responsive.h(8)),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Text(
              'Tap to connect instantly with our on-call legal team. Available 24×7 for notices, police visits, media enquiries and negligence allegations.',
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
              PrimaryButton(
                text: 'Call Legal Expert',
                onPressed: () => _makePhoneCall('+9118001234567'),
                height: Responsive.h(40),
                width: Responsive.w(130),
                borderRadius: Responsive.w(25),
                gradientColors: [AppColors.primary, AppColors.newPri],
                textColor: Colors.white,
                fontSize: Responsive.sp(12),
                fontWeight: FontWeight.w600,
              ),

              PrimaryButton(
                text: 'Call Consultant',
                onPressed: () => _makePhoneCall('+9118009876543'),
                height: Responsive.h(40),
                width: Responsive.w(130),
                borderRadius: Responsive.w(25),
                backgroundColor: Color(0xFFFFF5F5),
                borderColor: Colors.grey.shade300,
                textColor: AppColors.textColor,
                fontSize: Responsive.sp(12),
                fontWeight: FontWeight.w600,
              ),
              PrimaryButton(
                text: 'Chat with Support',
                onPressed: () {
                  setState(() {
                    _isOpen = true;
                  });
                },
                height: Responsive.h(40),
                width: Responsive.w(130),
                borderRadius: Responsive.w(25),
                backgroundColor: Color(0xFFFFF5F5),
                borderColor: Colors.grey.shade300,
                textColor: AppColors.textColor,
                fontSize: Responsive.sp(12),
                fontWeight: FontWeight.w600,
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

  Widget _buildScenarioCard(BuildContext context, SopModel sop, bool isDark) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.h(12)),
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1D) : Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey.shade200,
        ),
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
                      sop.title,
                      style: customTextStyle(
                        fontSize: Responsive.sp(12),
                        fontWeight: FontWeight.w700,
                        color: AppColors.textColor,
                      ),
                    ),

                    height(Responsive.h(4)),

                    Text(
                      sop.shortDescription,
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
            spacing: Responsive.w(12),
            runSpacing: Responsive.h(10),
            children: [
              PrimaryButton(
                text: 'View checklist',
                onPressed: () {
                  _showChecklistBottomSheet(context, sop, isDark);
                },
                height: Responsive.h(36),
                width: Responsive.w(145),
                borderRadius: Responsive.w(25),
                borderColor: context.borderColor,
                textColor: context.primaryTextColor,
                fontSize: Responsive.sp(12),
                backgroundColor: context.primaryBackgroundColor,
              ),
              PrimaryButton(
                text: 'Download SOP',
                onPressed: sop.downloadButtonVisible
                    ? () => _downloadSop(sop.sop ?? '')
                    : null,
                icon: sop.downloadButtonVisible
                    ? null
                    : Icons.lock_outline_rounded,
                height: Responsive.h(36),
                width: Responsive.w(145),
                borderRadius: Responsive.w(25),
                fontSize: Responsive.sp(12),
                borderColor: context.borderColor,
                textColor: context.primaryTextColor,
                backgroundColor: context.primaryBackgroundColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
