import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../utils/constants.dart';

class CardComponent extends RectangleComponent with TapCallbacks {
  final CardModel cardModel;
  late TextComponent rankText;
  late TextComponent suitText;

  CardComponent(this.cardModel) : super(size: GameConstants.cardSize);

  @override
  Future<void> onLoad() async {
    paint = Paint()
      ..color = cardModel.state == CardState.faceDown 
          ? GameColors.cardBack 
          : GameColors.cardFront
      ..style = PaintingStyle.fill;

    add(RectangleComponent(
      size: size,
      paint: Paint()
        ..color = GameColors.cardBorder
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    ));

    if (cardModel.state != CardState.faceDown) {
      _addCardContent();
    }
  }

  void _addCardContent() {
    final textColor = cardModel.suit == CardSuit.hearts || cardModel.suit == CardSuit.diamonds
        ? GameColors.hearts
        : GameColors.clubs;

    rankText = TextComponent(
      text: cardModel.rankString,
      textRenderer: TextPaint(
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      position: Vector2(8, 8),
    );

    suitText = TextComponent(
      text: cardModel.suitSymbol,
      textRenderer: TextPaint(
        style: TextStyle(
          color: textColor,
          fontSize: 20,
        ),
      ),
      position: Vector2(size.x / 2 - 6, size.y / 2 - 10),
    );

    add(rankText);
    add(suitText);
  }

  @override
  bool onTapDown(TapDownEvent event) {
    if (cardModel.state == CardState.faceDown) {
      flipCard();
    }
    return true;
  }

  void flipCard() {
    cardModel.state = CardState.faceUp;
    paint.color = GameColors.cardFront;
    _addCardContent();
  }

  void markAsMatched() {
    cardModel.state = CardState.matched;
    paint.color = GameColors.matched;
  }
}