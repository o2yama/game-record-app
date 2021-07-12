import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/domain/game/game.dart';

class GameListState extends StateNotifier<List<Game>> {
  GameListState() : super(<Game>[]);

  Future<void> fetchGames() async {}
}
