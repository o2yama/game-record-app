import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/domain/party/party.dart';
import 'package:record_game_app/repository/game_repository.dart';
import 'package:record_game_app/screens/game_detail_screen/team_list_argument.dart';
import 'package:uuid/uuid.dart';

final teamListModelProvider = ChangeNotifierProvider.family(
    (ref, TeamListArgument gameDetailArgument) =>
        TeamListModel(gameDetailArgument: gameDetailArgument));

class TeamListModel extends ChangeNotifier {
  TeamListModel({required this.gameDetailArgument});
  final TeamListArgument gameDetailArgument;

  GameRepository get gameRepository => GameRepository.instance;

  String get getUuid => const Uuid().v4();
  List<Party>? teamList;

  Future<void> fetchTeams() async {
    teamList = await gameRepository.fetchParties(gameDetailArgument.game);
  }

  Future<void> createPartyWithTotal(String partyName) async {
    final newId = getUuid;
    await gameRepository.createParty(
      gameDetailArgument.game,
      const Party().copyWith(
        partyId: newId,
        partyName: partyName,
        isTeam: true,
      ),
    );
    await fetchTeams();
  }

  Future<void> createNewTeamWithoutTotal(String partyName) async {
    final newId = getUuid;
    await gameRepository.createParty(
      gameDetailArgument.game,
      const Party().copyWith(
        partyId: newId,
        partyName: partyName,
        isTeam: false,
      ),
    );
    await fetchTeams();
  }
}
