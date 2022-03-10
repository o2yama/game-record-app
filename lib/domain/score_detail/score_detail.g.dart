// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Score _$_$_ScoreFromJson(Map<String, dynamic> json) {
  return _$_Score(
    scoreId: json['scoreId'] as String? ?? '',
    d: json['d'] as num? ?? 0,
    e: json['e'] as num? ?? 0,
    nd: json['nd'] as num? ?? 0,
  );
}

Map<String, dynamic> _$_$_ScoreToJson(_$_Score instance) => <String, dynamic>{
      'scoreId': instance.scoreId,
      'd': instance.d,
      'e': instance.e,
      'nd': instance.nd,
    };
