import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:uuid/uuid.dart';

final createNewRehearsalModelProvider = ChangeNotifierProvider.family(
    (ref, AppUser appUser) => CreateNewRehearsalModel(appUser: appUser));

class CreateNewRehearsalModel extends ChangeNotifier {
  CreateNewRehearsalModel({required this.appUser});

  final AppUser appUser;
  final uuid = const Uuid().v4();

  String gameId = '';
  String gameTitle = '';
  DateTime heldAt = DateTime.now();
  String editorKey = '';
  String readerKey = '';
  List<String> editorIds = [];
  List<String> readerIds = [];

  void pickedHeldAt(DateTime heldAt) {
    this.heldAt = heldAt;
    notifyListeners();
  }

  Future<void> createNewGame() async {}
}
