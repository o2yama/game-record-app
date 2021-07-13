// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Team _$_$_TeamFromJson(Map<String, dynamic> json) {
  return _$_Team(
    teamId: json['teamId'] as String? ?? '',
    teamName: json['teamName'] as String? ?? '',
    isTeam: json['isTeam'] as bool? ?? false,
    teamTotal: json['teamTotal'] as num?,
  );
}

Map<String, dynamic> _$_$_TeamToJson(_$_Team instance) => <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'isTeam': instance.isTeam,
      'teamTotal': instance.teamTotal,
    };
