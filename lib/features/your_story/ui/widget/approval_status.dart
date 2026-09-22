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

ApprovalStatusInfo resolveApprovalStatus(
    BuildContext context,
    String? rawStatus,
    ) {
  final status = (rawStatus ?? 'awaiting_admin_approval').toLowerCase().trim();
  final isDark = Theme.of(context).brightness == Brightness.dark;

  if (_publishedStatuses.contains(status)) {
    return ApprovalStatusInfo(
      'Published',
      const Color(0xFF16A34A),
      isDark
          ? const Color(0xFF14281D)
          : const Color(0xFFF0FDF4),
    );
  }

  if (_rejectedStatuses.contains(status)) {
    return ApprovalStatusInfo(
      'Not Approved',
      const Color(0xFFDC2626),
      isDark
          ? const Color(0xFF2A1719)
          : const Color(0xFFFEF2F2),
    );
  }

  if (status == 'draft') {
    return ApprovalStatusInfo(
      'Draft',
      isDark
          ? const Color(0xFFB3C0BC)
          : const Color(0xFF4B5563),
      isDark
          ? const Color(0xFF242A2D)
          : const Color(0xFFF3F4F6),
    );
  }

  return ApprovalStatusInfo(
    'Awaiting Admin Approval',
    isDark
        ? const Color(0xFFFFB84D)
        : const Color(0xFFD97706),
    isDark
        ? const Color(0xFF2A2418)
        : const Color(0xFFFFFBEB),
  );
}

String pointsLabelFor(String? rawStatus) {
  final status = (rawStatus ?? '').toLowerCase().trim();

  return _publishedStatuses.contains(status)
      ? '+15 Pts'
      : '+15 Pts on Approval';
}