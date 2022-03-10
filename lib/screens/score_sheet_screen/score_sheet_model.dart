import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/domain/party/party.dart';
import 'package:record_game_app/domain/player/player.dart';
import 'package:record_game_app/domain/score_detail/score_detail.dart';
import 'package:record_game_app/repository/game_repository.dart';
import 'package:record_game_app/screens/score_sheet_screen/score_sheet_argument.dart';
import 'package:record_game_app/screens/score_sheet_screen/score_sheet_screen.dart';

final scoreSheetModelProvider = StateNotifierProvider.family<ScoreSheetModel,
        ScoreSheetArgument, ScoreSheetArgument>(
    (ref, ScoreSheetArgument scoreSheetArgs) =>
        ScoreSheetModel(scoreSheetArgs));

class ScoreSheetModel extends StateNotifier<ScoreSheetArgument> {
  ScoreSheetModel(ScoreSheetArgument argument) : super(argument);

  Future<void> createPlayer(String name, int grade) async {
    final player = const Player().copyWith(name: name, grade: grade); //名前と学年
    await gameRepository.createPlayer(state.game, state.party.partyId, player);
  }

  Future<void> updatePlayerData(Player player, String name, int grade) async {
    final newPlayerData = player.copyWith(name: name, grade: grade);
    await gameRepository.updatePlayerData(
        state.game, state.party.partyId, newPlayerData);
  }

  Future<void> deletePlayer(Player player) async {
    await gameRepository.deletePlayer(state.game, state.party.partyId, player);
  }

  // Future<double> calculateTeamScore(EVENT event, Game game, Party party) async {
  //   final playerList = <Player>[];
  //   state.party.playerIds.forEach(state.party.playerIds.add);
  //
  //   switch (event) {
  //     case EVENT.fx:
  //       final fxScoreList = <num>[];
  //
  //     case EVENT.ph:
  //       // TODO: Handle this case.
  //       break;
  //     case EVENT.sr:
  //       // TODO: Handle this case.
  //       break;
  //     case EVENT.vt:
  //       // TODO: Handle this case.
  //       break;
  //     case EVENT.pb:
  //       // TODO: Handle this case.
  //       break;
  //     case EVENT.hb:
  //       // TODO: Handle this case.
  //       break;
  //   }
  //
  //   final phScoreList = <num>[];
  //   final srScoreList = <num>[];
  //   final vtScoreList = <num>[];
  //   final pbScoreList = <num>[];
  //   final hbScoreList = <num>[];
  //
  //   //全ての選手のスコアを一度リスト化
  //   for (final player in playerList) {}
  //
  //   //スコアの高い順に並び替え
  //
  //   phScoreList.sort((a, b) => b.compareTo(a));
  //   srScoreList.sort((a, b) => b.compareTo(a));
  //   vtScoreList.sort((a, b) => b.compareTo(a));
  //   pbScoreList.sort((a, b) => b.compareTo(a));
  //   hbScoreList.sort((a, b) => b.compareTo(a));
  //
  //   //一番低いスコアを削除
  //   fxScoreList.remove(fxScoreList.last);
  //   phScoreList.remove(phScoreList.last);
  //   srScoreList.remove(srScoreList.last);
  //   vtScoreList.remove(vtScoreList.last);
  //   pbScoreList.remove(pbScoreList.last);
  //   hbScoreList.remove(hbScoreList.last);
  //
  //   //残ったスコアのリストを合計
  //   if (event == EVENT.fx) {
  //     var total = 0.0;
  //     for (final score in fxScoreList) {
  //       total += score;
  //     }
  //     return total;
  //   } else if (event == EVENT.ph) {
  //     var total = 0.0;
  //     for (final score in phScoreList) {
  //       total += score;
  //     }
  //     return total;
  //   }
  //   for (final score in srScoreList) {
  //     srTotal += score;
  //   }
  //   for (final score in vtScoreList) {
  //     vtTotal += score;
  //   }
  //   for (final score in pbScoreList) {
  //     pbTotal += score;
  //   }
  //   for (final score in hbScoreList) {
  //     hbTotal += score;
  //   }
  // }

  Future<ScoreDetail> fetchScoreDetail(Player player, EVENT event) async {
    final scoreDetail = await gameRepository.fetchScoreDetail(
        state.game.gameId, state.party.partyId, player.playerId, event);
    return scoreDetail;
  }

  Future<void> updateScore(Player player) async {}
}
