import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/widgets/loading_screen.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/screens/create_new_game/create_new_game_screen.dart';
import 'package:record_game_app/screens/home_screens/match_list_screen/match_list_state.dart';
import 'package:record_game_app/screens/team_list_screen/team_list_screen.dart';
import 'package:record_game_app/screens/loading_state.dart';

final _searchMatchController = TextEditingController();

class MatchListScreen extends HookWidget {
  const MatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isLoading = useProvider(loadingStateProvider);
    final _appUser = useProvider(appUserStateProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('試合'),
          actions: [
            IconButton(
              onPressed: () async {
                _appUser.email == ''
                    ? await showOkAlertDialog(
                        context: context,
                        title: 'ユーザー登録をして、\n試合を記録しましょう！',
                        message: 'アカウントページより\n新規登録、ログインできます。',
                      )
                    : Navigator.push<Widget>(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateNewGameScreen()));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Stack(children: [
          const MatchListView(),
          _isLoading ? const LoadingScreen() : Container(),
        ]),
      ),
    );
  }
}

class MatchListView extends HookWidget {
  const MatchListView({Key? key}) : super(key: key);

  Widget _adWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(height: 50, color: Colors.pink),
    );
  }

  Widget _searchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 8, left: 8),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: TextField(
            controller: _searchMatchController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '試合名で検索',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ),
    );
  }

  Widget _matchTile(BuildContext context, Game game, bool isLast) {
    return Column(children: [
      ListTile(
        onTap: () => Navigator.push<Widget>(
            context,
            MaterialPageRoute(
              builder: (context) => TeamListScreen(game: game),
            )),
        leading: Text(
          '${game.heldAt!.month}/${game.heldAt!.day}',
          textAlign: TextAlign.center,
        ),
        title: Text(
          game.gameTitle,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      isLast ? _adWidget() : Container(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final _loadingStateModel = useProvider(loadingStateProvider.notifier);
    final _matchListModel = useProvider(matchListStateProvider.notifier);
    final _matchList = useProvider(matchListStateProvider);

    return RefreshIndicator(
      onRefresh: () async {
        _loadingStateModel.startLoading();
        await _matchListModel.fetchMatches();
        _loadingStateModel.endLoading();
      },
      child: Column(children: [
        _searchField(context),
        _matchList.isEmpty
            ? _adWidget()
            : Expanded(
                child: ListView.builder(
                  itemCount: _matchList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _matchTile(
                      context,
                      _matchList[index],
                      index == _matchList.length - 1,
                    );
                  },
                ),
              ),
      ]),
    );
  }
}
