import 'package:flutter_riverpod/flutter_riverpod.dart';

final textVisibilityProvider =
    StateNotifierProvider.autoDispose<TextVisibilityModel, bool>(
  (ref) => TextVisibilityModel(),
);

class TextVisibilityModel extends StateNotifier<bool> {
  TextVisibilityModel() : super(true);

  void changeVisibility() {
    state ? state = false : state = true;
  }
}
