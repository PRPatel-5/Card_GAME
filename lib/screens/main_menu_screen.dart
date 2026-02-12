import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/vita_theme.dart';
import 'level_select_screen.dart';
import 'gallery_screen.dart';
import 'settings_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Title
              Text(
                '雅',
                style: GoogleFonts.notoSerifJp(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: VitaTheme.accentGold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              
              Text(
                'MIYABI MAHJONG',
                style: GoogleFonts.notoSansJp(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: VitaTheme.textLight,
                  letterSpacing: 4,
                ),
              ),
              
              const SizedBox(height: 60),
              
              // Menu Buttons
              _MenuButton(
                label: '続ける',
                sublabel: 'CONTINUE',
                icon: Icons.play_arrow,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LevelSelectScreen(),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 16),
              
              _MenuButton(
                label: 'レベル',
                sublabel: 'LEVELS',
                icon: Icons.grid_view,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LevelSelectScreen(),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 16),
              
              _MenuButton(
                label: 'ギャラリー',
                sublabel: 'GALLERY',
                icon: Icons.collections,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GalleryScreen(),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 16),
              
              _MenuButton(
                label: '設定',
                sublabel: 'SETTINGS',
                icon: Icons.settings,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              
              const Spacer(),
              
              Text(
                'v1.0.0',
                style: GoogleFonts.notoSansJp(
                  fontSize: 12,
                  color: VitaTheme.textLight.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String label;
  final String sublabel;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuButton({
    required this.label,
    required this.sublabel,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: VitaTheme.primaryLight.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: VitaTheme.accentGold.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: VitaTheme.accentGold.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: VitaTheme.accentGold,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.notoSansJp(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: VitaTheme.textLight,
                    ),
                  ),
                  Text(
                    sublabel,
                    style: GoogleFonts.notoSansJp(
                      fontSize: 12,
                      color: VitaTheme.textLight.withOpacity(0.7),
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: VitaTheme.accentGold.withOpacity(0.5),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
