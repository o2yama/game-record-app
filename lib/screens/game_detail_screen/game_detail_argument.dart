import 'package:record_game_app/domain/game/game.dart';

class GameDetailArgument {
  GameDetailArgument({required this.game, required this.isMatch});

  final Game game;
  final bool isMatch;
}
