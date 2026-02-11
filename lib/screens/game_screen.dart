import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/mahjong_board.dart';
import '../widgets/game_hud.dart';

class GameScreen extends StatefulWidget {
  final int layoutIndex;
  const GameScreen({super.key, required this.layoutIndex});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().startGame(layoutIndex: widget.layoutIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0D1B2A), Color(0xFF1B4332), Color(0xFF0D1B2A)])),
        child: SafeArea(
          child: Consumer<GameProvider>(
            builder: (context, game, child) {
              return Column(
                children: [
                  const GameHUD(),
                  Expanded(child: game.gameState == GameState.paused ? _buildPauseOverlay(game) : const MahjongBoard()),
                  _buildBottomBar(game),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(GameProvider game) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBtn(Icons.lightbulb_outline, 'Hint (${game.hintsRemaining})', Colors.amber, game.hintsRemaining > 0 ? () => game.useHint() : null),
          _buildBtn(Icons.shuffle, 'Shuffle (${game.shufflesRemaining})', Colors.blue, game.shufflesRemaining > 0 ? () => game.shuffleTiles() : null),
          _buildBtn(Icons.undo, 'Undo', Colors.orange, () => game.undo()),
          _buildBtn(Icons.refresh, 'Restart', Colors.red, () => game.startGame(layoutIndex: widget.layoutIndex)),
        ],
      ),
    );
  }

  Widget _buildBtn(IconData icon, String label, Color color, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: onTap != null ? 1.0 : 0.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.4))), child: Icon(icon, color: color, size: 24)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildPauseOverlay(GameProvider game) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(40),
        margin: const EdgeInsets.all(40),
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.85), borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.pause_circle, color: Colors.white, size: 64),
            const SizedBox(height: 20),
            const Text('PAUSED', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ElevatedButton.icon(onPressed: () => game.togglePause(), icon: const Icon(Icons.play_arrow), label: const Text('RESUME'), style: ElevatedButton.styleFrom(backgroundColor: Colors.green)),
          ],
        ),
      ),
    );
  }
}