import 'package:hooks_riverpod/hooks_riverpod.dart';

final loadingStateProvider = StateNotifierProvider<LoadingStateModel, bool>(
  (ref) => LoadingStateModel(),
);

class LoadingStateModel extends StateNotifier<bool> {
  LoadingStateModel() : super(false);

  void startLoading() {
    state = true;
  }

  void endLoading() {
    state = false;
  }
}
