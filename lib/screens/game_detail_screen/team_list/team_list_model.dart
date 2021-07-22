import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/domain/team/team.dart';
import 'package:record_game_app/repository/game_repository.dart';
import 'package:record_game_app/screens/game_detail_screen/game_detail_argument.dart';
import 'package:uuid/uuid.dart';

final teamListModelProvider = ChangeNotifierProvider.family(
    (ref, GameDetailArgument gameDetailArgument) =>
        TeamListModel(gameDetailArgument: gameDetailArgument));

class TeamListModel extends ChangeNotifier {
  TeamListModel({required this.gameDetailArgument});
  final GameDetailArgument gameDetailArgument;

  GameRepository get gameRepository => GameRepository.instance;

  String get getUuid => const Uuid().v4();
  List<Team>? teamList;

  Future<void> fetchTeams() async {
    teamList = await gameRepository.fetchTeams(gameDetailArgument.game);
    notifyListeners();
  }

  Future<void> createNewTeamWithTotal(String teamName) async {
    final newId = getUuid;
    await gameRepository.createNewTeam(
      gameDetailArgument.game,
      const Team().copyWith(teamId: newId, teamName: teamName, isTeam: true),
    );
    await fetchTeams();
  }

  Future<void> createNewTeamWithoutTotal(String teamName) async {
    final newId = getUuid;
    await gameRepository.createNewTeam(
      gameDetailArgument.game,
      const Team().copyWith(teamId: newId, teamName: teamName, isTeam: false),
    );
    await fetchTeams();
  }
}
