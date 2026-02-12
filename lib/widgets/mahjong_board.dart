import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../models/mahjong_tile.dart';
import 'tile_widget.dart';

class MahjongBoard extends StatelessWidget {
  const MahjongBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (ctx, game, _) {
      List<MahjongTile> visible = game.visibleTiles;
      if (visible.isEmpty) return const Center(child: CircularProgressIndicator());

      double minX = double.infinity, maxX = double.negativeInfinity;
      double minY = double.infinity, maxY = double.negativeInfinity;
      int maxLayer = 0;
      for (var t in visible) {
        if (t.gridX < minX) minX = t.gridX;
        if (t.gridX > maxX) maxX = t.gridX;
        if (t.gridY < minY) minY = t.gridY;
        if (t.gridY > maxY) maxY = t.gridY;
        if (t.layer > maxLayer) maxLayer = t.layer;
      }

      double tw = 55, th = 70, lox = 3.0, loy = -3.0;
      double bw = (maxX - minX + 1) * tw + maxLayer * lox.abs() + 40;
      double bh = (maxY - minY + 1) * th + maxLayer * loy.abs() + 40;

      List<MahjongTile> sorted = List.from(visible)..sort((a, b) {
        if (a.layer != b.layer) return a.layer.compareTo(b.layer);
        if (a.gridY != b.gridY) return a.gridY.compareTo(b.gridY);
        return a.gridX.compareTo(b.gridX);
      });

      return InteractiveViewer(
        minScale: 0.4, maxScale: 3.0, boundaryMargin: const EdgeInsets.all(100),
        child: Center(child: SizedBox(width: bw, height: bh, child: Stack(
          children: sorted.map((tile) {
            double x = (tile.gridX - minX) * tw + tile.layer * lox + 20;
            double y = (tile.gridY - minY) * th + tile.layer * loy + 20;
            return Positioned(left: x, top: y, child: TileWidget(
              tile: tile, isFree: game.isTileFree(tile),
              isSelected: tile.state == TileState.selected,
              isHinted: tile.state == TileState.hinted,
              isMatched: tile.state == TileState.matched,
              tileWidth: tw, tileHeight: th,
              onTap: () => game.onTileTap(tile),
            ));
          }).toList(),
        ))),
      );
    });
  }
}
