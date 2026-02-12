import 'vita_card.dart';

enum LevelDifficulty {
  tutorial, // 1-10
  beginner, // 11-25
  intermediate, // 26-40
  advanced, // 41-60
  expert, // 61-80
  master // 81-100
}

class GameLevel {
  final int levelNumber;
  final LevelDifficulty difficulty;
  final int gridRows;
  final int gridCols;
  final int totalCards; // Must be even
  final int timeLimit; // seconds
  final int hintsAvailable;
  final int shufflesAvailable;
  final List<CardCategory> allowedCategories;
  final bool isBossLevel;
  final int coinsReward;

  const GameLevel({
    required this.levelNumber,
    required this.difficulty,
    required this.gridRows,
    required this.gridCols,
    required this.totalCards,
    required this.timeLimit,
    required this.hintsAvailable,
    required this.shufflesAvailable,
    required this.allowedCategories,
    this.isBossLevel = false,
    required this.coinsReward,
  });

  int get totalPairs => totalCards ~/ 2;

  String get difficultyName {
    switch (difficulty) {
      case LevelDifficulty.tutorial:
        return 'TUTORIAL';
      case LevelDifficulty.beginner:
        return 'BEGINNER';
      case LevelDifficulty.intermediate:
        return 'INTERMEDIATE';
      case LevelDifficulty.advanced:
        return 'ADVANCED';
      case LevelDifficulty.expert:
        return 'EXPERT';
      case LevelDifficulty.master:
        return 'MASTER';
    }
  }
}

class LevelGenerator {
  static List<GameLevel> generateAll100Levels() {
    List<GameLevel> levels = [];

    // Levels 1-10: TUTORIAL
    for (int i = 1; i <= 10; i++) {
      levels.add(GameLevel(
        levelNumber: i,
        difficulty: LevelDifficulty.tutorial,
        gridRows: 3,
        gridCols: 4,
        totalCards: 12,
        timeLimit: 180,
        hintsAvailable: 5,
        shufflesAvailable: 3,
        allowedCategories: [CardCategory.nature],
        isBossLevel: i == 10,
        coinsReward: i == 10 ? 100 : 20,
      ));
    }

    // Levels 11-25: BEGINNER
    for (int i = 11; i <= 25; i++) {
      levels.add(GameLevel(
        levelNumber: i,
        difficulty: LevelDifficulty.beginner,
        gridRows: 4,
        gridCols: 4,
        totalCards: 16,
        timeLimit: 240,
        hintsAvailable: 4,
        shufflesAvailable: 2,
        allowedCategories: [CardCategory.nature, CardCategory.japanese],
        isBossLevel: i == 20,
        coinsReward: i == 20 ? 200 : 30,
      ));
    }

    // Levels 26-40: INTERMEDIATE
    for (int i = 26; i <= 40; i++) {
      levels.add(GameLevel(
        levelNumber: i,
        difficulty: LevelDifficulty.intermediate,
        gridRows: 4,
        gridCols: 6,
        totalCards: 24,
        timeLimit: 300,
        hintsAvailable: 3,
        shufflesAvailable: 2,
        allowedCategories: [
          CardCategory.nature,
          CardCategory.japanese,
          CardCategory.celestial
        ],
        isBossLevel: i == 30 || i == 40,
        coinsReward: (i == 30 || i == 40) ? 300 : 40,
      ));
    }

    // Levels 41-60: ADVANCED
    for (int i = 41; i <= 60; i++) {
      levels.add(GameLevel(
        levelNumber: i,
        difficulty: LevelDifficulty.advanced,
        gridRows: 5,
        gridCols: 6,
        totalCards: 30,
        timeLimit: 360,
        hintsAvailable: 2,
        shufflesAvailable: 1,
        allowedCategories: [
          CardCategory.nature,
          CardCategory.japanese,
          CardCategory.celestial,
          CardCategory.mythical
        ],
        isBossLevel: i == 50 || i == 60,
        coinsReward: (i == 50 || i == 60) ? 500 : 50,
      ));
    }

    // Levels 61-80: EXPERT
    for (int i = 61; i <= 80; i++) {
      levels.add(GameLevel(
        levelNumber: i,
        difficulty: LevelDifficulty.expert,
        gridRows: 5,
        gridCols: 8,
        totalCards: 40,
        timeLimit: 420,
        hintsAvailable: 2,
        shufflesAvailable: 1,
        allowedCategories: [
          CardCategory.nature,
          CardCategory.japanese,
          CardCategory.celestial,
          CardCategory.mythical,
          CardCategory.seasonal
        ],
        isBossLevel: i == 70 || i == 80,
        coinsReward: (i == 70 || i == 80) ? 700 : 60,
      ));
    }

    // Levels 81-100: MASTER
    for (int i = 81; i <= 100; i++) {
      levels.add(GameLevel(
        levelNumber: i,
        difficulty: LevelDifficulty.master,
        gridRows: 6,
        gridCols: 8,
        totalCards: 48,
        timeLimit: i == 100 ? 600 : 480,
        hintsAvailable: 1,
        shufflesAvailable: 1,
        allowedCategories: CardCategory.values,
        isBossLevel: i == 90 || i == 100,
        coinsReward: i == 100 ? 5000 : (i == 90 ? 900 : 70),
      ));
    }

    return levels;
  }

  static GameLevel? getLevelByNumber(int levelNumber) {
    if (levelNumber < 1 || levelNumber > 100) return null;
    final levels = generateAll100Levels();
    return levels[levelNumber - 1];
  }
}
