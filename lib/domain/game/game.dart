import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
abstract class Game with _$Game {
  const factory Game({
    @Default('') String gameId,
    @Default('') String gameTitle,
    DateTime? heldAt,
    @Default(true) bool isRehearsal,
    @Default('') String editorKey,
    @Default('') String readerKey,
    @Default(<String>[]) List<String> editorIds,
    @Default(<String>[]) List<String> readerIds,
    @Default(<String>[]) List<String> partyIds,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}
