import 'package:flutter/material.dart';
import '../models/game_layout.dart';
import 'game_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<GameLayout> layouts = LayoutGenerator.allLayouts();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF0D1B2A), Color(0xFF1B2838), Color(0xFF1B4332)])),
        child: SafeArea(
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.all(16), child: Row(children: [IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios, color: Colors.white)), const Expanded(child: Text('SELECT LAYOUT', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))), const SizedBox(width: 48)])),
              Expanded(child: ListView.builder(padding: const EdgeInsets.all(20), itemCount: layouts.length, itemBuilder: (context, index) => _buildCard(context, layouts[index], index))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, GameLayout layout, int index) {
    List<Color> colors = [Color(0xFF4CAF50), Color(0xFF2196F3), Color(0xFFFF9800), Color(0xFF9C27B0)];
    Color color = colors[index % colors.length];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => GameScreen(layoutIndex: index))),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [color.withOpacity(0.15), color.withOpacity(0.05)]), borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withOpacity(0.3), width: 1.5)),
          child: Row(
            children: [
              Container(width: 70, height: 70, decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(16)), child: Center(child: Icon(Icons.grid_4x4, color: color, size: 40))),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(layout.name, style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(layout.description, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14)), const SizedBox(height: 8), Text('${layout.totalTiles} tiles', style: const TextStyle(color: Colors.white54, fontSize: 12))])),
              Icon(Icons.chevron_right, color: color, size: 32),
            ],
          ),
        ),
      ),
    );
  }
}