import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../game/memory_garden_game.dart';
import '../models/garden_state.dart';
import '../utils/constants.dart';
import 'completion_screen.dart';

/// Garden Screen - Minimal UI, focus on the garden
class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  late MemoryGardenGame game;
  GardenState gardenState = const GardenState();
  String healthMessage = '';
  bool showHealthMessage = false;

  @override
  void initState() {
    super.initState();
    game = MemoryGardenGame()
      ..onGardenUpdate = _onGardenUpdate
      ..onGameComplete = _onGameComplete;
  }

  void _onGardenUpdate(GardenState newState) {
    setState(() {
      gardenState = newState;
      
      // Show health message briefly on significant changes
      if (newState.currentStreak > 0 && newState.currentStreak % 3 == 0) {
        healthMessage = 'Streak: ${newState.currentStreak} 🌿';
        showHealthMessage = true;
        
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() => showHealthMessage = false);
          }
        });
      }
    });
  }

  void _onGameComplete(String message) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => CompletionScreen(
          message: message,
          gardenState: gardenState,
          onRestart: () {
            Navigator.pop(context);
            game.reset();
            setState(() {
              gardenState = const GardenState();
            });
          },
          onHome: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        transitionDuration: const Duration(milliseconds: 1500),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Game canvas (full screen)
          GameWidget(game: game),
          
          // Minimal top overlay (stats)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopOverlay(),
          ),
          
          // Health message (center)
          if (showHealthMessage)
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: _buildHealthMessage(),
            ),
          
          // Bottom hint (subtle)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: _buildBottomHint(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopOverlay() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button (minimal)
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: GardenColors.textPrimary,
                ),
              ),
            ),
            
            // Streak indicator (if active)
            if (gardenState.currentStreak > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: GardenColors.plantHealthy.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🔥', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 4),
                    Text(
                      '${gardenState.currentStreak}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ).animate()
                .fadeIn(duration: 300.ms)
                .scale(begin: Offset(0.8, 0.8)),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthMessage() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          healthMessage,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: GardenColors.textPrimary,
            letterSpacing: 1.5,
          ),
        ),
      )
          .animate()
          .fadeIn(duration: 400.ms)
          .scale(begin: Offset(0.9, 0.9))
          .then()
          .shimmer(duration: 600.ms, color: GardenColors.particleGlow),
    );
  }

  Widget _buildBottomHint() {
    return Center(
      child: Text(
        'Tap cards gently • Find pairs • Grow your garden',
        style: GardenTextStyles.hint.copyWith(
          color: GardenColors.textSecondary.withOpacity(0.6),
        ),
        textAlign: TextAlign.center,
      ).animate()
        .fadeIn(delay: 2000.ms, duration: 1000.ms),
    );
  }
}
