import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0D1B2A), Color(0xFF1B4332), Color(0xFF0D1B2A)]),
        ),
        child: SafeArea(
          child: Consumer<GameProvider>(
            builder: (context, game, _) {
              return Stack(
                children: [
                  Column(children: [
                    const GameHUD(),
                    Expanded(child: game.gameState == GameState.paused ? _pauseOverlay(game) : const MahjongBoard()),
                    _bottomBar(game),
                  ]),
                  if (game.message != null) _msgOverlay(game.message!),
                  if (game.gameState == GameState.won) _winOverlay(game),
                  if (game.gameState == GameState.noMoves) _noMovesOverlay(game),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _bottomBar(GameProvider g) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.3), border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1)))),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      _actBtn(Icons.lightbulb_outline, 'Hint(${g.hintsRemaining})', Colors.amber, g.hintsRemaining > 0 ? () => g.useHint() : null),
      _actBtn(Icons.shuffle, 'Shuffle(${g.shufflesRemaining})', Colors.blue, g.shufflesRemaining > 0 ? () => g.shuffleTiles() : null),
      _actBtn(Icons.undo, 'Undo', Colors.orange, () => g.undo()),
      _actBtn(Icons.refresh, 'Restart', Colors.red, () => g.startGame(layoutIndex: widget.layoutIndex)),
    ]),
  );

  Widget _actBtn(IconData ic, String lb, Color c, VoidCallback? onTap) => GestureDetector(
    onTap: onTap,
    child: Opacity(opacity: onTap != null ? 1.0 : 0.4, child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: c.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12), border: Border.all(color: c.withValues(alpha: 0.4))), child: Icon(ic, color: c, size: 24)),
      const SizedBox(height: 4),
      Text(lb, style: TextStyle(color: c.withValues(alpha: 0.8), fontSize: 10, fontWeight: FontWeight.w600)),
    ])),
  );

  Widget _pauseOverlay(GameProvider g) => Center(
    child: Container(
      padding: const EdgeInsets.all(40), margin: const EdgeInsets.all(40),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.85), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white24)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.pause_circle, color: Colors.white, size: 64),
        const SizedBox(height: 20),
        const Text('PAUSED', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 6)),
        const SizedBox(height: 30),
        ElevatedButton.icon(onPressed: () => g.togglePause(), icon: const Icon(Icons.play_arrow), label: const Text('RESUME'), style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))),
        const SizedBox(height: 16),
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('QUIT', style: TextStyle(color: Colors.red))),
      ]),
    ),
  ).animate().fadeIn(duration: 300.ms);

  Widget _msgOverlay(String msg) => Positioned(
    bottom: 120, left: 0, right: 0,
    child: Center(child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.amber.withValues(alpha: 0.5))),
      child: Text(msg, style: const TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.w600)),
    )).animate().fadeIn(duration: 200.ms).slideY(begin: 0.3),
  );

  Widget _winOverlay(GameProvider g) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsProvider>().updateHighScore(g.score);
      context.read<SettingsProvider>().recordGame(won: true);
    });
    return Positioned.fill(child: Container(
      color: Colors.black.withValues(alpha: 0.8),
      child: Center(child: Container(
        margin: const EdgeInsets.all(32), padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)]), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.amber, width: 2), boxShadow: [BoxShadow(color: Colors.amber.withValues(alpha: 0.3), blurRadius: 30, spreadRadius: 5)]),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('🎉', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          const Text('YOU WON!', style: TextStyle(color: Colors.amber, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 3)),
          const SizedBox(height: 24),
          _stat('Score', '${g.score}'), _stat('Time', g.formattedTime), _stat('Moves', '${g.moves}'), _stat('Max Combo', '${g.maxCombo}x'),
          const SizedBox(height: 24),
          Row(mainAxisSize: MainAxisSize.min, children: [
            ElevatedButton.icon(onPressed: () => g.startGame(layoutIndex: widget.layoutIndex), icon: const Icon(Icons.replay), label: const Text('AGAIN'), style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))),
            const SizedBox(width: 16),
            OutlinedButton.icon(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.home, color: Colors.white), label: const Text('HOME', style: TextStyle(color: Colors.white)), style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white54), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))),
          ]),
        ]),
      )),
    )).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.8, 0.8));
  }

  Widget _noMovesOverlay(GameProvider g) => Positioned.fill(child: Container(
    color: Colors.black.withValues(alpha: 0.7),
    child: Center(child: Container(
      margin: const EdgeInsets.all(32), padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: const Color(0xFF1B2838), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.orange, width: 2)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 64),
        const SizedBox(height: 16),
        const Text('NO MOVES LEFT', style: TextStyle(color: Colors.orange, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        if (g.shufflesRemaining > 0) ElevatedButton.icon(onPressed: () => g.shuffleTiles(), icon: const Icon(Icons.shuffle), label: Text('SHUFFLE (${g.shufflesRemaining})'), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))),
        const SizedBox(height: 12),
        OutlinedButton.icon(onPressed: () => g.startGame(layoutIndex: widget.layoutIndex), icon: const Icon(Icons.replay, color: Colors.white), label: const Text('RESTART', style: TextStyle(color: Colors.white)), style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white54), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))),
      ]),
    )),
  )).animate().fadeIn(duration: 400.ms);

  Widget _stat(String l, String v) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(mainAxisSize: MainAxisSize.min, children: [SizedBox(width: 120, child: Text(l, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 16))), Text(v, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))]));
}
