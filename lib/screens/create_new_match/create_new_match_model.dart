import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:uuid/uuid.dart';

final createNewMatchModelProvider = ChangeNotifierProvider.family(
    (ref, AppUser appUser) => CreateNewMatchModel(appUser: appUser));

class CreateNewMatchModel extends ChangeNotifier {
  CreateNewMatchModel({required this.appUser});
  final AppUser appUser;

  final uuid = const Uuid().v4();

  String gameId = '';
  String gameTitle = '';
  DateTime heldAt = DateTime.now();
  String editorKey = '';
  String readerKey = '';
  bool isMatch = false;
  List<String> editorIds = [];
  List<String> readerIds = [];

  void pickedHeldAt(DateTime heldAt) {
    this.heldAt = heldAt;
    notifyListeners();
  }

  void get isMatchChanged => isMatch;

  Future<void> createNewGame() async {}
}
