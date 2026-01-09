import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/constants.dart';

class GameCompleteDialog extends StatelessWidget {
  final int score;
  final int moves;
  final int stars;
  final VoidCallback onRestart;
  final VoidCallback onMenu;

  const GameCompleteDialog({
    super.key,
    required this.score,
    required this.moves,
    required this.stars,
    required this.onRestart,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [GameColors.primaryDark, GameColors.primaryLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 30,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Trophy Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [GameColors.accentGold, Color(0xFFF59E0B)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: GameColors.accentGold.withOpacity(0.5),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                size: 48,
                color: Colors.white,
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .scale(
                  duration: 2000.ms,
                  begin: const Offset(1.0, 1.0),
                  end: const Offset(1.1, 1.1),
                  curve: Curves.easeInOut,
                )
                .then()
                .scale(
                  duration: 2000.ms,
                  begin: const Offset(1.1, 1.1),
                  end: const Offset(1.0, 1.0),
                  curve: Curves.easeInOut,
                ),

            const SizedBox(height: 24),

            // Title
            Text(
              'VICTORY!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [GameColors.accentGold, Colors.white],
                  ).createShader(const Rect.fromLTWH(0, 0, 200, 50)),
                letterSpacing: 3,
              ),
            ).animate().fadeIn(delay: 200.ms).scale(),

            const SizedBox(height: 8),

            // Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final isActive = index < stars;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    isActive ? Icons.star_rounded : Icons.star_outline_rounded,
                    size: 40,
                    color: isActive ? GameColors.accentGold : Colors.grey,
                  ),
                )
                    .animate(delay: (300 + index * 150).ms)
                    .fadeIn()
                    .scale(begin: const Offset(0.5, 0.5));
              }),
            ),

            const SizedBox(height: 24),

            // Stats
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _StatRow(
                    label: 'FINAL SCORE',
                    value: '$score',
                    valueColor: GameColors.accentGold,
                  ),
                  const SizedBox(height: 12),
                  _StatRow(
                    label: 'TOTAL MOVES',
                    value: '$moves',
                    valueColor: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  _StatRow(
                    label: 'RATING',
                    value: _getRating(),
                    valueColor: GameColors.matchedStart,
                  ),
                ],
              ),
            ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.3),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: _DialogButton(
                    label: 'MENU',
                    icon: Icons.home_rounded,
                    isPrimary: false,
                    onTap: onMenu,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DialogButton(
                    label: 'PLAY AGAIN',
                    icon: Icons.refresh_rounded,
                    isPrimary: true,
                    onTap: onRestart,
                  ),
                ),
              ],
            ).animate(delay: 800.ms).fadeIn().slideY(begin: 0.3),
          ],
        ),
      ),
    );
  }

  String _getRating() {
    if (stars == 3) return 'PERFECT!';
    if (stars == 2) return 'GREAT!';
    if (stars == 1) return 'GOOD!';
    return 'TRY AGAIN!';
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _StatRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: valueColor,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _DialogButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _DialogButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_DialogButton> createState() => _DialogButtonState();
}

class _DialogButtonState extends State<_DialogButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: widget.isPrimary
                ? const LinearGradient(
                    colors: [
                      GameColors.buttonGradientStart,
                      GameColors.buttonGradientEnd,
                    ],
                  )
                : null,
            color: widget.isPrimary ? null : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: widget.isPrimary
                ? [
                    BoxShadow(
                      color: GameColors.buttonGradientEnd.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
