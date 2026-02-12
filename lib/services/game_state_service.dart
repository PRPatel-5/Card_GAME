import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/vita_card.dart';
import '../models/game_level.dart';
import '../models/power_up.dart';
import '../models/player_progress.dart';

enum GameState {
  idle,
  playing,
  paused,
  completed,
  failed
}

class VitaGameState extends ChangeNotifier {
  GameLevel? currentLevel;
  GameState gameState = GameState.idle;
  
  List<GameCard> cards = [];
  GameCard? firstSelected;
  GameCard? secondSelected;
  
  int timeRemaining = 0;
  int score = 0;
  int matchesFound = 0;
  int mismatchCount = 0;
  int currentStreak = 0;
  int scoreMultiplier = 1;
  
  int hintsRemaining = 0;
  int shufflesRemaining = 0;
  bool isTimeFrozen = false;
  
  Timer? _gameTimer;
  Map<PowerUpType, DateTime> powerUpCooldowns = {};

  void startLevel(GameLevel level) {
    currentLevel = level;
    gameState = GameState.playing;
    timeRemaining = level.timeLimit;
    score = 0;
    matchesFound = 0;
    mismatchCount = 0;
    currentStreak = 0;
    scoreMultiplier = 1;
    hintsRemaining = level.hintsAvailable;
    shufflesRemaining = level.shufflesAvailable;
    
    _generateCards();
    _startTimer();
    notifyListeners();
  }

  void _generateCards() {
    cards.clear();
    final level = currentLevel!;
    final random = Random();
    
    List<VitaCard> availableCards = [];
    for (var category in level.allowedCategories) {
      availableCards.addAll(CardDatabase.getCardsByCategory(category));
    }
    
    availableCards.shuffle();
    final selectedCards = availableCards.take(level.totalPairs).toList();
    
    List<GameCard> cardList = [];
    for (int i = 0; i < selectedCards.length; i++) {
      cardList.add(GameCard(id: i * 2, vitaCard: selectedCards[i]));
      cardList.add(GameCard(id: i * 2 + 1, vitaCard: selectedCards[i]));
    }
    
    cardList.shuffle();
    cards = cardList;
  }

  void _startTimer() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (gameState == GameState.playing && !isTimeFrozen) {
        timeRemaining--;
        if (timeRemaining <= 0) {
          _endGame(false);
        }
        notifyListeners();
      }
    });
  }

  void selectCard(int cardId) {
    if (gameState != GameState.playing) return;
    
    final card = cards.firstWhere((c) => c.id == cardId);
    if (card.isMatched || card.isFlipped) return;
    
    card.isFlipped = true;
    
    if (firstSelected == null) {
      firstSelected = card;
    } else if (secondSelected == null && card != firstSelected) {
      secondSelected = card;
      _checkMatch();
    }
    
    notifyListeners();
  }

  void _checkMatch() {
    if (firstSelected == null || secondSelected == null) return;
    
    Future.delayed(const Duration(milliseconds: 600), () {
      if (firstSelected!.vitaCard.id == secondSelected!.vitaCard.id) {
        _handleMatch();
      } else {
        _handleMismatch();
      }
    });
  }

  void _handleMatch() {
    firstSelected!.isMatched = true;
    secondSelected!.isMatched = true;
    matchesFound++;
    currentStreak++;
    
    int baseScore = 100;
    if (currentStreak >= 3) scoreMultiplier = 2;
    if (currentStreak >= 5) scoreMultiplier = 3;
    if (currentStreak >= 10) scoreMultiplier = 4;
    
    score += baseScore * scoreMultiplier;
    
    firstSelected = null;
    secondSelected = null;
    
    if (matchesFound == currentLevel!.totalPairs) {
      _endGame(true);
    }
    
    notifyListeners();
  }

  void _handleMismatch() {
    firstSelected!.isFlipped = false;
    secondSelected!.isFlipped = false;
    mismatchCount++;
    currentStreak = 0;
    scoreMultiplier = 1;
    
    firstSelected = null;
    secondSelected = null;
    
    notifyListeners();
  }

  void _endGame(bool success) {
    _gameTimer?.cancel();
    gameState = success ? GameState.completed : GameState.failed;
    notifyListeners();
  }

  void useHint() {
    if (hintsRemaining <= 0 || !_canUsePowerUp(PowerUpType.hint)) return;
    
    hintsRemaining--;
    _setPowerUpCooldown(PowerUpType.hint);
    
    for (var card in cards) {
      if (!card.isMatched && !card.isFlipped) {
        final matchingCard = cards.firstWhere(
          (c) => c != card && c.vitaCard.id == card.vitaCard.id && !c.isMatched,
        );
        card.isHinted = true;
        matchingCard.isHinted = true;
        
        Future.delayed(const Duration(seconds: 3), () {
          card.isHinted = false;
          matchingCard.isHinted = false;
          notifyListeners();
        });
        break;
      }
    }
    
    notifyListeners();
  }

  void useShuffle() {
    if (shufflesRemaining <= 0 || !_canUsePowerUp(PowerUpType.shuffle)) return;
    
    shufflesRemaining--;
    _setPowerUpCooldown(PowerUpType.shuffle);
    
    final unmatchedCards = cards.where((c) => !c.isMatched).toList();
    unmatchedCards.shuffle();
    
    int unmatchedIndex = 0;
    for (int i = 0; i < cards.length; i++) {
      if (!cards[i].isMatched) {
        cards[i] = unmatchedCards[unmatchedIndex++];
      }
    }
    
    notifyListeners();
  }

  void useTimeFreeze() {
    if (!_canUsePowerUp(PowerUpType.timeFreeze)) return;
    
    _setPowerUpCooldown(PowerUpType.timeFreeze);
    isTimeFrozen = true;
    
    Future.delayed(const Duration(seconds: 5), () {
      isTimeFrozen = false;
      notifyListeners();
    });
    
    notifyListeners();
  }

  bool _canUsePowerUp(PowerUpType type) {
    final cooldown = powerUpCooldowns[type];
    if (cooldown == null) return true;
    return DateTime.now().isAfter(cooldown);
  }

  void _setPowerUpCooldown(PowerUpType type) {
    final powerUp = PowerUpDatabase.getPowerUp(type);
    if (powerUp != null) {
      powerUpCooldowns[type] = DateTime.now().add(
        Duration(seconds: powerUp.cooldownSeconds),
      );
    }
  }

  void pauseGame() {
    if (gameState == GameState.playing) {
      gameState = GameState.paused;
      notifyListeners();
    }
  }

  void resumeGame() {
    if (gameState == GameState.paused) {
      gameState = GameState.playing;
      notifyListeners();
    }
  }

  LevelProgress getLevelProgress() {
    return LevelProgress(
      levelNumber: currentLevel!.levelNumber,
      stars: LevelProgress.calculateStars(
        timeRemaining,
        currentLevel!.timeLimit,
        mismatchCount,
      ),
      score: score,
      timeRemaining: timeRemaining,
      matchesCount: matchesFound,
      mismatchesCount: mismatchCount,
      completedAt: DateTime.now(),
      isPerfect: mismatchCount == 0,
    );
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }
}

class GameCard {
  final int id;
  final VitaCard vitaCard;
  bool isFlipped;
  bool isMatched;
  bool isHinted;

  GameCard({
    required this.id,
    required this.vitaCard,
    this.isFlipped = false,
    this.isMatched = false,
    this.isHinted = false,
  });
}
