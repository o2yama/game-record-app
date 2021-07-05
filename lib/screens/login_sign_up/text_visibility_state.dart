import 'package:flutter_riverpod/flutter_riverpod.dart';

final textVisibilityProvider =
    StateNotifierProvider.autoDispose((ref) => TextVisibilityState());

class TextVisibilityState extends StateNotifier<bool> {
  TextVisibilityState() : super(false);

  void changeVisibility() {
    state ? state = false : state = true;
  }
}
