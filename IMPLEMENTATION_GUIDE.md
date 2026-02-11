# 🌿 MEMORY GARDEN - Implementation Guide

Complete guide to build and launch your calming card game.

---

## 📋 Table of Contents

1. [Quick Start](#quick-start)
2. [Understanding the Architecture](#architecture)
3. [Customization Guide](#customization)
4. [Adding Sound](#adding-sound)
5. [Testing & Polish](#testing)
6. [Publishing](#publishing)

---

## 🚀 Quick Start

### Step 1: Setup Project

```bash
# Extract the project
cd memory_garden

# Install dependencies
flutter pub get

# Run on device/emulator
flutter run
```

### Step 2: First Launch Experience

You should see:
1. **Home Screen**: "MEMORY GARDEN" title with soft animations
2. **Tap "Begin"**: Fade transition to garden
3. **Game Screen**: Cards appear with staggered entrance
4. **Tap Cards**: Gentle flip animations
5. **Match Cards**: Plants grow in garden below
6. **Complete**: Calm celebration screen

---

## 🏗 Architecture

### Core Components

#### 1. **Game Logic** (`lib/game/game_logic.dart`)

```dart
// Handles all game rules
class GardenGameLogic {
  - Tracks matches/mistakes
  - Manages garden state
  - Calculates emotional responses
  - No harsh penalties (gentle recovery)
}
```

**Key Features:**
- Streak system (rare plants after 5+ matches)
- Garden health (0.0 - 1.0 scale)
- Emotional mood tracking
- Recovery system (mistakes heal)

#### 2. **Garden State** (`lib/models/garden_state.dart`)

```dart
// The living garden that remembers
class GardenState {
  - Overall health (affects visuals)
  - Plant list (what's grown)
  - Mood (affects colors/sound)
  - Time of day (lighting changes)
}
```

**Mood System:**
```
Joyful      → High streak, bright colors
Peaceful    → Default, soft greens
Calm        → Neutral state
Melancholic → Poor accuracy, faded colors
```

#### 3. **Card Component** (`lib/game/garden_card_component.dart`)

```dart
// Animated, breathing cards
class GardenCardComponent {
  - Breathing animation (subtle pulse)
  - Smooth flip (0.6s organic motion)
  - Match celebration (growth + particles)
  - Wilt feedback (gentle shake)
}
```

**Animation Timing:**
- Flip: 600ms (2x slower than typical)
- Breath cycle: 3 seconds
- Growth: 1.2 seconds
- All use organic curves (no linear)

#### 4. **Main Game** (`lib/game/memory_garden_game.dart`)

```dart
// Flame game with living background
class MemoryGardenGame extends FlameGame {
  - Sky layer (gradient, changes with time)
  - Ground layer (grass texture)
  - Card grid (centered layout)
  - Plant components (grow over time)
}
```

---

## 🎨 Customization

### Change Color Palette

Edit `lib/utils/constants.dart`:

```dart
class GardenColors {
  // Sky colors (affects mood)
  static const Color skyMorning = Color(0xFFE8F4F8);  // ← Edit
  static const Color skyEvening = Color(0xFFFFF4E6); // ← Edit
  
  // Plant colors (affects vitality feel)
  static const Color plantHealthy = Color(0xFF88C057);
  static const Color plantWilting = Color(0xFF9BA89C);
  
  // Card colors (soft, not harsh)
  static const Color cardBack = Color(0xFFE8E0D5);
  static const Color cardFront = Color(0xFFFFFBF5);
}
```

### Adjust Animation Speed

```dart
class GardenConstants {
  // Make animations slower (more calming)
  static const double flipDuration = 0.8;     // Default: 0.6
  static const double breathingCycle = 4.0;   // Default: 3.0
  
  // Make animations faster (less calming)
  static const double flipDuration = 0.4;
  static const double breathingCycle = 2.0;
}
```

### Change Card Types

Edit `lib/utils/constants.dart`:

```dart
enum CardType {
  seed,    // 🌱
  leaf,    // 🍃
  flower,  // 🌸
  season,  // 🍂
  
  // Add new types:
  // tree,    // 🌳
  // cactus,  // 🌵
}

extension CardTypeExtension on CardType {
  String get emoji {
    switch (this) {
      case CardType.seed: return '🌱';
      // Add your custom emojis
    }
  }
}
```

### Modify Difficulty

```dart
// In deck_manager.dart
List<CardModel> createDeck({int pairs = 8}) {  // ← Change this
  // pairs = 4  → Easy (8 cards)
  // pairs = 8  → Normal (16 cards)
  // pairs = 12 → Hard (24 cards)
}
```

---

## 🎵 Adding Sound

### Step 1: Add Sound Files

```bash
# Create assets/sounds/ folder
mkdir -p assets/sounds

# Add your sound files (MP3 or WAV):
assets/sounds/
  ├── flip.mp3         # Card flip
  ├── match.mp3        # Successful match
  ├── wilt.mp3         # Wrong match (gentle)
  ├── grow.mp3         # Plant growth
  ├── streak.mp3       # Combo achievement
  └── ambient.mp3      # Background (optional)
```

### Step 2: Update pubspec.yaml

Already included in `assets/sounds/` declaration.

### Step 3: Add Sound Manager

Create `lib/utils/sound_manager.dart`:

```dart
import 'package:flame_audio/flame_audio.dart';

class SoundManager {
  static Future<void> initialize() async {
    // Preload sounds
    await FlameAudio.audioCache.loadAll([
      'flip.mp3',
      'match.mp3',
      'wilt.mp3',
      'grow.mp3',
      'streak.mp3',
    ]);
  }
  
  static void playFlip() => FlameAudio.play('flip.mp3', volume: 0.3);
  static void playMatch() => FlameAudio.play('match.mp3', volume: 0.4);
  static void playWilt() => FlameAudio.play('wilt.mp3', volume: 0.2);
  static void playGrow() => FlameAudio.play('grow.mp3', volume: 0.3);
  static void playStreak() => FlameAudio.play('streak.mp3', volume: 0.5);
  
  static void playAmbient() {
    FlameAudio.bgm.play('ambient.mp3', volume: 0.15);
  }
  
  static void stopAmbient() {
    FlameAudio.bgm.stop();
  }
}
```

### Step 4: Integrate into Game

In `garden_card_component.dart`:

```dart
// When card flips
void flip() {
  // ... existing code
  SoundManager.playFlip();  // ← Add this
}

// When match succeeds
void markAsMatched() {
  // ... existing code
  SoundManager.playMatch();  // ← Add this
}

// When wrong match
void markAsWilted() {
  // ... existing code
  SoundManager.playWilt();   // ← Add this
}
```

In `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize sounds
  await SoundManager.initialize();  // ← Add this
  await SoundManager.playAmbient();  // ← Add this
  
  runApp(const MemoryGardenApp());
}
```

### Sound Design Tips

**For Calmness:**
- Keep volume LOW (0.2 - 0.4)
- Use soft, organic sounds (wood, wind, water)
- Avoid harsh digital beeps
- Pitch sounds slightly lower (0.9x speed)

**Recommended Sources:**
- Wind chimes: Search "meditation chimes"
- Leaves: Search "rustling leaves ASMR"
- Growth: Search "sprouting plant sound"
- Ambient: Search "calm nature soundscape"

---

## 🧪 Testing & Polish

### Test Checklist

#### Visual Polish
- [ ] All animations feel smooth (60 FPS)
- [ ] No harsh transitions
- [ ] Cards breathe gently
- [ ] Plants sway naturally
- [ ] Colors feel calming

#### Gameplay Feel
- [ ] Tapping feels responsive
- [ ] Wrong matches don't feel punishing
- [ ] Streaks feel rewarding (not aggressive)
- [ ] Completion feels peaceful
- [ ] No frustration points

#### Edge Cases
- [ ] Works on small screens (5")
- [ ] Works on large screens (6.7"+)
- [ ] Handles rapid tapping gracefully
- [ ] Background doesn't glitch
- [ ] No memory leaks (test 10+ rounds)

### Performance Optimization

```dart
// In memory_garden_game.dart

@override
void update(double dt) {
  super.update(dt);
  
  // Limit plant updates to visible only
  for (final plant in plantComponents.where((p) => p.isVisible)) {
    plant.grow(dt);
  }
}
```

### Device Testing

**Test On:**
- [ ] Budget Android (check performance)
- [ ] iPhone (test iOS animations)
- [ ] Tablet (check layout scaling)

---

## 📦 Publishing

### Pre-Launch Checklist

#### Assets
- [ ] App icon (1024×1024)
  - Use soft, organic design
  - Show a simple plant
  - Calming color palette
  
- [ ] Splash screen
  - Match home screen aesthetic
  - Show "MEMORY GARDEN" title
  - Fade in gently

#### Metadata

**App Name:**
```
Memory Garden - Calm Card Game
```

**Short Description:**
```
You don't win a game—you grow it. A calming memory game where every decision grows a living garden. No timer, no pressure.
```

**Full Description:**
```
🌿 Memory Garden is different.

Instead of racing against a clock, you grow at your own pace.
Instead of harsh "Game Over" screens, your garden responds emotionally.
Instead of points and pressure, you simply... grow.

✨ WHAT MAKES IT SPECIAL:
• No timer - Play calmly
• No punishment - Garden heals
• Organic animations - Everything breathes
• Emotional feedback - Garden reflects your play

🌱 FEATURES:
• Beautiful hand-crafted design
• Soothing sound design
• Multiple garden themes
• No ads, no energy systems
• One-time purchase option

Perfect for:
- Mindful moments
- Before bed relaxation
- Stress relief
- Aesthetic appreciation

Memory Garden isn't about winning.
It's about growing.
```

**Keywords:**
```
memory, calm, relaxing, garden, zen, mindful, meditation, casual, puzzle, peaceful, no timer, stress relief, aesthetic
```

**Category:**
```
Primary: Games > Puzzle
Secondary: Games > Casual
```

#### Screenshots (5-8 needed)

**Must Include:**
1. Home screen (title + "Begin" button)
2. Garden view (cards + growing plants)
3. Match animation (sparkles visible)
4. Completion screen (gentle celebration)
5. Streak notification (if visible)

**Pro Tips:**
- Use soft frames (no harsh borders)
- Add subtle text overlays: "No Timer", "Grow at Your Pace"
- Show the garden evolution (bare → full)

### Build Commands

```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS (on Mac)
flutter build ios --release
```

### App Store Optimization (ASO)

**Focus Keywords:**
- "calm game"
- "relaxing puzzle"
- "no timer game"
- "meditation game"
- "zen memory game"

**Not:**
- "best memory game" (too competitive)
- "brain training" (not our vibe)
- "challenge yourself" (wrong message)

---

## 🎯 Launch Strategy

### Soft Launch
1. Share with friends/family
2. Gather qualitative feedback:
   - "Did you feel calm?"
   - "Any frustration points?"
   - "Would you play again?"

### App Store Launch
1. Submit to **iOS first** (stricter review)
2. Then **Android** (faster approval)
3. Post on:
   - r/incremental_games
   - r/AndroidGaming (Android only)
   - r/iosGaming (iOS only)

### Content for Social
- Short video (15s): Show card flip → match → plant grows
- Screenshot: Beautiful full garden
- Quote: "You don't win a game—you grow it."

---

## 📈 Post-Launch

### Gather Feedback On:
- [ ] Is it actually calming?
- [ ] Any confusing moments?
- [ ] Sound design working?
- [ ] Any bugs/crashes?

### Metrics to Watch:
- **Session length** (longer = more engaging)
- **Return rate** (do people come back?)
- **Review sentiment** (mentions of "calm/relaxing")

### Don't Stress About:
- ❌ Daily active users (not our goal)
- ❌ Viral growth (not our style)
- ❌ High downloads (quality > quantity)

---

## 💚 Support & Community

### Future Updates
- Add seasonal themes
- Expand plant varieties
- Weather effects
- Garden journal

### Philosophy
Memory Garden succeeds when ONE person says:
*"This made me feel peaceful."*

Not when it hits #1 on charts.

---

**You have everything you need to launch a beautiful, calm experience.**

**Now go grow something beautiful.** 🌿

---

*Questions? The code is well-commented—read through slowly, like the game itself.* 😊
