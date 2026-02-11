# 🌿 Memory Garden

> **"You don't win a game—you grow it."**

A calm card matching game where every decision grows a living, breathing garden. No timer. No pressure. No "Game Over". Just organic growth responding to how you play.

---

## ✨ What Makes Memory Garden Different

### 🎮 Not Your Typical Memory Game

**Traditional Memory Games:**
- ❌ Timed pressure
- ❌ Harsh "Game Over" screens
- ❌ Points-focused
- ❌ Stressful gameplay

**Memory Garden:**
- ✅ No timer (play at your pace)
- ✅ Garden responds emotionally
- ✅ Growth-focused (not winning)
- ✅ Calming experience

---

## 🌱 Core Features

### 1. **Emotional Garden System**
Your garden is alive and remembers how you play:

```
Good Matches → Plants grow, colors brighten
Mistakes → Plants slightly wilt (but recover!)
Streaks → Rare plants appear
Perfect Play → Garden thrives with vibrant life
```

### 2. **Card Types with Personality**

| Type | Symbol | Effect |
|------|--------|--------|
| 🌱 **Seed** | Basic | Foundation plants |
| 🍃 **Leaf** | Boost | Enhances nearby growth |
| 🌸 **Flower** | Beauty | Adds color variety |
| 🍂 **Season** | Change | Affects garden mood |

### 3. **Living, Breathing Visuals**

- **Breathing Animation**: Cards gently pulse like they're alive
- **Organic Growth**: Plants grow slowly and sway naturally
- **Time Progression**: Garden lighting shifts (morning → noon → evening → night)
- **Emotional Tints**: Colors shift based on your accuracy

### 4. **Calm Sound Design** *(Ready for audio)*

Planned sounds that react to gameplay:
- 🎵 Wind chimes on matches
- 🍃 Leaves rustling on flips
- 💧 Water drops on streaks
- 🎹 Soft piano pads (ambient)

---

## 🎨 Visual Identity

### Color Palette

```
Sky:      Morning cream, evening peach
Ground:   Earthy browns, soft grass green
Cards:    Warm whites, natural borders
Plants:   Organic greens, gentle pinks

Everything is SOFT. Nothing is harsh.
```

### Design Philosophy

1. **Minimal UI** - Focus stays on the garden
2. **Organic Motion** - All animations curve naturally
3. **Low Contrast** - Easy on the eyes
4. **Breathing Space** - Never cluttered

---

## 🧠 How It Works

### Game Loop

```
1. Tap card → Gentle flip animation
2. Tap another → Check for match
3. Match? → Plant grows in garden
4. No match? → Cards flip back (garden slightly fades)
5. Garden responds emotionally throughout
```

### Streak System

```
3+ matches in a row → Garden mood brightens
5+ matches → Rare plant variants appear
10+ matches → Garden achieves "Perfect" state
```

### No Punishment

- Wrong matches don't hurt you badly
- Garden recovers as you improve
- No "lives" or "energy" systems
- No forced ads interrupting flow

---

## 🛠 Technical Stack

```yaml
Framework: Flutter 3.0+
Game Engine: Flame 1.12+
Animations: flutter_animate
Typography: Google Fonts (Cormorant Garamond)
Storage: shared_preferences (garden memory)
```

### Architecture

```
lib/
├── game/
│   ├── memory_garden_game.dart   # Main game loop
│   ├── garden_card_component.dart # Animated cards
│   ├── deck_manager.dart          # Card generation
│   └── game_logic.dart            # Match rules
├── models/
│   ├── card_model.dart            # Card data
│   └── garden_state.dart          # Living garden state
├── screens/
│   ├── home_screen.dart           # Serene introduction
│   ├── garden_screen.dart         # Main gameplay
│   └── completion_screen.dart     # Gentle celebration
└── utils/
    └── constants.dart             # Design system
```

---

## 🚀 Getting Started

### Requirements

- Flutter SDK 3.0+
- Dart 3.0+
- Android Studio / VS Code

### Installation

