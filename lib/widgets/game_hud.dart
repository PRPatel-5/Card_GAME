import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class GameHUD extends StatelessWidget {
  const GameHUD({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (ctx, g, _) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.3), border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1)))),
      child: Row(children: [
        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20)),
        _item(Icons.star, 'Score', '${g.score}', Colors.amber),
        const Spacer(),
        _item(Icons.timer, 'Time', g.formattedTime, Colors.cyan),
        const Spacer(),
        _item(Icons.grid_view, 'Tiles', '${g.tilesRemaining}', Colors.green),
        const Spacer(),
        if (g.combo > 1) Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.orange)),
          child: Text('${g.combo}x', style: const TextStyle(color: Colors.orange, fontSize: 14, fontWeight: FontWeight.bold)),
        ),
        IconButton(onPressed: () => g.togglePause(), icon: Icon(g.gameState == GameState.paused ? Icons.play_arrow : Icons.pause, color: Colors.white, size: 24)),
      ]),
    ));
  }

  Widget _item(IconData ic, String lb, String val, Color c) => Column(mainAxisSize: MainAxisSize.min, children: [
    Row(mainAxisSize: MainAxisSize.min, children: [Icon(ic, color: c, size: 16), const SizedBox(width: 4), Text(val, style: TextStyle(color: c, fontSize: 18, fontWeight: FontWeight.bold))]),
    Text(lb, style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 10)),
  ]);
}
