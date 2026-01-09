import 'package:flutter/material.dart';
import 'package:flame/components.dart';

class GameConstants {
  static final Vector2 cardSize = Vector2(70, 95);
  static const double cardSpacing = 80;
  static const int gridColumns = 4;
  static const int gridRows = 4;
  static const double animationDuration = 0.5;
  static const double flipDuration = 0.3;
  static const double matchDelay = 0.8;
  static const double cardRadius = 12.0;
  
  // Game modes
  static const int easyPairs = 8;
  static const int mediumPairs = 12;
  static const int hardPairs = 16;
}

class GameColors {
  // Modern gradient backgrounds
  static const Color primaryDark = Color(0xFF0F172A);
  static const Color primaryLight = Color(0xFF1E293B);
  
  // Card colors with gradients
  static const Color cardBackStart = Color(0xFF6366F1);
  static const Color cardBackEnd = Color(0xFF8B5CF6);
  
  static const Color cardFrontStart = Color(0xFFFFFFFF);
  static const Color cardFrontEnd = Color(0xFFF8FAFC);
  
  // Matched cards - success green gradient
  static const Color matchedStart = Color(0xFF10B981);
  static const Color matchedEnd = Color(0xFF059669);
  
  // Wrong match - subtle red
  static const Color wrongMatchStart = Color(0xFFEF4444);
  static const Color wrongMatchEnd = Color(0xFFDC2626);
  
  // Card border & shadow
  static const Color cardBorder = Color(0xFFE2E8F0);
  static const Color cardShadow = Color(0x40000000);
  
  // Suit colors - vibrant
  static const Color hearts = Color(0xFFEC4899);
  static const Color diamonds = Color(0xFFF59E0B);
  static const Color clubs = Color(0xFF3B82F6);
  static const Color spades = Color(0xFF8B5CF6);
  
  // UI elements
  static const Color scoreText = Color(0xFFF1F5F9);
  static const Color accentGold = Color(0xFFFBBF24);
  static const Color buttonGradientStart = Color(0xFF8B5CF6);
  static const Color buttonGradientEnd = Color(0xFF6366F1);
}

class GameStyles {
  static const TextStyle scoreStyle = TextStyle(
    color: GameColors.scoreText,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );
  
  static const TextStyle movesStyle = TextStyle(
    color: GameColors.scoreText,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  
  static const TextStyle cardRankStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle cardSuitStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
}