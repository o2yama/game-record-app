import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/repository/game_repository.dart';
import 'package:uuid/uuid.dart';

final createNewRehearsalModelProvider = ChangeNotifierProvider.family(
    (ref, AppUser appUser) => CreateNewRehearsalModel(appUser: appUser));

class CreateNewRehearsalModel extends ChangeNotifier {
  CreateNewRehearsalModel({required this.appUser});
  final AppUser appUser;
  GameRepository get gameRepository => GameRepository.instance;

  String get getUuid => const Uuid().v4();

  Future<void> createNewRehearsal(
      {required String gameTitle,
      required String editorKey,
      required String readerKey,
      required DateTime heldAt}) async {
    final newId = getUuid;
    final newGame = const Game().copyWith(
      gameId: newId,
      gameTitle: gameTitle,
      heldAt: heldAt,
      editorKey: editorKey,
      readerKey: readerKey,
      editorIds: [appUser.userId],
      readerIds: [],
    );
    await gameRepository.createNewRehearsal(appUser, newGame);
  }
}
