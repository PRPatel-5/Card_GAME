import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import 'garden_screen.dart';

/// Home Screen - Calm introduction to Memory Garden
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              GardenColors.skyMorning,
              GardenColors.skyEvening,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                
                // Title
                Text(
                  'MEMORY',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 56,
                    fontWeight: FontWeight.w300,
                    color: GardenColors.textPrimary,
                    letterSpacing: 8,
                    height: 1.0,
                  ),
                ).animate()
                  .fadeIn(duration: 1200.ms, curve: GardenCurves.gentle)
                  .slideY(begin: 0.1, end: 0),
                
                const SizedBox(height: 8),
                
                Text(
                  'GARDEN',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 64,
                    fontWeight: FontWeight.w300,
                    color: GardenColors.leafGreen,
                    letterSpacing: 10,
                    height: 1.0,
                  ),
                ).animate()
                  .fadeIn(delay: 400.ms, duration: 1200.ms, curve: GardenCurves.gentle)
                  .slideY(begin: 0.1, end: 0),
                
                const SizedBox(height: 32),
                
                // Tagline
                Text(
                  '"You don\'t win a game—\nyou grow it."',
                  textAlign: TextAlign.center,
                  style: GardenTextStyles.subtitle.copyWith(
                    fontStyle: FontStyle.italic,
                    height: 1.6,
                  ),
                ).animate()
                  .fadeIn(delay: 800.ms, duration: 1000.ms),
                
                const SizedBox(height: 48),
                
                // Decorative plant
                const Text(
                  '🌿',
                  style: TextStyle(fontSize: 48),
                ).animate()
                  .fadeIn(delay: 1200.ms)
                  .scale(begin: Offset(0.5, 0.5)),
                
                const Spacer(),
                
                // Begin button
                _CalmButton(
                  label: 'Begin',
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const GardenScreen(),
                        transitionDuration: const Duration(milliseconds: 1000),
                        transitionsBuilder: (_, animation, __, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ).animate()
                  .fadeIn(delay: 1600.ms, duration: 800.ms)
                  .slideY(begin: 0.2, end: 0),
                
                const SizedBox(height: 24),
                
                // Subtle hint
                Text(
                  'No timer • No pressure • Just growth',
                  style: GardenTextStyles.hint,
                ).animate()
                  .fadeIn(delay: 2000.ms, duration: 600.ms),
                
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Calm, minimal button design
class _CalmButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _CalmButton({
    required this.label,
    required this.onTap,
  });

  @override
  State<_CalmButton> createState() => _CalmButtonState();
}

class _CalmButtonState extends State<_CalmButton> {
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
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 18),
        decoration: BoxDecoration(
          color: _isPressed
              ? GardenColors.leafGreen.withOpacity(0.8)
              : GardenColors.leafGreen.withOpacity(0.2),
          border: Border.all(
            color: GardenColors.leafGreen.withOpacity(0.6),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: GardenColors.textPrimary,
            letterSpacing: 4,
          ),
        ),
      ),
    );
  }
}
