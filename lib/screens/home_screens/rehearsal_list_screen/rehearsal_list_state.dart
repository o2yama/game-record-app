import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/domain/game/game.dart';

class RehearsalListState extends StateNotifier<List<Game>> {
  RehearsalListState() : super(<Game>[]);

  Future<void> fetchRehearsals() async {}
}
