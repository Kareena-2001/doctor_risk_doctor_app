import 'package:flutter/material.dart';

class ApprovalStatusInfo {
  const ApprovalStatusInfo(this.label, this.color, this.background);

  final String label;
  final Color color;
  final Color background;
}

const _publishedStatuses = {
  'published',
  'approved',
  'published_to_forum',
  'published to forum',
};

const _rejectedStatuses = {'rejected', 'not_approved', 'not approved'};

/// Resolves an `approve_status` value from the API into a display label + colors.
ApprovalStatusInfo resolveApprovalStatus(String? rawStatus) {
  final status = (rawStatus ?? 'awaiting_admin_approval').toLowerCase().trim();

  if (_publishedStatuses.contains(status)) {
    return const ApprovalStatusInfo('Published', Color(0xFF16A34A), Color(0xFFF0FDF4));
  }

  if (_rejectedStatuses.contains(status)) {
    return const ApprovalStatusInfo('Not Approved', Color(0xFFDC2626), Color(0xFFFEF2F2));
  }

  if (status == 'draft') {
    return const ApprovalStatusInfo('Draft', Color(0xFF4B5563), Color(0xFFF3F4F6));
  }

  return const ApprovalStatusInfo('Awaiting Admin Approval', Color(0xFFD97706), Color(0xFFFFFBEB));
}

/// "+15 Pts" once published/approved, "+15 Pts on Approval" while pending.
String pointsLabelFor(String? rawStatus) {
  final status = (rawStatus ?? '').toLowerCase().trim();
  return _publishedStatuses.contains(status) ? '+15 Pts' : '+15 Pts on Approval';
}