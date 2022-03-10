import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/domain/party/party.dart';

class ScoreSheetArgument {
  ScoreSheetArgument({required this.game, required this.party});

  final Game game;
  final Party party;
}
