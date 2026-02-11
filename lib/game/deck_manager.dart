import 'dart:math';
import '../models/card_model.dart';
import '../utils/constants.dart';

/// Deck Manager - Creates balanced card sets for the garden
class DeckManager {
  final Random _random = Random();
  
  /// Create a deck with specified number of pairs
  List<CardModel> createDeck({int pairs = 8}) {
    final List<CardModel> deck = [];
    
    // Determine card type distribution
    // Balanced mix of all types for variety
    final types = _generateTypeDistribution(pairs);
    
    for (int i = 0; i < pairs; i++) {
      final type = types[i];
      final value = i; // Unique value for matching
      
      // Create pair
      deck.add(CardModel(
        id: 'card_${i}_a',
        type: type,
        value: value,
      ));
      
      deck.add(CardModel(
        id: 'card_${i}_b',
        type: type,
        value: value,
      ));
    }
    
    // Shuffle the deck
    deck.shuffle(_random);
    
    return deck;
  }
  
  /// Generate balanced type distribution
  List<CardType> _generateTypeDistribution(int pairs) {
    final types = <CardType>[];
    final allTypes = CardType.values;
    
    // Evenly distribute types
    for (int i = 0; i < pairs; i++) {
      types.add(allTypes[i % allTypes.length]);
    }
    
    // Shuffle for randomness
    types.shuffle(_random);
    
    return types;
  }
  
  /// Create a themed deck (e.g., all flowers)
  List<CardModel> createThemedDeck({
    required CardType theme,
    int pairs = 8,
  }) {
    final List<CardModel> deck = [];
    
    for (int i = 0; i < pairs; i++) {
      final value = i;
      
      deck.add(CardModel(
        id: 'card_${i}_a',
        type: theme,
        value: value,
      ));
      
      deck.add(CardModel(
        id: 'card_${i}_b',
        type: theme,
        value: value,
      ));
    }
    
    deck.shuffle(_random);
    return deck;
  }
  
  /// Create progressive difficulty deck
  /// Starts easy (fewer cards), gets harder
  List<CardModel> createProgressiveDeck(int level) {
    // Level 1: 4 pairs (8 cards)
    // Level 2: 6 pairs (12 cards)
    // Level 3: 8 pairs (16 cards)
    final pairs = 4 + (level - 1) * 2;
    return createDeck(pairs: pairs.clamp(4, 8));
  }
}
