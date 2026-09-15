import 'package:flutter/material.dart';

/// Source of truth: mockups/Paleta de colores.pdf.
///
/// The color section in the design-system document is intentionally ignored.
abstract final class AppColors {
  static const primary500 = Color(0xFFFF6117);

  static const secondary500 = Color(0xFF343C98);
  static const secondary700 = Color(0xFF000449);
  static const secondary900 = Color(0xFF000222);

  static const neutral100 = Color(0xFFF4F7FA);
  static const neutral300 = Color(0xFFCFDEE9);
  static const neutral500 = Color(0xFF7B8794);
  static const neutral700 = Color(0xFF3D4957);
  static const neutral900 = Color(0xFF17202A);

  static const info100 = Color(0xFFE3F2FD);
  static const info700 = Color(0xFF155A8A);

  static const warning100 = Color(0xFFFFF0C2);
  static const warning700 = Color(0xFFB76800);
  static const warning900 = Color(0xFF663900);

  static const error500 = Color(0xFFFF3E40);

  static const canvas = neutral100;
  static const surface = Colors.white;
  static const textPrimary = secondary700;
  static const textSecondary = neutral700;
  static const captureMenuScrim = Color(0xA3000449);
}
