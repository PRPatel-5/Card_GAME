import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/effects.dart';
import 'dart:async' as async_lib;

import '../models/card_model.dart';
import '../models/garden_state.dart';
import '../utils/constants.dart';
import 'garden_card_component.dart';
import 'deck_manager.dart';
import 'game_logic.dart';

/// Main Garden Game - A living, breathing experience
class MemoryGardenGame extends FlameGame with TapCallbacks {
  late DeckManager deckManager;
  late GardenGameLogic gameLogic;
  List<GardenCardComponent> cardComponents = [];

  // Background layers
  late RectangleComponent skyLayer;
  late RectangleComponent groundLayer;

  // Plant components
  List<PlantComponent> plantComponents = [];

  // Callbacks
  Function(GardenState state)? onGardenUpdate;
  Function(String message)? onGameComplete;

  @override
  Color backgroundColor() => GardenColors.skyMorning;

  @override
  Future<void> onLoad() async {
    camera.viewfinder.visibleGameSize = Vector2(360, 640);

    deckManager = DeckManager();
    gameLogic = GardenGameLogic();

    await _createGardenBackground();
    await _initializeGame();
  }

  /// Create the garden background (sky + ground)
  Future<void> _createGardenBackground() async {
    // Sky gradient
    skyLayer = RectangleComponent(
      size: Vector2(360, GardenConstants.groundLevel),
      position: Vector2.zero(),
      paint: Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            gameLogic.gardenState.timeOfDay.skyColor,
            gameLogic.gardenState.timeOfDay.skyColor.withOpacity(0.8),
          ],
        ).createShader(Rect.fromLTWH(0, 0, 360, GardenConstants.groundLevel)),
    );
    add(skyLayer);

    // Ground
    groundLayer = RectangleComponent(
      size: Vector2(360, 640 - GardenConstants.groundLevel),
      position: Vector2(0, GardenConstants.groundLevel),
      paint: Paint()..color = gameLogic.gardenState.theme.groundColor,
    );
    add(groundLayer);

    // Add grass texture (simple)
    _addGrassTexture();
  }

  /// Add simple grass texture
  void _addGrassTexture() {
    for (int i = 0; i < 20; i++) {
      final x = (i * 18.0);
      final grassBlade = TextComponent(
        text: '🌾',
        textRenderer: TextPaint(
          style: TextStyle(
            fontSize: 12,
            color: GardenColors.grass.withOpacity(0.6),
          ),
        ),
        position: Vector2(x, GardenConstants.groundLevel + 10),
      );
      add(grassBlade);
    }
  }

  /// Initialize game with cards
  Future<void> _initializeGame() async {
    // Clear existing
    cardComponents.clear();
    children
        .whereType<GardenCardComponent>()
        .forEach((c) => c.removeFromParent());
    plantComponents.clear();
    children.whereType<PlantComponent>().forEach((c) => c.removeFromParent());

    final cards = deckManager.createDeck(pairs: 8);
    gameLogic.allCards = List.from(cards); // Initialize game logic cards

    // Calculate grid layout (centered)
    final totalWidth =
        GardenConstants.gridColumns * GardenConstants.cardSpacing;
    final startX = (360 - totalWidth) / 2 + GardenConstants.cardSize.x / 2;
    final startY = 80; // Below sky, above ground

    // Add cards with staggered entrance
    for (int i = 0; i < cards.length; i++) {
      final card = GardenCardComponent(cards[i])
        ..onCardTap = _onCardTapped;
      final row = i ~/ GardenConstants.gridColumns;
      final col = i % GardenConstants.gridColumns;

      card.position = Vector2(
        startX + col * GardenConstants.cardSpacing,
        startY + row * GardenConstants.cardSpacing,
      );

      cardComponents.add(card);
      add(card);

      await async_lib.Future.delayed(const Duration(milliseconds: 100));
    }
  }

  /// Handle card tap
  void _onCardTapped(CardModel card) {
    final updatedCard = gameLogic.flipCard(card);
    if (updatedCard != card) {
      // Update the component's card model
      final component = cardComponents.firstWhere((c) => c.cardModel.id == card.id);
      component.cardModel = updatedCard;
      component.flip();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _checkGameLogic();
    _updatePlants(dt);
  }

  /// Check game state
  void _checkGameLogic() {
    if (gameLogic.flippedCards.length == 2 && !gameLogic.isProcessing) {
      final card1 = gameLogic.flippedCards[0];
      final card2 = gameLogic.flippedCards[1];

      final comp1 = cardComponents.firstWhere((c) => c.cardModel.id == card1.id);
      final comp2 = cardComponents.firstWhere((c) => c.cardModel.id == card2.id);

      if (card1.matches(card2)) {
        // MATCH! Grow plants
        async_lib.Future.delayed(const Duration(milliseconds: 600), () {
          // Update components with matched cards
          final matchedCard1 = gameLogic.allCards.firstWhere((c) => c.id == card1.id);
          final matchedCard2 = gameLogic.allCards.firstWhere((c) => c.id == card2.id);
          
          comp1.cardModel = matchedCard1;
          comp2.cardModel = matchedCard2;
          
          comp1.markAsMatched();
          comp2.markAsMatched();

          // Add plants to garden
          _addNewPlants();

          onGardenUpdate?.call(gameLogic.gardenState);

          _checkGameComplete();
        });
      } else {
        // Wrong match - gentle feedback
        comp1.markAsWilted();
        comp2.markAsWilted();

        async_lib.Future.delayed(const Duration(milliseconds: 1200), () {
          // Update components with recovered cards
          final recoveredCard1 = gameLogic.allCards.firstWhere((c) => c.id == card1.id).recover();
          final recoveredCard2 = gameLogic.allCards.firstWhere((c) => c.id == card2.id).recover();
          
          // Update game logic
          gameLogic.updateCard(recoveredCard1);
          gameLogic.updateCard(recoveredCard2);
          
          comp1.cardModel = recoveredCard1;
          comp2.cardModel = recoveredCard2;
          
          comp1.flipBack();
          comp2.flipBack();

          onGardenUpdate?.call(gameLogic.gardenState);
        });
      }

      gameLogic.isProcessing = true;
      async_lib.Future.delayed(const Duration(milliseconds: 1500), () {
        gameLogic.isProcessing = false;
      });
    }
  }

  /// Add new plants to garden
  void _addNewPlants() {
    final newPlants = gameLogic.gardenState.plants
        .where((p) => !plantComponents.any((pc) => pc.plant.id == p.id))
        .toList();

    for (final plant in newPlants) {
      final plantComp = PlantComponent(plant);
      plantComponents.add(plantComp);
      add(plantComp);
    }
  }

  /// Update plant growth
  void _updatePlants(double dt) {
    for (final plantComp in plantComponents) {
      plantComp.grow(dt);
    }
  }

  /// Check if game is complete
  void _checkGameComplete() {
    if (gameLogic.isGameComplete(gameLogic.allCards)) {
      async_lib.Future.delayed(const Duration(milliseconds: 1000), () {
        final message = gameLogic.getCompletionMessage();
        onGameComplete?.call(message);
      });
    }
  }

  /// Reset game
  void reset() {
    gameLogic.reset();
    _initializeGame();
  }
}

/// Plant Component - Visual representation of garden growth
class PlantComponent extends PositionComponent {
  final PlantGrowth plant;
  late TextComponent plantEmoji;
  double currentSize = 0.0;

  PlantComponent(this.plant)
      : super(
          position: Vector2(plant.x, plant.y),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    plantEmoji = TextComponent(
      text: plant.emoji,
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 24),
      ),
      anchor: Anchor.center,
    );

    add(plantEmoji);

    // Start invisible and grow
    scale = Vector2.all(0.1);
  }

  /// Grow the plant over time
  void grow(double dt) {
    if (currentSize < 1.0) {
      currentSize += dt * 0.3; // Slow growth
      currentSize = currentSize.clamp(0.0, 1.0);

      // Update scale
      scale = Vector2.all(0.3 + currentSize * 0.7);

      // Update emoji size
      final fontSize = 24 + currentSize * 20;
      plantEmoji.textRenderer = TextPaint(
        style: TextStyle(fontSize: fontSize),
      );
    }

    // Gentle sway
    final sway = 0.02 * currentSize;
    angle =
        sway * (0.5 - (DateTime.now().millisecondsSinceEpoch % 3000) / 3000);
  }
}
