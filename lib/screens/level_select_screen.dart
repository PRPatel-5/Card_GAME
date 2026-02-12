import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../utils/vita_theme.dart';
import '../models/game_level.dart';
import '../services/game_state_service.dart';
import 'gameplay_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final levels = LevelGenerator.generateAll100Levels();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Level',
          style: GoogleFonts.notoSerifJp(),
        ),
        backgroundColor: VitaTheme.primaryDark,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [VitaTheme.primaryDark, VitaTheme.primaryLight],
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: 100,
          itemBuilder: (context, index) {
            final level = levels[index];
            return _LevelTile(level: level);
          },
        ),
      ),
    );
  }
}

class _LevelTile extends StatelessWidget {
  final GameLevel level;

  const _LevelTile({required this.level});

  @override
  Widget build(BuildContext context) {
    final isBoss = level.isBossLevel;
    
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => VitaGameState(),
              child: GameplayScreen(level: level),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isBoss 
              ? VitaTheme.accentCrimson.withOpacity(0.3)
              : VitaTheme.primaryLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isBoss 
                ? VitaTheme.accentCrimson
                : VitaTheme.accentGold.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            if (isBoss)
              BoxShadow(
                color: VitaTheme.accentCrimson.withOpacity(0.5),
                blurRadius: 8,
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isBoss)
              const Icon(
                Icons.star,
                color: VitaTheme.accentGold,
                size: 16,
              ),
            Text(
              '${level.levelNumber}',
              style: GoogleFonts.notoSerifJp(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: VitaTheme.textLight,
              ),
            ),
            Text(
              level.difficultyName,
              style: GoogleFonts.notoSansJp(
                fontSize: 8,
                color: VitaTheme.textLight.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
