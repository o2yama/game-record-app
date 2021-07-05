import 'package:hooks_riverpod/hooks_riverpod.dart';

final loadingStateProvider =
    StateNotifierProvider.autoDispose((ref) => LoadingState());

class LoadingState extends StateNotifier<bool> {
  LoadingState() : super(false);

  void startLoading() {
    state = true;
  }

  void endLoading() {
    state = false;
  }
}
