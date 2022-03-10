import 'package:freezed_annotation/freezed_annotation.dart';

part 'score_detail.freezed.dart';
part 'score_detail.g.dart';

@freezed
abstract class ScoreDetail with _$ScoreDetail {
  const factory ScoreDetail({
    @Default('') String scoreId, //playerIdと一致
    @Default(0) num d,
    @Default(0) num e,
    @Default(0) num nd,
  }) = _Score;

  factory ScoreDetail.fromJson(Map<String, dynamic> json) =>
      _$ScoreDetailFromJson(json);
}
