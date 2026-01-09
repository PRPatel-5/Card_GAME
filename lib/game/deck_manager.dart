import 'dart:math';
import '../models/card_model.dart';

class DeckManager {
  List<CardModel> createDeck() {
    List<CardModel> cards = [];
    
    // Create pairs of cards for matching game
    for (int rank = 1; rank <= 8; rank++) {
      cards.add(CardModel(suit: CardSuit.hearts, rank: rank));
      cards.add(CardModel(suit: CardSuit.spades, rank: rank));
    }
    
    return shuffleDeck(cards);
  }

  List<CardModel> shuffleDeck(List<CardModel> cards) {
    final random = Random();
    for (int i = cards.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      CardModel temp = cards[i];
      cards[i] = cards[j];
      cards[j] = temp;
    }
    return cards;
  }
}