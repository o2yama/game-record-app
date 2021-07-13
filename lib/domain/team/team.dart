import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.freezed.dart';
part 'team.g.dart';

@freezed
abstract class Team with _$Team {
  const factory Team({
    @Default('') String teamId,
    @Default('') String teamName,
    @Default(false) bool isTeam,
    num? teamTotal,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}

final teamStateProvider =
    StateNotifierProvider<TeamState, Team>((ref) => TeamState());

class TeamState extends StateNotifier<Team> {
  TeamState() : super(const Team());

  void get setTeamState => state;
}
