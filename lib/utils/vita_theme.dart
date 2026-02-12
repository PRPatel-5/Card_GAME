import 'package:flutter/material.dart';

class VitaTheme {
  // Primary Colors
  static const primaryDark = Color(0xFF1A1B2E);
  static const primaryLight = Color(0xFF2C3E50);
  static const accentGold = Color(0xFFFFD700);
  static const accentCrimson = Color(0xFFDC143C);
  static const accentEmerald = Color(0xFF50C878);
  
  // Text Colors
  static const textLight = Color(0xFFFFF8DC);
  static const textDark = Color(0xFF2C2C2C);
  
  // Card Rarity Colors
  static const commonGreen = Color(0xFF228B22);
  static const rareBlue = Color(0xFF4169E1);
  static const epicPurple = Color(0xFF9400D3);
  static const legendaryGold = Color(0xFFFFD700);
  
  // UI Elements
  static const successGreen = Color(0xFF00C853);
  static const errorRed = Color(0xFFD32F2F);
  static const cardBack = Color(0xFFFFF8DC);
  static const cardFront = Color(0xFFFFFFFF);
  
  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryDark,
      scaffoldBackgroundColor: primaryDark,
      colorScheme: const ColorScheme.dark(
        primary: accentGold,
        secondary: accentCrimson,
        surface: primaryLight,
      ),
      cardTheme: const CardThemeData(
        color: primaryLight,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentGold,
          foregroundColor: textDark,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class VitaConstants {
  static const double cardAspectRatio = 0.7;
  static const Duration cardFlipDuration = Duration(milliseconds: 400);
  static const Duration matchDelay = Duration(milliseconds: 600);
  static const Duration hintDuration = Duration(seconds: 3);
  static const Duration revealDuration = Duration(seconds: 2);
  static const Duration freezeDuration = Duration(seconds: 5);
}
