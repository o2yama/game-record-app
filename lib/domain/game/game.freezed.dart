// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Game _$GameFromJson(Map<String, dynamic> json) {
  return _Game.fromJson(json);
}

/// @nodoc
class _$GameTearOff {
  const _$GameTearOff();

  _Game call(
      {String gameId = '',
      String gameTitle = '',
      DateTime? heldAt,
      bool isRehearsal = true,
      String editorKey = '',
      String readerKey = '',
      List<String> editorIds = const <String>[],
      List<String> readerIds = const <String>[],
      List<String> partyIds = const <String>[]}) {
    return _Game(
      gameId: gameId,
      gameTitle: gameTitle,
      heldAt: heldAt,
      isRehearsal: isRehearsal,
      editorKey: editorKey,
      readerKey: readerKey,
      editorIds: editorIds,
      readerIds: readerIds,
      partyIds: partyIds,
    );
  }

  Game fromJson(Map<String, Object> json) {
    return Game.fromJson(json);
  }
}

/// @nodoc
const $Game = _$GameTearOff();

/// @nodoc
mixin _$Game {
  String get gameId => throw _privateConstructorUsedError;
  String get gameTitle => throw _privateConstructorUsedError;
  DateTime? get heldAt => throw _privateConstructorUsedError;
  bool get isRehearsal => throw _privateConstructorUsedError;
  String get editorKey => throw _privateConstructorUsedError;
  String get readerKey => throw _privateConstructorUsedError;
  List<String> get editorIds => throw _privateConstructorUsedError;
  List<String> get readerIds => throw _privateConstructorUsedError;
  List<String> get partyIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res>;
  $Res call(
      {String gameId,
      String gameTitle,
      DateTime? heldAt,
      bool isRehearsal,
      String editorKey,
      String readerKey,
      List<String> editorIds,
      List<String> readerIds,
      List<String> partyIds});
}

