import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/repository/game_repository.dart';

final matchListStateProvider =
    StateNotifierProvider<MatchListState, List<Game>>(
        (ref) => MatchListState());

class MatchListState extends StateNotifier<List<Game>> {
  MatchListState() : super(<Game>[]);
  GameRepository get gameRepository => GameRepository.instance;

  Future<void> fetchMatches() async {
    Future<void> fetchMatches(AppUser appUser) async {
      state = await gameRepository.fetchMatches(appUser);
    }
  }

  Future<void> deleteMatch() async {}
}
