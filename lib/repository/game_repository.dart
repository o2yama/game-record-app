import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/repository/user_repository.dart';
import 'auth_repository.dart';

class GameRepository {
  factory GameRepository() => GameRepository();
  GameRepository._();
  static final instance = GameRepository._();

  static const users = 'users';
  static const games = 'games';
  static const rehearsals = 'rehearsals';

  AuthRepository get authRepository => AuthRepository.instance;
  UserRepository get userRepository => UserRepository.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Game>> fetchGames(AppUser appUser) async {
    final gameList = <Game>[];
    final gameQuery =
        await _db.collection(users).doc(appUser.userId).collection(games).get();
    final gameIds =
        gameQuery.docs.map((game) => game.data()['gameId'].toString()).toList();
    for (final gameId in gameIds) {
      final gameDoc = await _db.collection(games).doc(gameId).get();
      if (gameDoc.exists) {
        final game = Game.fromJson(gameDoc as Map<String, dynamic>);
        gameList.add(game);
      }
    }
    gameList.sort((a, b) => b.heldAt!.compareTo(a.heldAt!));
    return gameList;
  }

  Future<List<Game>> fetchRehearsals(AppUser appUser) async {
    final rehearsalList = <Game>[];
    final rehearsalQuery = await _db
        .collection(users)
        .doc(appUser.userId)
        .collection(rehearsals)
        .get();
    final rehearsalIds = rehearsalQuery.docs
        .map((rehearsalId) => rehearsalId.data()['rehearsalId'].toString())
        .toList();
    for (final rehearsalId in rehearsalIds) {
      final rehearsalDoc =
          await _db.collection(rehearsals).doc(rehearsalId).get();
      if (rehearsalDoc.exists) {
        final rehearsal = Game.fromJson(rehearsalDoc as Map<String, dynamic>);
        rehearsalList.add(rehearsal);
      }
    }
    rehearsalList.sort((a, b) => b.heldAt!.compareTo(a.heldAt!));
    return rehearsalList;
  }

  Future<List<Game>> fetchFavoriteGames(AppUser appUser) async {
    return [];
  }
}
