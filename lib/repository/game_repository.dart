import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/repository/user_repository.dart';
import 'auth_repository.dart';

class GameRepository {
  factory GameRepository() => GameRepository();
  GameRepository._();
  static final instance = GameRepository._();

  AuthRepository get authRepository => AuthRepository.instance;
  UserRepository get userRepository => UserRepository.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static const userKey = 'users';
  static const matchKey = 'matches';
  static const rehearsalKey = 'rehearsals';
  static const matchIdKey = 'matchIds';
  static const rehearsalIdKey = 'rehearsalIds';

  Future<List<Game>> fetchMatches(AppUser appUser) async {
    final matchList = <Game>[];
    final query = await _db
        .collection(userKey)
        .doc(appUser.userId)
        .collection(matchIdKey)
        .get();
    final matchIds = query.docs.map((game) => game.id).toList();
    if (matchIds.isNotEmpty) {
      for (final gameId in matchIds) {
        final matchDoc = await _db.collection(matchKey).doc(gameId).get();
        if (matchDoc.exists) {
          final match = Game.fromJson(matchDoc.data()!);
          matchList.add(match);
        }
      }
      matchList.sort((a, b) => b.heldAt!.compareTo(a.heldAt!));
    }
    return matchList;
  }

  Future<void> createNewMatch(AppUser appUser, Game match) async {
    await _db.collection(matchKey).doc(match.gameId).set(match.toJson());
    await _db
        .collection(userKey)
        .doc(appUser.userId)
        .collection(matchIdKey)
        .doc(match.gameId)
        .set(<String, dynamic>{'matchId': match.gameId});
  }

  Future<List<Game>> fetchRehearsals(AppUser appUser) async {
    final rehearsalList = <Game>[];
    final query = await _db
        .collection(userKey)
        .doc(appUser.userId)
        .collection(rehearsalIdKey)
        .get();
    final rehearsalIds =
        query.docs.map((rehearsalId) => rehearsalId.id).toList();
    for (final rehearsalId in rehearsalIds) {
      final rehearsalDoc =
          await _db.collection(rehearsalKey).doc(rehearsalId).get();
      if (rehearsalDoc.exists) {
        final rehearsal = Game.fromJson(rehearsalDoc.data()!);
        rehearsalList.add(rehearsal);
      }
    }
    rehearsalList.sort((a, b) => b.heldAt!.compareTo(a.heldAt!));
    return rehearsalList;
  }

  Future<void> createNewRehearsal(AppUser appUser, Game rehearsal) async {
    await _db
        .collection(rehearsalKey)
        .doc(rehearsal.gameId)
        .set(rehearsal.toJson());
    await _db
        .collection(userKey)
        .doc(appUser.userId)
        .collection(rehearsalIdKey)
        .doc(rehearsal.gameId)
        .set(<String, dynamic>{'rehearsalId': rehearsal.gameId});
  }
}
