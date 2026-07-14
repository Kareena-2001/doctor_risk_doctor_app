import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../theme/app_colors.dart';
import '../model/whatsApp_model.dart';

class ReferAndGroupsTab extends ConsumerStatefulWidget {
  const ReferAndGroupsTab({super.key});

  @override
  ConsumerState<ReferAndGroupsTab> createState() => _ReferAndGroupsTabState();
}

class _ReferAndGroupsTabState extends ConsumerState<ReferAndGroupsTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  String? _speciality;
  bool _isSubmitting = false;

  final List<WhatsAppGroup> _groups = const [
    WhatsAppGroup(
      name: 'Doctors Risk — General Practice',
      description: 'Case discussions, updates, and peer support',
      memberCount: '1.2k members',
      inviteLink: 'https://chat.whatsapp.com/PLACEHOLDER1',
    ),
    WhatsAppGroup(
      name: 'Doctors Risk — Surgery & Specialists',
      description: 'Speciality-focused legal and compliance updates',
      memberCount: '860 members',
      inviteLink: 'https://chat.whatsapp.com/PLACEHOLDER2',
    ),
    WhatsAppGroup(
      name: 'Doctors Risk — Announcements',
      description: 'Webinars, events, and policy news',
      memberCount: '2.1k members',
      inviteLink: 'https://chat.whatsapp.com/PLACEHOLDER3',
    ),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  Future<void> _joinGroup(String link) async {
    final uri = Uri.parse(link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (mounted) {
      context.showSuccessSnackBar('Could not open WhatsApp');
    }
  }

  Future<void> _submitReferral() async {
    if (_nameController.text.trim().isEmpty ||
        _numberController.text.trim().isEmpty ||
        _speciality == null) {
      context.showWarningSnackBar('Please Fill in all fields');
      return;
    }

    setState(() => _isSubmitting = true);

    // ref.read(communityViewModelProvider.notifier).referPeer(
    //   name: _nameController.text, number: _numberController.text, speciality: _speciality!,
    // );
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() {
      _isSubmitting = false;
      _nameController.clear();
      _numberController.clear();
      _speciality = null;
    });

    context.showSuccessSnackBar(
      'Referral submitted! Points will be credited on verification',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.w(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPointsBanner(),
          height(Responsive.h(24)),
          Text(
            'WhatsApp Community Groups',
            style: customTextStyle(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(4)),
          Text(
            'Join to stay updated on the latest trends and discussions',
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              color: Colors.grey.shade600,
            ),
          ),
          height(Responsive.h(14)),
          ..._groups.map(
            (g) => Padding(
              padding: EdgeInsets.only(bottom: Responsive.h(12)),
              child: _buildGroupCard(g),
            ),
          ),
          height(Responsive.h(14)),
          Text(
            'Refer a Peer',
            style: customTextStyle(
              fontSize: Responsive.sp(15),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          height(Responsive.h(4)),
          Text(
            'Know a professional who\'d benefit from our services? Refer and earn points',
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              color: Colors.grey.shade600,
            ),
          ),
          height(Responsive.h(14)),
          _buildReferralForm(),
        ],
      ),
    );
  }

  Widget _buildPointsBanner() {
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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.w(10)),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Responsive.w(14)),
            ),
            child: Icon(
              Icons.stars_rounded,
              color: Colors.white,
              size: Responsive.sp(20),
            ),
          ),
          width(Responsive.w(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '240 Points',
                  style: customTextStyle(
                    fontSize: Responsive.sp(16),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Earn points for every successful referral',
                  style: customTextStyle(
                    fontSize: Responsive.sp(10.5),
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(WhatsAppGroup group) {
    return Container(
      padding: EdgeInsets.all(Responsive.w(14)),
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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.w(10)),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Responsive.w(12)),
            ),
            child: const Icon(Icons.groups_rounded, color: AppColors.primary),
          ),
          width(Responsive.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name,
                  style: customTextStyle(
                    fontSize: Responsive.sp(13),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                height(Responsive.h(3)),
                Text(
                  group.description,
                  style: customTextStyle(
                    fontSize: Responsive.sp(11),
                    color: Colors.grey.shade600,
                  ),
                ),
                height(Responsive.h(3)),
                Text(
                  group.memberCount,
                  style: customTextStyle(
                    fontSize: Responsive.sp(10.5),
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          width(Responsive.w(8)),
          ElevatedButton(
            onPressed: () => _joinGroup(group.inviteLink),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.w(14),
                vertical: Responsive.h(10),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Responsive.w(10)),
              ),
            ),
            child: Text(
              'Join',
              style: customTextStyle(
                fontSize: Responsive.sp(11),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralForm() {
    final specialities = [
      'General Practice',
      'Surgery',
      'Orthopedics',
      'Gynaecology',
      'Cardiology',
      'Other',
    ];

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
          CustomTextField(
            label: 'Doctor / Professional Name',
            controller: _nameController,
          ),
          height(Responsive.h(14)),
          CustomTextField(
            label: 'Phone Number',
            controller: _numberController,
            keyboardType: TextInputType.phone,
          ),
          height(Responsive.h(14)),
          CustomDropdownField<String>(
            label: 'Select Type',
            hint: 'Speciality',
            controller: _numberController,
            value: _speciality,
            items: specialities,
            onChanged: (String? value) {
              setState(() {
                _speciality = value;
              });
            },
          ),
          height(Responsive.h(18)),
          SizedBox(
            width: double.infinity,
            height: Responsive.h(46),
            child: ElevatedButton.icon(
              onPressed: _isSubmitting ? null : _submitReferral,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.newPri,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Responsive.w(12)),
                ),
              ),
              icon: _isSubmitting
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(
                      Icons.person_add_alt_1_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
              label: Text(
                _isSubmitting ? 'Submitting...' : 'Refer & Earn Points',
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
}
