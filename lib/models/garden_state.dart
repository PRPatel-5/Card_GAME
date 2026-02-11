import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// Garden State - The living, breathing entity that responds to player
class GardenState extends Equatable {
  final double overallHealth; // 0.0 to 1.0
  final int totalMatches;
  final int totalMistakes;
  final int currentStreak;
  final int bestStreak;
  final GardenTheme theme;
  final List<PlantGrowth> plants; // All plants in the garden
  
  // Emotional state (affects visuals and sound)
  final GardenMood mood;
  
  // Time of day (affects lighting and colors)
  final TimeOfDay timeOfDay;
  
  const GardenState({
    this.overallHealth = 1.0,
    this.totalMatches = 0,
    this.totalMistakes = 0,
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.theme = GardenTheme.morning,
    this.plants = const [],
    this.mood = GardenMood.peaceful,
    this.timeOfDay = TimeOfDay.morning,
  });
  
  /// Calculate accuracy percentage
  double get accuracy {
    final total = totalMatches + totalMistakes;
    if (total == 0) return 1.0;
    return totalMatches / total;
  }
  
  /// Check if garden is thriving (high accuracy)
  bool get isThriving => accuracy >= GardenBalance.healthyThreshold;
  
  /// Check if garden is struggling
  bool get isStruggling => accuracy < GardenBalance.wiltingThreshold;
  
  /// Get garden mood based on performance
  GardenMood calculateMood() {
    if (currentStreak >= 5) return GardenMood.joyful;
    if (isThriving) return GardenMood.peaceful;
    if (isStruggling) return GardenMood.melancholic;
    return GardenMood.calm;
  }
  
  /// Update state after correct match
  GardenState onCorrectMatch(PlantGrowth newPlant) {
    return copyWith(
      totalMatches: totalMatches + 1,
      currentStreak: currentStreak + 1,
      bestStreak: currentStreak + 1 > bestStreak ? currentStreak + 1 : bestStreak,
      overallHealth: (overallHealth + 0.05).clamp(0.0, 1.0),
      plants: [...plants, newPlant],
      mood: calculateMood(),
    );
  }
  
  /// Update state after mistake
  GardenState onMistake() {
    return copyWith(
      totalMistakes: totalMistakes + 1,
      currentStreak: 0,
      overallHealth: (overallHealth - 0.03).clamp(0.0, 1.0),
      mood: calculateMood(),
    );
  }
  
  /// Progress to next time of day
  GardenState progressTimeOfDay() {
    final nextTime = timeOfDay.next;
    return copyWith(timeOfDay: nextTime);
  }

  @override
  List<Object?> get props => [
    overallHealth,
    totalMatches,
    totalMistakes,
    currentStreak,
    bestStreak,
    theme,
    plants,
    mood,
    timeOfDay,
  ];
  
  GardenState copyWith({
    double? overallHealth,
    int? totalMatches,
    int? totalMistakes,
    int? currentStreak,
    int? bestStreak,
    GardenTheme? theme,
    List<PlantGrowth>? plants,
    GardenMood? mood,
    TimeOfDay? timeOfDay,
  }) {
    return GardenState(
      overallHealth: overallHealth ?? this.overallHealth,
      totalMatches: totalMatches ?? this.totalMatches,
      totalMistakes: totalMistakes ?? this.totalMistakes,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      theme: theme ?? this.theme,
      plants: plants ?? this.plants,
      mood: mood ?? this.mood,
      timeOfDay: timeOfDay ?? this.timeOfDay,
    );
  }
}

/// Individual plant growth in the garden
class PlantGrowth extends Equatable {
  final String id;
  final CardType plantType;
  final double x; // Position in garden
  final double y;
  final double size; // Growth size (0.0 to 1.0)
  final double age; // How long it's been growing
  final bool isRare; // Special plant from streak
  
  const PlantGrowth({
    required this.id,
    required this.plantType,
    required this.x,
    required this.y,
    this.size = 0.0,
    this.age = 0.0,
    this.isRare = false,
  });
  
  /// Plant emoji representation
  String get emoji {
    if (isRare) {
      // Rare variants
      switch (plantType) {
        case CardType.seed:
          return '🌳'; // Tree
        case CardType.leaf:
          return '🌴'; // Palm tree
        case CardType.flower:
          return '🌹'; // Rose
        case CardType.season:
          return '🎋'; // Bamboo
      }
    } else {
      // Normal growth
      return plantType.emoji;
    }
  }
  
  /// Grow the plant over time
  PlantGrowth grow(double delta) {
    return PlantGrowth(
      id: id,
      plantType: plantType,
      x: x,
      y: y,
      size: (size + delta * 0.1).clamp(0.0, 1.0),
      age: age + delta,
      isRare: isRare,
    );
  }

  @override
  List<Object?> get props => [id, plantType, x, y, size, age, isRare];
}

/// Garden mood affects colors, sounds, and particle effects
enum GardenMood {
  peaceful,    // Default: Soft greens, gentle sounds
  joyful,      // High streak: Bright colors, happy sounds
  melancholic, // Poor performance: Faded colors, slower sounds
  calm,        // Neutral: Balanced
}

extension GardenMoodExtension on GardenMood {
  /// Get color tint for this mood
  Color get tint {
    switch (this) {
      case GardenMood.peaceful:
        return GardenColors.plantHealthy.withOpacity(0.3);
      case GardenMood.joyful:
        return GardenColors.plantThriving.withOpacity(0.4);
      case GardenMood.melancholic:
        return GardenColors.plantWilting.withOpacity(0.3);
      case GardenMood.calm:
        return Colors.transparent;
    }
  }
  
  /// Get sound pitch modifier
  double get soundPitch {
    switch (this) {
      case GardenMood.joyful:
        return 1.1; // Slightly higher pitch
      case GardenMood.melancholic:
        return 0.9; // Slightly lower pitch
      default:
        return 1.0;
    }
  }
}

/// Time of day affects lighting and atmosphere
enum TimeOfDay {
  morning,
  noon,
  evening,
  night,
}

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay get next {
    switch (this) {
      case TimeOfDay.morning:
        return TimeOfDay.noon;
      case TimeOfDay.noon:
        return TimeOfDay.evening;
      case TimeOfDay.evening:
        return TimeOfDay.night;
      case TimeOfDay.night:
        return TimeOfDay.morning;
    }
  }
  
  Color get skyColor {
    switch (this) {
      case TimeOfDay.morning:
        return  Color(0xFFFFE5B4); // Peach
      case TimeOfDay.noon:
        return Color(0xFF87CEEB); // Sky blue
      case TimeOfDay.evening:
        return Color(0xFFFFB347); // Orange
      case TimeOfDay.night:
        return Color(0xFF191970); // Midnight blue
    }
  }
  
  double get brightness {
    switch (this) {
      case TimeOfDay.morning:
        return 0.9;
      case TimeOfDay.noon:
        return 1.0;
      case TimeOfDay.evening:
        return 0.7;
      case TimeOfDay.night:
        return 0.4;
    }
  }
}
