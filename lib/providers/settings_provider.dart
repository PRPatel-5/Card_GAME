import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _soundEnabled = true;
  bool _musicEnabled = true;
  bool _animationsEnabled = true;
  int _highScore = 0;
  int _gamesPlayed = 0;
  int _gamesWon = 0;

  bool get soundEnabled => _soundEnabled;
  bool get musicEnabled => _musicEnabled;
  bool get animationsEnabled => _animationsEnabled;
  int get highScore => _highScore;
  int get gamesPlayed => _gamesPlayed;
  int get gamesWon => _gamesWon;

  SettingsProvider() { _load(); }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    _soundEnabled = p.getBool('sound') ?? true;
    _musicEnabled = p.getBool('music') ?? true;
    _animationsEnabled = p.getBool('anims') ?? true;
    _highScore = p.getInt('highScore') ?? 0;
    _gamesPlayed = p.getInt('played') ?? 0;
    _gamesWon = p.getInt('won') ?? 0;
    notifyListeners();
  }

  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setBool('sound', _soundEnabled);
    await p.setBool('music', _musicEnabled);
    await p.setBool('anims', _animationsEnabled);
    await p.setInt('highScore', _highScore);
    await p.setInt('played', _gamesPlayed);
    await p.setInt('won', _gamesWon);
  }

  void toggleSound() { _soundEnabled = !_soundEnabled; _save(); notifyListeners(); }
  void toggleMusic() { _musicEnabled = !_musicEnabled; _save(); notifyListeners(); }
  void toggleAnimations() { _animationsEnabled = !_animationsEnabled; _save(); notifyListeners(); }

  void updateHighScore(int s) { if (s > _highScore) { _highScore = s; _save(); notifyListeners(); } }
  void recordGame({bool won = false}) { _gamesPlayed++; if (won) _gamesWon++; _save(); notifyListeners(); }
  void resetStats() { _highScore = 0; _gamesPlayed = 0; _gamesWon = 0; _save(); notifyListeners(); }
}
