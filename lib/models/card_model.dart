enum CardSuit { hearts, diamonds, clubs, spades }

enum CardState { faceDown, faceUp, matched }

class CardModel {
  final CardSuit suit;
  final int rank;
  CardState state;
  
  CardModel({
    required this.suit,
    required this.rank,
    this.state = CardState.faceDown,
  });

  String get suitSymbol {
    switch (suit) {
      case CardSuit.hearts:
        return '♥';
      case CardSuit.diamonds:
        return '♦';
      case CardSuit.clubs:
        return '♣';
      case CardSuit.spades:
        return '♠';
    }
  }

  String get rankString {
    switch (rank) {
      case 1:
        return 'A';
      case 11:
        return 'J';
      case 12:
        return 'Q';
      case 13:
        return 'K';
      default:
        return rank.toString();
    }
  }

  bool matches(CardModel other) {
    return rank == other.rank;
  }
}