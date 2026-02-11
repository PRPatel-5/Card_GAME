# 🀄 Vita Mahjong - Quick Start

## Run the Game:
```bash
cd /home/prince/projects/Card_GAME
flutter pub get
flutter run
```

## Game Files Structure:
```
lib/
├── main.dart                    # App entry
├── models/                      # Game data
│   ├── mahjong_tile.dart       # Tile structure
│   ├── game_layout.dart        # 4 layouts
│   └── tile_factory.dart       # 42 tile types
├── providers/                   # Game logic
│   ├── game_provider.dart      # Core game engine
│   └── settings_provider.dart  # Settings
├── screens/                     # UI screens
│   ├── home_screen.dart        # Main menu
│   ├── game_screen.dart        # Gameplay
│   ├── level_select_screen.dart
│   └── settings_screen.dart
└── widgets/                     # Game components
    ├── game_hud.dart           # Top HUD
    ├── mahjong_board.dart      # Board renderer
    └── tile_widget.dart        # Tile display
```

## Features:
✅ 4 Layouts (Simple, Pyramid, Classic, Cross)
✅ 42 Unique Tiles (Bamboo, Circle, Character, Wind, Dragon, Flower, Season)
✅ 3D Stacking with proper blocking
✅ Hint System (3 per game)
✅ Shuffle System (3 per game)
✅ Undo System
✅ Score + Combo + Timer
✅ High Score Tracking
✅ Statistics (Games Played/Won)

## Controls:
- Tap tile to select
- Tap another to match
- Use Hint/Shuffle/Undo buttons
- Pinch to zoom board
- Pause anytime

## Status: ✅ COMPLETE & PLAYABLE!
