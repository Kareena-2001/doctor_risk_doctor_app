String formatFriendlyDate(String? raw, {String emptyFallback = 'N/A'}) {
  if (raw == null || raw.trim().isEmpty) {
    return emptyFallback;
  }

  try {
    final parsed = DateTime.parse(raw.replaceFirst(' ', 'T'));

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${parsed.day} ${months[parsed.month - 1]} ${parsed.year}';
  } catch (_) {
    return raw;
  }
}

/// Capitalizes the first letter and lowercases the rest, e.g. "VIDEO" -> "Video".
String capitalizeFirst(String value, {String fallback = ''}) {
  if (value.trim().isEmpty) return fallback;
  return value[0].toUpperCase() + value.substring(1).toLowerCase();
}

/// Title-cases a snake_case or space separated status string,
/// e.g. "awaiting_admin_approval" -> "Awaiting Admin Approval".
String titleCaseStatus(String? raw, {String fallback = ''}) {
  if (raw == null || raw.trim().isEmpty) return fallback;

  return raw
      .replaceAll('_', ' ')
      .trim()
      .split(RegExp(r'\s+'))
      .map(
        (word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1),
      )
      .join(' ');
}
