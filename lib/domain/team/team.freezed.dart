// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Team _$TeamFromJson(Map<String, dynamic> json) {
  return _Team.fromJson(json);
}

/// @nodoc
class _$TeamTearOff {
  const _$TeamTearOff();

  _Team call(
      {String teamId = '',
      String teamName = '',
      bool isTeam = false,
      num? teamTotal}) {
    return _Team(
      teamId: teamId,
      teamName: teamName,
      isTeam: isTeam,
      teamTotal: teamTotal,
    );
  }

  Team fromJson(Map<String, Object> json) {
    return Team.fromJson(json);
  }
}

/// @nodoc
const $Team = _$TeamTearOff();

/// @nodoc
mixin _$Team {
  String get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  bool get isTeam => throw _privateConstructorUsedError;
  num? get teamTotal => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamCopyWith<Team> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamCopyWith<$Res> {
  factory $TeamCopyWith(Team value, $Res Function(Team) then) =
      _$TeamCopyWithImpl<$Res>;
  $Res call({String teamId, String teamName, bool isTeam, num? teamTotal});
}

/// @nodoc
class _$TeamCopyWithImpl<$Res> implements $TeamCopyWith<$Res> {
  _$TeamCopyWithImpl(this._value, this._then);

  final Team _value;
  // ignore: unused_field
  final $Res Function(Team) _then;

  @override
  $Res call({
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? isTeam = freezed,
    Object? teamTotal = freezed,
  }) {
    return _then(_value.copyWith(
      teamId: teamId == freezed
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: teamName == freezed
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      isTeam: isTeam == freezed
          ? _value.isTeam
          : isTeam // ignore: cast_nullable_to_non_nullable
              as bool,
      teamTotal: teamTotal == freezed
          ? _value.teamTotal
          : teamTotal // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
abstract class _$TeamCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$TeamCopyWith(_Team value, $Res Function(_Team) then) =
      __$TeamCopyWithImpl<$Res>;
  @override
  $Res call({String teamId, String teamName, bool isTeam, num? teamTotal});
}

/// @nodoc
class __$TeamCopyWithImpl<$Res> extends _$TeamCopyWithImpl<$Res>
    implements _$TeamCopyWith<$Res> {
  __$TeamCopyWithImpl(_Team _value, $Res Function(_Team) _then)
      : super(_value, (v) => _then(v as _Team));

  @override
  _Team get _value => super._value as _Team;

  @override
  $Res call({
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? isTeam = freezed,
    Object? teamTotal = freezed,
  }) {
    return _then(_Team(
      teamId: teamId == freezed
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: teamName == freezed
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      isTeam: isTeam == freezed
          ? _value.isTeam
          : isTeam // ignore: cast_nullable_to_non_nullable
              as bool,
      teamTotal: teamTotal == freezed
          ? _value.teamTotal
          : teamTotal // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Team implements _Team {
  const _$_Team(
      {this.teamId = '',
      this.teamName = '',
      this.isTeam = false,
      this.teamTotal});

  factory _$_Team.fromJson(Map<String, dynamic> json) =>
      _$_$_TeamFromJson(json);

  @JsonKey(defaultValue: '')
  @override
  final String teamId;
  @JsonKey(defaultValue: '')
  @override
  final String teamName;
  @JsonKey(defaultValue: false)
  @override
  final bool isTeam;
  @override
  final num? teamTotal;

  @override
  String toString() {
    return 'Team(teamId: $teamId, teamName: $teamName, '
        'isTeam: $isTeam, teamTotal: $teamTotal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Team &&
            (identical(other.teamId, teamId) ||
                const DeepCollectionEquality().equals(other.teamId, teamId)) &&
            (identical(other.teamName, teamName) ||
                const DeepCollectionEquality()
                    .equals(other.teamName, teamName)) &&
            (identical(other.isTeam, isTeam) ||
                const DeepCollectionEquality().equals(other.isTeam, isTeam)) &&
            (identical(other.teamTotal, teamTotal) ||
                const DeepCollectionEquality()
                    .equals(other.teamTotal, teamTotal)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(teamId) ^
      const DeepCollectionEquality().hash(teamName) ^
      const DeepCollectionEquality().hash(isTeam) ^
      const DeepCollectionEquality().hash(teamTotal);

  @JsonKey(ignore: true)
  @override
  _$TeamCopyWith<_Team> get copyWith =>
      __$TeamCopyWithImpl<_Team>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TeamToJson(this);
  }
}

abstract class _Team implements Team {
  const factory _Team(
      {String teamId, String teamName, bool isTeam, num? teamTotal}) = _$_Team;

  factory _Team.fromJson(Map<String, dynamic> json) = _$_Team.fromJson;

  @override
  String get teamId => throw _privateConstructorUsedError;
  @override
  String get teamName => throw _privateConstructorUsedError;
  @override
  bool get isTeam => throw _privateConstructorUsedError;
  @override
  num? get teamTotal => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TeamCopyWith<_Team> get copyWith => throw _privateConstructorUsedError;
}
