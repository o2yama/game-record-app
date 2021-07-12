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
    editorKey: json['editorKey'] as String? ?? '',
    readerKey: json['readerKey'] as String? ?? '',
    isMatch: json['isMatch'] as bool? ?? true,
    editorIds: (json['editorIds'] as List<dynamic>?)
            ?.map((dynamic e) => e as String)
            .toList() ??
        [],
    readerIds: (json['readerIds'] as List<dynamic>?)
            ?.map((dynamic e) => e as String)
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$_$_GameToJson(_$_Game instance) => <String, dynamic>{
      'gameId': instance.gameId,
      'gameTitle': instance.gameTitle,
      'heldAt': instance.heldAt?.toIso8601String(),
      'editorKey': instance.editorKey,
      'readerKey': instance.readerKey,
      'isMatch': instance.isMatch,
      'editorIds': instance.editorIds,
      'readerIds': instance.readerIds,
    };
