import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/community/model/referred_doctors_response.dart';
import 'package:Doctors_App/core/widgets/pagination_footer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/values/app_text_style.dart';

class ReferralList extends StatelessWidget {
  final List<ReferredDoctor> referrals;
  final bool hasMore;
  final bool isLoadingMore;
  final String? paginationError;
  final VoidCallback onLoadMore;

  const ReferralList({
    super.key,
    required this.referrals,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    this.paginationError,
  });

  @override
  Widget build(BuildContext context) {
    if (referrals.isEmpty) {
      return Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(Responsive.w(20)),
            decoration: BoxDecoration(
              color: context.secondaryBackgroundColor,
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
          ),
          PaginationFooter(
            hasMore: hasMore,
            isLoading: isLoadingMore,
            errorMessage: paginationError,
            onLoadMore: onLoadMore,
          ),
        ],
      );
    }

    return Column(
      children: [
        ...referrals.map(
          (referral) => Padding(
            padding: EdgeInsets.only(bottom: Responsive.h(10)),
            child: _ReferralTile(referral: referral),
          ),
        ),
        PaginationFooter(
          hasMore: hasMore,
          isLoading: isLoadingMore,
          errorMessage: paginationError,
          onLoadMore: onLoadMore,
        ),
      ],
    );
  }
}

class _ReferralTile extends StatelessWidget {
  final ReferredDoctor referral;

  const _ReferralTile({required this.referral});

  void _showReferralDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(sheetContext).size.height * 0.75,
          ),
          decoration: BoxDecoration(
            color: Theme.of(sheetContext).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Responsive.w(24)),
            ),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Responsive.w(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: Responsive.w(42),
                      height: Responsive.h(4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  height(Responsive.h(18)),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Referral Details',
                          style: customTextStyle(
                            fontSize: Responsive.sp(18),
                            fontWeight: FontWeight.bold,
                            color: sheetContext.primaryTextColor,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),

                  height(Responsive.h(8)),

                  _DetailRow(
                    icon: Icons.person_outline_rounded,
                    label: 'Full Name',
                    value: referral.fullName,
                  ),

                  _DetailRow(
                    icon: Icons.verified_user_outlined,
                    label: 'Status',
                    value: referral.status.isNotEmpty
                        ? _capitalize(referral.status)
                        : 'N/A',
                  ),

                  _DetailRow(
                    icon: Icons.category_outlined,
                    label: 'Category',
                    value: _displayValue(referral.categoryName),
                  ),

                  _DetailRow(
                    icon: Icons.medical_services_outlined,
                    label: 'Speciality',
                    value: _displayValue(referral.specialityName),
                  ),

                  _DetailRow(
                    icon: Icons.school_outlined,
                    label: 'Degree',
                    value: _displayValue(referral.degree),
                  ),

                  _DetailRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Referred On',
                    value: _formatDate(referral.createdOn),
                  ),

                  _DetailRow(
                    icon: Icons.notes_outlined,
                    label: 'Remarks',
                    value: _displayValue(referral.remarks),
                    isLast: true,
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
    final isJoined = referral.status.toLowerCase() == 'joined';

    final parsedDate = DateTime.tryParse(referral.createdOn);

    final dateLabel = parsedDate != null
        ? DateFormat('d MMM yyyy').format(parsedDate)
        : referral.createdOn;

    return Container(
      padding: EdgeInsets.all(Responsive.w(14)),
      decoration: BoxDecoration(
        border: Border.all(color: context.borderColor),
        color: context.secondaryBackgroundColor,
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
                  referral.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: customTextStyle(
                    fontSize: Responsive.sp(13),
                    fontWeight: FontWeight.bold,
                    color: context.primaryTextColor,
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

          width(Responsive.w(8)),

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
              isJoined ? 'Joined' : 'Pending',
              style: customTextStyle(
                fontSize: Responsive.sp(10.5),
                fontWeight: FontWeight.bold,
                color: isJoined
                    ? Colors.green.shade700
                    : Colors.orange.shade700,
              ),
            ),
          ),

          width(Responsive.w(4)),

          IconButton(
            onPressed: () => _showReferralDetails(context),
            tooltip: 'View referral',
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.visibility_outlined,
              size: Responsive.sp(20),
              color: context.primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  static String _displayValue(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Not provided';
    }

    return value.trim();
  }

  static String _formatDate(String value) {
    final date = DateTime.tryParse(value);

    if (date == null) {
      return value;
    }

    return DateFormat('d MMM yyyy, hh:mm a').format(date.toLocal());
  }

  static String _capitalize(String value) {
    if (value.isEmpty) {
      return value;
    }

    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : Responsive.h(14)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Responsive.w(36),
            height: Responsive.w(36),
            decoration: BoxDecoration(
              color: context.primaryTextColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(Responsive.w(10)),
            ),
            child: Icon(
              icon,
              size: Responsive.sp(18),
              color: context.primaryTextColor,
            ),
          ),

          width(Responsive.w(12)),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: customTextStyle(
                    fontSize: Responsive.sp(10),
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                height(Responsive.h(3)),

                Text(
                  value,
                  style: customTextStyle(
                    fontSize: Responsive.sp(12),
                    fontWeight: FontWeight.w600,
                    color: context.primaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
