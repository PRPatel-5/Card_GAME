import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'dart:async' as async_lib;

import '../utils/constants.dart';
import 'card_component.dart';
import 'deck_manager.dart';
import 'game_logic.dart';
import '../models/card_model.dart';

class VitaGame extends FlameGame with TapCallbacks {
  late DeckManager deckManager;
  late GameLogic gameLogic;
  List<CardComponent> cardComponents = [];
  
  // Game state callbacks
  Function(int score, int moves, int combo)? onGameUpdate;
  Function(int score, int moves, int stars)? onGameComplete;

  @override
  Color backgroundColor() => GameColors.primaryDark;

  @override
  Future<void> onLoad() async {
    camera.viewfinder.visibleGameSize = Vector2(360, 640);

    deckManager = DeckManager();
    gameLogic = GameLogic();

    await _initializeGame();
  }

  Future<void> _initializeGame() async {
    // Clear existing cards
    cardComponents.clear();
    children.whereType<CardComponent>().forEach((card) => card.removeFromParent());
    
    final cards = deckManager.createDeck();
    
    // Calculate grid positioning for centered layout
    final totalWidth = GameConstants.gridColumns * GameConstants.cardSpacing;
    final totalHeight = GameConstants.gridRows * GameConstants.cardSpacing;
    final startX = (360 - totalWidth) / 2 + GameConstants.cardSize.x / 2;
    final startY = 150; // Leave space for header

    for (int i = 0; i < cards.length; i++) {
      final card = CardComponent(cards[i]);
      final row = i ~/ GameConstants.gridColumns;
      final col = i % GameConstants.gridColumns;
      
      card.position = Vector2(
        startX + col * GameConstants.cardSpacing,
        startY + row * GameConstants.cardSpacing,
      );
      
      cardComponents.add(card);
      add(card);
      
      // Stagger the entrance animation
      await async_lib.Future.delayed(const Duration(milliseconds: 50));
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _checkGameLogic();
  }

  void _checkGameLogic() {
    // Check if two cards are flipped
    if (gameLogic.flippedCards.length == 2 && !gameLogic.isProcessing) {
      final card1 = gameLogic.flippedCards[0];
      final card2 = gameLogic.flippedCards[1];
      
      // Find corresponding components
      final comp1 = cardComponents.firstWhere((c) => c.cardModel == card1);
      final comp2 = cardComponents.firstWhere((c) => c.cardModel == card2);
      
      if (card1.matches(card2)) {
        // MATCH!
        async_lib.Future.delayed(const Duration(milliseconds: 400), () {
          comp1.markAsMatched();
          comp2.markAsMatched();
          
          // Update UI
          onGameUpdate?.call(
            gameLogic.score,
            gameLogic.moves,
            gameLogic.comboStreak,
          );
          
          // Check if game is complete
          _checkGameComplete();
        });
      } else {
        // NO MATCH - flip back
        comp1.markAsWrong();
        comp2.markAsWrong();
        
        async_lib.Future.delayed(const Duration(milliseconds: 800), () {
          comp1.flipBack();
          comp2.flipBack();
          
          onGameUpdate?.call(
            gameLogic.score,
            gameLogic.moves,
            gameLogic.comboStreak,
          );
        });
      }
      
      gameLogic.isProcessing = true;
      async_lib.Future.delayed(const Duration(milliseconds: 1000), () {
        gameLogic.isProcessing = false;
      });
    }
  }

  void _checkGameComplete() {
    final allCards = cardComponents.map((c) => c.cardModel).toList();
    if (gameLogic.isGameComplete(allCards)) {
      async_lib.Future.delayed(const Duration(milliseconds: 500), () {
        final stars = gameLogic.calculateStars();
        onGameComplete?.call(gameLogic.score, gameLogic.moves, stars);
      });
    }
  }

  void handleCardTap(CardComponent card) {
    if (gameLogic.canFlipCard(card.cardModel)) {
      gameLogic.flipCard(card.cardModel);
      onGameUpdate?.call(
        gameLogic.score,
        gameLogic.moves,
        gameLogic.comboStreak,
      );
    }
  }

  void resetGame() {
    gameLogic.resetGame();
    _initializeGame();
  }
}
