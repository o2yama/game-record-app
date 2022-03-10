import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/widgets/ad_widget.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_screen.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_state.dart';
import 'package:record_game_app/common/widgets/simple_text_field.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/screens/create_game_rehearsal/create_new_game_screen.dart';
import 'package:record_game_app/screens/game_detail_screen/team_list_argument.dart';
import 'package:record_game_app/screens/game_detail_screen/team_list_screen.dart';
import 'package:record_game_app/screens/home_screens/match_list_screen/game_document.dart';
import 'package:record_game_app/screens/home_screens/rehearsal_list_screen/rehearsal_list_state.dart';

final _rehearsalController = TextEditingController();

class RehearsalListScreen extends HookWidget {
  const RehearsalListScreen({Key? key, required this.gameType})
      : super(key: key);
  final GameType gameType;

  static Route<dynamic> route(GameType gameType) {
    return MaterialPageRoute<Widget>(
        builder: (_) => RehearsalListScreen(gameType: gameType));
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = useProvider(loadingStateProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('試技会'),
          actions: [
            IconButton(
              onPressed: () async {
                await Navigator.of(context)
                    .push<Widget>(CreateNewGameScreen.route(gameType));
              },
              icon: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
        body: Stack(children: [
          const RehearsalListView(),
          const AdWidget(),
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
      child: SimpleTextField(
        controller: _rehearsalController,
        hintText: 'チェック名で検索',
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget _rehearsalTile(BuildContext context, Game game) {
    return InkWell(
      onTap: () => Navigator.of(context).push<Widget>(
        TeamListScreen.route(teamListArgument: TeamListArgument(game: game)),
      ),
      child: GameDocument(game: game),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _loadingStateModel = useProvider(loadingStateProvider.notifier);
    final _appUser = useProvider(appUserStateProvider);
    final _rehearsalListModel =
        useProvider(rehearsalListStateProvider.notifier);
    final _rehearsalList = useProvider(rehearsalListStateProvider);

    Future(() async {
      _loadingStateModel.startLoading();
      if (_rehearsalList == null) {
        await _rehearsalListModel.fetchRehearsals(_appUser);
      }
      _loadingStateModel.endLoading();
    });

    return RefreshIndicator(
      onRefresh: () async {
        _loadingStateModel.startLoading();
        await _rehearsalListModel.fetchRehearsals(_appUser);
        _loadingStateModel.endLoading();
      },
      child: _rehearsalList == null
          ? Container()
          : Column(children: [
              _searchField(context),
              Expanded(
                child: ListView.builder(
                  itemCount: _rehearsalList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _rehearsalTile(context, _rehearsalList[index]);
                  },
                ),
              ),
            ]),
    );
  }
}
