// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Party _$_$_PartyFromJson(Map<String, dynamic> json) {
  return _$_Party(
    partyId: json['partyId'] as String? ?? '',
    partyName: json['partyName'] as String? ?? '',
    isTeam: json['isTeam'] as bool? ?? false,
    teamTotal: json['teamTotal'] as num? ?? 0,
    playerIds:
        (json['playerIds'] as List<String>?)?.map((e) => e).toList() ?? [],
  );
}

Map<String, dynamic> _$_$_PartyToJson(_$_Party instance) => <String, dynamic>{
      'partyId': instance.partyId,
      'partyName': instance.partyName,
      'isTeam': instance.isTeam,
      'teamTotal': instance.teamTotal,
      'playerIds': instance.playerIds,
    };
