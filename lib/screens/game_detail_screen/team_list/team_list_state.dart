import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/domain/team/team.dart';
import 'package:record_game_app/repository/game_repository.dart';
import 'package:record_game_app/screens/game_detail_screen/game_detail_argument.dart';

final teamListStateProvider = StateNotifierProvider.family<TeamListState,
        List<Team>?, GameDetailArgument>(
    (ref, GameDetailArgument gameDetailArgument) =>
        TeamListState(gameDetailArgument: gameDetailArgument));

class TeamListState extends StateNotifier<List<Team>?> {
  TeamListState({required this.gameDetailArgument}) : super(null);
  final GameDetailArgument gameDetailArgument;

  GameRepository get gameRepository => GameRepository.instance;

  Future<void> fetchTeams() async {
    state = await gameRepository.fetchTeams(gameDetailArgument.game);
  }

  Future<void> createNewTeam(String teamName) async {
    await gameRepository.createNewTeam(
        gameDetailArgument.game, Team().copyWith());
  }
}
