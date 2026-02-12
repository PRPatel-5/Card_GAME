import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import 'game_screen.dart';
import 'level_select_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [Color(0xFF0D1B2A), Color(0xFF1B2838), Color(0xFF1B4332)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                ShaderMask(
                  shaderCallback: (b) => const LinearGradient(colors: [Color(0xFFFFD700), Color(0xFFFFA000), Color(0xFFFFD700)]).createShader(b),
                  child: const Text('麻雀', style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.white)),
                ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.3),
                const SizedBox(height: 8),
                Text('VITA MAHJONG', style: TextStyle(fontSize: 18, color: Colors.white.withValues(alpha: 0.6), letterSpacing: 8, fontWeight: FontWeight.w300)).animate().fadeIn(delay: 300.ms),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _miniTile('東', const Color(0xFFC62828)),
                    const SizedBox(width: 8),
                    _miniTile('南', const Color(0xFF2E7D32)),
                    const SizedBox(width: 8),
                    _miniTile('西', const Color(0xFF1565C0)),
                    const SizedBox(width: 8),
                    _miniTile('北', const Color(0xFF6A1B9A)),
                  ],
                ).animate().fadeIn(delay: 500.ms).scale(begin: const Offset(0.8, 0.8)),
                const Spacer(),
                _menuBtn(context, Icons.play_arrow_rounded, 'PLAY', const Color(0xFF4CAF50), () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const GameScreen(layoutIndex: 0)));
                }).animate().fadeIn(delay: 700.ms).slideX(begin: -0.3),
                const SizedBox(height: 16),
                _menuBtn(context, Icons.grid_view_rounded, 'LEVELS', const Color(0xFF2196F3), () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const LevelSelectScreen()));
                }).animate().fadeIn(delay: 800.ms).slideX(begin: -0.3),
                const SizedBox(height: 16),
                _menuBtn(context, Icons.settings_rounded, 'SETTINGS', const Color(0xFF9C27B0), () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
                }).animate().fadeIn(delay: 900.ms).slideX(begin: -0.3),
                const Spacer(flex: 2),
                Consumer<SettingsProvider>(
                  builder: (_, s, __) => Text('High Score: ${s.highScore}', style: TextStyle(color: Colors.amber.withValues(alpha: 0.8), fontSize: 16, fontWeight: FontWeight.w600)),
                ).animate().fadeIn(delay: 1000.ms),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _miniTile(String s, Color c) => Container(
    width: 50, height: 65,
    decoration: BoxDecoration(
      color: const Color(0xFFF5F0E1), borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFD4C5A0), width: 2),
      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.4), offset: const Offset(2, 3), blurRadius: 5)],
    ),
    child: Center(child: Text(s, style: TextStyle(fontSize: 28, color: c, fontWeight: FontWeight.bold))),
  );

  Widget _menuBtn(BuildContext ctx, IconData icon, String label, Color color, VoidCallback onTap) => SizedBox(
    width: 260, height: 56,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.2), foregroundColor: Colors.white,
        side: BorderSide(color: color.withValues(alpha: 0.5), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: color),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 3, color: color)),
        ],
      ),
    ),
  );
}
