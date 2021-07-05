import 'package:flutter_riverpod/flutter_riverpod.dart';

final textVisibilityProvider =
    StateNotifierProvider.autoDispose((ref) => TextVisibilityController());

class TextVisibilityController extends StateNotifier<bool> {
  TextVisibilityController() : super(false);

  void changeVisibility() {
    state ? state = false : state = true;
  }
}
