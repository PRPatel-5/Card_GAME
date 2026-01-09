import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/constants.dart';
import 'game_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Game Title
              Text(
                '✨ MEMORY',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 4,
                  shadows: [
                    Shadow(
                      color: GameColors.buttonGradientEnd.withOpacity(0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms).scale(),
              
              const SizedBox(height: 8),
              
              Text(
                'MASTER',
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [GameColors.buttonGradientStart, GameColors.accentGold],
                    ).createShader(const Rect.fromLTWH(0, 0, 300, 70)),
                  letterSpacing: 6,
                  shadows: [
                    Shadow(
                      color: GameColors.accentGold.withOpacity(0.5),
                      blurRadius: 30,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms).scale(),
              
              const SizedBox(height: 12),
              
              Text(
                'Train Your Brain • Match & Win',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                  letterSpacing: 2,
                ),
              ).animate().fadeIn(delay: 400.ms),
              
              const SizedBox(height: 80),
              
              // Play Button
              _GameButton(
                label: 'PLAY NOW',
                icon: Icons.play_arrow_rounded,
                gradientColors: const [
                  GameColors.buttonGradientStart,
                  GameColors.buttonGradientEnd,
                ],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GameScreen()),
                  );
                },
              ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 20),
              
              // Stats Button
              _GameButton(
                label: 'STATISTICS',
                icon: Icons.bar_chart_rounded,
                gradientColors: const [
                  Color(0xFF6366F1),
                  Color(0xFF4F46E5),
                ],
                onTap: () {
                  // TODO: Show stats screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coming soon!')),
                  );
                },
              ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 20),
              
              // Settings Button
              _GameButton(
                label: 'SETTINGS',
                icon: Icons.settings_rounded,
                gradientColors: const [
                  Color(0xFF8B5CF6),
                  Color(0xFF7C3AED),
                ],
                onTap: () {
                  // TODO: Show settings
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coming soon!')),
                  );
                },
              ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0),
              
              const Spacer(),
              
              // Footer
              Text(
                'v1.0.0 • Made with ❤️',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.4),
                ),
              ).animate().fadeIn(delay: 1000.ms),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _GameButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const _GameButton({
    required this.label,
    required this.icon,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  State<_GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<_GameButton> {
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
          width: 280,
          height: 65,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: widget.gradientColors[1].withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
