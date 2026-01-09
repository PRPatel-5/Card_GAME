import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'card_component.dart';
import 'deck_manager.dart';
import 'game_logic.dart';

class VitaGame extends FlameGame with TapCallbacks {
  late DeckManager deckManager;
  late GameLogic gameLogic;

  @override
  Color backgroundColor() => GameColors.background;

  @override
  Future<void> onLoad() async {
    camera.viewfinder.visibleGameSize = Vector2(360, 640);

    deckManager = DeckManager();
    gameLogic = GameLogic();

    await _initializeGame();
  }

  Future<void> _initializeGame() async {
    final cards = deckManager.createDeck();

    for (int i = 0; i < cards.length; i++) {
      final card = CardComponent(cards[i]);
      card.position = Vector2(
        (i % GameConstants.gridColumns) * GameConstants.cardSpacing +
            GameConstants.cardSize.x / 2,
        (i ~/ GameConstants.gridColumns) * GameConstants.cardSpacing +
            GameConstants.cardSize.y / 2 +
            100,
      );
      add(card);
    }
  }
}
