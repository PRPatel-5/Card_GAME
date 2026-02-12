class PlayerProgress {
  int currentLevel;
  int totalCoins;
  Map<int, LevelProgress> completedLevels;
  Set<int> unlockedCards;
  Set<int> unlockedRewards;
  Map<String, int> statistics;

  PlayerProgress({
    this.currentLevel = 1,
    this.totalCoins = 0,
    Map<int, LevelProgress>? completedLevels,
    Set<int>? unlockedCards,
    Set<int>? unlockedRewards,
    Map<String, int>? statistics,
  })  : completedLevels = completedLevels ?? {},
        unlockedCards = unlockedCards ?? {},
        unlockedRewards = unlockedRewards ?? {},
        statistics = statistics ?? {
          'totalGamesPlayed': 0,
          'totalMatches': 0,
          'totalMismatches': 0,
          'longestStreak': 0,
          'totalPlayTime': 0,
          'perfectLevels': 0,
        };

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'currentLevel': currentLevel,
      'totalCoins': totalCoins,
      'completedLevels': completedLevels.map(
        (key, value) => MapEntry(key.toString(), value.toJson()),
      ),
      'unlockedCards': unlockedCards.toList(),
      'unlockedRewards': unlockedRewards.toList(),
      'statistics': statistics,
    };
  }

  // Create from JSON
  factory PlayerProgress.fromJson(Map<String, dynamic> json) {
    return PlayerProgress(
      currentLevel: json['currentLevel'] ?? 1,
      totalCoins: json['totalCoins'] ?? 0,
      completedLevels: (json['completedLevels'] as Map<String, dynamic>?)
              ?.map((key, value) => MapEntry(
                    int.parse(key),
                    LevelProgress.fromJson(value),
                  )) ??
          {},
      unlockedCards: (json['unlockedCards'] as List<dynamic>?)?.cast<int>().toSet() ?? {},
      unlockedRewards: (json['unlockedRewards'] as List<dynamic>?)?.cast<int>().toSet() ?? {},
      statistics: (json['statistics'] as Map<String, dynamic>?)?.cast<String, int>() ?? {},
    );
  }

  void unlockCard(int cardId) {
    unlockedCards.add(cardId);
  }

  void unlockReward(int level) {
    unlockedRewards.add(level);
  }

  void addCoins(int amount) {
    totalCoins += amount;
  }

  void completeLevel(int level, LevelProgress progress) {
    completedLevels[level] = progress;
    if (level >= currentLevel) {
      currentLevel = level + 1;
    }
  }

  int getStarsForLevel(int level) {
    return completedLevels[level]?.stars ?? 0;
  }

  int getTotalStars() {
    return completedLevels.values.fold(0, (sum, progress) => sum + progress.stars);
  }

  bool isLevelUnlocked(int level) {
    return level <= currentLevel;
  }

  void incrementStat(String statName, [int amount = 1]) {
    statistics[statName] = (statistics[statName] ?? 0) + amount;
  }
}

class LevelProgress {
  final int levelNumber;
  final int stars; // 1-3 stars based on performance
  final int score;
  final int timeRemaining;
  final int matchesCount;
  final int mismatchesCount;
  final DateTime completedAt;
  final bool isPerfect; // No mistakes

  LevelProgress({
    required this.levelNumber,
    required this.stars,
    required this.score,
    required this.timeRemaining,
    required this.matchesCount,
    required this.mismatchesCount,
    required this.completedAt,
    required this.isPerfect,
  });

  Map<String, dynamic> toJson() {
    return {
      'levelNumber': levelNumber,
      'stars': stars,
      'score': score,
      'timeRemaining': timeRemaining,
      'matchesCount': matchesCount,
      'mismatchesCount': mismatchesCount,
      'completedAt': completedAt.toIso8601String(),
      'isPerfect': isPerfect,
    };
  }

  factory LevelProgress.fromJson(Map<String, dynamic> json) {
    return LevelProgress(
      levelNumber: json['levelNumber'],
      stars: json['stars'],
      score: json['score'],
      timeRemaining: json['timeRemaining'],
      matchesCount: json['matchesCount'],
      mismatchesCount: json['mismatchesCount'],
      completedAt: DateTime.parse(json['completedAt']),
      isPerfect: json['isPerfect'],
    );
  }

  // Calculate stars based on performance
  static int calculateStars(int timeRemaining, int timeLimit, int mismatches) {
    if (mismatches == 0 && timeRemaining > timeLimit * 0.5) {
      return 3; // Perfect + fast
    } else if (mismatches <= 2 && timeRemaining > timeLimit * 0.3) {
      return 2; // Good performance
    } else {
      return 1; // Completed
    }
  }
}
