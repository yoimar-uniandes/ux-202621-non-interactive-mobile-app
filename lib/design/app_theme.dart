import 'package:fakto_mobile/design/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  const TextTheme textTheme = TextTheme(
    displaySmall: TextStyle(
      fontSize: 32,
      height: 1.25,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      height: 1.333,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(fontSize: 16, height: 1.5),
    bodyMedium: TextStyle(fontSize: 14, height: 1.429),
    labelLarge: TextStyle(
      fontSize: 14,
      height: 1.429,
      fontWeight: FontWeight.w500,
    ),
  );
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.canvas,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary500,
      onPrimary: AppColors.secondary700,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      outline: AppColors.neutral300,
      error: AppColors.error500,
    ),
    textTheme: textTheme.apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    ),
  );
}
