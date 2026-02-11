class TilePosition {
  final double x, y;
  final int layer;
  const TilePosition(this.x, this.y, this.layer);
}

class GameLayout {
  final String name, description;
  final List<TilePosition> positions;
  final int difficulty;
  const GameLayout({required this.name, required this.description, required this.positions, required this.difficulty});
  int get totalTiles => positions.length;
}

class LayoutGenerator {
  static GameLayout simpleLayout() {
    List<TilePosition> p = [];
    for (int r = 0; r < 4; r++) for (int c = 0; c < 6; c++) p.add(TilePosition(c.toDouble(), r.toDouble(), 0));
    for (int r = 1; r < 3; r++) for (int c = 1; c < 5; c++) p.add(TilePosition(c.toDouble(), r.toDouble(), 1));
    p.addAll([TilePosition(2.0, 1.0, 2), TilePosition(3.0, 1.0, 2), TilePosition(2.0, 2.0, 2), TilePosition(3.0, 2.0, 2)]);
    if (p.length % 2 != 0) p.removeLast();
    return GameLayout(name: 'Simple', description: 'Easy layout for beginners', positions: p, difficulty: 0);
  }

  static GameLayout pyramidLayout() {
    List<TilePosition> p = [];
    for (int r = 0; r < 6; r++) for (int c = 0; c < 8; c++) p.add(TilePosition(c.toDouble(), r.toDouble(), 0));
    for (int r = 1; r < 5; r++) for (int c = 1; c < 7; c++) p.add(TilePosition(c.toDouble(), r.toDouble(), 1));
    for (int r = 2; r < 4; r++) for (int c = 2; c < 6; c++) p.add(TilePosition(c.toDouble(), r.toDouble(), 2));
    for (int r = 2; r < 4; r++) for (int c = 3; c < 5; c++) p.add(TilePosition(c.toDouble(), r.toDouble(), 3));
    if (p.length % 2 != 0) p.removeLast();
    return GameLayout(name: 'Pyramid', description: 'A simpler stacked pyramid layout', positions: p, difficulty: 1);
  }

  static GameLayout classicLayout() {
    List<TilePosition> p = [];
    List<List<int>> l0 = [
      [0,0,1,1,1,1,1,1,1,1,0,0], [0,1,1,1,1,1,1,1,1,1,1,0],
      [1,1,1,1,1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1,1,1,1,1],
      [1,1,1,1,1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1,1,1,1,1],
      [0,1,1,1,1,1,1,1,1,1,1,0], [0,0,1,1,1,1,1,1,1,1,0,0],
    ];
    for (int r = 0; r < l0.length; r++) for (int c = 0; c < l0[r].length; c++) if (l0[r][c] == 1) p.add(TilePosition(c.toDouble(), r.toDouble(), 0));
    for (int r = 1; r < 7; r++) for (int c = 2; c < 10; c++) if (r >= 1 && r <= 6 && c >= 2 && c <= 9) p.add(TilePosition(c.toDouble(), r.toDouble(), 1));
    for (int r = 2; r < 6; r++) for (int c = 3; c < 9; c++) p.add(TilePosition(c.toDouble(), r.toDouble(), 2));
    for (int r = 3; r < 5; r++) for (int c = 4; c < 8; c++) p.add(TilePosition(c.toDouble(), r.toDouble(), 3));
    p.addAll([TilePosition(5.0, 3.5, 4), TilePosition(6.0, 3.5, 4)]);
    if (p.length % 2 != 0) p.removeLast();
    return GameLayout(name: 'Classic Turtle', description: 'The traditional Mahjong solitaire layout', positions: p, difficulty: 1);
  }

  static GameLayout crossLayout() {
    List<TilePosition> p = [];
    for (int c = 0; c < 10; c++) for (int r = 3; r < 5; r++) p.add(TilePosition(c.toDouble(), r.toDouble(), 0));
    for (int r = 0; r < 8; r++) for (int c = 4; c < 6; c++) if (r < 3 || r > 4) p.add(TilePosition(c.toDouble(), r.toDouble(), 0));
    for (int c = 2; c < 8; c++) { p.add(TilePosition(c.toDouble(), 3.0, 1)); p.add(TilePosition(c.toDouble(), 4.0, 1)); }
    for (int r = 1; r < 7; r++) if (r != 3 && r != 4) { p.add(TilePosition(4.0, r.toDouble(), 1)); p.add(TilePosition(5.0, r.toDouble(), 1)); }
    for (int c = 3; c < 7; c++) { p.add(TilePosition(c.toDouble(), 3.0, 2)); p.add(TilePosition(c.toDouble(), 4.0, 2)); }
    p.addAll([TilePosition(4.0, 3.0, 3), TilePosition(5.0, 3.0, 3), TilePosition(4.0, 4.0, 3), TilePosition(5.0, 4.0, 3)]);
    if (p.length % 2 != 0) p.removeLast();
    return GameLayout(name: 'Cross', description: 'A challenging cross-shaped layout', positions: p, difficulty: 2);
  }

  static List<GameLayout> allLayouts() => [simpleLayout(), pyramidLayout(), classicLayout(), crossLayout()];
}
