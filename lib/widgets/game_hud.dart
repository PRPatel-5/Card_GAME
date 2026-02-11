import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class GameHUD extends StatelessWidget {
  const GameHUD({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
          child: Row(
            children: [
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20)),
              _buildItem(Icons.star, 'Score', '${game.score}', Colors.amber),
              const Spacer(),
              _buildItem(Icons.timer, 'Time', game.formattedTime, Colors.cyan),
              const Spacer(),
              _buildItem(Icons.grid_view, 'Tiles', '${game.tilesRemaining}', Colors.green),
              const Spacer(),
              if (game.combo > 1) Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.orange.withOpacity(0.3), borderRadius: BorderRadius.circular(20)), child: Text('${game.combo}x COMBO!', style: const TextStyle(color: Colors.orange, fontSize: 14, fontWeight: FontWeight.bold))),
              IconButton(onPressed: () => game.togglePause(), icon: Icon(game.gameState == GameState.paused ? Icons.play_arrow : Icons.pause, color: Colors.white, size: 24)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItem(IconData icon, String label, String value, Color color) {
    return Column(mainAxisSize: MainAxisSize.min, children: [Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: color, size: 16), const SizedBox(width: 4), Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold))]), Text(label, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 10))]);
  }
}