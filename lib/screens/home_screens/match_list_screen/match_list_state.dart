import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/repository/game_repository.dart';

final matchListStateProvider =
    StateNotifierProvider<MatchListState, List<Game>?>(
        (ref) => MatchListState());

class MatchListState extends StateNotifier<List<Game>?> {
  MatchListState() : super(null);
  GameRepository get gameRepository => GameRepository.instance;

  Future<void> fetchMatches(AppUser appUser) async {
    final matches = <Game>[];
    final allGames = await gameRepository.fetchGames(appUser);
    for (final game in allGames) {
      if (!game.isRehearsal) {
        matches.add(game);
      }
    }
    state = matches;
  }
}
