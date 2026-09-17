import 'package:Doctors_App/features/community/model/referred_doctors_response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';

class ReferralList extends StatelessWidget {
  final List<ReferredDoctor> referrals;

  const ReferralList({super.key, required this.referrals});

  @override
  Widget build(BuildContext context) {
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
            (referral) => Padding(
          padding: EdgeInsets.only(bottom: Responsive.h(10)),
          child: _ReferralTile(referral: referral),
        ),
      )
          .toList(),
    );
  }
}

class _ReferralTile extends StatelessWidget {
  final ReferredDoctor referral;

  const _ReferralTile({required this.referral});

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
                  referral.fullName,
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
        ],
      ),
    );
  }
}