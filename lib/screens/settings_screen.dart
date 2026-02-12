import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0D1B2A), Color(0xFF1B2838), Color(0xFF1B4332)])),
      child: SafeArea(child: Consumer<SettingsProvider>(builder: (ctx, s, _) => Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: Row(children: [
          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          const Expanded(child: Text('SETTINGS', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 4))),
          const SizedBox(width: 48),
        ])),
        Expanded(child: ListView(padding: const EdgeInsets.all(20), children: [
          _section('Audio', [
            _toggle('Sound Effects', Icons.volume_up, s.soundEnabled, s.toggleSound),
            _toggle('Music', Icons.music_note, s.musicEnabled, s.toggleMusic),
          ]),
          const SizedBox(height: 24),
          _section('Visual', [_toggle('Animations', Icons.animation, s.animationsEnabled, s.toggleAnimations)]),
          const SizedBox(height: 24),
          _section('Statistics', [
            _statItem('High Score', '${s.highScore}'),
            _statItem('Games Played', '${s.gamesPlayed}'),
            _statItem('Games Won', '${s.gamesWon}'),
            _statItem('Win Rate', s.gamesPlayed > 0 ? '${((s.gamesWon / s.gamesPlayed) * 100).toStringAsFixed(1)}%' : 'N/A'),
          ]),
          const SizedBox(height: 24),
          Center(child: TextButton.icon(
            onPressed: () => showDialog(context: context, builder: (c) => AlertDialog(
              backgroundColor: const Color(0xFF1B2838),
              title: const Text('Reset?', style: TextStyle(color: Colors.white)),
              content: const Text('Reset all stats?', style: TextStyle(color: Colors.white70)),
              actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')), ElevatedButton(onPressed: () { s.resetStats(); Navigator.pop(c); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text('Reset'))],
            )),
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            label: const Text('Reset Statistics', style: TextStyle(color: Colors.red)),
          )),
        ])),
      ]))),
    ));
  }

  static Widget _section(String title, List<Widget> children) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title.toUpperCase(), style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 2)),
    const SizedBox(height: 12),
    Container(decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withValues(alpha: 0.1))), child: Column(children: children)),
  ]);

  static Widget _toggle(String t, IconData ic, bool v, VoidCallback onTap) => ListTile(leading: Icon(ic, color: Colors.white70), title: Text(t, style: const TextStyle(color: Colors.white)), trailing: Switch(value: v, onChanged: (_) => onTap(), activeColor: Colors.green));
  static Widget _statItem(String l, String v) => ListTile(title: Text(l, style: const TextStyle(color: Colors.white70)), trailing: Text(v, style: const TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)));
}
