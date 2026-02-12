import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/mahjong_tile.dart';
import '../models/game_layout.dart';
import '../models/tile_factory.dart';

enum GameState { idle, playing, paused, won, lost, noMoves }

class GameProvider extends ChangeNotifier {
  GameState _gameState = GameState.idle;
  List<MahjongTile> _tiles = [];
  MahjongTile? _selectedTile;
  int _score = 0;
  int _moves = 0;
  int _matchesFound = 0;
  int _totalPairs = 0;
  int _hintsRemaining = 3;
  int _shufflesRemaining = 3;
  int _combo = 0;
  int _maxCombo = 0;
  int _elapsedSeconds = 0;
  Timer? _timer;
  int _currentLayoutIndex = 0;
  List<List<MahjongTile>> _undoStack = [];
  String? _message;

  GameState get gameState => _gameState;
  List<MahjongTile> get tiles => _tiles;
  List<MahjongTile> get visibleTiles => _tiles.where((t) => !t.isRemoved).toList();
  MahjongTile? get selectedTile => _selectedTile;
  int get score => _score;
  int get moves => _moves;
  int get matchesFound => _matchesFound;
  int get totalPairs => _totalPairs;
  int get hintsRemaining => _hintsRemaining;
  int get shufflesRemaining => _shufflesRemaining;
  int get combo => _combo;
  int get maxCombo => _maxCombo;
  int get elapsedSeconds => _elapsedSeconds;
  int get currentLayoutIndex => _currentLayoutIndex;
  String? get message => _message;
  int get tilesRemaining => visibleTiles.length;
  int get freeTilesCount => visibleTiles.where((t) => isTileFree(t)).length;

