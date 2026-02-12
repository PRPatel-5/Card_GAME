import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import '../utils/vita_theme.dart';
import '../models/reward.dart';

class RewardScreen extends StatefulWidget {
  final int level;

  const RewardScreen({super.key, required this.level});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  late ConfettiController _confettiController;
  Reward? reward;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    reward = RewardDatabase.getRewardForLevel(widget.level);
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (reward == null) {
      return Scaffold(
        body: Center(
          child: Text('No reward found'),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  VitaTheme.primaryDark,
                  VitaTheme.primaryLight,
                  const Color(0xFF4B0082),
                ],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Level ${widget.level} Complete!',
                      style: GoogleFonts.notoSerifJp(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: VitaTheme.accentGold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: VitaTheme.accentGold.withOpacity(0.2),
                        border: Border.all(
                          color: VitaTheme.accentGold,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: VitaTheme.accentGold.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          reward!.emoji,
                          style: const TextStyle(fontSize: 80),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      reward!.title,
                      style: GoogleFonts.notoSerifJp(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: VitaTheme.textLight,
                      ),
                    ),
                    Text(
                      reward!.titleJp,
                      style: GoogleFonts.notoSansJp(
                        fontSize: 18,
                        color: VitaTheme.textLight.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        reward!.description,
                        style: GoogleFonts.notoSansJp(
                          fontSize: 16,
                          color: VitaTheme.textLight,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: VitaTheme.accentGold.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: VitaTheme.accentGold,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        '+${reward!.coinsBonus} 🪙',
                        style: GoogleFonts.notoSansJp(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: VitaTheme.accentGold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VitaTheme.accentGold,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 16,
                        ),
                      ),
                      child: Text(
                        'Claim Reward',
                        style: GoogleFonts.notoSansJp(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: VitaTheme.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.1,
              colors: const [
                VitaTheme.accentGold,
                VitaTheme.accentCrimson,
                VitaTheme.accentEmerald,
                VitaTheme.epicPurple,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
