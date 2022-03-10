import 'package:flutter_riverpod/flutter_riverpod.dart';

final largeImageStateProvider =
    StateNotifierProvider<LargeImageState, bool>((ref) => LargeImageState());

class LargeImageState extends StateNotifier<bool> {
  LargeImageState() : super(false);

  void toSmall() {
    state = false;
  }

  void toBig() {
    state = true;
  }
}
