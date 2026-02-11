import 'dart:math';
import 'package:flutter/material.dart';
import 'mahjong_tile.dart';
import 'game_layout.dart';

class TileFactory {
  static int _nextId = 0;

  static List<MahjongTile> createTilesForLayout(GameLayout layout) {
    _nextId = 0;
    int totalTiles = layout.positions.length;
    assert(totalTiles % 2 == 0);
    int pairsNeeded = totalTiles ~/ 2;
    List<_TileType> tileTypes = _getAllTileTypes();
    List<_TileType> selectedTypes = [];
    int typeIndex = 0;
    for (int i = 0; i < pairsNeeded; i++) {
      selectedTypes.add(tileTypes[typeIndex % tileTypes.length]);
      selectedTypes.add(tileTypes[typeIndex % tileTypes.length]);
      typeIndex++;
    }
    selectedTypes.shuffle(Random());
    List<MahjongTile> tiles = [];
    for (int i = 0; i < layout.positions.length; i++) {
      var pos = layout.positions[i];
      var type = selectedTypes[i];
      tiles.add(MahjongTile(
        id: _nextId++, tileTypeId: type.typeId, suit: type.suit,
        name: type.name, displaySymbol: type.symbol, color: type.color,
        gridX: pos.x, gridY: pos.y, layer: pos.layer,
      ));
    }
    return tiles;
  }

  static List<_TileType> _getAllTileTypes() {
    List<_TileType> types = [];
    int typeId = 0;
    for (int i = 0; i < 9; i++) types.add(_TileType(typeId: typeId++, suit: TileSuit.bamboo, name: 'Bamboo ${i+1}', symbol: '${i+1}', color: Color(0xFF2E7D32), label: 'B'));
    for (int i = 0; i < 9; i++) types.add(_TileType(typeId: typeId++, suit: TileSuit.circle, name: 'Circle ${i+1}', symbol: '${i+1}', color: Color(0xFF1565C0), label: 'C'));
    List<String> chars = ['一','二','三','四','五','六','七','八','九'];
    for (int i = 0; i < 9; i++) types.add(_TileType(typeId: typeId++, suit: TileSuit.character, name: 'Char ${i+1}', symbol: chars[i], color: Color(0xFFC62828), label: 'W'));
    List<String> winds = ['東','南','西','北'];
    List<String> windNames = ['East','South','West','North'];
    for (int i = 0; i < 4; i++) types.add(_TileType(typeId: typeId++, suit: TileSuit.wind, name: windNames[i], symbol: winds[i], color: Color(0xFF6A1B9A), label: 'Wi'));
    List<String> dragons = ['中','發','白'];
    List<String> dragonNames = ['Red','Green','White'];
    List<Color> dragonColors = [Color(0xFFD32F2F), Color(0xFF388E3C), Color(0xFF757575)];
    for (int i = 0; i < 3; i++) types.add(_TileType(typeId: typeId++, suit: TileSuit.dragon, name: '${dragonNames[i]} Dragon', symbol: dragons[i], color: dragonColors[i], label: 'D'));
    List<String> flowers = ['梅','蘭','竹','菊'];
    for (int i = 0; i < 4; i++) types.add(_TileType(typeId: typeId++, suit: TileSuit.flower, name: 'Flower ${i+1}', symbol: flowers[i], color: Color(0xFFE91E63), label: 'F'));
    List<String> seasons = ['春','夏','秋','冬'];
    for (int i = 0; i < 4; i++) types.add(_TileType(typeId: typeId++, suit: TileSuit.season, name: 'Season ${i+1}', symbol: seasons[i], color: Color(0xFFFF6F00), label: 'S'));
    return types;
  }
}

class _TileType {
  final int typeId;
  final TileSuit suit;
  final String name, symbol, label;
  final Color color;
  const _TileType({required this.typeId, required this.suit, required this.name, required this.symbol, required this.color, required this.label});
}