/// @nodoc
class _$GameCopyWithImpl<$Res> implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  final Game _value;
  // ignore: unused_field
  final $Res Function(Game) _then;

  @override
  $Res call({
    Object? gameId = freezed,
    Object? gameTitle = freezed,
    Object? heldAt = freezed,
    Object? isRehearsal = freezed,
    Object? editorKey = freezed,
    Object? readerKey = freezed,
    Object? editorIds = freezed,
    Object? readerIds = freezed,
    Object? partyIds = freezed,
  }) {
    return _then(_value.copyWith(
      gameId: gameId == freezed
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      gameTitle: gameTitle == freezed
          ? _value.gameTitle
          : gameTitle // ignore: cast_nullable_to_non_nullable
              as String,
      heldAt: heldAt == freezed
          ? _value.heldAt
          : heldAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isRehearsal: isRehearsal == freezed
          ? _value.isRehearsal
          : isRehearsal // ignore: cast_nullable_to_non_nullable
              as bool,
      editorKey: editorKey == freezed
          ? _value.editorKey
          : editorKey // ignore: cast_nullable_to_non_nullable
              as String,
      readerKey: readerKey == freezed
          ? _value.readerKey
          : readerKey // ignore: cast_nullable_to_non_nullable
              as String,
      editorIds: editorIds == freezed
          ? _value.editorIds
          : editorIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      readerIds: readerIds == freezed
          ? _value.readerIds
          : readerIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      partyIds: partyIds == freezed
          ? _value.partyIds
          : partyIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$GameCopyWith(_Game value, $Res Function(_Game) then) =
      __$GameCopyWithImpl<$Res>;
  @override
  $Res call(
      {String gameId,
      String gameTitle,
      DateTime? heldAt,
      bool isRehearsal,
      String editorKey,
      String readerKey,
      List<String> editorIds,
      List<String> readerIds,
      List<String> partyIds});
}

/// @nodoc
class __$GameCopyWithImpl<$Res> extends _$GameCopyWithImpl<$Res>
    implements _$GameCopyWith<$Res> {
  __$GameCopyWithImpl(_Game _value, $Res Function(_Game) _then)
      : super(_value, (v) => _then(v as _Game));

  @override
  _Game get _value => super._value as _Game;

  @override
  $Res call({
    Object? gameId = freezed,
    Object? gameTitle = freezed,
    Object? heldAt = freezed,
    Object? isRehearsal = freezed,
    Object? editorKey = freezed,
    Object? readerKey = freezed,
    Object? editorIds = freezed,
    Object? readerIds = freezed,
    Object? partyIds = freezed,
  }) {
    return _then(_Game(
      gameId: gameId == freezed
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      gameTitle: gameTitle == freezed
          ? _value.gameTitle
          : gameTitle // ignore: cast_nullable_to_non_nullable
              as String,
      heldAt: heldAt == freezed
          ? _value.heldAt
          : heldAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isRehearsal: isRehearsal == freezed
          ? _value.isRehearsal
          : isRehearsal // ignore: cast_nullable_to_non_nullable
              as bool,
      editorKey: editorKey == freezed
          ? _value.editorKey
          : editorKey // ignore: cast_nullable_to_non_nullable
              as String,
      readerKey: readerKey == freezed
          ? _value.readerKey
          : readerKey // ignore: cast_nullable_to_non_nullable
              as String,
      editorIds: editorIds == freezed
          ? _value.editorIds
          : editorIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      readerIds: readerIds == freezed
          ? _value.readerIds
          : readerIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      partyIds: partyIds == freezed
          ? _value.partyIds
          : partyIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Game implements _Game {
  const _$_Game(
      {this.gameId = '',
      this.gameTitle = '',
      this.heldAt,
      this.isRehearsal = true,
      this.editorKey = '',
      this.readerKey = '',
      this.editorIds = const <String>[],
      this.readerIds = const <String>[],
      this.partyIds = const <String>[]});

  factory _$_Game.fromJson(Map<String, dynamic> json) =>
      _$_$_GameFromJson(json);

  @JsonKey(defaultValue: '')
  @override
  final String gameId;
  @JsonKey(defaultValue: '')
  @override
  final String gameTitle;
  @override
  final DateTime? heldAt;
  @JsonKey(defaultValue: true)
  @override
  final bool isRehearsal;
  @JsonKey(defaultValue: '')
  @override
  final String editorKey;
  @JsonKey(defaultValue: '')
  @override
  final String readerKey;
  @JsonKey(defaultValue: const <String>[])
  @override
  final List<String> editorIds;
  @JsonKey(defaultValue: const <String>[])
  @override
  final List<String> readerIds;
  @JsonKey(defaultValue: const <String>[])
  @override
  final List<String> partyIds;

  @override
  String toString() {
    return 'Game(gameId: $gameId, gameTitle: $gameTitle, heldAt: $heldAt, isRehearsal: $isRehearsal, editorKey: $editorKey, readerKey: $readerKey, editorIds: $editorIds, readerIds: $readerIds, partyIds: $partyIds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Game &&
            (identical(other.gameId, gameId) ||
                const DeepCollectionEquality().equals(other.gameId, gameId)) &&
            (identical(other.gameTitle, gameTitle) ||
                const DeepCollectionEquality()
                    .equals(other.gameTitle, gameTitle)) &&
            (identical(other.heldAt, heldAt) ||
                const DeepCollectionEquality().equals(other.heldAt, heldAt)) &&
            (identical(other.isRehearsal, isRehearsal) ||
                const DeepCollectionEquality()
                    .equals(other.isRehearsal, isRehearsal)) &&
            (identical(other.editorKey, editorKey) ||
                const DeepCollectionEquality()
                    .equals(other.editorKey, editorKey)) &&
            (identical(other.readerKey, readerKey) ||
                const DeepCollectionEquality()
                    .equals(other.readerKey, readerKey)) &&
            (identical(other.editorIds, editorIds) ||
                const DeepCollectionEquality()
                    .equals(other.editorIds, editorIds)) &&
            (identical(other.readerIds, readerIds) ||
                const DeepCollectionEquality()
                    .equals(other.readerIds, readerIds)) &&
            (identical(other.partyIds, partyIds) ||
                const DeepCollectionEquality()
                    .equals(other.partyIds, partyIds)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(gameId) ^
      const DeepCollectionEquality().hash(gameTitle) ^
      const DeepCollectionEquality().hash(heldAt) ^
      const DeepCollectionEquality().hash(isRehearsal) ^
      const DeepCollectionEquality().hash(editorKey) ^
      const DeepCollectionEquality().hash(readerKey) ^
      const DeepCollectionEquality().hash(editorIds) ^
      const DeepCollectionEquality().hash(readerIds) ^
      const DeepCollectionEquality().hash(partyIds);

  @JsonKey(ignore: true)
  @override
  _$GameCopyWith<_Game> get copyWith =>
      __$GameCopyWithImpl<_Game>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GameToJson(this);
  }
}

abstract class _Game implements Game {
  const factory _Game(
      {String gameId,
      String gameTitle,
      DateTime? heldAt,
      bool isRehearsal,
      String editorKey,
      String readerKey,
      List<String> editorIds,
      List<String> readerIds,
      List<String> partyIds}) = _$_Game;

  factory _Game.fromJson(Map<String, dynamic> json) = _$_Game.fromJson;

  @override
  String get gameId => throw _privateConstructorUsedError;
  @override
  String get gameTitle => throw _privateConstructorUsedError;
  @override
  DateTime? get heldAt => throw _privateConstructorUsedError;
  @override
  bool get isRehearsal => throw _privateConstructorUsedError;
  @override
  String get editorKey => throw _privateConstructorUsedError;
  @override
  String get readerKey => throw _privateConstructorUsedError;
  @override
  List<String> get editorIds => throw _privateConstructorUsedError;
  @override
  List<String> get readerIds => throw _privateConstructorUsedError;
  @override
  List<String> get partyIds => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GameCopyWith<_Game> get copyWith => throw _privateConstructorUsedError;
}
