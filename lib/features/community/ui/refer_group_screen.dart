import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../theme/app_colors.dart';
import '../model/refer_model.dart';
import '../view_model/refer_view_model.dart';

class ReferAndGroupsTab extends ConsumerStatefulWidget {
  const ReferAndGroupsTab({super.key});

  @override
  ConsumerState<ReferAndGroupsTab> createState() => _ReferAndGroupsTabState();
}

class _ReferAndGroupsTabState extends ConsumerState<ReferAndGroupsTab> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  String? _speciality;
  bool _isSubmitting = false;

  final List<String> _specialities = const [
    'General Practice',
    'Surgery',
    'Orthopedics',
    'Gynaecology',
    'Cardiology',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _emailController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  Future<void> _copyLink(String link) async {
    if (link.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: link));
    if (!mounted) return;
    context.showSuccessSnackBar('Referral link copied');
  }

  Future<void> _shareVia(String channel, String link) async {
    if (link.isEmpty) return;
    final text =
        "Join me on Doctors Risk — use my referral link to sign up: $link";

    switch (channel) {
      case 'whatsapp':
      case 'x':
        // share_plus opens the system share sheet; the user picks the app.
        // If you need a direct WhatsApp/X deep link instead, swap this for
        // url_launcher with the platform-specific share URL.
        // await SharePlus.instance.share(ShareParams(text: text));
        break;
      case 'email':
        // await SharePlus.instance.share(
        //   ShareParams(subject: 'Join me on Doctors Risk', text: text),
        // );
        break;
    }
  }

  Future<void> _submitReferral() async {
    if (_nameController.text.trim().isEmpty ||
        _numberController.text.trim().isEmpty ||
        _speciality == null) {
      context.showWarningSnackBar('Please fill in all required fields');
      return;
    }

    setState(() => _isSubmitting = true);
    //
    // final error = await ref
    //     .read(referralSummaryProvider.notifier)
    //     .submitReferral(
    //       ReferralFormData(
    //         name: _nameController.text.trim(),
    //         speciality: _speciality!,
    //         number: _numberController.text.trim(),
    //         email: _emailController.text,
    //         remark: _remarkController.text,
    //       ),
    //     );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    // if (error == null) {
    //   _nameController.clear();
    //   _numberController.clear();
    //   _emailController.clear();
    //   _remarkController.clear();
    //   setState(() => _speciality = null);
    //   context.showSuccessSnackBar(
    //     'Referral submitted! Points will be credited on verification',
    //   );
    // } else {
    //   context.showWarningSnackBar(error);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final summaryAsync = ref.watch(referralSummaryProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(referralSummaryProvider.notifier).refresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(Responsive.w(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            summaryAsync.when(
              data: (summary) => _buildHeaderBanner(summary.peersReferredCount),
              loading: () => _buildHeaderBanner(null),
              error: (_, __) => _buildHeaderBanner(0),
            ),
            height(Responsive.h(16)),
            summaryAsync.when(
              data: (summary) => _buildReferralLinkCard(summary.referralLink),
              loading: () => _buildReferralLinkCard(null),
              error: (_, __) => _buildReferralLinkCard(''),
            ),
            height(Responsive.h(16)),
            _buildReferralForm(),
            height(Responsive.h(16)),
            Text(
              'Your referrals',
              style: customTextStyle(
                fontSize: Responsive.sp(15),
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            height(Responsive.h(10)),
            summaryAsync.when(
              data: (summary) => _buildReferralsList(summary.referrals),
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => _buildReferralsError(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBanner(int? peersReferred) {
    return Container(
      padding: EdgeInsets.all(Responsive.w(18)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Responsive.w(20)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.newPri, AppColors.newPri.withValues(alpha: 0.75)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.newPri.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(Responsive.w(10)),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(Responsive.w(14)),
                ),
                child: Icon(
                  Icons.card_giftcard_rounded,
                  color: Colors.white,
                  size: Responsive.sp(20),
                ),
              ),
              width(Responsive.w(14)),
              Text(
                'Refer & Earn',
                style: customTextStyle(
                  fontSize: Responsive.sp(17),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          height(Responsive.h(10)),
          Text(
            'Invite a peer, earn reward points',
            style: customTextStyle(
              fontSize: Responsive.sp(12.5),
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          height(Responsive.h(6)),
          Text(
            'When a referred professional joins and secures a membership, '
            'you earn reward points — redeemable at your next renewal, '
            'new plan purchase, or a paid event.',
            style: customTextStyle(
              fontSize: Responsive.sp(11),
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          height(Responsive.h(14)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(12),
              vertical: Responsive.h(8),
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Responsive.w(10)),
            ),
            child: Text(
              peersReferred == null
                  ? 'Peers referred'
                  : '$peersReferred Peers referred',
              style: customTextStyle(
                fontSize: Responsive.sp(12),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralLinkCard(String? link) {
    final displayLink = link ?? '';
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
                  child: Text(
                    displayLink.isEmpty ? 'Loading your link…' : displayLink,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: customTextStyle(
                      fontSize: Responsive.sp(12),
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                width(Responsive.w(8)),
                InkWell(
                  onTap: () => _copyLink(displayLink),
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
                  onTap: () => _shareVia('whatsapp', displayLink),
                ),
              ),
              width(Responsive.w(10)),
              Expanded(
                child: _buildShareButton(
                  label: 'Email',
                  icon: Icons.email_rounded,
                  onTap: () => _shareVia('email', displayLink),
                ),
              ),
              width(Responsive.w(10)),
              Expanded(
                child: _buildShareButton(
                  label: 'X',
                  icon: Icons.close_rounded,
                  onTap: () => _shareVia('x', displayLink),
                ),
              ),
            ],
          ),
        ],
      ),
    );
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

  Widget _buildReferralForm() {
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
            'Refer a colleague directly',
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(4)),
          Text(
            "A form is required even if you've already shared your link.",
            style: customTextStyle(
              fontSize: Responsive.sp(11),
              color: Colors.grey.shade600,
            ),
          ),
          height(Responsive.h(14)),
          CustomTextField(label: 'Name', controller: _nameController),
          height(Responsive.h(14)),
          CustomDropdownField<String>(
            label: 'Speciality',
            hint: 'Speciality',
            value: _speciality,
            items: _specialities,
            onChanged: (String? value) => setState(() => _speciality = value),
          ),
          height(Responsive.h(14)),
          CustomTextField(
            label: 'Number *',
            controller: _numberController,
            keyboardType: TextInputType.phone,
          ),
          height(Responsive.h(14)),
          CustomTextField(
            label: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          height(Responsive.h(14)),
          CustomTextField(
            label: 'Remark (optional)',
            controller: _remarkController,
            maxLines: 2,
          ),
          height(Responsive.h(18)),
          SizedBox(
            width: double.infinity,
            height: Responsive.h(46),
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submitReferral,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.newPri,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Responsive.w(12)),
                ),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Submit Referral',
                      style: customTextStyle(
                        fontSize: Responsive.sp(13.5),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralsList(List<ReferralEntry> referrals) {
    if (referrals.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(Responsive.w(20)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Responsive.w(16)),
        ),
        child: Text(
          'No referrals yet. Share your link to get started.',
          textAlign: TextAlign.center,
          style: customTextStyle(
            fontSize: Responsive.sp(12),
            color: Colors.grey.shade600,
          ),
        ),
      );
    }

    return Column(
      children: referrals
          .map(
            (r) => Padding(
              padding: EdgeInsets.only(bottom: Responsive.h(10)),
              child: _buildReferralTile(r),
            ),
          )
          .toList(),
    );
  }

  Widget _buildReferralTile(ReferralEntry referral) {
    final isJoined = referral.status == ReferralStatus.joined;
    final dateLabel = DateFormat('d MMM yyyy').format(referral.date);

    return Container(
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(14)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  referral.doctorName,
                  style: customTextStyle(
                    fontSize: Responsive.sp(13),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                height(Responsive.h(3)),
                Text(
                  isJoined ? dateLabel : 'Signed up $dateLabel',
                  style: customTextStyle(
                    fontSize: Responsive.sp(10.5),
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(10),
              vertical: Responsive.h(6),
            ),
            decoration: BoxDecoration(
              color: isJoined
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Responsive.w(8)),
            ),
            child: Text(
              isJoined ? 'Joined · +${referral.pointsEarned} Pts' : 'Pending',
              style: customTextStyle(
                fontSize: Responsive.sp(10.5),
                fontWeight: FontWeight.bold,
                color: isJoined
                    ? Colors.green.shade700
                    : Colors.orange.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralsError() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
      ),
      child: Column(
        children: [
          Text(
            "Couldn't load your referrals.",
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              color: Colors.grey.shade600,
            ),
          ),
          height(Responsive.h(8)),
          TextButton(
            onPressed: () =>
                ref.read(referralSummaryProvider.notifier).refresh(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
