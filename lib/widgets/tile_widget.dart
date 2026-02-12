import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/mahjong_tile.dart';

class TileWidget extends StatelessWidget {
  final MahjongTile tile;
  final bool isFree;
  final bool isSelected;
  final bool isHinted;
  final bool isMatched;
  final double tileWidth;
  final double tileHeight;
  final VoidCallback onTap;

  const TileWidget({super.key, required this.tile, required this.isFree, required this.isSelected, required this.isHinted, required this.isMatched, required this.tileWidth, required this.tileHeight, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Widget w = GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: tileWidth - 2, height: tileHeight - 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: _colors()),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _borderColor(), width: isSelected || isHinted ? 2.5 : 1.5),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.5), offset: Offset(tile.layer * 1.5 + 1, tile.layer * 1.5 + 2), blurRadius: 3),
            if (tile.layer > 0) BoxShadow(color: const Color(0xFF5D4E37).withValues(alpha: 0.8), offset: const Offset(2, 3)),
            if (isSelected) BoxShadow(color: Colors.amber.withValues(alpha: 0.6), blurRadius: 12, spreadRadius: 2),
            if (isHinted) BoxShadow(color: Colors.cyan.withValues(alpha: 0.6), blurRadius: 12, spreadRadius: 2),
          ],
        ),
        child: Stack(children: [
          Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(tile.displaySymbol, style: TextStyle(fontSize: tileWidth * 0.45, fontWeight: FontWeight.bold, color: tile.color)),
            Text(_suitLabel(), style: TextStyle(fontSize: 8, color: tile.color.withValues(alpha: 0.7), fontWeight: FontWeight.w600)),
          ])),
          if (!isFree) Container(decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(8))),
          if (isMatched) Container(decoration: BoxDecoration(color: Colors.amber.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(8)), child: const Center(child: Icon(Icons.auto_awesome, color: Colors.amber, size: 28))),
        ]),
      ),
    );
    if (isMatched) return w.animate().scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 200.ms).then().fadeOut(duration: 200.ms);
    if (isHinted) return w.animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 600.ms);
    return w;
  }

  List<Color> _colors() {
    if (isSelected) return [const Color(0xFFFFF8E1), const Color(0xFFFFECB3)];
    if (isHinted) return [const Color(0xFFE0F7FA), const Color(0xFFB2EBF2)];
    if (!isFree) return [const Color(0xFFE0D8C8), const Color(0xFFD0C8B8)];
    return [const Color(0xFFFFFDF5), const Color(0xFFF5F0E1)];
  }

  Color _borderColor() {
    if (isSelected) return Colors.amber;
    if (isHinted) return Colors.cyan;
    if (isMatched) return Colors.green;
    if (!isFree) return const Color(0xFFA89880);
    return const Color(0xFFD4C5A0);
  }

  String _suitLabel() {
    switch (tile.suit) {
      case TileSuit.bamboo: return 'BAMBOO';
      case TileSuit.circle: return 'CIRCLE';
      case TileSuit.character: return 'CHAR';
      case TileSuit.wind: return 'WIND';
      case TileSuit.dragon: return 'DRAGON';
      case TileSuit.flower: return 'FLOWER';
      case TileSuit.season: return 'SEASON';
    }
  }
}
