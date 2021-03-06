import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/repository/game_repository.dart';

final rehearsalListStateProvider =
    StateNotifierProvider<RehearsalListState, List<Game>?>(
        (ref) => RehearsalListState());

class RehearsalListState extends StateNotifier<List<Game>?> {
  RehearsalListState() : super(null);

  GameRepository get gameRepository => GameRepository.instance;

  Future<void> fetchRehearsals(AppUser appUser) async {
    final rehearsals = <Game>[];
    final allGames = await gameRepository.fetchGames(appUser);
    for (final game in allGames) {
      if (game.isRehearsal) {
        rehearsals.add(game);
      }
    }
    state = rehearsals;
  }
}
