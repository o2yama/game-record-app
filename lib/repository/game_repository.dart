import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/domain/party/party.dart';
import 'package:record_game_app/domain/player/player.dart';
import 'package:record_game_app/domain/score_detail/score_detail.dart';
import 'package:record_game_app/screens/score_sheet_screen/score_sheet_screen.dart';
import 'package:uuid/uuid.dart';

final gameRepository = GameRepository.instance;

class GameRepository {
  factory GameRepository() => GameRepository();
  GameRepository._();
  static final instance = GameRepository._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String uuid = '';

  void getUuid() {
    uuid = const Uuid().v4();
  }

  static const users = 'users';
  static const games = 'games';
  static const gameIds = 'gameIds';
  static const teams = 'teams';
  static const players = 'players';

  ///全てのゲーム(試合、試技会ともに)取得
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

  Future<void> createNewGame(AppUser appUser, Game game) async {
    await _db.collection(games).doc(game.gameId).set(game.toJson());
    await _db
        .collection(users)
        .doc(appUser.userId)
        .collection(gameIds)
        .doc(game.gameId)
        .set(<String, dynamic>{'gameId': game.gameId});
  }

  Future<void> updateGame(AppUser appUser, Game game) async {
    await _db.collection(games).doc(game.gameId).update(game.toJson());
  }

  Future<void> deleteGame(AppUser appUser, Game game) async {
    await _db.collection(games).doc(game.gameId).delete();
  }

  ///班の取得
  Future<List<Party>> fetchParties(Game game) async {
    var partyList = <Party>[];
    final query =
        await _db.collection(games).doc(game.gameId).collection(teams).get();
    if (!query.size.isNaN) {
      partyList = query.docs
          .map(
            (json) => Party.fromJson(json.data()),
          )
          .toList();
    }
    partyList.sort((a, b) => b.teamTotal.compareTo(a.teamTotal));
    return partyList;
  }

  Future<void> createParty(Game game, Party party) async {
    await _db
        .collection(games)
        .doc(game.gameId)
        .collection(teams)
        .doc(party.partyId)
        .set(party.toJson());
  }

  Future<void> updateParty(Game game, Party party) async {
    await _db
        .collection(games)
        .doc(game.gameId)
        .collection(teams)
        .doc(party.partyId)
        .update(party.toJson());
  }

  Future<void> deleteParty(Game game, String partyId) async {
    await _db
        .collection(games)
        .doc(game.gameId)
        .collection(teams)
        .doc(partyId)
        .delete();
  }

  ///班のメンバーの取得
  Future<List<Player>> fetchPlayers(Game game, String partyId) async {
    var playerList = <Player>[];
    final query = await _db
        .collection(games)
        .doc(game.gameId)
        .collection(teams)
        .doc(partyId)
        .collection(players)
        .get();
    if (!query.size.isNaN) {
      playerList =
          query.docs.map((json) => Player.fromJson(json.data())).toList();
    }
    playerList.sort((a, b) => b.grade.compareTo(a.grade));
    return playerList;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchPlayer(
    Game game,
    Party party,
  ) {
    return _db
        .collection(games)
        .doc(game.gameId)
        .collection(teams)
        .doc(party.partyId)
        .collection(players)
        .snapshots();
  }

  Future<void> createPlayer(Game game, String partyId, Player player) async {
    await _db
        .collection(games)
        .doc(game.gameId)
        .collection(teams)
        .doc(partyId)
        .collection(players)
        .add(player.toJson());
  }

  Future<void> updatePlayerData(
      Game game, String partyId, Player newPlayerData) async {
    await _db
        .collection(games)
        .doc(game.gameId)
        .collection(teams)
        .doc(partyId)
        .collection(players)
        .doc(newPlayerData.playerId)
        .update(newPlayerData.toJson());
  }

  Future<void> deletePlayer(Game game, String partyId, Player player) async {
    await _db
        .collection(games)
        .doc(game.gameId)
        .collection(teams)
        .doc(partyId)
        .collection(players)
        .doc(player.playerId)
        .delete();
  }

  ///スコアの詳細(D, E, ND)取得
  Future<ScoreDetail> fetchScoreDetail(
      String gameId, String partyId, String playerId, EVENT event) async {
    var scoreDetail = const ScoreDetail().copyWith();

    final doc = await _db
        .collection(games)
        .doc(gameId)
        .collection(teams)
        .doc(partyId)
        .collection(players)
        .doc(playerId)
        .collection(scoreDetailKey(event))
        .doc(playerId)
        .get();
    if (doc.exists) {
      scoreDetail = ScoreDetail.fromJson(doc.data()!);
    }
    return scoreDetail;
  }

  Future<void> setScoreDetail(
    String gameId,
    String partyId,
    String playerId,
    EVENT event,
    ScoreDetail scoreDetail,
  ) async {
    if (scoreDetail.scoreId == '') {
      //スコアIDが空だったらまだ未登録だからset
      getUuid();
      await _db
          .collection(games)
          .doc(gameId)
          .collection(teams)
          .doc(partyId)
          .collection(players)
          .doc(playerId)
          .collection(scoreDetailKey(event))
          .doc(uuid)
          .set(scoreDetail.copyWith(scoreId: uuid).toJson());
    } else {
      //スコアIDが空じゃなければ取得できるデータがあるってことだからupdate
      await _db
          .collection(games)
          .doc(gameId)
          .collection(teams)
          .doc(partyId)
          .collection(players)
          .doc(playerId)
          .collection(scoreDetailKey(event))
          .doc(uuid)
          .update(scoreDetail.toJson());
    }
  }

  String scoreDetailKey(EVENT event) {
    var scoreDetailKey = '';
    if (event == EVENT.fx) {
      scoreDetailKey = 'fxDetail';
    } else if (event == EVENT.ph) {
      scoreDetailKey = 'phDetail';
    } else if (event == EVENT.sr) {
      scoreDetailKey = 'srDetail';
    } else if (event == EVENT.vt) {
      scoreDetailKey = 'vtDetail';
    } else if (event == EVENT.pb) {
      scoreDetailKey = 'pbDetail';
    } else if (event == EVENT.hb) {
      scoreDetailKey = 'hbDetail';
    }
    if (scoreDetailKey != '') {
      return scoreDetailKey;
    } else {
      throw Exception('種目の情報が取得できていません。');
    }
  }
}
