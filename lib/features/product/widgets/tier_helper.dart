import 'package:flutter/material.dart';

class TierStyle {
  final Color accentColor;
  final Color bgColor;
  final Color textColor;
  final IconData icon;

  const TierStyle({
    required this.accentColor,
    required this.bgColor,
    required this.textColor,
    required this.icon,
  });
}
class TierStyles {
  static const bronze = TierStyle(
    accentColor: Color(0xFFB87333),
    bgColor: Color(0xFFFFF4EC),
    textColor: Color(0xFF8C4A16),
    icon: Icons.shield_outlined,
  );

  static const silver = TierStyle(
    accentColor: Color(0xFF94A3B8),
    bgColor: Color(0xFFF8FAFC),
    textColor: Color(0xFF475569),
    icon: Icons.shield_rounded,
  );

  static const gold = TierStyle(
    accentColor: Color(0xFFD4AF37),
    bgColor: Color(0xFFFFF8E1),
    textColor: Color(0xFF8B6B00),
    icon: Icons.workspace_premium_rounded,
  );

  static const platinum = TierStyle(
    accentColor: Color(0xFF2D3748),
    bgColor: Color(0xFFF7FAFC),
    textColor: Color(0xFF1A202C),
    icon: Icons.diamond_rounded,
  );

  static const basic = TierStyle(
    accentColor: Color(0xFF0EA5E9),
    bgColor: Color(0xFFE0F2FE),
    textColor: Color(0xFF0369A1),
    icon: Icons.star_border_rounded,
  );

  static const standard = TierStyle(
    accentColor: Color(0xFF059669),
    bgColor: Color(0xFFECFDF5),
    textColor: Color(0xFF065F46),
    icon: Icons.verified_rounded,
  );
}

String formatAmount(double amount) {
  if (amount >= 10000000) return '${(amount / 10000000).toStringAsFixed(1)}Cr';
  if (amount >= 100000) {
    final l = amount / 100000;
    return '${l % 1 == 0 ? l.toInt() : l}L';
  }
  if (amount >= 1000) {
    final k = amount / 1000;
    return '${k % 1 == 0 ? k.toInt() : k}K';
  }
  return amount.toInt().toString();
}

String formatDate(DateTime dt) {
  const months = [
    '',
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
  return '${dt.day.toString().padLeft(2, '0')} ${months[dt.month]} ${dt.year}';
}
