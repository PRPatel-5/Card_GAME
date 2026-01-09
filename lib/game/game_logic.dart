import '../models/card_model.dart';

class GameLogic {
  List<CardModel> flippedCards = [];
  int score = 0;
  int moves = 0;

  bool canFlipCard(CardModel card) {
    return card.state == CardState.faceDown && flippedCards.length < 2;
  }

  void flipCard(CardModel card) {
    if (canFlipCard(card)) {
      card.state = CardState.faceUp;
      flippedCards.add(card);
      moves++;
      
      if (flippedCards.length == 2) {
        _checkForMatch();
      }
    }
  }

  void _checkForMatch() {
    if (flippedCards.length == 2) {
      final card1 = flippedCards[0];
      final card2 = flippedCards[1];
      
      if (card1.matches(card2)) {
        card1.state = CardState.matched;
        card2.state = CardState.matched;
        score += 10;
      } else {
        // Flip back after delay
        Future.delayed(const Duration(seconds: 1), () {
          card1.state = CardState.faceDown;
          card2.state = CardState.faceDown;
        });
      }
      
      flippedCards.clear();
    }
  }

  bool isGameComplete(List<CardModel> allCards) {
    return allCards.every((card) => card.state == CardState.matched);
  }

  void resetGame() {
    flippedCards.clear();
    score = 0;
    moves = 0;
  }
}