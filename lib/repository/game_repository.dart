import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/domain/team/team.dart';
import 'package:record_game_app/repository/user_repository.dart';
import 'auth_repository.dart';

class GameRepository {
  factory GameRepository() => GameRepository();

  GameRepository._();

  static final instance = GameRepository._();

  AuthRepository get authRepository => AuthRepository.instance;

  UserRepository get userRepository => UserRepository.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static const users = 'users';
  static const games = 'games';
  static const gameIds = 'gameIds';
  static const teams = 'teams';
  static const isRehearsal = 'isRehearsal';

  //全てのゲーム取得
  Future<List<Game>> fetchGames(AppUser appUser) async {
    final gameList = <Game>[];
    final query = await _db
        .collection(users)
        .doc(appUser.userId)
        .collection(gameIds)
        .get();
    final gameIdList = query.docs.map((game) => game.id).toList();
    if (gameIdList.isNotEmpty) {
      for (final gameId in gameIdList) {
        final gameDoc = await _db.collection(games).doc(gameId).get();
        if (gameDoc.exists) {
          final game = Game.fromJson(gameDoc.data()!);
          gameList.add(game);
        }
      }
      gameList.sort((a, b) => b.heldAt!.compareTo(a.heldAt!));
    }
    return gameList;
  }

  Future<bool> fetchIsPermittedToEdit(AppUser appUser, Game game) async {
    final gameDocument = await _db
        .collection(games)
        .doc(game.gameId)
        .get()
        .then((json) => Game.fromJson(json.data()!));
    return gameDocument.isRehearsal;
  }

  Future<void> createNewGame(AppUser appUser, Game game) async {
    await _db.collection(games).doc(game.gameId).set(game.toJson());
    await _db
        .collection(users)
        .doc(appUser.userId)
        .collection(games)
        .doc(game.gameId)
        .set(<String, dynamic>{'gameId': game.gameId});
  }

  Future<void> createNewTeam(Game game, Team team) async {
    await _db
        .collection(games)
        .doc(game.gameId)
        .collection(teams)
        .doc(team.teamId)
        .set(team.toJson());
  }

  Future<List<Team>> fetchTeams(Game game) async {
    var teamList = <Team>[];
    final query =
        await _db.collection(games).doc(game.gameId).collection(teams).get();
    if (!query.size.isNaN) {
      teamList = query.docs.map((json) => Team.fromJson(json.data())).toList();
    }
    teamList.sort((a, b) => b.teamTotal.compareTo(a.teamTotal));
    return teamList;
  }
}
