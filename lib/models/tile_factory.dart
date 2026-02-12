import 'dart:math';
import 'package:flutter/material.dart';
import 'mahjong_tile.dart';
import 'game_layout.dart';

class _TileType {
  final int typeId;
  final TileSuit suit;
  final String name;
  final String symbol;
  final Color color;
  const _TileType({required this.typeId, required this.suit, required this.name, required this.symbol, required this.color});
}

class TileFactory {
  static int _nextId = 0;

  static List<MahjongTile> createTilesForLayout(GameLayout layout) {
    _nextId = 0;
    int totalTiles = layout.positions.length;
    assert(totalTiles % 2 == 0);
    int pairsNeeded = totalTiles ~/ 2;
    List<_TileType> tileTypes = _getAllTileTypes();
    List<_TileType> selectedTypes = [];
    for (int i = 0; i < pairsNeeded; i++) {
      _TileType type = tileTypes[i % tileTypes.length];
      selectedTypes.add(type);
      selectedTypes.add(type);
    }
    selectedTypes.shuffle(Random());
    List<MahjongTile> tiles = [];
    for (int i = 0; i < layout.positions.length; i++) {
      TilePosition pos = layout.positions[i];
      _TileType type = selectedTypes[i];
      tiles.add(MahjongTile(
        id: _nextId++,
        tileTypeId: type.typeId,
        suit: type.suit,
        name: type.name,
        displaySymbol: type.symbol,
        color: type.color,
        gridX: pos.x,
        gridY: pos.y,
        layer: pos.layer,
      ));
    }
    return tiles;
  }

  static List<_TileType> _getAllTileTypes() {
    List<_TileType> types = [];
    int id = 0;
    for (int i = 1; i <= 9; i++) {
      types.add(_TileType(typeId: id++, suit: TileSuit.bamboo, name: 'Bamboo $i', symbol: '$i', color: const Color(0xFF2E7D32)));
    }
    for (int i = 1; i <= 9; i++) {
      types.add(_TileType(typeId: id++, suit: TileSuit.circle, name: 'Circle $i', symbol: '$i', color: const Color(0xFF1565C0)));
    }
    List<String> chars = ['一', '二', '三', '四', '五', '六', '七', '八', '九'];
    for (int i = 0; i < 9; i++) {
      types.add(_TileType(typeId: id++, suit: TileSuit.character, name: 'Char ${i+1}', symbol: chars[i], color: const Color(0xFFC62828)));
    }
    List<String> winds = ['東', '南', '西', '北'];
    List<String> windNames = ['East', 'South', 'West', 'North'];
    for (int i = 0; i < 4; i++) {
      types.add(_TileType(typeId: id++, suit: TileSuit.wind, name: windNames[i], symbol: winds[i], color: const Color(0xFF6A1B9A)));
    }
    List<String> dragons = ['中', '發', '白'];
    List<String> dragonNames = ['Red', 'Green', 'White'];
    List<Color> dragonColors = [const Color(0xFFD32F2F), const Color(0xFF388E3C), const Color(0xFF757575)];
    for (int i = 0; i < 3; i++) {
      types.add(_TileType(typeId: id++, suit: TileSuit.dragon, name: '${dragonNames[i]} Dragon', symbol: dragons[i], color: dragonColors[i]));
    }
    List<String> flowers = ['梅', '蘭', '竹', '菊'];
    for (int i = 0; i < 4; i++) {
      types.add(_TileType(typeId: id++, suit: TileSuit.flower, name: 'Flower ${i+1}', symbol: flowers[i], color: const Color(0xFFE91E63)));
    }
    List<String> seasons = ['春', '夏', '秋', '冬'];
    for (int i = 0; i < 4; i++) {
      types.add(_TileType(typeId: id++, suit: TileSuit.season, name: 'Season ${i+1}', symbol: seasons[i], color: const Color(0xFFFF6F00)));
    }
    return types;
  }
}
