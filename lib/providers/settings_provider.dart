import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _soundEnabled = true, _musicEnabled = true, _animationsEnabled = true;
  int _highScore = 0, _gamesPlayed = 0, _gamesWon = 0;
  String _theme = 'classic';

  bool get soundEnabled => _soundEnabled;
  bool get musicEnabled => _musicEnabled;
  bool get animationsEnabled => _animationsEnabled;
  int get highScore => _highScore;
  int get gamesPlayed => _gamesPlayed;
  int get gamesWon => _gamesWon;
  String get theme => _theme;

  SettingsProvider() { _loadSettings(); }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _soundEnabled = prefs.getBool('soundEnabled') ?? true;
    _musicEnabled = prefs.getBool('musicEnabled') ?? true;
    _animationsEnabled = prefs.getBool('animationsEnabled') ?? true;
    _highScore = prefs.getInt('highScore') ?? 0;
    _gamesPlayed = prefs.getInt('gamesPlayed') ?? 0;
    _gamesWon = prefs.getInt('gamesWon') ?? 0;
    _theme = prefs.getString('theme') ?? 'classic';
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundEnabled', _soundEnabled);
    await prefs.setBool('musicEnabled', _musicEnabled);
    await prefs.setBool('animationsEnabled', _animationsEnabled);
    await prefs.setInt('highScore', _highScore);
    await prefs.setInt('gamesPlayed', _gamesPlayed);
    await prefs.setInt('gamesWon', _gamesWon);
    await prefs.setString('theme', _theme);
  }

  void toggleSound() { _soundEnabled = !_soundEnabled; _saveSettings(); notifyListeners(); }
  void toggleMusic() { _musicEnabled = !_musicEnabled; _saveSettings(); notifyListeners(); }
  void toggleAnimations() { _animationsEnabled = !_animationsEnabled; _saveSettings(); notifyListeners(); }
  void setTheme(String theme) { _theme = theme; _saveSettings(); notifyListeners(); }
  void updateHighScore(int score) { if (score > _highScore) { _highScore = score; _saveSettings(); notifyListeners(); } }
  void recordGamePlayed({bool won = false}) { _gamesPlayed++; if (won) _gamesWon++; _saveSettings(); notifyListeners(); }
  void resetStats() { _highScore = 0; _gamesPlayed = 0; _gamesWon = 0; _saveSettings(); notifyListeners(); }
}
