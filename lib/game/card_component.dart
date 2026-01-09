import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/card_model.dart';
import '../utils/constants.dart';

class CardComponent extends PositionComponent with TapCallbacks {
  final CardModel cardModel;
  late RectangleComponent cardBack;
  late RectangleComponent cardFront;
  late TextComponent rankText;
  late TextComponent suitText;
  late TextComponent suitCorner;
  bool isFlipping = false;
  bool isFaceUp = false;

  CardComponent(this.cardModel) : super(size: GameConstants.cardSize, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    // Create card back (gradient effect)
    cardBack = RectangleComponent(
      size: size,
      paint: Paint()
        ..shader = LinearGradient(
          colors: [GameColors.cardBackStart, GameColors.cardBackEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, size.x, size.y))
        ..style = PaintingStyle.fill,
      children: [
        RectangleComponent(
          size: size,
          paint: Paint()
            ..color = Colors.white.withOpacity(0.2)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3,
        ),
        // Decorative pattern on back
        TextComponent(
          text: '★',
          textRenderer: TextPaint(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          position: Vector2(size.x / 2, size.y / 2),
          anchor: Anchor.center,
        ),
      ],
    );

    // Create card front (with shadow and gradient)
    cardFront = RectangleComponent(
      size: size,
      paint: Paint()
        ..shader = LinearGradient(
          colors: [GameColors.cardFrontStart, GameColors.cardFrontEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, size.x, size.y))
        ..style = PaintingStyle.fill,
    );

    // Add card content
    _addCardContent();

    // Initially show back
    if (cardModel.state == CardState.faceDown) {
      add(cardBack);
      isFaceUp = false;
    } else {
      add(cardFront);
      isFaceUp = true;
    }

    // Add subtle hover effect
    add(
      ScaleEffect.to(
        Vector2.all(1.0),
        EffectController(
          duration: 0.3,
          alternate: true,
          infinite: true,
        ),
      ),
    );
  }

  void _addCardContent() {
    final textColor = _getSuitColor();

    // Large center suit symbol
    suitText = TextComponent(
      text: cardModel.suitSymbol,
      textRenderer: TextPaint(
        style: TextStyle(
          color: textColor,
          fontSize: 40,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: textColor.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
      ),
      position: Vector2(size.x / 2, size.y / 2),
      anchor: Anchor.center,
    );

    // Top-left rank and suit
    rankText = TextComponent(
      text: cardModel.rankString,
      textRenderer: TextPaint(
        style: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      position: Vector2(10, 10),
    );

    suitCorner = TextComponent(
      text: cardModel.suitSymbol,
      textRenderer: TextPaint(
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      position: Vector2(10, 28),
    );

    // Add border
    final border = RectangleComponent(
      size: size,
      paint: Paint()
        ..color = GameColors.cardBorder
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );

    cardFront.addAll([border, rankText, suitCorner, suitText]);
  }

  Color _getSuitColor() {
    switch (cardModel.suit) {
      case CardSuit.hearts:
        return GameColors.hearts;
      case CardSuit.diamonds:
        return GameColors.diamonds;
      case CardSuit.clubs:
        return GameColors.clubs;
      case CardSuit.spades:
        return GameColors.spades;
    }
  }

  @override
  bool onTapDown(TapDownEvent event) {
    if (!isFlipping && cardModel.state == CardState.faceDown) {
      flipCard();
      // Trigger haptic feedback would go here
      _addTapEffect();
    }
    return true;
  }

  void _addTapEffect() {
    add(
      ScaleEffect.to(
        Vector2.all(0.95),
        EffectController(
          duration: 0.1,
          reverseDuration: 0.1,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  void flipCard() {
    if (isFlipping) return;
    isFlipping = true;

    // Flip animation using scale
    add(
      SequenceEffect([
        ScaleEffect.to(
          Vector2(0, 1),
          EffectController(duration: GameConstants.flipDuration / 2),
          onComplete: () {
            // Switch card face at the middle of animation
            if (isFaceUp) {
              remove(cardFront);
              add(cardBack);
            } else {
              remove(cardBack);
              add(cardFront);
            }
            isFaceUp = !isFaceUp;
          },
        ),
        ScaleEffect.to(
          Vector2.all(1.0),
          EffectController(duration: GameConstants.flipDuration / 2),
          onComplete: () {
            isFlipping = false;
          },
        ),
      ]),
    );

    cardModel.state = CardState.faceUp;
  }

  void flipBack() {
    if (isFlipping || !isFaceUp) return;
    isFlipping = true;

    add(
      SequenceEffect([
        ScaleEffect.to(
          Vector2(0, 1),
          EffectController(duration: GameConstants.flipDuration / 2),
          onComplete: () {
            remove(cardFront);
            add(cardBack);
            isFaceUp = false;
          },
        ),
        ScaleEffect.to(
          Vector2.all(1.0),
          EffectController(duration: GameConstants.flipDuration / 2),
          onComplete: () {
            isFlipping = false;
          },
        ),
      ]),
    );

    cardModel.state = CardState.faceDown;
  }

  void markAsMatched() {
    cardModel.state = CardState.matched;

    // Celebration effect - pulse and glow
    add(
      SequenceEffect([
        ScaleEffect.to(
          Vector2.all(1.15),
          EffectController(duration: 0.2),
        ),
        ScaleEffect.to(
          Vector2.all(1.0),
          EffectController(duration: 0.2),
        ),
      ]),
    );

    // Change card front to matched color
    final matchedPaint = Paint()
      ..shader = LinearGradient(
        colors: [GameColors.matchedStart, GameColors.matchedEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.x, size.y));

    cardFront.paint = matchedPaint;

    // Add sparkle effect
    _addSparkles();
  }

  void markAsWrong() {
    // Quick shake effect
    add(
      SequenceEffect([
        MoveEffect.by(
          Vector2(5, 0),
          EffectController(duration: 0.05),
        ),
        MoveEffect.by(
          Vector2(-10, 0),
          EffectController(duration: 0.1),
        ),
        MoveEffect.by(
          Vector2(10, 0),
          EffectController(duration: 0.1),
        ),
        MoveEffect.by(
          Vector2(-5, 0),
          EffectController(duration: 0.05),
        ),
      ]),
    );
  }

  void _addSparkles() {
    final random = math.Random();
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi * 2) / 8;
      final sparkle = CircleComponent(
        radius: 3,
        paint: Paint()..color = GameColors.accentGold,
        position: Vector2(size.x / 2, size.y / 2),
      );

      add(sparkle);

      final distance = 40.0;
      sparkle.add(
        SequenceEffect([
          MoveEffect.by(
            Vector2(math.cos(angle) * distance, math.sin(angle) * distance),
            EffectController(duration: 0.5, curve: Curves.easeOut),
          ),
          RemoveEffect(),
        ]),
      );

      sparkle.add(
        OpacityEffect.to(
          0,
          EffectController(duration: 0.5),
        ),
      );
    }
  }
}