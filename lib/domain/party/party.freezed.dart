// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'party.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Party _$PartyFromJson(Map<String, dynamic> json) {
  return _Party.fromJson(json);
}

/// @nodoc
class _$PartyTearOff {
  const _$PartyTearOff();

  _Party call(
      {String partyId = '',
      String partyName = '',
      bool isTeam = false,
      num teamTotal = 0,
      List<String> playerIds = const <String>[]}) {
    return _Party(
      partyId: partyId,
      partyName: partyName,
      isTeam: isTeam,
      teamTotal: teamTotal,
      playerIds: playerIds,
    );
  }

  Party fromJson(Map<String, Object> json) {
    return Party.fromJson(json);
  }
}

/// @nodoc
const $Party = _$PartyTearOff();

/// @nodoc
mixin _$Party {
  String get partyId => throw _privateConstructorUsedError;
  String get partyName => throw _privateConstructorUsedError;
  bool get isTeam => throw _privateConstructorUsedError;
  num get teamTotal => throw _privateConstructorUsedError;
  List<String> get playerIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PartyCopyWith<Party> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyCopyWith<$Res> {
  factory $PartyCopyWith(Party value, $Res Function(Party) then) =
      _$PartyCopyWithImpl<$Res>;
  $Res call(
      {String partyId,
      String partyName,
      bool isTeam,
      num teamTotal,
      List<String> playerIds});
}

/// @nodoc
class _$PartyCopyWithImpl<$Res> implements $PartyCopyWith<$Res> {
  _$PartyCopyWithImpl(this._value, this._then);

  final Party _value;
  // ignore: unused_field
  final $Res Function(Party) _then;

  @override
  $Res call({
    Object? partyId = freezed,
    Object? partyName = freezed,
    Object? isTeam = freezed,
    Object? teamTotal = freezed,
    Object? playerIds = freezed,
  }) {
    return _then(_value.copyWith(
      partyId: partyId == freezed
          ? _value.partyId
          : partyId // ignore: cast_nullable_to_non_nullable
              as String,
      partyName: partyName == freezed
          ? _value.partyName
          : partyName // ignore: cast_nullable_to_non_nullable
              as String,
      isTeam: isTeam == freezed
          ? _value.isTeam
          : isTeam // ignore: cast_nullable_to_non_nullable
              as bool,
      teamTotal: teamTotal == freezed
          ? _value.teamTotal
          : teamTotal // ignore: cast_nullable_to_non_nullable
              as num,
      playerIds: playerIds == freezed
          ? _value.playerIds
          : playerIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$PartyCopyWith<$Res> implements $PartyCopyWith<$Res> {
  factory _$PartyCopyWith(_Party value, $Res Function(_Party) then) =
      __$PartyCopyWithImpl<$Res>;
  @override
  $Res call(
      {String partyId,
      String partyName,
      bool isTeam,
      num teamTotal,
      List<String> playerIds});
}

/// @nodoc
class __$PartyCopyWithImpl<$Res> extends _$PartyCopyWithImpl<$Res>
    implements _$PartyCopyWith<$Res> {
  __$PartyCopyWithImpl(_Party _value, $Res Function(_Party) _then)
      : super(_value, (v) => _then(v as _Party));

  @override
  _Party get _value => super._value as _Party;

  @override
  $Res call({
    Object? partyId = freezed,
    Object? partyName = freezed,
    Object? isTeam = freezed,
    Object? teamTotal = freezed,
    Object? playerIds = freezed,
  }) {
    return _then(_Party(
      partyId: partyId == freezed
          ? _value.partyId
          : partyId // ignore: cast_nullable_to_non_nullable
              as String,
      partyName: partyName == freezed
          ? _value.partyName
          : partyName // ignore: cast_nullable_to_non_nullable
              as String,
      isTeam: isTeam == freezed
          ? _value.isTeam
          : isTeam // ignore: cast_nullable_to_non_nullable
              as bool,
      teamTotal: teamTotal == freezed
          ? _value.teamTotal
          : teamTotal // ignore: cast_nullable_to_non_nullable
              as num,
      playerIds: playerIds == freezed
          ? _value.playerIds
          : playerIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Party implements _Party {
  const _$_Party(
      {this.partyId = '',
      this.partyName = '',
      this.isTeam = false,
      this.teamTotal = 0,
      this.playerIds = const <String>[]});

  factory _$_Party.fromJson(Map<String, dynamic> json) =>
      _$_$_PartyFromJson(json);

  @JsonKey(defaultValue: '')
  @override
  final String partyId;
  @JsonKey(defaultValue: '')
  @override
  final String partyName;
  @JsonKey(defaultValue: false)
  @override
  final bool isTeam;
  @JsonKey(defaultValue: 0)
  @override
  final num teamTotal;
  @JsonKey(defaultValue: const <String>[])
  @override
  final List<String> playerIds;

  @override
  String toString() {
    return 'Party(partyId: $partyId, partyName: $partyName, isTeam: $isTeam, teamTotal: $teamTotal, playerIds: $playerIds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Party &&
            (identical(other.partyId, partyId) ||
                const DeepCollectionEquality()
                    .equals(other.partyId, partyId)) &&
            (identical(other.partyName, partyName) ||
                const DeepCollectionEquality()
                    .equals(other.partyName, partyName)) &&
            (identical(other.isTeam, isTeam) ||
                const DeepCollectionEquality().equals(other.isTeam, isTeam)) &&
            (identical(other.teamTotal, teamTotal) ||
                const DeepCollectionEquality()
                    .equals(other.teamTotal, teamTotal)) &&
            (identical(other.playerIds, playerIds) ||
                const DeepCollectionEquality()
                    .equals(other.playerIds, playerIds)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(partyId) ^
      const DeepCollectionEquality().hash(partyName) ^
      const DeepCollectionEquality().hash(isTeam) ^
      const DeepCollectionEquality().hash(teamTotal) ^
      const DeepCollectionEquality().hash(playerIds);

  @JsonKey(ignore: true)
  @override
  _$PartyCopyWith<_Party> get copyWith =>
      __$PartyCopyWithImpl<_Party>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PartyToJson(this);
  }
}

abstract class _Party implements Party {
  const factory _Party(
      {String partyId,
      String partyName,
      bool isTeam,
      num teamTotal,
      List<String> playerIds}) = _$_Party;

  factory _Party.fromJson(Map<String, dynamic> json) = _$_Party.fromJson;

  @override
  String get partyId => throw _privateConstructorUsedError;
  @override
  String get partyName => throw _privateConstructorUsedError;
  @override
  bool get isTeam => throw _privateConstructorUsedError;
  @override
  num get teamTotal => throw _privateConstructorUsedError;
  @override
  List<String> get playerIds => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PartyCopyWith<_Party> get copyWith => throw _privateConstructorUsedError;
}
