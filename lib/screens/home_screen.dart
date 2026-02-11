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
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0D1B2A), Color(0xFF1B2838), Color(0xFF1B4332)])),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                ShaderMask(shaderCallback: (bounds) => const LinearGradient(colors: [Color(0xFFFFD700), Color(0xFFFFA000), Color(0xFFFFD700)]).createShader(bounds), child: const Text('麻雀', style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.white))).animate().fadeIn(duration: 800.ms).slideY(begin: -0.3, end: 0),
                const SizedBox(height: 10),
                Text('CARD GAME', style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.6), letterSpacing: 8, fontWeight: FontWeight.w300)).animate().fadeIn(delay: 300.ms, duration: 800.ms),
                const Spacer(flex: 2),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _buildMiniTile('東', const Color(0xFFC62828)), const SizedBox(width: 8),
                  _buildMiniTile('南', const Color(0xFF2E7D32)), const SizedBox(width: 8),
                  _buildMiniTile('西', const Color(0xFF1565C0)), const SizedBox(width: 8),
                  _buildMiniTile('北', const Color(0xFF6A1B9A)),
                ]).animate().fadeIn(delay: 500.ms, duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
                const Spacer(),
                _buildMenuButton(context, icon: Icons.play_arrow_rounded, label: 'PLAY', color: const Color(0xFF4CAF50), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GameScreen(layoutIndex: 0)))).animate().fadeIn(delay: 700.ms).slideX(begin: -0.3),
                const SizedBox(height: 16),
                _buildMenuButton(context, icon: Icons.grid_view_rounded, label: 'LEVELS', color: const Color(0xFF2196F3), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LevelSelectScreen()))).animate().fadeIn(delay: 800.ms).slideX(begin: -0.3),
                const SizedBox(height: 16),
                _buildMenuButton(context, icon: Icons.settings_rounded, label: 'SETTINGS', color: const Color(0xFF9C27B0), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))).animate().fadeIn(delay: 900.ms).slideX(begin: -0.3),
                const Spacer(flex: 2),
                Consumer<SettingsProvider>(builder: (context, settings, child) => Text('High Score: ${settings.highScore}', style: TextStyle(color: Colors.amber.withOpacity(0.8), fontSize: 16, fontWeight: FontWeight.w600))).animate().fadeIn(delay: 1000.ms),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMiniTile(String symbol, Color color) {
    return Container(width: 50, height: 65, decoration: BoxDecoration(color: const Color(0xFFF5F0E1), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFD4C5A0), width: 2), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), offset: const Offset(2, 3), blurRadius: 5)]), child: Center(child: Text(symbol, style: TextStyle(fontSize: 28, color: color, fontWeight: FontWeight.bold))));
  }

  Widget _buildMenuButton(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return SizedBox(width: 260, height: 56, child: ElevatedButton(onPressed: onTap, style: ElevatedButton.styleFrom(backgroundColor: color.withOpacity(0.2), foregroundColor: Colors.white, side: BorderSide(color: color.withOpacity(0.5), width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 28, color: color), const SizedBox(width: 12), Text(label, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 3, color: color))])));
  }
}
