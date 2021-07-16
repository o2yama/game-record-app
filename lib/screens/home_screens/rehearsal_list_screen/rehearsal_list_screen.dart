import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/widgets/ad_widget.dart';
import 'package:record_game_app/common/widgets/loading_screen.dart';
import 'package:record_game_app/common/widgets/search_text_field.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/screens/create_new_rehearsal/create_new_rehearsal_screen.dart';
import 'package:record_game_app/screens/game_detail_screen/game_detail_argument.dart';
import 'package:record_game_app/screens/game_detail_screen/game_detail_screen.dart';
import 'package:record_game_app/screens/home_screens/rehearsal_list_screen/rehearsal_list_state.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up/sign_up_model.dart';
import 'package:record_game_app/common/loading_state.dart';

final _rehearsalController = TextEditingController();

class RehearsalListScreen extends HookWidget {
  const RehearsalListScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute<Widget>(
        builder: (_) => const RehearsalListScreen());
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = useProvider(loadingStateProvider);
    final _signUpModel = useProvider(signUpModelProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('試技会'),
          actions: [
            IconButton(
              onPressed: () async {
                _signUpModel.authRepository.authUser!.email == ''
                    ? await showOkAlertDialog(
                        context: context,
                        title: 'ユーザー登録をして、\n試合を記録しましょう！',
                        message: 'アカウントページより\n新規登録、ログインできます。',
                      )
                    : Navigator.of(context)
                        .push<Widget>(CreateNewRehearsalScreen.route());
              },
              icon: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
        body: Stack(children: [
          const RehearsalListView(),
          _isLoading ? const LoadingScreen() : Container(),
        ]),
      ),
    );
  }
}

class RehearsalListView extends HookWidget {
  const RehearsalListView({Key? key}) : super(key: key);

  Widget _searchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchTextField(
        controller: _rehearsalController,
        hintText: 'チェック名で検索',
      ),
    );
  }

  Widget _rehearsalTile(BuildContext context, Game game, bool isLast) {
    return Column(children: [
      ListTile(
        onTap: () => Navigator.of(context).push<Widget>(
          GameDetailScreen.route(
              gameDetailArgument: GameDetailArgument(game: game)),
        ),
        leading: Text(
          '${game.heldAt!.month}/${game.heldAt!.day}',
          textAlign: TextAlign.center,
        ),
        title: Text(
          game.gameTitle,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      isLast ? const AdWidget() : Container(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final _loadingStateModel = useProvider(loadingStateProvider.notifier);
    final _rehearsalListModel =
        useProvider(rehearsalListStateProvider.notifier);
    final _rehearsalList = useProvider(rehearsalListStateProvider);

    return RefreshIndicator(
      onRefresh: () async {
        _loadingStateModel.startLoading();
        await _rehearsalListModel.fetchRehearsals();
        _loadingStateModel.endLoading();
      },
      child: _rehearsalList.isEmpty
          ? Column(children: [
              _searchField(context),
              const Expanded(child: SizedBox()),
              const AdWidget(),
            ])
          : Column(children: [
              _searchField(context),
              Expanded(
                child: ListView.builder(
                  itemCount: _rehearsalList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _rehearsalTile(
                      context,
                      _rehearsalList[index],
                      index == _rehearsalList.length - 1,
                    );
                  },
                ),
              ),
            ]),
    );
  }
}