```bash
# 1. Clone or extract project
cd memory_garden

# 2. Get dependencies
flutter pub get

# 3. Run on device
flutter run

# 4. Build release APK
flutter build apk --release
```

---

## 🎯 Design Principles

### 1. **Calmness First**
Every decision prioritizes calm:
- Slow, gentle animations (0.6s - 1.2s)
- Soft colors with low saturation
- No sudden movements or loud feedback

### 2. **Emotional Feedback**
The garden IS the feedback:
- No numbers shouting at you
- Visual growth shows progress
- Colors shift with mood

### 3. **No Pressure**
Completely removed:
- Timers
- Lives/Energy systems
- Forced restarts
- Aggressive monetization

### 4. **Organic Feel**
Everything feels alive:
- Breathing animations
- Swaying plants
- Natural curves in all motion

---

## 📱 Target Audience

**Perfect For:**
- People who want to relax, not compete
- Mindfulness & meditation app users
- Anyone stressed by typical mobile games
- Art/design enthusiasts
- Casual players who value aesthetics

**Unique Position:**
- Between "brain training" and "zen experience"
- Competes with: Alto's Adventure, Monument Valley
- NOT competing with: Candy Crush, typical match games

---

## 🎁 Future Features (Roadmap)

### Phase 1: Sound & Polish
- [ ] Wind chime sound effects
- [ ] Ambient nature sounds
- [ ] Haptic feedback (gentle vibrations)
- [ ] More plant varieties

### Phase 2: Variety
- [ ] Garden themes (Forest, Desert, Night)
- [ ] Seasonal variations (Spring, Summer, Fall, Winter)
- [ ] Weather effects (Rain, Fog, Sunshine)
- [ ] Daily garden variations

### Phase 3: Memory
- [ ] Save garden progress
- [ ] Garden journal (visual history)
- [ ] Long-term plant growth
- [ ] Personal garden "album"

### Phase 4: Social (Gentle)
- [ ] Share garden screenshots
- [ ] Garden exchange (see friends' gardens)
- [ ] No competitive leaderboards (by design)

---

## 💰 Monetization (Ethical)

### Free Forever:
- ✅ Full core gameplay
- ✅ Morning garden theme
- ✅ All basic plant types

### Optional Premium ($2.99 one-time):
- 🌲 Forest, Desert, Night themes
- 🎵 Premium sound packs
- 🌺 Rare plant cosmetics
- 🧘 "Zen Mode" (no mistakes impact garden)

**No:**
- ❌ Energy systems
- ❌ Forced ads
- ❌ Time-gated content
- ❌ Pay-to-win mechanics

---

## 🎨 Brand Values

**Memory Garden is:**
- 🌿 Calm, not chaotic
- 🌸 Growth-focused, not competitive
- 🍃 Organic, not digital-feeling
- 💚 Kind, not punishing

**Memory Garden is NOT:**
- ❌ A brain training tool
- ❌ A productivity app
- ❌ A competitive challenge
- ❌ A typical "match game"

---

## 📊 Success Metrics

**We measure:**
- Average session length (longer = more relaxing)
- Return rate (do people come back?)
- Screenshot shares (visual appeal)
- App Store reviews mentioning "calm/relaxing"

**We DON'T measure:**
- Daily active users (no pressure)
- Engagement tricks (no manipulation)
- Ad revenue (clean experience)

---

## 🙏 Credits & Inspiration

**Inspired by:**
- Alto's Adventure (calm gameplay)
- Monument Valley (visual zen)
- Viridi (slow plant growth sim)
- Forest (mindful waiting)

**Built with love for:**
- People who need a break
- Those who appreciate craft
- Anyone seeking calm in chaos

---

## 📜 License

MIT License - Feel free to learn from this!

---

## 🌱 Final Words

Memory Garden isn't trying to be the most popular game.
It's trying to be the most calming one.

If even one person feels less stressed after playing,
the garden has grown successfully.

---

**Made with 🌿 and intention**

*"Every garden grows at its own pace."*
