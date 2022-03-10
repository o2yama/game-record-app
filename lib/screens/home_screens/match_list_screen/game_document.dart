import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:record_game_app/domain/game/game.dart';

class GameDocument extends StatelessWidget {
  const GameDocument({required this.game, Key? key}) : super(key: key);

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${game.heldAt!.month}/${game.heldAt!.day}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            title: Text(
              game.gameTitle,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                color: Colors.white,
                width: 20,
                height: 20,
                child: Image.asset('images/like_paper.png')),
          ],
        ),
      ]),
    );
  }
}
