import 'package:flutter/material.dart';

enum TileSuit { bamboo, circle, character, wind, dragon, flower, season }
enum TileState { normal, selected, matched, hinted, blocked }

class MahjongTile {
  final int id;
  final int tileTypeId;
  final TileSuit suit;
  final String name;
  final String displaySymbol;
  final Color color;
  double gridX;
  double gridY;
  int layer;
  TileState state;
  bool isRemoved;
  bool isAnimating;

  MahjongTile({
    required this.id,
    required this.tileTypeId,
    required this.suit,
    required this.name,
    required this.displaySymbol,
    required this.color,
    required this.gridX,
    required this.gridY,
    required this.layer,
    this.state = TileState.normal,
    this.isRemoved = false,
    this.isAnimating = false,
  });

  bool matchesWith(MahjongTile other) {
    if (id == other.id) return false;
    if (suit == TileSuit.flower && other.suit == TileSuit.flower) return true;
    if (suit == TileSuit.season && other.suit == TileSuit.season) return true;
    return tileTypeId == other.tileTypeId;
  }

  MahjongTile copyWith({
    double? gridX,
    double? gridY,
    int? layer,
    TileState? state,
    bool? isRemoved,
  }) {
    return MahjongTile(
      id: id,
      tileTypeId: tileTypeId,
      suit: suit,
      name: name,
      displaySymbol: displaySymbol,
      color: color,
      gridX: gridX ?? this.gridX,
      gridY: gridY ?? this.gridY,
      layer: layer ?? this.layer,
      state: state ?? this.state,
      isRemoved: isRemoved ?? this.isRemoved,
    );
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is MahjongTile && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
