import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/responsive.dart';

class RenewalCentreScreen extends ConsumerStatefulWidget {
  const RenewalCentreScreen({super.key});

  @override
  ConsumerState<RenewalCentreScreen> createState() =>
      _RenewalCentreScreenState();
}

class _RenewalCentreScreenState extends ConsumerState<RenewalCentreScreen> {
  int _selectedRenewalIndex = 0;

  final double _basePremium = 44000;

  final List<Map<String, dynamic>> _renewalOptions = [
    {'title': '9+ months out', 'discount': 0},
    {'title': '3rd month before expiry', 'discount': 3},
    {'title': '2nd month before expiry', 'discount': 2},
    {'title': 'Month of expiry', 'discount': 1},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      appBar: CustomAppBar(title: 'Renewal Centre'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track your renewal window and keep your coverage continuous.',
              style: customTextStyle(
                fontSize: 12,
                color: context.secondaryTextColor,
              ),
            ),
            height(20),
            _buildStatusCard(),
            height(16),
            _buildEarlyRenewalCard(),
            height(80),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    final isDark = context.isDarkMode;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF14281D)
                  : const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 14,
                  color: isDark
                      ? AppColors.darkBrand500
                      : const Color(0xFF059669),
                ),
                width(6),
                Text(
                  'Your plan is in good standing',
                  style: customTextStyle(
                    color: isDark
                        ? AppColors.darkBrand500
                        : const Color(0xFF059669),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          height(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plan',
                      style: customTextStyle(
                        fontSize: 12,
                        color: context.secondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Product A · Professional Indemnity',
                      style: customTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: context.primaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Renews on',
                    style: customTextStyle(
                      fontSize: 12,
                      color: context.secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '31 Aug 2026',
                    style: customTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: context.primaryTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            height: 1,
            color: context.dividerColor,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: context.secondaryTextColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "No action needed right now — we'll remind you 30 days before renewal.",
                  style: customTextStyle(
                    fontSize: 12,
                    color: context.secondaryTextColor,
                  ),
                ),
              ),
            ],
          ),
          height(12),
          Align(
            alignment: Alignment.centerLeft,
            child: PrimaryButton(
              onPressed: () {
                _policyDetails(context, ref);
              },
              text: 'View Policy Details',
              width: 200,
              height: 50,
              borderRadius: 25,
              fontSize: 14,
              gradient: LinearGradient(
                colors: [
                  AppColors.newPri,
                  AppColors.primary,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _policyDetails(
      BuildContext context,
      WidgetRef ref,
      ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: context.secondaryBackgroundColor,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 650,
            ),
            decoration: BoxDecoration(
              color: context.secondaryBackgroundColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: context.borderColor,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    20,
                    12,
                    16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Policy Details',
                          style: customTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: context.primaryTextColor,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(dialogContext).pop();
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: context.isDarkMode
                                ? AppColors.darkMint100
                                : const Color(0xFFF3F4F6),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: context.secondaryTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: context.dividerColor,
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Basic Professional Membership — Standard Plan · Professional Indemnity',
                          style: customTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: context.primaryTextColor,
                          ),
                        ),
                        height(20),
                        _policyDetailRow(
                          'Policyholder',
                          'Dr. Paresh Mathur',
                        ),
                        _policyDetailRow(
                          'State',
                          'Maharashtra',
                        ),
                        _policyDetailRow(
                          'Start Date',
                          '01 Sep 2025',
                        ),
                        _policyDetailRow(
                          'End Date',
                          '31 Aug 2026',
                        ),
                        _policyDetailRow(
                          'Sum Assured',
                          '₹ 50,00,000',
                        ),
                        _policyDetailRow(
                          'Retroactive Date',
                          '01 Sep 2020',
                        ),
                        height(12),
                        Divider(
                          color: context.dividerColor,
                        ),
                        height(16),
                        _policySection(
                          title: 'How retroactive coverage works',
                          content:
                          'Your retroactive date is the earliest date from which claims are covered, even if the incident is reported later. As long as your policy stays continuously renewed, this date keeps carrying forward. If your policy lapses and you reactivate without retroactive coverage, this date resets — incidents from before your new start date are no longer covered.',
                        ),
                        height(20),
                        _policySection(
                          title:
                          'IRDAI guidance: holding two professional policies',
                          content:
                          'IRDAI permits — and many practitioners choose — to hold two concurrent Professional Indemnity policies for a short overlap period when switching insurers. This avoids any coverage gap during the transition and lets you compare claims experience before fully moving your retroactive history to a new carrier. Speak to Service Support if you’re considering a switch.',
                        ),
                        height(20),
                        _policySection(
                          title: 'Offers & discounts available to you',
                          content: '',
                        ),
                        _offerCard(
                          icon: Icons.workspace_premium_outlined,
                          title:
                          'Upgrade to Comprehensive Professional Membership',
                          description:
                          'Add Court Representation & Bail Cost coverage. Get 15% off your first upgraded year.',
                        ),
                        height(10),
                        _offerCard(
                          icon: Icons.local_offer_outlined,
                          title: 'Early Renewal Reward',
                          description:
                          'Renew more than 30 days before expiry and get an extra 5% off, on top of any multi-year discount.',
                        ),
                        height(12),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    12,
                    20,
                    20,
                  ),
                  child: PrimaryButton(
                    text: 'Close',
                    height: 48,
                    borderRadius: 25,
                    fontSize: 14,
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    gradient: LinearGradient(
                      colors: [
                        AppColors.newPri,
                        AppColors.primary,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _policySection({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: customTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: context.primaryTextColor,
          ),
        ),
        if (content.isNotEmpty) ...[
          height(8),
          Text(
            content,
            style: customTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: context.secondaryTextColor,
            ).copyWith(height: 1.5),
          ),
        ],
      ],
    );
  }

  Widget _offerCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    final isDark = context.isDarkMode;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkMint100
            : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.borderColor,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF17263A)
                  : const Color(0xFFDBEAFE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 18,
              color: isDark
                  ? const Color(0xFF60A5FA)
                  : AppColors.primary,
            ),
          ),
          width(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: customTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: context.primaryTextColor,
                  ),
                ),
                height(4),
                Text(
                  description,
                  style: customTextStyle(
                    fontSize: 11,
                    color: context.secondaryTextColor,
                  ).copyWith(height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _policyDetailRow(
      String label,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: customTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: context.secondaryTextColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: customTextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: context.primaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarlyRenewalCard() {
    final selectedOption =
    _renewalOptions[_selectedRenewalIndex];

    final int discount =
    selectedOption['discount'] as int;

    final double premium =
        _basePremium - (_basePremium * discount / 100);

    final isDark = context.isDarkMode;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? const Color(0xFF294A68)
              : const Color(0xFFBFDBFE),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Early Renewal',
                style: customTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: context.primaryTextColor,
                ),
              ),
              InkWell(
                onTap: _showCodeGuide,
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF17263A)
                        : const Color(0xFFDBEAFE),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'No lapse · No surcharge',
                        style: customTextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: isDark
                              ? const Color(0xFF60A5FA)
                              : AppColors.primary,
                        ),
                      ),
                      width(4),
                      Icon(
                        Icons.info_outline_rounded,
                        size: 14,
                        color: isDark
                            ? const Color(0xFF60A5FA)
                            : AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          height(8),
          Text(
            'Lock in continuous coverage and your current premium before your policy is even due.',
            style: customTextStyle(
              fontSize: 13,
              color: context.primaryTextColor,
            ).copyWith(height: 1.4),
          ),
          height(18),
          Text(
            'Renewal window',
            style: customTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: context.secondaryTextColor,
            ),
          ),
          height(10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              _renewalOptions.length,
                  (index) {
                final option = _renewalOptions[index];

                final bool isSelected =
                    _selectedRenewalIndex == index;

                final int optionDiscount =
                option['discount'] as int;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedRenewalIndex = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : isDark
                          ? AppColors.darkMint100
                          : AppColors.grey.withValues(
                        alpha: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : context.borderColor,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          option['title'],
                          style: customTextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? Colors.white
                                : context.primaryTextColor,
                          ),
                        ),
                        if (optionDiscount > 0) ...[
                          height(3),
                          Text(
                            '$optionDiscount% OFF',
                            style: customTextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: isSelected
                                  ? Colors.white
                                  : isDark
                                  ? AppColors.darkBrand500
                                  : AppColors.primary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          height(20),
          Divider(
            height: 1,
            color: context.dividerColor,
          ),
          height(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Premium',
                    style: customTextStyle(
                      fontSize: 12,
                      color: context.secondaryTextColor,
                    ),
                  ),
                  height(2),
                  Text(
                    '₹ ${premium.toStringAsFixed(0)}',
                    style: customTextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: context.primaryTextColor,
                    ),
                  ),
                ],
              ),
              if (discount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF14281D)
                        : const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$discount% discount',
                    style: customTextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.darkBrand500
                          : const Color(0xFF15803D),
                    ),
                  ),
                ),
            ],
          ),
          height(16),
          PrimaryButton(
            text: 'Renew Early',
            height: 48,
            borderRadius: 25,
            fontSize: 14,
            onPressed: () {},
            gradient: LinearGradient(
              colors: [
                AppColors.newPri,
                AppColors.primary,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCodeGuide() {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.secondaryBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No discount applies for the first 9 months from the membership start date — same premium if renewed then.\n\n'
                  'A 3% discount applies in the 3rd month before expiry, '
                  '2% in the 2nd month before expiry, and '
                  '1% in the month of expiry (or within a month of expiry).',
              style: customTextStyle(
                fontSize: Responsive.h(14),
                color: context.secondaryTextColor,
              ),
            ),
            height(20),
            PrimaryButton(
              text: 'Got it',
              onPressed: () => Navigator.pop(context),
              backgroundColor: AppColors.newPri,
            ),
          ],
        ),
      ),
    );
  }
}