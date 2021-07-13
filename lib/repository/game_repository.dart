import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/repository/user_repository.dart';
import 'auth_repository.dart';

class GameRepository {
  factory GameRepository() => GameRepository();
  GameRepository._();
  static final instance = GameRepository._();

  static const userKey = 'users';
  static const matchKey = 'matches';
  static const rehearsalKey = 'rehearsals';

  AuthRepository get authRepository => AuthRepository.instance;
  UserRepository get userRepository => UserRepository.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createNewGame() async {}

  Future<List<Game>> fetchMatches(AppUser appUser) async {
    final matchList = <Game>[];
    final matchQuery = await _db
        .collection(userKey)
        .doc(appUser.userId)
        .collection(matchKey)
        .get();
    final matchIds = matchQuery.docs
        .map((game) => game.data()['gameId'].toString())
        .toList();
    if (matchIds.isNotEmpty) {
      for (final gameId in matchIds) {
        final gameDoc = await _db.collection(matchKey).doc(gameId).get();
        if (gameDoc.exists) {
          final game = Game.fromJson(gameDoc as Map<String, dynamic>);
          matchList.add(game);
        }
      }
      matchList.sort((a, b) => b.heldAt!.compareTo(a.heldAt!));
    }
    return matchList;
  }

  Future<List<Game>> fetchRehearsals(AppUser appUser) async {
    final rehearsalList = <Game>[];
    final rehearsalQuery = await _db
        .collection(userKey)
        .doc(appUser.userId)
        .collection(rehearsalKey)
        .get();
    final rehearsalIds = rehearsalQuery.docs
        .map((rehearsalId) => rehearsalId.data()['gameId'].toString())
        .toList();
    for (final rehearsalId in rehearsalIds) {
      final rehearsalDoc =
          await _db.collection(rehearsalKey).doc(rehearsalId).get();
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
