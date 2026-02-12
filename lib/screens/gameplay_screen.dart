import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../utils/vita_theme.dart';
import '../models/game_level.dart';
import '../services/game_state_service.dart';
import '../widgets/game_card_widget.dart';
import '../widgets/power_up_button.dart';
import '../models/power_up.dart';

class GameplayScreen extends StatefulWidget {
  final GameLevel level;

  const GameplayScreen({super.key, required this.level});

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VitaGameState>().startLevel(widget.level);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [VitaTheme.primaryDark, VitaTheme.primaryLight],
          ),
        ),
        child: SafeArea(
          child: Consumer<VitaGameState>(
            builder: (context, gameState, child) {
              if (gameState.gameState == GameState.completed) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _showCompletionDialog(context, gameState);
                });
              }
              
              return Column(
                children: [
                  _buildTopBar(gameState),
                  Expanded(
                    child: _buildCardGrid(gameState),
                  ),
                  _buildBottomBar(gameState),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(VitaGameState gameState) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: VitaTheme.textLight),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Level ${widget.level.levelNumber}',
                  style: GoogleFonts.notoSerifJp(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: VitaTheme.textLight,
                  ),
                ),
                Text(
                  widget.level.difficultyName,
                  style: GoogleFonts.notoSansJp(
                    fontSize: 12,
                    color: VitaTheme.textLight.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '⏱️ ${_formatTime(gameState.timeRemaining)}',
                style: GoogleFonts.notoSansJp(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _getTimeColor(gameState.timeRemaining),
                ),
              ),
              Text(
                '⭐ ${gameState.score}',
                style: GoogleFonts.notoSansJp(
                  fontSize: 14,
                  color: VitaTheme.accentGold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardGrid(VitaGameState gameState) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.level.gridCols,
          childAspectRatio: VitaConstants.cardAspectRatio,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: gameState.cards.length,
        itemBuilder: (context, index) {
          final card = gameState.cards[index];
          return GameCardWidget(
            card: card,
            onTap: () => gameState.selectCard(card.id),
          );
        },
      ),
    );
  }

  Widget _buildBottomBar(VitaGameState gameState) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PowerUpButton(
            powerUp: PowerUpDatabase.getPowerUp(PowerUpType.hint)!,
            count: gameState.hintsRemaining,
            onPressed: () => gameState.useHint(),
          ),
          PowerUpButton(
            powerUp: PowerUpDatabase.getPowerUp(PowerUpType.shuffle)!,
            count: gameState.shufflesRemaining,
            onPressed: () => gameState.useShuffle(),
          ),
          if (widget.level.levelNumber >= 15)
            PowerUpButton(
              powerUp: PowerUpDatabase.getPowerUp(PowerUpType.timeFreeze)!,
              count: 3,
              onPressed: () => gameState.useTimeFreeze(),
            ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Color _getTimeColor(int seconds) {
    if (seconds > 60) return VitaTheme.successGreen;
    if (seconds > 30) return Colors.orange;
    return VitaTheme.errorRed;
  }

  void _showCompletionDialog(BuildContext context, VitaGameState gameState) {
    final progress = gameState.getLevelProgress();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: VitaTheme.primaryLight,
        title: Text(
          'Level Complete!',
          style: GoogleFonts.notoSerifJp(
            color: VitaTheme.accentGold,
            fontSize: 24,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Icon(
                  index < progress.stars ? Icons.star : Icons.star_border,
                  color: VitaTheme.accentGold,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Score: ${progress.score}',
              style: GoogleFonts.notoSansJp(
                color: VitaTheme.textLight,
                fontSize: 18,
              ),
            ),
            Text(
              'Matches: ${progress.matchesCount}',
              style: GoogleFonts.notoSansJp(
                color: VitaTheme.textLight,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'Continue',
              style: GoogleFonts.notoSansJp(
                color: VitaTheme.textLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
