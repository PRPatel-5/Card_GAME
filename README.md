# 🀄 Vita Mahjong - 100 Level Card Matching Game

> **"Match cards, unlock rewards, master 100 levels"**

A polished card matching game with 90 unique cards, 100 progressive levels, power-ups, and rewards every 5 levels. Built with Flutter and inspired by Japanese aesthetics.

---

## ✨ Features

### 🎮 Core Gameplay
- **100 Progressive Levels** - From Tutorial to Master difficulty
- **90 Unique Cards** - Across 6 themed categories
- **Power-Up System** - 5 different power-ups to help you win
- **Reward System** - Unlock rewards every 5 levels
- **Star Rating** - Earn 1-3 stars based on performance
- **Save System** - Progress automatically saved

### 🎨 Card Categories (90 Cards Total)

1. **Nature Elements** (15 cards) - Cherry Blossom, Maple Leaf, Bamboo, etc.
2. **Japanese Symbols** (15 cards) - Torii Gate, Lucky Cat, Origami Crane, etc.
3. **Celestial Objects** (15 cards) - Sun, Moon, Stars, Aurora, etc.
4. **Mythical Creatures** (15 cards) - Dragons, Phoenix, Kitsune, etc.
5. **Seasonal Icons** (15 cards) - Spring Blossom, Fireworks, Snow, etc.
6. **Fortune Symbols** (15 cards) - Gold Coin, Lucky Seven, Rainbow, etc.

### 🎯 Difficulty Progression

| Levels | Difficulty | Grid Size | Time | Hints | Shuffles |
|--------|-----------|-----------|------|-------|----------|
| 1-10 | Tutorial | 3×4 (12 cards) | 3 min | 5 | 3 |
| 11-25 | Beginner | 4×4 (16 cards) | 4 min | 4 | 2 |
| 26-40 | Intermediate | 4×6 (24 cards) | 5 min | 3 | 2 |
| 41-60 | Advanced | 5×6 (30 cards) | 6 min | 2 | 1 |
| 61-80 | Expert | 5×8 (40 cards) | 7 min | 2 | 1 |
| 81-100 | Master | 6×8 (48 cards) | 8 min | 1 | 1 |

### 💎 Power-Ups

1. **Hint** 💡 - Highlights one matching pair for 3 seconds
2. **Shuffle** 🔄 - Randomizes all face-down cards
3. **Time Freeze** ⏸️ - Pauses timer for 5 seconds (Unlocks Level 15)
4. **Reveal All** 👁️ - Shows all cards for 2 seconds (Unlocks Level 20)
5. **Undo** ↩️ - Reverts last incorrect match (Unlocks Level 40)

### 🎁 Rewards (Every 5 Levels)

- **Level 5**: Hint Master - +2 permanent hints
- **Level 10**: Shuffle King - +1 permanent shuffle
- **Level 15**: Time Wizard - Unlock Time Freeze power-up
- **Level 20**: Eagle Eye - Unlock Reveal All power-up
- **Level 25**: Card Collector - Unlock Card Gallery
- **Level 30**: Match Multiplier - Score multiplier system
- **Level 40**: Undo Master - Unlock Undo power-up
- **Level 50**: Zen Mode - Play without timer
- **Level 100**: MAHJONG MASTER - Game completion!

---

## 🚀 Getting Started

### Prerequisites

```bash
Flutter SDK 3.0+
Dart 3.0+
Android Studio / VS Code
```

### Installation

```bash
# 1. Clone repository
git clone https://github.com/PRPatel-5/Card_GAME.git
cd Card_GAME

# 2. Install dependencies
flutter pub get

# 3. Run on device
flutter run

# 4. Build APK
flutter build apk --release
```

---

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/
│   ├── vita_card.dart                 # 90 card definitions
│   ├── game_level.dart                # 100 level configurations
│   ├── power_up.dart                  # Power-up definitions
│   ├── reward.dart                    # Reward system
│   └── player_progress.dart           # Save data model
├── services/
│   ├── game_state_service.dart        # Core game logic
│   └── storage_service.dart           # Save/load system
├── screens/
│   ├── main_menu_screen.dart          # Home screen
│   ├── level_select_screen.dart       # 100 level grid
│   ├── gameplay_screen.dart           # Main game
│   ├── reward_screen.dart             # Reward reveals
│   ├── gallery_screen.dart            # Card collection
│   └── settings_screen.dart           # Options
├── widgets/
│   ├── game_card_widget.dart          # Animated card
│   └── power_up_button.dart           # Power-up UI
└── utils/
    └── vita_theme.dart                # Theme & constants
```

---

## 🎨 Design System

### Color Palette

```dart
Primary Dark:    #1A1B2E  // Background
Primary Light:   #2C3E50  // Cards
Accent Gold:     #FFD700  // Highlights
Accent Crimson:  #DC143C  // Actions
Accent Emerald:  #50C878  // Success

