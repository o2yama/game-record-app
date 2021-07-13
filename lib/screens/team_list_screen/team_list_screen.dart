import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:record_game_app/domain/game/game.dart';

class TeamListScreen extends HookWidget {
  const TeamListScreen({Key? key, required this.game}) : super(key: key);
  final Game game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(game.gameTitle)),
      body: Container(),
    );
  }
}
