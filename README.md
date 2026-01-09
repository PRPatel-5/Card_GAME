# Vita Card Game

A relaxing card matching game built with Flutter and Flame engine.

## Features

- Clean, minimalist UI with relaxing color palette
- Smooth card animations and touch gestures
- Single-player card matching gameplay
- Simple scoring system
- Cross-platform (Android & iOS)

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio or VS Code with Flutter extensions
- Android SDK with API level 34
- iOS development tools (for iOS builds)

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Building for Release

#### Android
```bash
flutter build apk --release
```

#### iOS
```bash
flutter build ios --release
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── game/                     # Game engine components
│   ├── vita_game.dart       # Main game class
│   ├── card_component.dart  # Card visual component
│   ├── deck_manager.dart    # Deck creation and shuffling
│   └── game_logic.dart      # Game rules and scoring
├── screens/                  # UI screens
│   ├── home_screen.dart     # Main menu
│   └── game_over_screen.dart # End game screen
├── models/                   # Data models
│   └── card_model.dart      # Card data structure
└── utils/                    # Utilities
    ├── constants.dart       # Game constants
    └── colors.dart          # Color palette
```

## Dependencies

- `flame: ^1.12.0` - Game engine
- `flame_audio: ^2.1.0` - Audio support
- `flutter_animate: ^4.5.0` - Animations

## Game Rules

1. Tap cards to flip them face up
2. Match pairs of cards with the same rank
3. Complete all matches to win
4. Try to finish with the fewest moves for a higher score# Card_GAME
