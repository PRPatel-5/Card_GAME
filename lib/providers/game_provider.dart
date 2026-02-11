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
  int _score = 0, _moves = 0, _matchesFound = 0, _totalPairs = 0, _hintsRemaining = 3, _shufflesRemaining = 3, _combo = 0, _maxCombo = 0, _elapsedSeconds = 0, _currentLayoutIndex = 0;
  Timer? _timer;
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
  String get formattedTime {
    int m = _elapsedSeconds ~/ 60, s = _elapsedSeconds % 60;
    return '${m.toString().padLeft(2,'0')}:${s.toString().padLeft(2,'0')}';
  }
  double get progress => _totalPairs == 0 ? 0 : _matchesFound / _totalPairs;
  List<GameLayout> get availableLayouts => LayoutGenerator.allLayouts();
  int get freeTilesCount => visibleTiles.where((t) => isTileFree(t)).length;

  void startGame({int layoutIndex = 0}) {
    _timer?.cancel();
    _currentLayoutIndex = layoutIndex;
    GameLayout layout = LayoutGenerator.allLayouts()[layoutIndex];
    _tiles = TileFactory.createTilesForLayout(layout);
    _totalPairs = _tiles.length ~/ 2;
    _selectedTile = null;
    _score = _moves = _matchesFound = _elapsedSeconds = _combo = _maxCombo = 0;
    _hintsRemaining = _shufflesRemaining = 3;
    _undoStack = [];
    _message = null;
    _gameState = GameState.playing;
    _startTimer();
    if (!_hasAvailableMatches()) _shuffleTiles();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_gameState == GameState.playing) { _elapsedSeconds++; notifyListeners(); }
    });
  }

  bool isTileFree(MahjongTile tile) {
    if (tile.isRemoved) return false;
    bool blockedFromAbove = _tiles.any((o) => !o.isRemoved && o.layer > tile.layer && _tilesOverlap(tile, o));
    if (blockedFromAbove) return false;
    bool blockedLeft = _tiles.any((o) => !o.isRemoved && o.layer == tile.layer && o.gridY == tile.gridY && o.gridX == tile.gridX - 1);
    bool blockedRight = _tiles.any((o) => !o.isRemoved && o.layer == tile.layer && o.gridY == tile.gridY && o.gridX == tile.gridX + 1);
    return !(blockedLeft && blockedRight);
  }

  bool _tilesOverlap(MahjongTile bottom, MahjongTile top) {
    double dx = (top.gridX - bottom.gridX).abs(), dy = (top.gridY - bottom.gridY).abs();
    return dx < 1.0 && dy < 1.0;
  }

  void onTileTap(MahjongTile tile) {
    if (_gameState != GameState.playing || tile.isRemoved || !isTileFree(tile)) {
      if (!isTileFree(tile)) _showMessage('This tile is blocked!');
      return;
    }
    for (var t in _tiles) if (t.state == TileState.hinted) t.state = TileState.normal;
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
      if (_selectedTile!.matchesWith(tile)) _handleMatch(_selectedTile!, tile);
      else _handleNoMatch(_selectedTile!, tile);
    }
  }

  void _handleMatch(MahjongTile tile1, MahjongTile tile2) {
    _moves++; _combo++; if (_combo > _maxCombo) _maxCombo = _combo; _matchesFound++;
    _undoStack.add([tile1.copyWith(), tile2.copyWith()]);
    int baseScore = 100, comboBonus = (_combo - 1) * 50, timeBonus = max(0, 500 - _elapsedSeconds);
    _score += baseScore + comboBonus + timeBonus;
    tile1.state = TileState.matched; tile2.state = TileState.matched; _selectedTile = null;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 400), () {
      tile1.isRemoved = tile2.isRemoved = true;
      tile1.state = tile2.state = TileState.normal;
      if (visibleTiles.isEmpty) {
        _gameState = GameState.won; _timer?.cancel();
        _score += max(0, 10000 - _elapsedSeconds * 10);
        _showMessage('🎉 You Won! Score: $_score');
      } else if (!_hasAvailableMatches()) {
        _gameState = GameState.noMoves;
        _showMessage('No more moves available! Try shuffle.');
      }
      notifyListeners();
    });
  }

  void _handleNoMatch(MahjongTile tile1, MahjongTile tile2) {
    _moves++; _combo = 0;
    Future.delayed(const Duration(milliseconds: 300), () {
      tile1.state = tile2.state = TileState.normal; _selectedTile = null; notifyListeners();
    });
  }

  bool _hasAvailableMatches() {
    List<MahjongTile> freeTiles = visibleTiles.where((t) => isTileFree(t)).toList();
    for (int i = 0; i < freeTiles.length; i++)
      for (int j = i + 1; j < freeTiles.length; j++)
        if (freeTiles[i].matchesWith(freeTiles[j])) return true;
    return false;
  }

  List<MahjongTile>? _getAvailableMatch() {
    List<MahjongTile> freeTiles = visibleTiles.where((t) => isTileFree(t)).toList();
    for (int i = 0; i < freeTiles.length; i++)
      for (int j = i + 1; j < freeTiles.length; j++)
        if (freeTiles[i].matchesWith(freeTiles[j])) return [freeTiles[i], freeTiles[j]];
    return null;
  }

  void useHint() {
    if (_gameState != GameState.playing && _gameState != GameState.noMoves) return;
    if (_hintsRemaining <= 0) { _showMessage('No hints remaining!'); return; }
    var match = _getAvailableMatch();
    if (match != null) {
      _hintsRemaining--; _score = max(0, _score - 50);
      if (_selectedTile != null) { _selectedTile!.state = TileState.normal; _selectedTile = null; }
      match[0].state = match[1].state = TileState.hinted;
      _showMessage('Hint: Match these tiles!');
    } else _showMessage('No matches available! Try shuffle.');
    notifyListeners();
  }

  void shuffleTiles() {
    if (_gameState != GameState.playing && _gameState != GameState.noMoves) return;
    if (_shufflesRemaining <= 0) { _showMessage('No shuffles remaining!'); return; }
    _shufflesRemaining--; _score = max(0, _score - 100); _combo = 0;
    if (_selectedTile != null) { _selectedTile!.state = TileState.normal; _selectedTile = null; }
    _shuffleTiles();
    if (_gameState == GameState.noMoves) _gameState = GameState.playing;
    _showMessage('Tiles shuffled!');
    notifyListeners();
  }

  void _shuffleTiles() {
    List<MahjongTile> remaining = visibleTiles.toList();
    List<TilePosition> positions = remaining.map((t) => TilePosition(t.gridX, t.gridY, t.layer)).toList();
    positions.shuffle(Random());
    List<int> tileTypeIds = remaining.map((t) => t.tileTypeId).toList();
    tileTypeIds.shuffle(Random());
    for (int i = 0; i < remaining.length; i++) {
      remaining[i].gridX = positions[i].x; remaining[i].gridY = positions[i].y;
      remaining[i].layer = positions[i].layer; remaining[i].state = TileState.normal;
    }
  }

  void undo() {
    if (_undoStack.isEmpty) { _showMessage('Nothing to undo!'); return; }
    List<MahjongTile> lastMatch = _undoStack.removeLast();
    _matchesFound--; _score = max(0, _score - 100);
    for (var savedTile in lastMatch) {
      MahjongTile tile = _tiles.firstWhere((t) => t.id == savedTile.id);
      tile.isRemoved = false; tile.state = TileState.normal;
      tile.gridX = savedTile.gridX; tile.gridY = savedTile.gridY; tile.layer = savedTile.layer;
    }
    if (_gameState == GameState.won) { _gameState = GameState.playing; _startTimer(); }
    _showMessage('Undo successful!');
    notifyListeners();
  }

  void togglePause() {
    if (_gameState == GameState.playing) _gameState = GameState.paused;
    else if (_gameState == GameState.paused) _gameState = GameState.playing;
    notifyListeners();
  }

  void _showMessage(String msg) {
    _message = msg;
    Future.delayed(const Duration(seconds: 2), () { if (_message == msg) { _message = null; notifyListeners(); } });
  }

  @override
  void dispose() { _timer?.cancel(); super.dispose(); }
}
