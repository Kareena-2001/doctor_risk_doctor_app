import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/common/ui/providers/app_theme_mode_provider.dart';

class AppColors {
  AppColors._();

  static const blueberry10 = Color(0xFFE5F4FF);
  static const blueberry20 = Color(0xFFCCE9FF);
  static const blueberry30 = Color(0xFFB3DFFF);
  static const blueberry40 = Color(0xFF99D4FF);
  static const blueberry50 = Color(0xFF80C9FF);
  static const blueberry60 = Color(0xFF66BEFF);
  static const blueberry70 = Color(0xFF4CB3FF);
  static const blueberry80 = Color(0xFF33A9FF);
  static const blueberry90 = Color(0xFF1A9EFF);
  static const blueberry100 = Color(0xFF0093FF);

  static const Color fieldBorder = Color(0xFFAECDCD);
  static const Color brown = Color(0xFFAE7C51);
  static const Color iconPink = Color(0xFFFF8C93);
  static const watermelon1 = Color(0xFFCAE6D5);
  static const watermelon10 = Color(0xFFE6F3F0);
  static const watermelon20 = Color(0xFFCDE7E0);
  static const watermelon30 = Color(0xFFB4DBD1);
  static const watermelon40 = Color(0xFF9BCFC1);
  static const watermelon50 = Color(0xFF81C2B2);
  static const watermelon60 = Color(0xFF68B6A3);
  static const watermelon70 = Color(0xFF4FAA93);
  static const watermelon80 = Color(0xFF369E84);
  static const watermelon90 = Color(0xFF1D9274);
  static const watermelon100 = Color(0xFF048665);

  static const cempedak10 = Color(0xFFFFF8E8);
  static const cempedak20 = Color(0xFFFFF2D0);
  static const cempedak30 = Color(0xFFFFECB9);
  static const cempedak40 = Color(0xFFFFE5A1);
  static const cempedak50 = Color(0xFFFFDF8A);
  static const cempedak60 = Color(0xFFFFD873);
  static const cempedak70 = Color(0xFFFFD15B);
  static const cempedak80 = Color(0xFFFFCB44);
  static const cempedak90 = Color(0xFFFFC42C);
  static const cempedak100 = Color(0xFFFFBE15);

  static const rambutan10 = Color(0xFFFDE7EC);
  static const rambutan20 = Color(0xFFFACFD9);
  static const rambutan30 = Color(0xFFF8B7C6);
  static const rambutan40 = Color(0xFFF59FB3);
  static const rambutan50 = Color(0xFFF387A0);
  static const rambutan60 = Color(0xFFF06F8D);
  static const rambutan70 = Color(0xFFED577A);
  static const rambutan80 = Color(0xFFEB3F67);
  static const rambutan90 = Color(0xFFE82754);
  static const rambutan100 = Color(0xFFE60F41);

  static const whiteBg = Color(0xFFFFF5EE);
  static const mono0 = Color(0xFFFFFFFF);
  static const mono20 = Color(0xFFEFEFEF);
  static const mono40 = Color(0xFFBEBEBE);
  static const mono60 = Color(0xFF8F8F8F);
  static const mono80 = Color(0xFF606060);
  static const mono90 = Color(0xFF404040);
  static const mono100 = Color(0xFF222222);

  static const gradient0 = Color(0x00000000);
  static const gradient10 = Color(0x1A000000);
  static const gradient20 = Color(0x33000000);
  static const gradient40 = Color(0x66000000);
  static const gradient60 = Color(0x99000000);
  static const gradient80 = Color(0xCC000000);
  static const gradient100 = Color(0xFF000000);

  static const premiumBackground = Color(0xFF000000);

  static const Color newPri = Color(0xFF669b98);
  static const Color newSec = Color(0xFFedf4f4);
  static const Color newTer = Color(0xFFE4E8EA);

  static const Color primary = Color(0xFF339D5C);
  static const Color sec = Color(0xFFf6c989);
  static const Color homeAccent = Color(0xFF00C6A2);
  static const Color homeTextMuted = Color(0xFF8FA3A6);

  static const Color secondary = Color(0xFFF9B62D);
  static const Color accent = Color(0xFFFF9800);
  static const Color orange = Color(0xFFF16723);

  static const Color homeBorder = Color(0xFFE2ECEA);
  static const Color border = Color(0xFFE8E8E8);
  static const Color divider = Color(0xFFF0F0F0);
  static const Color buttonColor = Color(0xff339D5C);
  static const Color greenAccent = Color(0xFF4f772d);
  static const Color grey = Color(0xFF424242);
  static const Color greyLight = Color(0xffE6E8E9);
  static const Color lightGray = Color(0xFfd3d3d3);
  static const Color textHint = Color(0xFFAAAAAA);
  static const Color fieldGrey = Color(0xffDBDBDB);
  static const Color textColor = Color(0xFF2D3748);

  static const Color supportTabColor = Color(0xFF1565C0);
  static const Color white = Color(0xFFFFFFFF);

  static Color baseColor(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFF3C4A57) : Colors.grey.shade300;
  }

  static Color highlightColor(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFF607080) : Colors.grey.shade100;
  }

  static Color background(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5);
  }

  static Color cardBackground(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFF1E1E1E) : Colors.white;
  }

  static Color surfaceBackground(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFF2C2C2C) : const Color(0xFFFFFFFF);
  }

  static Color textBg(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? accent : const Color(0xFFFFFFFF);
  }

  // Text colors
  static Color textAccent(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFFB0C4DE) : const Color(0xFF2C3E50);
  }

  static Color textPrimary(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFFF5F5F5) : const Color(0xFF212121);
  }

  static Color textSecondary(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFFB0B0B0) : const Color(0xFF757575);
  }

  static Color textTertiary(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFF808080) : const Color(0xFF9E9E9E);
  }

  static Color textQuaternary(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFF757575) : const Color(0xFF2D2D2D);
  }

  // App Bar colors
  static Color appBarBackground(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFF1E1E1E) : Colors.white;
  }

  static Color appBarText(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? Colors.white : const Color(0xFF212121);
  }

  static Color appBarIcon(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? grey : const Color(0xFF212121);
  }

  // Bottom Nav colors
  static Color bottomNavBackground(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFF1E1E1E) : Colors.white;
  }

  static const Color bottomNavSelected = primary;

  static Color bottomNavUnselected(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFF808080) : const Color(0xFF757575);
  }

  // Card colors
  static const Color labelColor = Color(0xFF383838);

  static const Color textColorGrey = Color(0XFF6B6B6B);

  static const Color borderGrey = Color(0xFFE6E6E6);
  static const Color cardBlue = Color(0xFF2196F3);
  static const Color cardGreen = Color(0xFF4CAF50);
  static const Color red = Color(0xFFE61825);
  static const Color cardOrange = Color(0xFFFF9800);
  static const Color cardPurple = Color(0xFF9C27B0);
  static const Color cardRed = Color(0xFFF44336);

  static Color cardSelected(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? orange : const Color(0xFF2D2D2D);
  }

  // Border colors
  static Color borderColor(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFF424242) : const Color(0xFFE0E0E0);
  }

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF42A5F5);

  static Color shimmerBase(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFF3A3A3A) : Colors.grey.shade300;
  }

  static Color shimmerHighlight(WidgetRef ref) {
    final isDark = ref.watch(appThemeModeProvider).value == ThemeMode.dark;
    return isDark ? const Color(0xFF4F4F4F) : Colors.grey.shade100;
  }
}
