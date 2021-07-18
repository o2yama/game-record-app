import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.freezed.dart';
part 'team.g.dart';

@freezed
abstract class Team with _$Team {
  const factory Team({
    @Default('') String teamId,
    @Default('') String teamName,
    @Default(false) bool isTeam,
    @Default(0) num teamTotal,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}
