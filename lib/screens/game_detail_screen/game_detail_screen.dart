import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:record_game_app/screens/game_detail_screen/game_detail_argument.dart';

class GameDetailScreen extends HookWidget {
  const GameDetailScreen({Key? key, required this.gameArgument})
      : super(key: key);

  final GameDetailArgument gameArgument;

  static Route<Widget> route({required GameDetailArgument gameDetailArgument}) {
    return MaterialPageRoute<Widget>(
      builder: (_) => GameDetailScreen(gameArgument: gameDetailArgument),
      settings: RouteSettings(arguments: gameDetailArgument),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gameArgument.game.gameTitle)),
      body: Container(),
    );
  }
}
