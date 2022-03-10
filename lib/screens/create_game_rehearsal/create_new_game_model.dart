import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/repository/game_repository.dart';
import 'package:uuid/uuid.dart';

import 'create_new_game_screen.dart';

final createNewGameModelProvider = ChangeNotifierProvider.family(
    (ref, AppUser appUser) => CreateNewGameModel(appUser: appUser));

class CreateNewGameModel extends ChangeNotifier {
  CreateNewGameModel({required this.appUser});
  final AppUser appUser;
  GameRepository get gameRepository => GameRepository.instance;

  String get getUuid => const Uuid().v4();

  Future<void> createNewGame(
      {required String gameTitle,
      required String editorKey,
      required String readerKey,
      required DateTime heldAt,
      required GameType gameType}) async {
    var isRehearsal = false;
    if (gameType == GameType.match) {
      isRehearsal = false;
    } else if (gameType == GameType.rehearsal) {
      isRehearsal = true;
    }
    final newId = getUuid;
    final newGame = const Game().copyWith(
      gameId: newId,
      gameTitle: gameTitle,
      heldAt: heldAt,
      isRehearsal: isRehearsal,
      editorKey: editorKey,
      readerKey: readerKey,
      editorIds: [appUser.userId],
      readerIds: [],
    );
    await gameRepository.createNewGame(appUser, newGame);
  }

  Future<void> deleteGame(Game game) async {
    await gameRepository.deleteGame(appUser, game);
  }
}
