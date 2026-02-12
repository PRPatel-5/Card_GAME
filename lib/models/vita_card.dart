import 'package:flutter/material.dart';

enum CardCategory {
  nature,
  japanese,
  celestial,
  mythical,
  seasonal,
  fortune
}

enum CardRarity {
  common,
  rare,
  epic,
  legendary
}

class VitaCard {
  final int id;
  final String name;
  final String nameJp;
  final String emoji;
  final CardCategory category;
  final CardRarity rarity;
  final Color color;

  const VitaCard({
    required this.id,
    required this.name,
    required this.nameJp,
    required this.emoji,
    required this.category,
    required this.rarity,
    required this.color,
  });

  String get categoryName {
    switch (category) {
      case CardCategory.nature:
        return 'Nature Elements';
      case CardCategory.japanese:
        return 'Japanese Symbols';
      case CardCategory.celestial:
        return 'Celestial Objects';
      case CardCategory.mythical:
        return 'Mythical Creatures';
      case CardCategory.seasonal:
        return 'Seasonal Icons';
      case CardCategory.fortune:
        return 'Fortune Symbols';
    }
  }

  Color get rarityColor {
    switch (rarity) {
      case CardRarity.common:
        return const Color(0xFF228B22);
      case CardRarity.rare:
        return const Color(0xFF4169E1);
      case CardRarity.epic:
        return const Color(0xFF9400D3);
      case CardRarity.legendary:
        return const Color(0xFFFFD700);
    }
  }
}

