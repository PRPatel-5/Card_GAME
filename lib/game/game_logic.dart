import '../models/card_model.dart';

class GameLogic {
  List<CardModel> flippedCards = [];
  int score = 0;
  int moves = 0;
  int matches = 0;
  int comboStreak = 0;
  int bestCombo = 0;
  DateTime? lastMatchTime;
  bool isProcessing = false;

  bool canFlipCard(CardModel card) {
    return !isProcessing && 
           card.state == CardState.faceDown && 
           flippedCards.length < 2;
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
    isProcessing = true;
    
    if (flippedCards.length == 2) {
      final card1 = flippedCards[0];
      final card2 = flippedCards[1];
      
      if (card1.matches(card2)) {
        // MATCH! Calculate combo bonus
        final now = DateTime.now();
        final timeSinceLastMatch = lastMatchTime != null 
            ? now.difference(lastMatchTime!).inSeconds 
            : 999;
        
        // Combo if matched within 3 seconds of last match
        if (timeSinceLastMatch < 3) {
          comboStreak++;
        } else {
          comboStreak = 1;
        }
        
        // Update best combo
        if (comboStreak > bestCombo) {
          bestCombo = comboStreak;
        }
        
        lastMatchTime = now;
        
        // Calculate score with combo multiplier
        final baseScore = 100;
        final comboBonus = (comboStreak - 1) * 50;
        final timeBonus = timeSinceLastMatch < 2 ? 25 : 0;
        
        score += baseScore + comboBonus + timeBonus;
        matches++;
        
        card1.state = CardState.matched;
        card2.state = CardState.matched;
      } else {
        // No match - reset combo
        comboStreak = 0;
        
        // Deduct points for wrong match
        score = (score - 10).clamp(0, double.infinity).toInt();
      }
      
      flippedCards.clear();
      isProcessing = false;
    }
  }

  bool isGameComplete(List<CardModel> allCards) {
    return allCards.every((card) => card.state == CardState.matched);
  }

  int calculateStars() {
    // 3 stars if completed with high efficiency
    final efficiency = matches > 0 ? matches / moves : 0;
    
    if (efficiency >= 0.95) return 3;
    if (efficiency >= 0.80) return 2;
    if (efficiency >= 0.65) return 1;
    return 0;
  }

  String getScoreRating() {
    if (score >= 2000) return 'LEGENDARY! 🏆';
    if (score >= 1500) return 'AMAZING! ⭐';
    if (score >= 1000) return 'GREAT! 🎯';
    if (score >= 500) return 'GOOD! 👍';
    return 'KEEP TRYING! 💪';
  }

  void resetGame() {
    flippedCards.clear();
    score = 0;
    moves = 0;
    matches = 0;
    comboStreak = 0;
    lastMatchTime = null;
    isProcessing = false;
  }
}