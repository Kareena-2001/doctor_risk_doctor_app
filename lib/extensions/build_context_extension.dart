import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../features/common/ui/widgets/custom_snack_bar.dart';
import '../theme/app_colors.dart';

extension ThemeModeExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get primaryBackgroundColor =>
      isDarkMode ? AppColors.darkPaper : AppColors.mono0;

  Color get secondaryBackgroundColor =>
      isDarkMode ? AppColors.darkCard : AppColors.whiteBg;

  Color get secondaryWidgetColor =>
      isDarkMode ? AppColors.darkMint100 : AppColors.mono0;

  Color get primaryTextColor =>
      isDarkMode ? AppColors.darkInk900 : AppColors.mono100;

  Color get secondaryTextColor =>
      isDarkMode ? AppColors.darkInk600 : AppColors.mono80;

  Color get dividerColor => isDarkMode ? AppColors.darkLine : AppColors.mono20;

  ThemeData get lightTheme => ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.mono0,
    colorScheme: Theme.of(this).colorScheme.copyWith(
      brightness: Brightness.light,
      primary: AppColors.blueberry100,
      error: AppColors.rambutan100,
    ),
    textTheme: Theme.of(this).textTheme.apply(bodyColor: AppColors.mono100),
  );

  ThemeData get darkTheme => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.darkPaper,
    canvasColor: AppColors.darkPaper,
    cardColor: AppColors.darkCard,
    cardTheme: const CardThemeData(
      color: AppColors.darkCard,
      surfaceTintColor: Colors.transparent,
    ),
    dialogTheme: const DialogThemeData(backgroundColor: AppColors.darkCard),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.darkCard,
      surfaceTintColor: Colors.transparent,
    ),
    colorScheme: Theme.of(this).colorScheme.copyWith(
      brightness: Brightness.dark,
      primary: AppColors.darkBrand700,
      secondary: AppColors.darkBrand500,
      surface: AppColors.darkCard,
      onSurface: AppColors.darkInk900,
      outline: AppColors.darkLine,
      error: AppColors.rambutan100,
    ),
    dividerTheme: const DividerThemeData(color: AppColors.darkLine),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppColors.darkCard,
      filled: true,
      hintStyle: TextStyle(color: AppColors.darkInk400),
    ),
    textTheme: Theme.of(this).textTheme.apply(
      bodyColor: AppColors.darkInk900,
      displayColor: AppColors.darkInk900,
    ),
  );

  void showSuccessSnackBar(String text) {
    ScaffoldMessenger.of(this).showSnackBar(CustomSnackBar.success(text: text));
  }

  void showInfoSnackBar(String text) {
    ScaffoldMessenger.of(this).showSnackBar(CustomSnackBar.info(text: text));
  }

  void showWarningSnackBar(String text) {
    ScaffoldMessenger.of(this).showSnackBar(CustomSnackBar.warning(text: text));
  }

  void showErrorSnackBar(String text) {
    ScaffoldMessenger.of(this).showSnackBar(CustomSnackBar.error(text: text));
  }

  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  void tryLaunchUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      if (mounted) {
        showErrorSnackBar('Can not open url: $url');
      }
    }
  }
}