Card Rarities:
Common:          #228B22  // Green
Rare:            #4169E1  // Blue
Epic:            #9400D3  // Purple
Legendary:       #FFD700  // Gold
```

### Typography

- **Titles**: Noto Serif JP (Japanese elegance)
- **Body**: Noto Sans JP (Clean readability)
- **Accent**: Gold with shadows for depth

---

## 🎮 How to Play

1. **Select a Level** - Choose from 100 levels
2. **Flip Cards** - Tap to reveal cards
3. **Match Pairs** - Find matching cards
4. **Use Power-Ups** - Strategic help when needed
5. **Beat the Timer** - Complete before time runs out
6. **Earn Stars** - 1-3 stars based on performance
7. **Unlock Rewards** - Every 5 levels

### Scoring System

- **Base Match**: 100 points
- **3+ Streak**: ×2 multiplier
- **5+ Streak**: ×3 multiplier
- **10+ Streak**: ×4 multiplier

### Star Requirements

- **3 Stars**: Perfect (no mistakes) + 50%+ time remaining
- **2 Stars**: ≤2 mistakes + 30%+ time remaining
- **1 Star**: Level completed

---

## 🛠 Technical Details

### Dependencies

```yaml
provider: ^6.1.1              # State management
google_fonts: ^6.1.0          # Japanese fonts
shared_preferences: ^2.2.2    # Save data
sqflite: ^2.3.0              # Database
path_provider: ^2.1.1         # File paths
audioplayers: ^5.2.0          # Sound effects
flutter_svg: ^2.0.9           # SVG graphics
animations: ^2.0.8            # Transitions
confetti: ^0.7.0              # Celebrations
shimmer: ^3.0.0               # Loading effects
```

### Performance

- **App Launch**: <2 seconds
- **Screen Transitions**: <300ms
- **Card Animations**: 60fps stable
- **Memory Usage**: <150MB
- **APK Size**: ~50MB

---

## 🎯 Game Mechanics

### Level Generation

Each level dynamically generates:
- Random card selection from allowed categories
- Shuffled card positions
- Appropriate difficulty settings
- Boss levels every 10 levels

### Match Logic

```dart
1. Player taps first card → Flip animation
2. Player taps second card → Check match
3. If match: Mark as matched, add score, check completion
4. If no match: Flip back after 600ms delay
5. Update streak and multiplier
```

### Power-Up Cooldowns

- Hint: 10 seconds
- Shuffle: 15 seconds
- Time Freeze: 30 seconds
- Reveal All: 45 seconds
- Undo: 20 seconds

---

## 📱 Supported Platforms

- ✅ Android 5.0+ (API 21+)
- ✅ iOS 12.0+
- ✅ Web (experimental)
- ✅ Desktop (Windows/macOS/Linux)

### Orientation

- **Primary**: Landscape (optimal gameplay)
- **Fallback**: Portrait (adjusted layout)

---

## 🎨 Customization

### Adding New Cards

Edit `lib/models/vita_card.dart`:

```dart
VitaCard(
  id: 91,
  name: 'Your Card',
  nameJp: '日本語',
  emoji: '🎴',
  category: CardCategory.nature,
  rarity: CardRarity.rare,
  color: Color(0xFFFFD700),
),
```

### Modifying Levels

Edit `lib/models/game_level.dart`:

```dart
GameLevel(
  levelNumber: 101,
  difficulty: LevelDifficulty.master,
  gridRows: 8,
  gridCols: 8,
  totalCards: 64,
  timeLimit: 600,
  // ...
)
```

### Adding Rewards

Edit `lib/models/reward.dart`:

```dart
Reward(
  levelUnlocked: 105,
  title: 'New Reward',
  titleJp: '新しい報酬',
  emoji: '🎁',
  description: 'Your reward description',
  coinsBonus: 1000,
  type: RewardType.feature,
)
```

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Integration tests
flutter drive --target=test_driver/app.dart
```

---

## 📊 Statistics Tracked

- Total games played
- Total matches made
- Total mismatches
- Longest streak
- Total playtime
- Perfect levels completed
- Favorite card category
- Most used power-up

---

## 🎵 Audio (Planned)

### Sound Effects
- Card flip: Soft paper rustle
- Match correct: Pleasant chime
- Match incorrect: Gentle tone
- Power-up: Magical sparkle
- Level complete: Victory bells

### Music
- Main menu: Peaceful koto melody
- Easy levels: Gentle shamisen
- Hard levels: Intense orchestral fusion

---

## 🚧 Roadmap

### Phase 1: Polish (Current)
- [x] 100 levels implemented
- [x] 90 unique cards
- [x] Power-up system
- [x] Reward system
- [ ] Sound effects
- [ ] Background music

### Phase 2: Features
- [ ] Daily challenges
- [ ] Achievement system
- [ ] Statistics screen
- [ ] Card trading
- [ ] Zen mode implementation

### Phase 3: Social
- [ ] Share screenshots
- [ ] Friend challenges
- [ ] Leaderboards (optional)

---

## 💰 Monetization (Planned)

### Free Forever
- ✅ All 100 levels
- ✅ All 90 cards
- ✅ All power-ups
- ✅ Full gameplay

### Optional Premium ($2.99)
- 🌲 Extra themes
- 🎵 Premium sounds
- 🌺 Cosmetic cards
- 🧘 Zen mode

**No ads, no energy systems, no pay-to-win**

---

## 🙏 Credits

**Inspired by:**
- Traditional Mahjong
- Japanese aesthetics
- Calm mobile games

**Built with:**
- Flutter & Dart
- Google Fonts
- Material Design

---

## 📜 License

MIT License - See LICENSE file

---

## 🌟 Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Open pull request

---

## 📧 Contact

- **GitHub**: [@PRPatel-5](https://github.com/PRPatel-5)
- **Repository**: [Card_GAME](https://github.com/PRPatel-5/Card_GAME)

---

## 🎊 Final Words

Vita Mahjong is designed to be:
- 🎮 Fun and challenging
- 🎨 Beautiful and polished
- 🧘 Calm and relaxing
- 💎 Rewarding and satisfying

**Enjoy the game!** 🀄✨

---

**Made with 🀄 and Flutter**

*"Every match brings you closer to mastery."*
