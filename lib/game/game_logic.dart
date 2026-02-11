import 'dart:math';
import '../models/card_model.dart';
import '../models/garden_state.dart';
import '../utils/constants.dart';

/// Game Logic - Manages matching, garden growth, and emotional responses
class GardenGameLogic {
  GardenState gardenState = const GardenState();
  List<CardModel> flippedCards = [];
  List<CardModel> allCards = []; // Track all cards
  bool isProcessing = false;
  final Random _random = Random();

  /// Check if a card can be flipped
  bool canFlipCard(CardModel card) {
    return !isProcessing &&
        card.state == CardState.faceDown &&
        flippedCards.length < 2;
  }

  /// Flip a card
  CardModel flipCard(CardModel card) {
    if (canFlipCard(card)) {
      final updatedCard = card.copyWith(state: CardState.faceUp);
      updateCard(updatedCard);
      flippedCards.add(updatedCard);

      if (flippedCards.length == 2) {
        _checkForMatch();
      }
      return updatedCard;
    }
    return card;
  }

  /// Update a card in the allCards list
  void updateCard(CardModel updatedCard) {
    final index = allCards.indexWhere((c) => c.id == updatedCard.id);
    if (index != -1) {
      allCards[index] = updatedCard;
    }
  }

  /// Check if two flipped cards match
  void _checkForMatch() {
    isProcessing = true;

    if (flippedCards.length == 2) {
      final card1 = flippedCards[0];
      final card2 = flippedCards[1];

      if (card1.matches(card2)) {
        _handleCorrectMatch(card1, card2);
      } else {
        _handleWrongMatch(card1, card2);
      }
    }
  }

  /// Handle correct match (grow garden)
  void _handleCorrectMatch(CardModel card1, CardModel card2) {
    // Update card states
    final updatedCard1 = card1.onCorrectMatch();
    final updatedCard2 = card2.onCorrectMatch();
    
    updateCard(updatedCard1);
    updateCard(updatedCard2);

    // Create new plant in garden
    final newPlant = _createPlant(
      card1.type,
      isRare: updatedCard1.isRare || updatedCard2.isRare,
    );

    // Update garden state
    gardenState = gardenState.onCorrectMatch(newPlant);

    flippedCards.clear();
    isProcessing = false;
  }

  /// Handle wrong match (slight wilt)
  void _handleWrongMatch(CardModel card1, CardModel card2) {
    // Update card states (gentle penalty)
    final updatedCard1 = card1.onWrongMatch();
    final updatedCard2 = card2.onWrongMatch();
    
    updateCard(updatedCard1);
    updateCard(updatedCard2);

    // Update garden state
    gardenState = gardenState.onMistake();

    flippedCards.clear();
    isProcessing = false;
  }

  /// Create a plant for the garden
  PlantGrowth _createPlant(CardType type, {bool isRare = false}) {
    // Random position in garden area
    final x = 50 + _random.nextDouble() * 260; // Keep within bounds
    final y = GardenConstants.groundLevel - 50 - _random.nextDouble() * 100;

    return PlantGrowth(
      id: 'plant_${DateTime.now().millisecondsSinceEpoch}',
      plantType: type,
      x: x,
      y: y,
      isRare: isRare,
    );
  }

  /// Check if game is complete
  bool isGameComplete(List<CardModel> allCards) {
    return allCards.every((card) => card.state == CardState.matched);
  }

  /// Get garden health message
  String getHealthMessage() {
    if (gardenState.isThriving) {
      return 'Your garden is thriving! 🌿';
    } else if (gardenState.isStruggling) {
      return 'Your garden needs care... 🥀';
    } else {
      return 'Your garden is growing steadily. 🌱';
    }
  }

  /// Get completion message (no harsh judgment)
  String getCompletionMessage() {
    final accuracy = gardenState.accuracy;
    
    if (accuracy >= 0.95) {
      return 'A perfect garden has bloomed.';
    } else if (accuracy >= 0.85) {
      return 'A beautiful garden has grown.';
    } else if (accuracy >= 0.70) {
      return 'Your garden has taken root.';
    } else {
      return 'Seeds have been planted.';
    }
  }

  /// Reset for new game
  void reset() {
    gardenState = const GardenState();
    flippedCards.clear();
    allCards.clear();
    isProcessing = false;
  }

  /// Progress time of day (for visual variety)
  void progressTime() {
    gardenState = gardenState.progressTimeOfDay();
  }
}
