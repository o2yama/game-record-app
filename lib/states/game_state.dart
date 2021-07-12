import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:uuid/uuid.dart';

final gameStateProvider =
    StateNotifierProvider.autoDispose<GameState, Game>((ref) => GameState());

class GameState extends StateNotifier<Game> {
  GameState() : super(Game());

  final uuid = Uuid().v4();

  String gameId = '';
  String gameTitle = '';
  DateTime heldAt = DateTime.now();
  String editorKey = '';
  String readerKey = '';
  bool isMatch = false;
  List<String> editorIds = [];
  List<String> readerIds = [];

  void get pickedHeldAt => heldAt;

  void get isMatchChanged => isMatch;

  Future<void> createNewGame() async {}
}
