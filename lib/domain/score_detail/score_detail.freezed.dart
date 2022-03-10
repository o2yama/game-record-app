// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'score_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScoreDetail _$ScoreDetailFromJson(Map<String, dynamic> json) {
  return _Score.fromJson(json);
}

/// @nodoc
class _$ScoreDetailTearOff {
  const _$ScoreDetailTearOff();

  _Score call({String scoreId = '', num d = 0, num e = 0, num nd = 0}) {
    return _Score(
      scoreId: scoreId,
      d: d,
      e: e,
      nd: nd,
    );
  }

  ScoreDetail fromJson(Map<String, Object> json) {
    return ScoreDetail.fromJson(json);
  }
}

/// @nodoc
const $ScoreDetail = _$ScoreDetailTearOff();

/// @nodoc
mixin _$ScoreDetail {
  String get scoreId => throw _privateConstructorUsedError; //playerIdと一致
  num get d => throw _privateConstructorUsedError;
  num get e => throw _privateConstructorUsedError;
  num get nd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScoreDetailCopyWith<ScoreDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreDetailCopyWith<$Res> {
  factory $ScoreDetailCopyWith(
          ScoreDetail value, $Res Function(ScoreDetail) then) =
      _$ScoreDetailCopyWithImpl<$Res>;
  $Res call({String scoreId, num d, num e, num nd});
}

/// @nodoc
class _$ScoreDetailCopyWithImpl<$Res> implements $ScoreDetailCopyWith<$Res> {
  _$ScoreDetailCopyWithImpl(this._value, this._then);

  final ScoreDetail _value;
  // ignore: unused_field
  final $Res Function(ScoreDetail) _then;

  @override
  $Res call({
    Object? scoreId = freezed,
    Object? d = freezed,
    Object? e = freezed,
    Object? nd = freezed,
  }) {
    return _then(_value.copyWith(
      scoreId: scoreId == freezed
          ? _value.scoreId
          : scoreId // ignore: cast_nullable_to_non_nullable
              as String,
      d: d == freezed
          ? _value.d
          : d // ignore: cast_nullable_to_non_nullable
              as num,
      e: e == freezed
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as num,
      nd: nd == freezed
          ? _value.nd
          : nd // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
abstract class _$ScoreCopyWith<$Res> implements $ScoreDetailCopyWith<$Res> {
  factory _$ScoreCopyWith(_Score value, $Res Function(_Score) then) =
      __$ScoreCopyWithImpl<$Res>;
  @override
  $Res call({String scoreId, num d, num e, num nd});
}

/// @nodoc
class __$ScoreCopyWithImpl<$Res> extends _$ScoreDetailCopyWithImpl<$Res>
    implements _$ScoreCopyWith<$Res> {
  __$ScoreCopyWithImpl(_Score _value, $Res Function(_Score) _then)
      : super(_value, (v) => _then(v as _Score));

  @override
  _Score get _value => super._value as _Score;

  @override
  $Res call({
    Object? scoreId = freezed,
    Object? d = freezed,
    Object? e = freezed,
    Object? nd = freezed,
  }) {
    return _then(_Score(
      scoreId: scoreId == freezed
          ? _value.scoreId
          : scoreId // ignore: cast_nullable_to_non_nullable
              as String,
      d: d == freezed
          ? _value.d
          : d // ignore: cast_nullable_to_non_nullable
              as num,
      e: e == freezed
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as num,
      nd: nd == freezed
          ? _value.nd
          : nd // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Score implements _Score {
  const _$_Score({this.scoreId = '', this.d = 0, this.e = 0, this.nd = 0});

  factory _$_Score.fromJson(Map<String, dynamic> json) =>
      _$_$_ScoreFromJson(json);

  @JsonKey(defaultValue: '')
  @override
  final String scoreId;
  @JsonKey(defaultValue: 0)
  @override //playerIdと一致
  final num d;
  @JsonKey(defaultValue: 0)
  @override
  final num e;
  @JsonKey(defaultValue: 0)
  @override
  final num nd;

  @override
  String toString() {
    return 'ScoreDetail(scoreId: $scoreId, d: $d, e: $e, nd: $nd)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Score &&
            (identical(other.scoreId, scoreId) ||
                const DeepCollectionEquality()
                    .equals(other.scoreId, scoreId)) &&
            (identical(other.d, d) ||
                const DeepCollectionEquality().equals(other.d, d)) &&
            (identical(other.e, e) ||
                const DeepCollectionEquality().equals(other.e, e)) &&
            (identical(other.nd, nd) ||
                const DeepCollectionEquality().equals(other.nd, nd)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(scoreId) ^
      const DeepCollectionEquality().hash(d) ^
      const DeepCollectionEquality().hash(e) ^
      const DeepCollectionEquality().hash(nd);

  @JsonKey(ignore: true)
  @override
  _$ScoreCopyWith<_Score> get copyWith =>
      __$ScoreCopyWithImpl<_Score>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ScoreToJson(this);
  }
}

abstract class _Score implements ScoreDetail {
  const factory _Score({String scoreId, num d, num e, num nd}) = _$_Score;

  factory _Score.fromJson(Map<String, dynamic> json) = _$_Score.fromJson;

  @override
  String get scoreId => throw _privateConstructorUsedError;
  @override //playerIdと一致
  num get d => throw _privateConstructorUsedError;
  @override
  num get e => throw _privateConstructorUsedError;
  @override
  num get nd => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ScoreCopyWith<_Score> get copyWith => throw _privateConstructorUsedError;
}
