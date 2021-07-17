import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/widgets/ad_widget.dart';
import 'package:record_game_app/common/widgets/game_document.dart';
import 'package:record_game_app/common/widgets/loading_screen.dart';
import 'package:record_game_app/common/widgets/search_text_field.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/screens/create_new_match/create_new_match_screen.dart';
import 'package:record_game_app/screens/game_detail_screen/game_detail_argument.dart';
import 'package:record_game_app/screens/game_detail_screen/game_detail_screen.dart';
import 'package:record_game_app/screens/home_screens/match_list_screen/match_list_state.dart';
import 'package:record_game_app/common/loading_state.dart';

final _matchController = TextEditingController();

class MatchListScreen extends HookWidget {
  const MatchListScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute<Widget>(builder: (_) => const MatchListScreen());
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = useProvider(loadingStateProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('試合'),
          actions: [
            IconButton(
              onPressed: () async {
                await Navigator.of(context)
                    .push<Widget>(CreateNewMatchScreen.route());
              },
              icon: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
        body: Stack(children: [
          const MatchListView(),
          const AdWidget(),
          _isLoading ? LoadingScreen(context) : Container(),
        ]),
      ),
    );
  }
}

class MatchListView extends HookWidget {
  const MatchListView({Key? key}) : super(key: key);

  Widget _searchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchTextField(
        controller: _matchController,
        hintText: '試合名で検索',
      ),
    );
  }

  Widget _matchTile(BuildContext context, Game game) {
    return InkWell(
      onTap: () => Navigator.of(context).push<Widget>(
        GameDetailScreen.route(
            gameDetailArgument: GameDetailArgument(game: game)),
      ),
      child: GameDocument(game: game),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _loadingStateModel = useProvider(loadingStateProvider.notifier);
    final _appUser = useProvider(appUserStateProvider);
    final _matchListModel = useProvider(matchListStateProvider.notifier);
    final _matchList = useProvider(matchListStateProvider);

    Future(() async {
      _loadingStateModel.startLoading();
      if (_matchList == null) {
        await _matchListModel.fetchMatches(_appUser);
      }
      _loadingStateModel.endLoading();
    });

    return RefreshIndicator(
      onRefresh: () async {
        _loadingStateModel.startLoading();
        await _matchListModel.fetchMatches(_appUser);
        _loadingStateModel.endLoading();
      },
      child: _matchList == null
          ? Container()
          : Column(children: [
              _searchField(context),
              Expanded(
                child: ListView.builder(
                  itemCount: _matchList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _matchTile(context, _matchList[index]);
                  },
                ),
              ),
            ]),
    );
  }
}
