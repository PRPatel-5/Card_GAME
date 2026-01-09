import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../game/vita_game.dart';
import '../utils/constants.dart';
import 'game_complete_dialog.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late VitaGame game;
  int score = 0;
  int moves = 0;
  int combo = 0;
  bool showCombo = false;

  @override
  void initState() {
    super.initState();
    game = VitaGame()
      ..onGameUpdate = _onGameUpdate
      ..onGameComplete = _onGameComplete;
  }

  void _onGameUpdate(int newScore, int newMoves, int newCombo) {
    setState(() {
      score = newScore;
      moves = newMoves;
      
      // Show combo animation if combo changed
      if (newCombo > combo && newCombo > 1) {
        showCombo = true;
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) setState(() => showCombo = false);
        });
      }
      combo = newCombo;
    });
  }

  void _onGameComplete(int finalScore, int finalMoves, int stars) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => GameCompleteDialog(
        score: finalScore,
        moves: finalMoves,
        stars: stars,
        onRestart: () {
          Navigator.pop(context);
          game.resetGame();
          setState(() {
            score = 0;
            moves = 0;
            combo = 0;
          });
        },
        onMenu: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [GameColors.primaryDark, GameColors.primaryLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Game Canvas
              GameWidget(game: game),
              
              // Top UI Bar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _buildTopBar(),
              ),
              
              // Combo Notification
              if (showCombo && combo > 1)
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: _buildComboNotification(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            GameColors.primaryDark.withOpacity(0.95),
            GameColors.primaryLight.withOpacity(0.85),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              
              // Score
              Column(
                children: [
                  Text(
                    'SCORE',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    '$score',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: GameColors.accentGold,
                      shadows: [
                        Shadow(
                          color: GameColors.accentGold,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ).animate(key: ValueKey(score))
                    .scale(duration: 200.ms, begin: const Offset(1.2, 1.2)),
                ],
              ),
              
              // Moves
              Column(
                children: [
                  Text(
                    'MOVES',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    '$moves',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              
              // Menu Button
              IconButton(
                icon: const Icon(Icons.menu_rounded, color: Colors.white),
                onPressed: () {
                  // Show pause menu
                  _showPauseMenu();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComboNotification() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [GameColors.matchedStart, GameColors.matchedEnd],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: GameColors.matchedStart.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.bolt_rounded, color: Colors.white, size: 28),
            const SizedBox(width: 8),
            Text(
              'COMBO x$combo',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.bolt_rounded, color: Colors.white, size: 28),
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 200.ms)
          .scale(begin: const Offset(0.8, 0.8))
          .shake(hz: 2, curve: Curves.easeInOut),
    );
  }

  void _showPauseMenu() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [GameColors.primaryDark, GameColors.primaryLight],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'PAUSED',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 30),
              _PauseButton(
                label: 'Resume',
                icon: Icons.play_arrow_rounded,
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 12),
              _PauseButton(
                label: 'Restart',
                icon: Icons.refresh_rounded,
                onTap: () {
                  Navigator.pop(context);
                  game.resetGame();
                  setState(() {
                    score = 0;
                    moves = 0;
                    combo = 0;
                  });
                },
              ),
              const SizedBox(height: 12),
              _PauseButton(
                label: 'Main Menu',
                icon: Icons.home_rounded,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PauseButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _PauseButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 22),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
