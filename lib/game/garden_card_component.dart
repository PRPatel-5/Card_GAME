import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../models/card_model.dart';
import '../game/memory_garden_game.dart';
import '../utils/constants.dart';

/// Card Component with organic animations and emotional responses
class GardenCardComponent extends PositionComponent with TapCallbacks {
  CardModel cardModel;
  late RectangleComponent cardBack;
  late RectangleComponent cardFront;
  late TextComponent contentText;
  bool isFlipping = false;
  bool isFaceUp = false;
  
  // Breathing effect (subtle scale)
  double breathPhase = 0;
  
  // Callback for card updates
  Function(CardModel)? onCardTap;

  GardenCardComponent(this.cardModel)
      : super(
          size: GardenConstants.cardSize,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    // Create card back (soft, earthy)
    cardBack = RectangleComponent(
      size: size,
      paint: Paint()
        ..color = GardenColors.cardBack
        ..style = PaintingStyle.fill,
      children: [
        // Subtle border
        RectangleComponent(
          size: size,
          paint: Paint()
            ..color = GardenColors.cardBorder.withOpacity(0.3)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        ),
        // Organic pattern (leaf shape)
        TextComponent(
          text: '🌿',
          textRenderer: TextPaint(
            style: TextStyle(
              color: GardenColors.soilLight.withOpacity(0.2),
              fontSize: 40,
            ),
          ),
          position: Vector2(size.x / 2, size.y / 2),
          anchor: Anchor.center,
        ),
      ],
    );

    // Create card front (warm white)
    cardFront = RectangleComponent(
      size: size,
      paint: Paint()
        ..color = GardenColors.cardFront
        ..style = PaintingStyle.fill,
    );

    _buildCardContent();

    // Start with back showing
    if (cardModel.state == CardState.faceDown) {
      add(cardBack);
      isFaceUp = false;
    } else {
      add(cardFront);
      isFaceUp = true;
    }

    // Add subtle breathing animation
    _startBreathingEffect();
  }

  /// Build the card's visual content
  void _buildCardContent() {
    // Large emoji in center
    contentText = TextComponent(
      text: cardModel.displayEmoji,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 48,
        ),
      ),
      position: Vector2(size.x / 2, size.y / 2 - 10),
      anchor: Anchor.center,
    );

    // Type label at bottom
    final typeLabel = TextComponent(
      text: cardModel.displayName,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 10,
          color: cardModel.displayColor.withOpacity(0.7),
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
      ),
      position: Vector2(size.x / 2, size.y - 15),
      anchor: Anchor.center,
    );

    // Soft border
    final border = RectangleComponent(
      size: size,
      paint: Paint()
        ..color = cardModel.displayColor.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    cardFront.addAll([border, contentText, typeLabel]);
  }

  /// Subtle breathing animation (organic feel)
  void _startBreathingEffect() {
    add(
      SequenceEffect(
        [
          ScaleEffect.to(
            Vector2.all(1.02),
            EffectController(
              duration: GardenConstants.breathingCycle / 2,
              curve: GardenCurves.breath,
            ),
          ),
          ScaleEffect.to(
            Vector2.all(1.0),
            EffectController(
              duration: GardenConstants.breathingCycle / 2,
              curve: GardenCurves.breath,
            ),
          ),
        ],
        infinite: true,
      ),
    );
  }

  @override
  bool onTapDown(TapDownEvent event) {
    if (!isFlipping && cardModel.state == CardState.faceDown) {
      onCardTap?.call(cardModel);
      return true;
    }
    return false;
  }

  
  /// Flip card (slow, organic animation)
  void flip() {
    if (isFlipping) return;
    isFlipping = true;

    // Scale animation for flip
    add(
      SequenceEffect([
        // Shrink horizontally
        ScaleEffect.to(
          Vector2(0, 1),
          EffectController(
            duration: GardenConstants.flipDuration / 2,
            curve: GardenCurves.gentle,
          ),
          onComplete: () {
            // Switch card face at midpoint
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
        // Expand horizontally
        ScaleEffect.to(
          Vector2.all(1.0),
          EffectController(
            duration: GardenConstants.flipDuration / 2,
            curve: GardenCurves.gentle,
          ),
          onComplete: () {
            isFlipping = false;
          },
        ),
      ]),
    );
  }

  /// Flip back to face down (after wrong match)
  void flipBack() {
    if (!isFaceUp || isFlipping) return;
    isFlipping = true;

    add(
      SequenceEffect([
        ScaleEffect.to(
          Vector2(0, 1),
          EffectController(
            duration: GardenConstants.flipDuration / 2,
            curve: GardenCurves.gentle,
          ),
          onComplete: () {
            remove(cardFront);
            add(cardBack);
            isFaceUp = false;
          },
        ),
        ScaleEffect.to(
          Vector2.all(1.0),
          EffectController(
            duration: GardenConstants.flipDuration / 2,
            curve: GardenCurves.gentle,
          ),
          onComplete: () {
            isFlipping = false;
          },
        ),
      ]),
    );
  }

  /// Mark as matched (gentle celebration)
  void markAsMatched() {
    // Update content to bloomed version
    contentText.text = cardModel.displayEmoji;

    // Gentle growth animation
    add(
      SequenceEffect([
        ScaleEffect.to(
          Vector2.all(1.1),
          EffectController(
            duration: GardenConstants.growthDuration / 2,
            curve: GardenCurves.grow,
          ),
        ),
        ScaleEffect.to(
          Vector2.all(1.0),
          EffectController(
            duration: GardenConstants.growthDuration / 2,
            curve: GardenCurves.gentle,
          ),
        ),
      ]),
    );

    // Add soft glow particles
    _addGlowParticles();
  }

  /// Mark as wilted (gentle negative feedback)
  void markAsWilted() {
    // Very subtle shake (not aggressive)
    add(
      SequenceEffect([
        MoveEffect.by(
          Vector2(3, 0),
          EffectController(duration: 0.1),
        ),
        MoveEffect.by(
          Vector2(-6, 0),
          EffectController(duration: 0.2),
        ),
        MoveEffect.by(
          Vector2(3, 0),
          EffectController(duration: 0.1),
        ),
      ]),
    );
  }

  /// Add soft glow particles (like pollen or light)
  void _addGlowParticles() {
    for (int i = 0; i < 6; i++) {
      final angle = (i * math.pi * 2) / 6;
      final particle = CircleComponent(
        radius: 2,
        paint: Paint()
          ..color = GardenColors.particleGlow.withOpacity(0.6),
        position: Vector2(size.x / 2, size.y / 2),
      );

      add(particle);

      const distance = 30.0;
      particle.add(
        SequenceEffect([
          MoveEffect.by(
            Vector2(
              math.cos(angle) * distance,
              math.sin(angle) * distance,
            ),
            EffectController(
              duration: 1.0,
              curve: GardenCurves.gentle,
            ),
          ),
          RemoveEffect(),
        ]),
      );
    }
  }
}
