import 'package:flutter/material.dart';
import 'package:flame/components.dart';

class GameConstants {
  static final Vector2 cardSize = Vector2(60, 80);
  static const double cardSpacing = 70;
  static const int gridColumns = 4;
  static const int gridRows = 4;
  static const double animationDuration = 0.3;
}

class GameColors {
  static const Color background = Color(0xFFF5F5DC);
  static const Color cardBack = Color(0xFF4A90E2);
  static const Color cardFront = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFF333333);
  static const Color hearts = Color(0xFFE74C3C);
  static const Color diamonds = Color(0xFFE74C3C);
  static const Color clubs = Color(0xFF2C3E50);
  static const Color spades = Color(0xFF2C3E50);
  static const Color matched = Color(0xFF27AE60);
}