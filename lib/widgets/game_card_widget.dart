import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/game_state_service.dart';
import '../utils/vita_theme.dart';

class GameCardWidget extends StatefulWidget {
  final GameCard card;
  final VoidCallback onTap;

  const GameCardWidget({
    super.key,
    required this.card,
    required this.onTap,
  });

  @override
  State<GameCardWidget> createState() => _GameCardWidgetState();
}

class _GameCardWidgetState extends State<GameCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: VitaConstants.cardFlipDuration,
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(GameCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.card.isFlipped != oldWidget.card.isFlipped) {
      if (widget.card.isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.card.isMatched ? null : widget.onTap,
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          final angle = _flipAnimation.value * 3.14159;
          final isBack = angle < 3.14159 / 2;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: isBack ? _buildCardBack() : _buildCardFront(),
          );
        },
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      decoration: BoxDecoration(
        color: VitaTheme.cardBack,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: VitaTheme.accentGold,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '雅',
          style: GoogleFonts.notoSerifJp(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: VitaTheme.accentGold.withOpacity(0.3),
          ),
        ),
      ),
    );
  }

  Widget _buildCardFront() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(3.14159),
      child: Container(
        decoration: BoxDecoration(
          color: widget.card.isMatched
              ? VitaTheme.successGreen.withOpacity(0.2)
              : VitaTheme.cardFront,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: widget.card.isHinted
                ? VitaTheme.accentGold
                : widget.card.vitaCard.rarityColor,
            width: widget.card.isHinted ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.card.isHinted
                  ? VitaTheme.accentGold.withOpacity(0.5)
                  : widget.card.vitaCard.rarityColor.withOpacity(0.3),
              blurRadius: widget.card.isHinted ? 12 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.card.vitaCard.emoji,
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 4),
            Text(
              widget.card.vitaCard.name,
              style: GoogleFonts.notoSansJp(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: VitaTheme.textDark,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
