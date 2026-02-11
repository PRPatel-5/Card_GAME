import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF0D1B2A), Color(0xFF1B2838), Color(0xFF1B4332)])),
        child: SafeArea(
          child: Consumer<SettingsProvider>(
            builder: (context, settings, child) {
              return Column(
                children: [
                  Padding(padding: const EdgeInsets.all(16), child: Row(children: [IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios, color: Colors.white)), const Expanded(child: Text('SETTINGS', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))), const SizedBox(width: 48)])),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        _buildSection('Audio', [_buildToggle('Sound Effects', Icons.volume_up, settings.soundEnabled, () => settings.toggleSound()), _buildToggle('Background Music', Icons.music_note, settings.musicEnabled, () => settings.toggleMusic())]),
                        const SizedBox(height: 24),
                        _buildSection('Statistics', [_buildStat('High Score', '${settings.highScore}'), _buildStat('Games Played', '${settings.gamesPlayed}'), _buildStat('Games Won', '${settings.gamesWon}'), _buildStat('Win Rate', settings.gamesPlayed > 0 ? '${((settings.gamesWon / settings.gamesPlayed) * 100).toStringAsFixed(1)}%' : 'N/A')]),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title.toUpperCase(), style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14, fontWeight: FontWeight.w600)), const SizedBox(height: 12), Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16)), child: Column(children: children))]);
  }

  Widget _buildToggle(String title, IconData icon, bool value, VoidCallback onToggle) {
    return ListTile(leading: Icon(icon, color: Colors.white70), title: Text(title, style: const TextStyle(color: Colors.white)), trailing: Switch(value: value, onChanged: (_) => onToggle(), activeColor: Colors.green));
  }

  Widget _buildStat(String label, String value) {
    return ListTile(title: Text(label, style: const TextStyle(color: Colors.white70)), trailing: Text(value, style: const TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)));
  }
}