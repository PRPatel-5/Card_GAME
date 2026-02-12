import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/player_progress.dart';

class StorageService {
  static const String _progressKey = 'player_progress';
  static const String _settingsKey = 'game_settings';

  Future<void> saveProgress(PlayerProgress progress) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(progress.toJson());
    await prefs.setString(_progressKey, jsonString);
  }

  Future<PlayerProgress> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_progressKey);
    
    if (jsonString == null) {
      return PlayerProgress();
    }
    
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return PlayerProgress.fromJson(json);
  }

  Future<void> saveSettings(Map<String, dynamic> settings) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(settings);
    await prefs.setString(_settingsKey, jsonString);
  }

  Future<Map<String, dynamic>> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_settingsKey);
    
    if (jsonString == null) {
      return {
        'soundEnabled': true,
        'musicEnabled': true,
        'vibrationEnabled': true,
        'cardFlipSpeed': 'medium',
      };
    }
    
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
