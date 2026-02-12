import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/power_up.dart';
import '../utils/vita_theme.dart';

class PowerUpButton extends StatelessWidget {
  final PowerUp powerUp;
  final int count;
  final VoidCallback onPressed;

  const PowerUpButton({
    super.key,
    required this.powerUp,
    required this.count,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = count > 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: isEnabled ? onPressed : null,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isEnabled
                  ? VitaTheme.accentGold
                  : VitaTheme.primaryLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isEnabled
                    ? VitaTheme.accentGold
                    : VitaTheme.textLight.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: isEnabled
                  ? [
                      BoxShadow(
                        color: VitaTheme.accentGold.withOpacity(0.5),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                powerUp.emoji,
                style: TextStyle(
                  fontSize: 28,
                  color: isEnabled ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '×$count',
          style: GoogleFonts.notoSansJp(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isEnabled ? VitaTheme.textLight : Colors.grey,
          ),
        ),
      ],
    );
  }
}
