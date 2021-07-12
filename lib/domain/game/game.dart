import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
abstract class Game with _$Game {
  const factory Game({
    @Default('') String gameId,
    @Default('') String gameTitle,
    DateTime? heldAt,
    @Default('') String editorKey,
    @Default('') String readerKey,
    @Default(true) bool isMatch,
    @Default(<String>[]) List<String> editorIds,
    @Default(<String>[]) List<String> readerIds,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}

final gameStateProvider = StateNotifierProvider.family
    .autoDispose<GameState, Game, Game>((ref, Game game) => GameState(game));

class GameState extends StateNotifier<Game> {
  GameState(Game game) : super(game);

  void get setGame => state;
}
