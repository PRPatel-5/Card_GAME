import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/game_layout.dart';
import 'game_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<GameLayout> layouts = LayoutGenerator.allLayouts();
    List<Color> colors = [const Color(0xFF4CAF50), const Color(0xFF2196F3), const Color(0xFFFF9800), const Color(0xFF9C27B0), const Color(0xFFE91E63)];

    return Scaffold(body: Container(
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0D1B2A), Color(0xFF1B2838), Color(0xFF1B4332)])),
      child: SafeArea(child: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: Row(children: [
          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          const Expanded(child: Text('SELECT LAYOUT', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 4))),
          const SizedBox(width: 48),
        ])),
        Expanded(child: ListView.builder(
          padding: const EdgeInsets.all(20), itemCount: layouts.length,
          itemBuilder: (ctx, i) {
            Color c = colors[i % colors.length];
            GameLayout l = layouts[i];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: () => Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (_) => GameScreen(layoutIndex: i))),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [c.withValues(alpha: 0.15), c.withValues(alpha: 0.05)]), borderRadius: BorderRadius.circular(20), border: Border.all(color: c.withValues(alpha: 0.3), width: 1.5)),
                  child: Row(children: [
                    Container(width: 70, height: 70, decoration: BoxDecoration(color: c.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(16), border: Border.all(color: c.withValues(alpha: 0.4))), child: Center(child: Text('${i + 1}', style: TextStyle(fontSize: 28, color: c, fontWeight: FontWeight.bold)))),
                    const SizedBox(width: 16),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(l.name, style: TextStyle(color: c, fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(l.description, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 14)),
                      const SizedBox(height: 8),
                      Row(children: [
                        const Icon(Icons.grid_4x4, color: Colors.white54, size: 16), const SizedBox(width: 4),
                        Text('${l.totalTiles} tiles', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                        const SizedBox(width: 16),
                        ...List.generate(3, (s) => Icon(s <= l.difficulty ? Icons.star : Icons.star_border, color: Colors.amber, size: 16)),
                      ]),
                    ])),
                    Icon(Icons.chevron_right, color: c, size: 32),
                  ]),
                ),
              ),
            ).animate().fadeIn(delay: (i * 150).ms).slideX(begin: 0.3);
          },
        )),
      ])),
    ));
  }
}
