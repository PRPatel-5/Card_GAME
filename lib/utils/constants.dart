import 'package:flutter/material.dart';
import 'package:flame/components.dart';

/// Design System for Memory Garden
/// Focused on: Calm, Organic, Emotional
class GardenConstants {
  // Card System
  static final Vector2 cardSize = Vector2(75, 100);
  static const double cardSpacing = 85;
  static const int gridColumns = 4;
  static const int gridRows = 4;
  
  // Timing (Everything is SLOW and CALM)
  static const double flipDuration = 0.6; // Slower than normal
  static const double growthDuration = 1.2; // Plants grow slowly
  static const double fadeInDuration = 0.8;
  static const double breathingCycle = 3.0; // Plants "breathe"
  
  // Card radius
  static const double cardRadius = 16.0;
  
  // Garden zones (for plant placement)
  static const double groundLevel = 500.0;
}

/// Calming Color Palette
/// Inspired by: Early morning garden, soft sunlight, earth
class GardenColors {
  // Base garden colors (pastel and earthy)
  static const Color skyMorning = Color(0xFFE8F4F8);
  static const Color skyEvening = Color(0xFFFFF4E6);
  
  // Ground colors
  static const Color soilDark = Color(0xFF6B5D4F);
  static const Color soilLight = Color(0xFF8B7765);
  static const Color grass = Color(0xFFB8D4B8);
  
  // Card colors (soft, non-aggressive)
  static const Color cardBack = Color(0xFFE8E0D5); // Cream
  static const Color cardFront = Color(0xFFFFFBF5); // Warm white
  static const Color cardBorder = Color(0xFFD4C4B0);
  
  // Card types (organic colors)
  static const Color seedBrown = Color(0xFF8B7355);
  static const Color leafGreen = Color(0xFF7FA779);
  static const Color flowerPink = Color(0xFFE8A5A5);
  static const Color seasonGold = Color(0xFFD4AF6A);
  
  // Plant states (emotional colors)
  static const Color plantHealthy = Color(0xFF88C057); // Vibrant green
  static const Color plantWilting = Color(0xFF9BA89C); // Faded green
  static const Color plantThriving = Color(0xFF6DB33F); // Bright green
  
  // Special effects (subtle)
  static const Color particleGlow = Color(0xFFFFF8DC);
  static const Color mistWhite = Color(0xFFFFFFFF);
  
  // UI text (low contrast, calm)
  static const Color textPrimary = Color(0xFF5A5A5A);
  static const Color textSecondary = Color(0xFF8A8A8A);
  static const Color textHighlight = Color(0xFF7FA779);
}

/// Typography (Soft and readable)
class GardenTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w300, // Light weight
    color: GardenColors.textPrimary,
    letterSpacing: 4,
    height: 1.2,
  );
  
  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: GardenColors.textSecondary,
    letterSpacing: 2,
  );
  
  static const TextStyle cardText = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 1,
  );
  
  static const TextStyle hint = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: GardenColors.textSecondary,
    fontStyle: FontStyle.italic,
  );
}

/// Game balance (No pressure!)
class GardenBalance {
  // Garden health system
  static const double healthyThreshold = 0.8; // 80%+ accuracy
  static const double wiltingThreshold = 0.5; // Below 50%
  
  // Streak bonuses (not aggressive)
  static const int rarePlantStreak = 5; // After 5 correct matches
  static const int perfectStreak = 10; // After 10 correct
  
  // Recovery system (garden heals itself)
  static const double recoveryRate = 0.1; // 10% recovery per good match
  static const double wiltRate = 0.05; // Only 5% wilt on mistake
}

/// Card Type Definitions
enum CardType {
  seed,   // 🌱 Basic
  leaf,   // 🍃 Boosts nearby
  flower, // 🌸 Multiplier
  season, // 🍂 Changes behavior
}

extension CardTypeExtension on CardType {
  String get emoji {
    switch (this) {
      case CardType.seed:
        return '🌱';
      case CardType.leaf:
        return '🍃';
      case CardType.flower:
        return '🌸';
      case CardType.season:
        return '🍂';
    }
  }
  
  Color get color {
    switch (this) {
      case CardType.seed:
        return GardenColors.seedBrown;
      case CardType.leaf:
        return GardenColors.leafGreen;
      case CardType.flower:
        return GardenColors.flowerPink;
      case CardType.season:
        return GardenColors.seasonGold;
    }
  }
  
  String get name {
    switch (this) {
      case CardType.seed:
        return 'SEED';
      case CardType.leaf:
        return 'LEAF';
      case CardType.flower:
        return 'FLOWER';
      case CardType.season:
        return 'SEASON';
    }
  }
}

/// Garden Themes (Unlockable)
enum GardenTheme {
  morning,  // Default: Soft green, warm light
  forest,   // Deep greens, moss
  desert,   // Sandy, cacti
  night,    // Dark blues, moonlight
}

extension GardenThemeExtension on GardenTheme {
  Color get skyColor {
    switch (this) {
      case GardenTheme.morning:
        return GardenColors.skyMorning;
      case GardenTheme.forest:
        return const Color(0xFF264E36);
      case GardenTheme.desert:
        return const Color(0xFFFFF4E0);
      case GardenTheme.night:
        return const Color(0xFF1A2332);
    }
  }
  
  Color get groundColor {
    switch (this) {
      case GardenTheme.morning:
        return GardenColors.grass;
      case GardenTheme.forest:
        return const Color(0xFF3A5F3F);
      case GardenTheme.desert:
        return const Color(0xFFD4A76A);
      case GardenTheme.night:
        return const Color(0xFF2A3A4A);
    }
  }
}

/// Animation Curves (All organic, no harsh transitions)
class GardenCurves {
  static const Curve gentle = Curves.easeInOutCubic;
  static const Curve breath = Curves.easeInOutSine;
  static const Curve grow = Curves.easeOutQuart;
  static const Curve wilt = Curves.easeInQuad;
}
