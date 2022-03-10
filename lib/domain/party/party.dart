import 'package:freezed_annotation/freezed_annotation.dart';

part 'party.freezed.dart';
part 'party.g.dart';

@freezed
abstract class Party with _$Party {
  const factory Party({
    @Default('') String partyId,
    @Default('') String partyName,
    @Default(false) bool isTeam,
    @Default(0) num teamTotal,
    @Default(<String>[]) List<String> playerIds,
  }) = _Party;

  factory Party.fromJson(Map<String, dynamic> json) => _$PartyFromJson(json);
}
