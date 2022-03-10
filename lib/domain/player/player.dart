import 'package:freezed_annotation/freezed_annotation.dart';

part 'player.freezed.dart';
part 'player.g.dart';

@freezed
abstract class Player with _$Player {
  const factory Player({
    @Default('') String playerId,
    @Default('') String name,
    @Default(1) int grade,
    @Default(0) num totalScore,
    @Default(0) num fx,
    @Default(0) num ph,
    @Default(0) num sr,
    @Default(0) num vt,
    @Default(0) num pb,
    @Default(0) num hb,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}