// All 90 unique cards
class CardDatabase {
  static const List<VitaCard> allCards = [
    // NATURE ELEMENTS (15 cards)
    VitaCard(id: 1, name: 'Cherry Blossom', nameJp: '桜の花', emoji: '🌸', category: CardCategory.nature, rarity: CardRarity.common, color: Color(0xFFFFB7C5)),
    VitaCard(id: 2, name: 'Maple Leaf', nameJp: '紅葉', emoji: '🍁', category: CardCategory.nature, rarity: CardRarity.common, color: Color(0xFFFF6347)),
    VitaCard(id: 3, name: 'Bamboo Shoot', nameJp: '竹', emoji: '🎋', category: CardCategory.nature, rarity: CardRarity.common, color: Color(0xFF90EE90)),
    VitaCard(id: 4, name: 'Pine Tree', nameJp: '松', emoji: '🌲', category: CardCategory.nature, rarity: CardRarity.common, color: Color(0xFF228B22)),
    VitaCard(id: 5, name: 'Lotus Flower', nameJp: '蓮', emoji: '🪷', category: CardCategory.nature, rarity: CardRarity.rare, color: Color(0xFFFFB6C1)),
    VitaCard(id: 6, name: 'Mountain Peak', nameJp: '山', emoji: '⛰️', category: CardCategory.nature, rarity: CardRarity.common, color: Color(0xFF8B7355)),
    VitaCard(id: 7, name: 'Ocean Wave', nameJp: '波', emoji: '🌊', category: CardCategory.nature, rarity: CardRarity.common, color: Color(0xFF4682B4)),
    VitaCard(id: 8, name: 'Thunder Cloud', nameJp: '雷', emoji: '⛈️', category: CardCategory.nature, rarity: CardRarity.rare, color: Color(0xFF708090)),
    VitaCard(id: 9, name: 'Sunrise', nameJp: '日の出', emoji: '🌅', category: CardCategory.nature, rarity: CardRarity.rare, color: Color(0xFFFF6347)),
    VitaCard(id: 10, name: 'Moon Phase', nameJp: '月', emoji: '🌙', category: CardCategory.nature, rarity: CardRarity.rare, color: Color(0xFFF0E68C)),
    VitaCard(id: 11, name: 'Rain Drop', nameJp: '雨', emoji: '💧', category: CardCategory.nature, rarity: CardRarity.common, color: Color(0xFF87CEEB)),
    VitaCard(id: 12, name: 'Snow Crystal', nameJp: '雪', emoji: '❄️', category: CardCategory.nature, rarity: CardRarity.common, color: Color(0xFFE0FFFF)),
    VitaCard(id: 13, name: 'Wind Swirl', nameJp: '風', emoji: '🌪️', category: CardCategory.nature, rarity: CardRarity.common, color: Color(0xFFB0C4DE)),
    VitaCard(id: 14, name: 'Fire Ember', nameJp: '火', emoji: '🔥', category: CardCategory.nature, rarity: CardRarity.rare, color: Color(0xFFFF4500)),
    VitaCard(id: 15, name: 'Earth Stone', nameJp: '土', emoji: '🪨', category: CardCategory.nature, rarity: CardRarity.common, color: Color(0xFF8B4513)),

    // JAPANESE SYMBOLS (15 cards)
    VitaCard(id: 16, name: 'Torii Gate', nameJp: '鳥居', emoji: '⛩️', category: CardCategory.japanese, rarity: CardRarity.rare, color: Color(0xFFDC143C)),
    VitaCard(id: 17, name: 'Paper Lantern', nameJp: '提灯', emoji: '🏮', category: CardCategory.japanese, rarity: CardRarity.common, color: Color(0xFFFF6347)),
    VitaCard(id: 18, name: 'Origami Crane', nameJp: '折り鶴', emoji: '🦢', category: CardCategory.japanese, rarity: CardRarity.rare, color: Color(0xFFFFFFFF)),
    VitaCard(id: 19, name: 'Koi Fish', nameJp: '鯉', emoji: '🐟', category: CardCategory.japanese, rarity: CardRarity.common, color: Color(0xFFFF8C00)),
    VitaCard(id: 20, name: 'Lucky Cat', nameJp: '招き猫', emoji: '🐱', category: CardCategory.japanese, rarity: CardRarity.epic, color: Color(0xFFFFD700)),
    VitaCard(id: 21, name: 'Daruma Doll', nameJp: 'だるま', emoji: '🎎', category: CardCategory.japanese, rarity: CardRarity.rare, color: Color(0xFFDC143C)),
    VitaCard(id: 22, name: 'Paper Fan', nameJp: '扇子', emoji: '🪭', category: CardCategory.japanese, rarity: CardRarity.common, color: Color(0xFFFFE4B5)),
    VitaCard(id: 23, name: 'Tea Cup', nameJp: '茶碗', emoji: '🍵', category: CardCategory.japanese, rarity: CardRarity.common, color: Color(0xFF90EE90)),
    VitaCard(id: 24, name: 'Rice Bowl', nameJp: '飯碗', emoji: '🍚', category: CardCategory.japanese, rarity: CardRarity.common, color: Color(0xFFFFFAFA)),
    VitaCard(id: 25, name: 'Sake Bottle', nameJp: '酒', emoji: '🍶', category: CardCategory.japanese, rarity: CardRarity.common, color: Color(0xFFF5F5DC)),
    VitaCard(id: 26, name: 'Shamisen', nameJp: '三味線', emoji: '🎸', category: CardCategory.japanese, rarity: CardRarity.rare, color: Color(0xFF8B4513)),
    VitaCard(id: 27, name: 'Taiko Drum', nameJp: '太鼓', emoji: '🥁', category: CardCategory.japanese, rarity: CardRarity.rare, color: Color(0xFFDC143C)),
    VitaCard(id: 28, name: 'Temple Bell', nameJp: '鐘', emoji: '🔔', category: CardCategory.japanese, rarity: CardRarity.rare, color: Color(0xFFFFD700)),
    VitaCard(id: 29, name: 'Incense Stick', nameJp: '線香', emoji: '🕯️', category: CardCategory.japanese, rarity: CardRarity.common, color: Color(0xFFDDA0DD)),
    VitaCard(id: 30, name: 'Bonsai Tree', nameJp: '盆栽', emoji: '🌳', category: CardCategory.japanese, rarity: CardRarity.epic, color: Color(0xFF228B22)),

    // CELESTIAL OBJECTS (15 cards)
    VitaCard(id: 31, name: 'Sun', nameJp: '太陽', emoji: '☀️', category: CardCategory.celestial, rarity: CardRarity.rare, color: Color(0xFFFFD700)),
    VitaCard(id: 32, name: 'Full Moon', nameJp: '満月', emoji: '🌕', category: CardCategory.celestial, rarity: CardRarity.rare, color: Color(0xFFF0E68C)),
    VitaCard(id: 33, name: 'Crescent Moon', nameJp: '三日月', emoji: '🌙', category: CardCategory.celestial, rarity: CardRarity.common, color: Color(0xFFFFFFE0)),
    VitaCard(id: 34, name: 'Morning Star', nameJp: '明けの明星', emoji: '⭐', category: CardCategory.celestial, rarity: CardRarity.common, color: Color(0xFFFFFFFF)),
    VitaCard(id: 35, name: 'Evening Star', nameJp: '宵の明星', emoji: '✨', category: CardCategory.celestial, rarity: CardRarity.common, color: Color(0xFFE6E6FA)),
    VitaCard(id: 36, name: 'North Star', nameJp: '北極星', emoji: '🌟', category: CardCategory.celestial, rarity: CardRarity.rare, color: Color(0xFFFFFFFF)),
    VitaCard(id: 37, name: 'Shooting Star', nameJp: '流れ星', emoji: '💫', category: CardCategory.celestial, rarity: CardRarity.epic, color: Color(0xFFFFD700)),
    VitaCard(id: 38, name: 'Nebula', nameJp: '星雲', emoji: '🌌', category: CardCategory.celestial, rarity: CardRarity.epic, color: Color(0xFF9370DB)),
    VitaCard(id: 39, name: 'Galaxy Spiral', nameJp: '銀河', emoji: '🌀', category: CardCategory.celestial, rarity: CardRarity.epic, color: Color(0xFF4B0082)),
    VitaCard(id: 40, name: 'Saturn', nameJp: '土星', emoji: '🪐', category: CardCategory.celestial, rarity: CardRarity.rare, color: Color(0xFFDAA520)),
    VitaCard(id: 41, name: 'Comet', nameJp: '彗星', emoji: '☄️', category: CardCategory.celestial, rarity: CardRarity.rare, color: Color(0xFF87CEEB)),
    VitaCard(id: 42, name: 'Aurora', nameJp: 'オーロラ', emoji: '🌈', category: CardCategory.celestial, rarity: CardRarity.legendary, color: Color(0xFF00CED1)),
    VitaCard(id: 43, name: 'Eclipse', nameJp: '日食', emoji: '🌑', category: CardCategory.celestial, rarity: CardRarity.legendary, color: Color(0xFF2F4F4F)),
    VitaCard(id: 44, name: 'Big Dipper', nameJp: '北斗七星', emoji: '✴️', category: CardCategory.celestial, rarity: CardRarity.rare, color: Color(0xFFFFFFFF)),
    VitaCard(id: 45, name: 'Orion', nameJp: 'オリオン座', emoji: '⭐', category: CardCategory.celestial, rarity: CardRarity.rare, color: Color(0xFF4169E1)),

    // MYTHICAL CREATURES (15 cards)
    VitaCard(id: 46, name: 'Red Dragon', nameJp: '赤龍', emoji: '🐉', category: CardCategory.mythical, rarity: CardRarity.legendary, color: Color(0xFFDC143C)),
    VitaCard(id: 47, name: 'Blue Dragon', nameJp: '青龍', emoji: '🐲', category: CardCategory.mythical, rarity: CardRarity.legendary, color: Color(0xFF4169E1)),
    VitaCard(id: 48, name: 'Phoenix', nameJp: '鳳凰', emoji: '🦅', category: CardCategory.mythical, rarity: CardRarity.legendary, color: Color(0xFFFF4500)),
    VitaCard(id: 49, name: 'Kirin', nameJp: '麒麟', emoji: '🦄', category: CardCategory.mythical, rarity: CardRarity.epic, color: Color(0xFFFFD700)),
    VitaCard(id: 50, name: 'Tengu', nameJp: '天狗', emoji: '👺', category: CardCategory.mythical, rarity: CardRarity.epic, color: Color(0xFFDC143C)),
    VitaCard(id: 51, name: 'Kitsune', nameJp: '狐', emoji: '🦊', category: CardCategory.mythical, rarity: CardRarity.epic, color: Color(0xFFFF8C00)),
    VitaCard(id: 52, name: 'Tanuki', nameJp: '狸', emoji: '🦝', category: CardCategory.mythical, rarity: CardRarity.rare, color: Color(0xFF8B4513)),
    VitaCard(id: 53, name: 'Oni', nameJp: '鬼', emoji: '👹', category: CardCategory.mythical, rarity: CardRarity.rare, color: Color(0xFF8B0000)),
    VitaCard(id: 54, name: 'Kappa', nameJp: '河童', emoji: '🐢', category: CardCategory.mythical, rarity: CardRarity.rare, color: Color(0xFF2E8B57)),
    VitaCard(id: 55, name: 'Ryujin', nameJp: '龍神', emoji: '🌊', category: CardCategory.mythical, rarity: CardRarity.legendary, color: Color(0xFF4682B4)),
    VitaCard(id: 56, name: 'Foo Dog', nameJp: '狛犬', emoji: '🦁', category: CardCategory.mythical, rarity: CardRarity.epic, color: Color(0xFFDAA520)),
    VitaCard(id: 57, name: 'Crane Spirit', nameJp: '鶴', emoji: '🦢', category: CardCategory.mythical, rarity: CardRarity.rare, color: Color(0xFFFFFFFF)),
    VitaCard(id: 58, name: 'Turtle Sage', nameJp: '亀', emoji: '🐢', category: CardCategory.mythical, rarity: CardRarity.rare, color: Color(0xFF2F4F4F)),
    VitaCard(id: 59, name: 'White Tiger', nameJp: '白虎', emoji: '🐯', category: CardCategory.mythical, rarity: CardRarity.legendary, color: Color(0xFFFFFFFF)),
    VitaCard(id: 60, name: 'Azure Dragon', nameJp: '青龍', emoji: '🐉', category: CardCategory.mythical, rarity: CardRarity.legendary, color: Color(0xFF00CED1)),

    // SEASONAL ICONS (15 cards)
    VitaCard(id: 61, name: 'Spring Blossom', nameJp: '春', emoji: '🌸', category: CardCategory.seasonal, rarity: CardRarity.common, color: Color(0xFFFFB7C5)),
    VitaCard(id: 62, name: 'Summer Sun', nameJp: '夏', emoji: '☀️', category: CardCategory.seasonal, rarity: CardRarity.common, color: Color(0xFFFFD700)),
    VitaCard(id: 63, name: 'Autumn Leaf', nameJp: '秋', emoji: '🍂', category: CardCategory.seasonal, rarity: CardRarity.common, color: Color(0xFFFF8C00)),
    VitaCard(id: 64, name: 'Winter Snow', nameJp: '冬', emoji: '⛄', category: CardCategory.seasonal, rarity: CardRarity.common, color: Color(0xFFE0FFFF)),
    VitaCard(id: 65, name: 'New Year Bell', nameJp: '正月', emoji: '🔔', category: CardCategory.seasonal, rarity: CardRarity.rare, color: Color(0xFFFFD700)),
    VitaCard(id: 66, name: 'Hanami', nameJp: '花見', emoji: '🌸', category: CardCategory.seasonal, rarity: CardRarity.rare, color: Color(0xFFFFB6C1)),
    VitaCard(id: 67, name: 'Tanabata Star', nameJp: '七夕', emoji: '🎋', category: CardCategory.seasonal, rarity: CardRarity.rare, color: Color(0xFF87CEEB)),
    VitaCard(id: 68, name: 'Harvest Moon', nameJp: '中秋', emoji: '🌕', category: CardCategory.seasonal, rarity: CardRarity.rare, color: Color(0xFFF0E68C)),
    VitaCard(id: 69, name: 'Kotatsu', nameJp: 'こたつ', emoji: '🛋️', category: CardCategory.seasonal, rarity: CardRarity.common, color: Color(0xFF8B4513)),
    VitaCard(id: 70, name: 'Hot Spring', nameJp: '温泉', emoji: '♨️', category: CardCategory.seasonal, rarity: CardRarity.common, color: Color(0xFF87CEEB)),
    VitaCard(id: 71, name: 'Fireworks', nameJp: '花火', emoji: '🎆', category: CardCategory.seasonal, rarity: CardRarity.epic, color: Color(0xFFFF1493)),
    VitaCard(id: 72, name: 'Wind Chime', nameJp: '風鈴', emoji: '🎐', category: CardCategory.seasonal, rarity: CardRarity.common, color: Color(0xFFB0E0E6)),
    VitaCard(id: 73, name: 'Paper Umbrella', nameJp: '和傘', emoji: '☂️', category: CardCategory.seasonal, rarity: CardRarity.common, color: Color(0xFFDC143C)),
    VitaCard(id: 74, name: 'Snowman', nameJp: '雪だるま', emoji: '⛄', category: CardCategory.seasonal, rarity: CardRarity.common, color: Color(0xFFFFFFFF)),
    VitaCard(id: 75, name: 'Festival Mask', nameJp: 'お面', emoji: '🎭', category: CardCategory.seasonal, rarity: CardRarity.rare, color: Color(0xFFFF6347)),

    // FORTUNE SYMBOLS (15 cards)
    VitaCard(id: 76, name: 'Gold Coin', nameJp: '金貨', emoji: '🪙', category: CardCategory.fortune, rarity: CardRarity.rare, color: Color(0xFFFFD700)),
    VitaCard(id: 77, name: 'Lucky Seven', nameJp: '七', emoji: '7️⃣', category: CardCategory.fortune, rarity: CardRarity.epic, color: Color(0xFFFFD700)),
    VitaCard(id: 78, name: 'Four-Leaf Clover', nameJp: '四つ葉', emoji: '🍀', category: CardCategory.fortune, rarity: CardRarity.rare, color: Color(0xFF32CD32)),
    VitaCard(id: 79, name: 'Horseshoe', nameJp: '蹄鉄', emoji: '🧲', category: CardCategory.fortune, rarity: CardRarity.common, color: Color(0xFF808080)),
    VitaCard(id: 80, name: 'Dice', nameJp: 'サイコロ', emoji: '🎲', category: CardCategory.fortune, rarity: CardRarity.common, color: Color(0xFFFFFFFF)),
    VitaCard(id: 81, name: 'Fortune Cookie', nameJp: 'おみくじ', emoji: '🥠', category: CardCategory.fortune, rarity: CardRarity.common, color: Color(0xFFFFE4B5)),
    VitaCard(id: 82, name: 'Lucky Charm', nameJp: 'お守り', emoji: '🧿', category: CardCategory.fortune, rarity: CardRarity.rare, color: Color(0xFF4169E1)),
    VitaCard(id: 83, name: 'Treasure Chest', nameJp: '宝箱', emoji: '💎', category: CardCategory.fortune, rarity: CardRarity.epic, color: Color(0xFF8B4513)),
    VitaCard(id: 84, name: 'Crystal Ball', nameJp: '水晶玉', emoji: '🔮', category: CardCategory.fortune, rarity: CardRarity.epic, color: Color(0xFF9370DB)),
    VitaCard(id: 85, name: 'Magic Lamp', nameJp: '魔法のランプ', emoji: '🪔', category: CardCategory.fortune, rarity: CardRarity.legendary, color: Color(0xFFDAA520)),
    VitaCard(id: 86, name: 'Wishing Well', nameJp: '願いの井戸', emoji: '🌊', category: CardCategory.fortune, rarity: CardRarity.rare, color: Color(0xFF4682B4)),
    VitaCard(id: 87, name: 'Rainbow', nameJp: '虹', emoji: '🌈', category: CardCategory.fortune, rarity: CardRarity.legendary, color: Color(0xFF00CED1)),
    VitaCard(id: 88, name: 'Shooting Arrow', nameJp: '矢', emoji: '🏹', category: CardCategory.fortune, rarity: CardRarity.common, color: Color(0xFF8B4513)),
    VitaCard(id: 89, name: 'Victory Crown', nameJp: '王冠', emoji: '👑', category: CardCategory.fortune, rarity: CardRarity.legendary, color: Color(0xFFFFD700)),
    VitaCard(id: 90, name: 'Golden Key', nameJp: '金の鍵', emoji: '🔑', category: CardCategory.fortune, rarity: CardRarity.epic, color: Color(0xFFFFD700)),
  ];

  static List<VitaCard> getCardsByCategory(CardCategory category) {
    return allCards.where((card) => card.category == category).toList();
  }

  static VitaCard? getCardById(int id) {
    try {
      return allCards.firstWhere((card) => card.id == id);
    } catch (e) {
      return null;
    }
  }
}
