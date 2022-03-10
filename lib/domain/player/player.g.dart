// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Player _$_$_PlayerFromJson(Map<String, dynamic> json) {
  return _$_Player(
    playerId: json['playerId'] as String? ?? '',
    name: json['name'] as String? ?? '',
    grade: json['grade'] as int? ?? 1,
    totalScore: json['totalScore'] as num? ?? 0,
    fx: json['fx'] as num? ?? 0,
    ph: json['ph'] as num? ?? 0,
    sr: json['sr'] as num? ?? 0,
    vt: json['vt'] as num? ?? 0,
    pb: json['pb'] as num? ?? 0,
    hb: json['hb'] as num? ?? 0,
  );
}

Map<String, dynamic> _$_$_PlayerToJson(_$_Player instance) => <String, dynamic>{
      'playerId': instance.playerId,
      'name': instance.name,
      'grade': instance.grade,
      'totalScore': instance.totalScore,
      'fx': instance.fx,
      'ph': instance.ph,
      'sr': instance.sr,
      'vt': instance.vt,
      'pb': instance.pb,
      'hb': instance.hb,
    };
