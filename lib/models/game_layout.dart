class TilePosition {
  final double x;
  final double y;
  final int layer;
  const TilePosition(this.x, this.y, this.layer);
}

class GameLayout {
  final String name;
  final String description;
  final List<TilePosition> positions;
  final int difficulty;
  const GameLayout({
    required this.name,
    required this.description,
    required this.positions,
    required this.difficulty,
  });
  int get totalTiles => positions.length;
}

class LayoutGenerator {
  static GameLayout simpleLayout() {
    List<TilePosition> positions = [];
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 6; col++) {
        positions.add(TilePosition(col.toDouble(), row.toDouble(), 0));
      }
    }
    for (int row = 1; row < 3; row++) {
      for (int col = 1; col < 5; col++) {
        positions.add(TilePosition(col.toDouble(), row.toDouble(), 1));
      }
    }
    positions.add(const TilePosition(2.0, 1.0, 2));
    positions.add(const TilePosition(3.0, 1.0, 2));
    positions.add(const TilePosition(2.0, 2.0, 2));
    positions.add(const TilePosition(3.0, 2.0, 2));
    if (positions.length % 2 != 0) positions.removeLast();
    return GameLayout(name: 'Simple', description: 'Easy beginner layout', positions: positions, difficulty: 0);
  }

  static GameLayout pyramidLayout() {
    List<TilePosition> positions = [];
    for (int row = 0; row < 6; row++) {
      for (int col = 0; col < 8; col++) {
        positions.add(TilePosition(col.toDouble(), row.toDouble(), 0));
      }
    }
    for (int row = 1; row < 5; row++) {
      for (int col = 1; col < 7; col++) {
        positions.add(TilePosition(col.toDouble(), row.toDouble(), 1));
      }
    }
    for (int row = 2; row < 4; row++) {
      for (int col = 2; col < 6; col++) {
        positions.add(TilePosition(col.toDouble(), row.toDouble(), 2));
      }
    }
    for (int row = 2; row < 4; row++) {
      for (int col = 3; col < 5; col++) {
        positions.add(TilePosition(col.toDouble(), row.toDouble(), 3));
      }
    }
    if (positions.length % 2 != 0) positions.removeLast();
    return GameLayout(name: 'Pyramid', description: 'Classic stacked pyramid', positions: positions, difficulty: 1);
  }

  static GameLayout turtleLayout() {
    List<TilePosition> positions = [];
    List<List<int>> layer0 = [
      [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
      [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
    ];
    for (int row = 0; row < layer0.length; row++) {
      for (int col = 0; col < layer0[row].length; col++) {
        if (layer0[row][col] == 1) {
          positions.add(TilePosition(col.toDouble(), row.toDouble(), 0));
        }
      }
    }
    for (int row = 1; row < 7; row++) {
      for (int col = 2; col < 10; col++) {
        positions.add(TilePosition(col.toDouble(), row.toDouble(), 1));
      }
    }
    for (int row = 2; row < 6; row++) {
      for (int col = 3; col < 9; col++) {
        positions.add(TilePosition(col.toDouble(), row.toDouble(), 2));
      }
    }
    for (int row = 3; row < 5; row++) {
      for (int col = 4; col < 8; col++) {
        positions.add(TilePosition(col.toDouble(), row.toDouble(), 3));
      }
    }
    positions.add(const TilePosition(5.0, 3.5, 4));
    positions.add(const TilePosition(6.0, 3.5, 4));
    if (positions.length % 2 != 0) positions.removeLast();
    return GameLayout(name: 'Turtle', description: 'Classic Mahjong turtle shape', positions: positions, difficulty: 2);
  }

  static GameLayout crossLayout() {
    List<TilePosition> positions = [];
    for (int col = 0; col < 10; col++) {
      for (int row = 3; row < 5; row++) {
        positions.add(TilePosition(col.toDouble(), row.toDouble(), 0));
      }
    }
    for (int row = 0; row < 8; row++) {
      for (int col = 4; col < 6; col++) {
        if (row < 3 || row > 4) {
          positions.add(TilePosition(col.toDouble(), row.toDouble(), 0));
        }
      }
    }
    for (int col = 2; col < 8; col++) {
      positions.add(TilePosition(col.toDouble(), 3.0, 1));
      positions.add(TilePosition(col.toDouble(), 4.0, 1));
    }
    for (int row = 1; row < 7; row++) {
      if (row != 3 && row != 4) {
        positions.add(TilePosition(4.0, row.toDouble(), 1));
        positions.add(TilePosition(5.0, row.toDouble(), 1));
      }
    }
    for (int col = 3; col < 7; col++) {
      positions.add(TilePosition(col.toDouble(), 3.0, 2));
      positions.add(TilePosition(col.toDouble(), 4.0, 2));
    }
    positions.add(const TilePosition(4.0, 3.0, 3));
    positions.add(const TilePosition(5.0, 3.0, 3));
    positions.add(const TilePosition(4.0, 4.0, 3));
    positions.add(const TilePosition(5.0, 4.0, 3));
    if (positions.length % 2 != 0) positions.removeLast();
    return GameLayout(name: 'Cross', description: 'Challenging cross pattern', positions: positions, difficulty: 3);
  }

  static GameLayout fortressLayout() {
    List<TilePosition> positions = [];
    for (int row = 0; row < 6; row++) {
      for (int col = 0; col < 10; col++) {
        if (row == 0 || row == 5 || col == 0 || col == 9 || (col >= 3 && col <= 6 && row >= 2 && row <= 3)) {
          positions.add(TilePosition(col.toDouble(), row.toDouble(), 0));
        }
      }
    }
    for (int row = 1; row < 5; row++) {
      for (int col = 1; col < 9; col++) {
        if (col >= 3 && col <= 6 && row >= 2 && row <= 3) {
          positions.add(TilePosition(col.toDouble(), row.toDouble(), 1));
        }
      }
    }
    positions.add(const TilePosition(4.0, 2.0, 2));
    positions.add(const TilePosition(5.0, 2.0, 2));
    positions.add(const TilePosition(4.0, 3.0, 2));
    positions.add(const TilePosition(5.0, 3.0, 2));
    if (positions.length % 2 != 0) positions.removeLast();
    return GameLayout(name: 'Fortress', description: 'Castle-shaped layout', positions: positions, difficulty: 2);
  }

  static List<GameLayout> allLayouts() {
    return [simpleLayout(), pyramidLayout(), turtleLayout(), crossLayout(), fortressLayout()];
  }
}
