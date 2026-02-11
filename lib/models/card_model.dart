import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// Card state representing the lifecycle of garden growth
enum CardState {
  faceDown,  // Dormant
  faceUp,    // Revealed
  matched,   // Blooming
  wilted,    // After wrong match (temporary)
}

/// Card model with emotional properties
class CardModel extends Equatable {
  final String id;
  final CardType type;
  final int value; // For matching pairs
  final CardState state;
  
  // Emotional properties (affects garden)
  final double vitality; // 0.0 to 1.0 (how "alive" the card feels)
  final int consecutiveCorrect; // Streak counter
  
  const CardModel({
    required this.id,
    required this.type,
    required this.value,
    this.state = CardState.faceDown,
    this.vitality = 1.0,
    this.consecutiveCorrect = 0,
  });

  /// Check if two cards match
  bool matches(CardModel other) {
    return value == other.value && id != other.id;
  }
  
  /// Boost vitality on correct match
  CardModel onCorrectMatch() {
    return copyWith(
      vitality: (vitality + GardenBalance.recoveryRate).clamp(0.0, 1.0),
      consecutiveCorrect: consecutiveCorrect + 1,
      state: CardState.matched,
    );
  }
  
  /// Reduce vitality on wrong match (gentle)
  CardModel onWrongMatch() {
    return copyWith(
      vitality: (vitality - GardenBalance.wiltRate).clamp(0.0, 1.0),
      consecutiveCorrect: 0,
      state: CardState.wilted,
    );
  }
  
  /// Recover from wilted state
  CardModel recover() {
    if (state == CardState.wilted) {
      return copyWith(
        state: CardState.faceDown,
        vitality: (vitality + 0.05).clamp(0.0, 1.0),
      );
    }
    return this;
  }
  
  /// Get the plant emoji based on type and state
  String get displayEmoji {
    if (state == CardState.matched) {
      // Fully bloomed version
      switch (type) {
        case CardType.seed:
          return '🌿'; // Sprouted
        case CardType.leaf:
          return '🍀'; // Four-leaf clover
        case CardType.flower:
          return '🌺'; // Hibiscus
        case CardType.season:
          return '🌻'; // Sunflower
      }
    } else if (state == CardState.wilted) {
      return '🥀'; // Wilted
    } else {
      return type.emoji; // Default
    }
  }
  
  /// Get the display name
  String get displayName => type.name;
  
  /// Get the display color
  Color get displayColor => type.color;
  
  /// Check if this is a rare plant (high streak)
  bool get isRare => consecutiveCorrect >= GardenBalance.rarePlantStreak;
  
  /// Check if this is perfect (very high streak)
  bool get isPerfect => consecutiveCorrect >= GardenBalance.perfectStreak;

  @override
  List<Object?> get props => [id, type, value, state, vitality];
  
  CardModel copyWith({
    String? id,
    CardType? type,
    int? value,
    CardState? state,
    double? vitality,
    int? consecutiveCorrect,
  }) {
    return CardModel(
      id: id ?? this.id,
      type: type ?? this.type,
      value: value ?? this.value,
      state: state ?? this.state,
      vitality: vitality ?? this.vitality,
      consecutiveCorrect: consecutiveCorrect ?? this.consecutiveCorrect,
    );
  }
}
