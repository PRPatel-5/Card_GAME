import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/vita_game.dart';

void main() {
  runApp(const VitaCardGameApp());
}

class VitaCardGameApp extends StatelessWidget {
  const VitaCardGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vita Card Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: GameWidget<VitaGame>.controlled(
        gameFactory: VitaGame.new,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}