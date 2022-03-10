// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Game _$_$_GameFromJson(Map<String, dynamic> json) {
  return _$_Game(
    gameId: json['gameId'] as String? ?? '',
    gameTitle: json['gameTitle'] as String? ?? '',
    heldAt: json['heldAt'] == null
        ? null
        : DateTime.parse(json['heldAt'] as String),
    isRehearsal: json['isRehearsal'] as bool? ?? true,
    editorKey: json['editorKey'] as String? ?? '',
    readerKey: json['readerKey'] as String? ?? '',
    editorIds:
        (json['editorIds'] as List<String>?)?.map((e) => e).toList() ?? [],
    readerIds:
        (json['readerIds'] as List<String>?)?.map((e) => e).toList() ?? [],
    partyIds: (json['partyIds'] as List<String>?)?.map((e) => e).toList() ?? [],
  );
}

Map<String, dynamic> _$_$_GameToJson(_$_Game instance) => <String, dynamic>{
      'gameId': instance.gameId,
      'gameTitle': instance.gameTitle,
      'heldAt': instance.heldAt?.toIso8601String(),
      'isRehearsal': instance.isRehearsal,
      'editorKey': instance.editorKey,
      'readerKey': instance.readerKey,
      'editorIds': instance.editorIds,
      'readerIds': instance.readerIds,
      'partyIds': instance.partyIds,
    };
