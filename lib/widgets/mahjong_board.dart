import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../models/mahjong_tile.dart';
import 'tile_widget.dart';

class MahjongBoard extends StatelessWidget {
  const MahjongBoard({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        List<MahjongTile> visibleTiles = game.visibleTiles;
        if (visibleTiles.isEmpty) return const Center(child: Text('Loading...', style: TextStyle(color: Colors.white54, fontSize: 18)));
        double minX = double.infinity, maxX = double.negativeInfinity, minY = double.infinity, maxY = double.negativeInfinity;
        int maxLayer = 0;
        for (var tile in visibleTiles) {
          if (tile.gridX < minX) minX = tile.gridX;
          if (tile.gridX > maxX) maxX = tile.gridX;
          if (tile.gridY < minY) minY = tile.gridY;
          if (tile.gridY > maxY) maxY = tile.gridY;
          if (tile.layer > maxLayer) maxLayer = tile.layer;
        }
        double tileWidth = 55, tileHeight = 70, layerOffsetX = 3.0, layerOffsetY = -3.0;
        double boardWidth = (maxX - minX + 1) * tileWidth + maxLayer * layerOffsetX.abs() + 40;
        double boardHeight = (maxY - minY + 1) * tileHeight + maxLayer * layerOffsetY.abs() + 40;
        List<MahjongTile> sortedTiles = List.from(visibleTiles);
        sortedTiles.sort((a, b) {
          if (a.layer != b.layer) return a.layer.compareTo(b.layer);
          if (a.gridY != b.gridY) return a.gridY.compareTo(b.gridY);
          return a.gridX.compareTo(b.gridX);
        });
        return InteractiveViewer(
          minScale: 0.5, maxScale: 2.5, boundaryMargin: const EdgeInsets.all(100),
          child: Center(
            child: SizedBox(
              width: boardWidth, height: boardHeight,
              child: Stack(
                children: sortedTiles.map((tile) {
                  double x = (tile.gridX - minX) * tileWidth + tile.layer * layerOffsetX + 20;
                  double y = (tile.gridY - minY) * tileHeight + tile.layer * layerOffsetY + 20;
                  bool isFree = game.isTileFree(tile);
                  return Positioned(left: x, top: y, child: TileWidget(tile: tile, isFree: isFree, isSelected: tile.state == TileState.selected, isHinted: tile.state == TileState.hinted, isMatched: tile.state == TileState.matched, tileWidth: tileWidth, tileHeight: tileHeight, onTap: () => game.onTileTap(tile)));
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}