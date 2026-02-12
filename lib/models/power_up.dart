enum PowerUpType {
  hint,
  shuffle,
  timeFreeze,
  revealAll,
  undo
}

class PowerUp {
  final PowerUpType type;
  final String name;
  final String nameJp;
  final String emoji;
  final String description;
  final int unlockLevel;
  final int cooldownSeconds;

  const PowerUp({
    required this.type,
    required this.name,
    required this.nameJp,
    required this.emoji,
    required this.description,
    required this.unlockLevel,
    required this.cooldownSeconds,
  });
}

class PowerUpDatabase {
  static const List<PowerUp> allPowerUps = [
    PowerUp(
      type: PowerUpType.hint,
      name: 'Hint',
      nameJp: 'ヒント',
      emoji: '💡',
      description: 'Highlights one matching pair for 3 seconds',
      unlockLevel: 1,
      cooldownSeconds: 10,
    ),
    PowerUp(
      type: PowerUpType.shuffle,
      name: 'Shuffle',
      nameJp: 'シャッフル',
      emoji: '🔄',
      description: 'Randomizes all face-down cards',
      unlockLevel: 1,
      cooldownSeconds: 15,
    ),
    PowerUp(
      type: PowerUpType.timeFreeze,
      name: 'Time Freeze',
      nameJp: '時間停止',
      emoji: '⏸️',
      description: 'Pauses timer for 5 seconds',
      unlockLevel: 15,
      cooldownSeconds: 30,
    ),
    PowerUp(
      type: PowerUpType.revealAll,
      name: 'Reveal All',
      nameJp: '全表示',
      emoji: '👁️',
      description: 'Shows all cards for 2 seconds',
      unlockLevel: 20,
      cooldownSeconds: 45,
    ),
    PowerUp(
      type: PowerUpType.undo,
      name: 'Undo',
      nameJp: '元に戻す',
      emoji: '↩️',
      description: 'Reverts last incorrect match',
      unlockLevel: 40,
      cooldownSeconds: 20,
    ),
  ];

  static PowerUp? getPowerUp(PowerUpType type) {
    try {
      return allPowerUps.firstWhere((p) => p.type == type);
    } catch (e) {
      return null;
    }
  }

  static List<PowerUp> getUnlockedPowerUps(int currentLevel) {
    return allPowerUps.where((p) => p.unlockLevel <= currentLevel).toList();
  }
}
