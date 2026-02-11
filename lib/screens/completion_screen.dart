import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/garden_state.dart';
import '../utils/constants.dart';

/// Completion Screen - Gentle celebration, no pressure
class CompletionScreen extends StatelessWidget {
  final String message;
  final GardenState gardenState;
  final VoidCallback onRestart;
  final VoidCallback onHome;

  const CompletionScreen({
    super.key,
    required this.message,
    required this.gardenState,
    required this.onRestart,
    required this.onHome,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              gardenState.timeOfDay.skyColor,
              gardenState.timeOfDay.skyColor.withOpacity(0.6),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                
                // Completed garden emoji
                Text(
                  _getCompletionEmoji(),
                  style: const TextStyle(fontSize: 80),
                ).animate()
                  .fadeIn(duration: 1200.ms)
                  .scale(begin: Offset(0.5, 0.5), curve: GardenCurves.grow),
                
                const SizedBox(height: 32),
                
                // Completion message (gentle)
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                    color: GardenColors.textPrimary,
                    height: 1.4,
                    letterSpacing: 2,
                  ),
                ).animate()
                  .fadeIn(delay: 400.ms, duration: 1000.ms),
                
                const SizedBox(height: 48),
                
                // Garden stats (soft presentation)
                _buildGardenStats(),
                
                const Spacer(),
                
                // Gentle action buttons
                Column(
                  children: [
                    _CalmActionButton(
                      label: 'Grow Another',
                      icon: Icons.spa_outlined,
                      onTap: onRestart,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _CalmActionButton(
                      label: 'Rest',
                      icon: Icons.home_outlined,
                      onTap: onHome,
                      isPrimary: false,
                    ),
                  ],
                ).animate()
                  .fadeIn(delay: 1200.ms, duration: 800.ms),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getCompletionEmoji() {
    final accuracy = gardenState.accuracy;
    
    if (accuracy >= 0.95) {
      return '🌺'; // Perfect - Hibiscus
    } else if (accuracy >= 0.85) {
      return '🌸'; // Great - Blossom
    } else if (accuracy >= 0.70) {
      return '🌿'; // Good - Herb
    } else {
      return '🌱'; // Growing - Seedling
    }
  }

  Widget _buildGardenStats() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: GardenColors.cardBorder.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _StatRow(
            label: 'Plants Grown',
            value: '${gardenState.plants.length}',
            emoji: '🌿',
          ),
          
          const SizedBox(height: 16),
          
          _StatRow(
            label: 'Best Streak',
            value: '${gardenState.bestStreak}',
            emoji: '🔥',
          ),
          
          const SizedBox(height: 16),
          
          _StatRow(
            label: 'Garden Health',
            value: '${(gardenState.accuracy * 100).toStringAsFixed(0)}%',
            emoji: gardenState.isThriving ? '✨' : '🌱',
          ),
        ],
      ),
    ).animate()
      .fadeIn(delay: 800.ms, duration: 800.ms)
      .slideY(begin: 0.1, end: 0);
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final String emoji;

  const _StatRow({
    required this.label,
    required this.value,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: GardenColors.textSecondary,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: GardenColors.leafGreen,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _CalmActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _CalmActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isPrimary = true,
  });

  @override
  State<_CalmActionButton> createState() => _CalmActionButtonState();
}

class _CalmActionButtonState extends State<_CalmActionButton> {
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: GardenCurves.gentle,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: widget.isPrimary
              ? (_isPressed
                  ? GardenColors.leafGreen.withOpacity(0.8)
                  : GardenColors.leafGreen.withOpacity(0.2))
              : (_isPressed
                  ? Colors.white.withOpacity(0.6)
                  : Colors.white.withOpacity(0.3)),
          border: Border.all(
            color: widget.isPrimary
                ? GardenColors.leafGreen.withOpacity(0.6)
                : GardenColors.textSecondary.withOpacity(0.3),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: 20,
              color: GardenColors.textPrimary,
            ),
            const SizedBox(width: 12),
            Text(
              widget.label,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: GardenColors.textPrimary,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
