class Reward {
  final int levelUnlocked;
  final String title;
  final String titleJp;
  final String emoji;
  final String description;
  final int coinsBonus;
  final RewardType type;

  const Reward({
    required this.levelUnlocked,
    required this.title,
    required this.titleJp,
    required this.emoji,
    required this.description,
    required this.coinsBonus,
    required this.type,
  });
}

enum RewardType {
  hints,
  shuffle,
  powerUp,
  feature,
  bonus
}

class RewardDatabase {
  static const List<Reward> allRewards = [
    Reward(
      levelUnlocked: 5,
      title: 'Hint Master',
      titleJp: 'ヒントマスター',
      emoji: '💡',
      description: '+2 permanent hints per level',
      coinsBonus: 50,
      type: RewardType.hints,
    ),
    Reward(
      levelUnlocked: 10,
      title: 'Shuffle King',
      titleJp: 'シャッフル王',
      emoji: '🔄',
      description: '+1 permanent shuffle per level',
      coinsBonus: 100,
      type: RewardType.shuffle,
    ),
    Reward(
      levelUnlocked: 15,
      title: 'Time Wizard',
      titleJp: '時間魔法使い',
      emoji: '⏸️',
      description: 'Unlock Time Freeze power-up',
      coinsBonus: 150,
      type: RewardType.powerUp,
    ),
    Reward(
      levelUnlocked: 20,
      title: 'Eagle Eye',
      titleJp: '鷹の目',
      emoji: '👁️',
      description: 'Unlock Reveal All power-up',
      coinsBonus: 200,
      type: RewardType.powerUp,
    ),
    Reward(
      levelUnlocked: 25,
      title: 'Card Collector',
      titleJp: 'カードコレクター',
      emoji: '📚',
      description: 'Unlock Card Gallery',
      coinsBonus: 250,
      type: RewardType.feature,
    ),
    Reward(
      levelUnlocked: 30,
      title: 'Match Multiplier',
      titleJp: 'マッチ倍率',
      emoji: '🔥',
      description: 'Score multiplier for consecutive matches',
      coinsBonus: 300,
      type: RewardType.feature,
    ),
    Reward(
      levelUnlocked: 35,
      title: 'Lucky Star',
      titleJp: 'ラッキースター',
      emoji: '⭐',
      description: 'Random bonus after completing levels',
      coinsBonus: 350,
      type: RewardType.bonus,
    ),
    Reward(
      levelUnlocked: 40,
      title: 'Undo Master',
      titleJp: '元に戻すマスター',
      emoji: '↩️',
      description: 'Unlock Undo power-up',
      coinsBonus: 400,
      type: RewardType.powerUp,
    ),
    Reward(
      levelUnlocked: 45,
      title: 'Combo Chain',
      titleJp: 'コンボチェーン',
      emoji: '⛓️',
      description: '3+ consecutive matches = bonus time',
      coinsBonus: 450,
      type: RewardType.feature,
    ),
    Reward(
      levelUnlocked: 50,
      title: 'Zen Mode',
      titleJp: '禅モード',
      emoji: '🧘',
      description: 'Play completed levels without timer',
      coinsBonus: 500,
      type: RewardType.feature,
    ),
    Reward(
      levelUnlocked: 55,
      title: 'Speed Demon',
      titleJp: 'スピード悪魔',
      emoji: '⚡',
      description: 'Fast matches give extra points',
      coinsBonus: 550,
      type: RewardType.bonus,
    ),
    Reward(
      levelUnlocked: 60,
      title: 'Memory Master',
      titleJp: '記憶マスター',
      emoji: '🧠',
      description: 'Perfect memory bonus activated',
      coinsBonus: 600,
      type: RewardType.bonus,
    ),
    Reward(
      levelUnlocked: 65,
      title: 'Card Sage',
      titleJp: 'カード賢者',
      emoji: '🎴',
      description: 'All rare cards unlocked',
      coinsBonus: 650,
      type: RewardType.feature,
    ),
    Reward(
      levelUnlocked: 70,
      title: 'Time Lord',
      titleJp: '時間の主',
      emoji: '⏰',
      description: '+30 seconds on all levels',
      coinsBonus: 700,
      type: RewardType.bonus,
    ),
    Reward(
      levelUnlocked: 75,
      title: 'Fortune Finder',
      titleJp: '幸運発見者',
      emoji: '🍀',
      description: 'Double coin rewards',
      coinsBonus: 750,
      type: RewardType.bonus,
    ),
    Reward(
      levelUnlocked: 80,
      title: 'Grand Master',
      titleJp: 'グランドマスター',
      emoji: '👑',
      description: 'All power-ups cooldown reduced',
      coinsBonus: 800,
      type: RewardType.feature,
    ),
    Reward(
      levelUnlocked: 85,
      title: 'Legendary Player',
      titleJp: '伝説のプレイヤー',
      emoji: '🏆',
      description: 'All legendary cards unlocked',
      coinsBonus: 850,
      type: RewardType.feature,
    ),
    Reward(
      levelUnlocked: 90,
      title: 'Ultimate Champion',
      titleJp: '究極のチャンピオン',
      emoji: '🥇',
      description: 'Maximum power-up charges',
      coinsBonus: 900,
      type: RewardType.feature,
    ),
    Reward(
      levelUnlocked: 95,
      title: 'Vita Legend',
      titleJp: 'ビタ伝説',
      emoji: '✨',
      description: 'Special golden card frame',
      coinsBonus: 950,
      type: RewardType.feature,
    ),
    Reward(
      levelUnlocked: 100,
      title: 'MAHJONG MASTER',
      titleJp: '麻雀マスター',
      emoji: '🀄',
      description: 'Game completion! All unlocked!',
      coinsBonus: 5000,
      type: RewardType.feature,
    ),
  ];

  static Reward? getRewardForLevel(int level) {
    try {
      return allRewards.firstWhere((r) => r.levelUnlocked == level);
    } catch (e) {
      return null;
    }
  }

  static bool hasReward(int level) {
    return level % 5 == 0 && level <= 100;
  }

  static List<Reward> getUnlockedRewards(int currentLevel) {
    return allRewards.where((r) => r.levelUnlocked <= currentLevel).toList();
  }
}