  String get formattedTime {
    int mins = _elapsedSeconds ~/ 60;
    int secs = _elapsedSeconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  double get progress => _totalPairs == 0 ? 0 : _matchesFound / _totalPairs;
  List<GameLayout> get availableLayouts => LayoutGenerator.allLayouts();

  void startGame({int layoutIndex = 0}) {
    _timer?.cancel();
    _currentLayoutIndex = layoutIndex;
    GameLayout layout = LayoutGenerator.allLayouts()[layoutIndex];
    _tiles = TileFactory.createTilesForLayout(layout);
    _totalPairs = _tiles.length ~/ 2;
    _selectedTile = null;
    _score = 0;
    _moves = 0;
    _matchesFound = 0;
    _hintsRemaining = 3;
    _shufflesRemaining = 3;
    _combo = 0;
    _maxCombo = 0;
    _elapsedSeconds = 0;
    _undoStack = [];
    _message = null;
    _gameState = GameState.playing;
    _startTimer();
    if (!_hasAvailableMatches()) _shufflePositions();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_gameState == GameState.playing) {
        _elapsedSeconds++;
        notifyListeners();
      }
    });
  }

  bool isTileFree(MahjongTile tile) {
    if (tile.isRemoved) return false;
    bool blockedAbove = _tiles.any((o) => !o.isRemoved && o.layer > tile.layer && _overlap(tile, o));
    if (blockedAbove) return false;
    bool blockedLeft = _tiles.any((o) => !o.isRemoved && o.layer == tile.layer && o.gridY == tile.gridY && o.gridX == tile.gridX - 1);
    bool blockedRight = _tiles.any((o) => !o.isRemoved && o.layer == tile.layer && o.gridY == tile.gridY && o.gridX == tile.gridX + 1);
    return !(blockedLeft && blockedRight);
  }

  bool _overlap(MahjongTile a, MahjongTile b) {
    return (b.gridX - a.gridX).abs() < 1.0 && (b.gridY - a.gridY).abs() < 1.0;
  }

  void onTileTap(MahjongTile tile) {
    if (_gameState != GameState.playing) return;
    if (tile.isRemoved || !isTileFree(tile)) {
      _showMessage('Tile is blocked!');
      return;
    }
    for (var t in _tiles) {
      if (t.state == TileState.hinted) t.state = TileState.normal;
    }
    if (_selectedTile == null) {
      _selectedTile = tile;
      tile.state = TileState.selected;
      notifyListeners();
    } else if (_selectedTile!.id == tile.id) {
      _selectedTile!.state = TileState.normal;
      _selectedTile = null;
      notifyListeners();
    } else {
      tile.state = TileState.selected;
      notifyListeners();
      if (_selectedTile!.matchesWith(tile)) {
        _handleMatch(_selectedTile!, tile);
      } else {
        _handleNoMatch(_selectedTile!, tile);
      }
    }
  }

  void _handleMatch(MahjongTile t1, MahjongTile t2) {
    _moves++;
    _combo++;
    if (_combo > _maxCombo) _maxCombo = _combo;
    _matchesFound++;
    _undoStack.add([t1.copyWith(), t2.copyWith()]);
    _score += 100 + (_combo - 1) * 50 + max(0, 500 - _elapsedSeconds);
    t1.state = TileState.matched;
    t2.state = TileState.matched;
    _selectedTile = null;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 400), () {
      t1.isRemoved = true;
      t2.isRemoved = true;
      t1.state = TileState.normal;
      t2.state = TileState.normal;
      if (visibleTiles.isEmpty) {
        _gameState = GameState.won;
        _timer?.cancel();
        _score += max(0, 10000 - _elapsedSeconds * 10);
      } else if (!_hasAvailableMatches()) {
        _gameState = GameState.noMoves;
        _showMessage('No moves! Use shuffle.');
      }
      notifyListeners();
    });
  }

  void _handleNoMatch(MahjongTile t1, MahjongTile t2) {
    _moves++;
    _combo = 0;
    Future.delayed(const Duration(milliseconds: 300), () {
      t1.state = TileState.normal;
      t2.state = TileState.normal;
      _selectedTile = null;
      notifyListeners();
    });
  }

  bool _hasAvailableMatches() {
    List<MahjongTile> free = visibleTiles.where((t) => isTileFree(t)).toList();
    for (int i = 0; i < free.length; i++) {
      for (int j = i + 1; j < free.length; j++) {
        if (free[i].matchesWith(free[j])) return true;
      }
    }
    return false;
  }

  List<MahjongTile>? _findMatch() {
    List<MahjongTile> free = visibleTiles.where((t) => isTileFree(t)).toList();
    for (int i = 0; i < free.length; i++) {
      for (int j = i + 1; j < free.length; j++) {
        if (free[i].matchesWith(free[j])) return [free[i], free[j]];
      }
    }
    return null;
  }

  void useHint() {
    if (_gameState != GameState.playing && _gameState != GameState.noMoves) return;
    if (_hintsRemaining <= 0) { _showMessage('No hints left!'); return; }
    var match = _findMatch();
    if (match != null) {
      _hintsRemaining--;
      _score = max(0, _score - 50);
      if (_selectedTile != null) { _selectedTile!.state = TileState.normal; _selectedTile = null; }
      match[0].state = TileState.hinted;
      match[1].state = TileState.hinted;
    } else {
      _showMessage('No matches! Shuffle needed.');
    }
    notifyListeners();
  }

  void shuffleTiles() {
    if (_gameState != GameState.playing && _gameState != GameState.noMoves) return;
    if (_shufflesRemaining <= 0) { _showMessage('No shuffles left!'); return; }
    _shufflesRemaining--;
    _score = max(0, _score - 100);
    _combo = 0;
    if (_selectedTile != null) { _selectedTile!.state = TileState.normal; _selectedTile = null; }
    _shufflePositions();
    if (_gameState == GameState.noMoves) _gameState = GameState.playing;
    _showMessage('Shuffled!');
    notifyListeners();
  }

  void _shufflePositions() {
    List<MahjongTile> remaining = visibleTiles.toList();
    List<_Pos> positions = remaining.map((t) => _Pos(t.gridX, t.gridY, t.layer)).toList();
    positions.shuffle(Random());
    for (int i = 0; i < remaining.length; i++) {
      remaining[i].gridX = positions[i].x;
      remaining[i].gridY = positions[i].y;
      remaining[i].layer = positions[i].l;
      remaining[i].state = TileState.normal;
    }
  }

  void undo() {
    if (_undoStack.isEmpty) { _showMessage('Nothing to undo!'); return; }
    List<MahjongTile> last = _undoStack.removeLast();
    _matchesFound--;
    _score = max(0, _score - 100);
    for (var saved in last) {
      MahjongTile tile = _tiles.firstWhere((t) => t.id == saved.id);
      tile.isRemoved = false;
      tile.state = TileState.normal;
      tile.gridX = saved.gridX;
      tile.gridY = saved.gridY;
      tile.layer = saved.layer;
    }
    if (_gameState == GameState.won) { _gameState = GameState.playing; _startTimer(); }
    notifyListeners();
  }

  void togglePause() {
    if (_gameState == GameState.playing) _gameState = GameState.paused;
    else if (_gameState == GameState.paused) _gameState = GameState.playing;
    notifyListeners();
  }

  void _showMessage(String msg) {
    _message = msg;
    notifyListeners();
    Future.delayed(const Duration(seconds: 2), () {
      if (_message == msg) { _message = null; notifyListeners(); }
    });
  }

  @override
  void dispose() { _timer?.cancel(); super.dispose(); }
}

class _Pos {
  final double x, y;
  final int l;
  _Pos(this.x, this.y, this.l);
}
