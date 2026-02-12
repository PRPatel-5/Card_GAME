import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/vita_theme.dart';
import '../models/vita_card.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Card Gallery',
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
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: CardDatabase.allCards.length,
          itemBuilder: (context, index) {
            final card = CardDatabase.allCards[index];
            return _CardTile(card: card);
          },
        ),
      ),
    );
  }
}

class _CardTile extends StatelessWidget {
  final VitaCard card;

  const _CardTile({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: VitaTheme.cardFront,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: card.rarityColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: card.rarityColor.withOpacity(0.3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            card.emoji,
            style: const TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 8),
          Text(
            card.name,
            style: GoogleFonts.notoSansJp(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: VitaTheme.textDark,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
