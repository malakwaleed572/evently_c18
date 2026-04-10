import 'package:evently/common/theme/app_colors.dart';
import 'package:evently/common/theme/text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorSchemeSeed: AppColors.mainLightMode,
    scaffoldBackgroundColor: AppColors.lightBg,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightBg,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyle.style18w500Black.copyWith(
        color: AppColors.maintextLightMode,
      ),
    ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (BuildContext context) => Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.strokeLightMode),
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.mainLightMode,
        ),
      ),
    ),
    textTheme: _generateTextTheme(AppColors.maintextLightMode),
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainLightMode),
    ),
  );
  static final ThemeData darktTheme = ThemeData(
    colorSchemeSeed: AppColors.mainDarkMode,
    scaffoldBackgroundColor: AppColors.darkBg,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBg,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyle.style18w500Black.copyWith(
        color: AppColors.mainTextDarkMode,
      ),
    ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (BuildContext context) => Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.inputs,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.strokeDarkMode),
        ),
        child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
      ),
    ),
    textTheme: _generateTextTheme(AppColors.mainTextDarkMode),
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainDarkMode),
    ),
  );
  static TextTheme _generateTextTheme(Color color) {
    return TextTheme(
      displayLarge: AppTextStyle.style24w600Black.copyWith(color: color),
      displayMedium: AppTextStyle.style20w500Black.copyWith(color: color),
      displaySmall: AppTextStyle.style20w400Black.copyWith(color: color),

      headlineLarge: AppTextStyle.style18w600Black.copyWith(color: color),
      headlineMedium: AppTextStyle.style18w500Black.copyWith(color: color),
      headlineSmall: AppTextStyle.style18w400Black.copyWith(color: color),
      titleLarge: AppTextStyle.style16w600Black.copyWith(color: color),
      titleMedium: AppTextStyle.style16w500Black.copyWith(color: color),
      titleSmall: AppTextStyle.style16w400Black.copyWith(color: color),
      labelLarge: AppTextStyle.style14w600Black.copyWith(color: color),
      labelMedium: AppTextStyle.style14w500Black.copyWith(color: color),
      labelSmall: AppTextStyle.style14w400Black.copyWith(color: color),
      bodyLarge: AppTextStyle.style12BoldBlack.copyWith(color: color),
      bodyMedium: AppTextStyle.style12w500Black.copyWith(color: color),
      bodySmall: AppTextStyle.style12w400Black.copyWith(color: color),
    );
  }
}
