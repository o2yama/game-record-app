import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/screens/home_screens/account_screen/account_screen.dart';
import 'package:record_game_app/screens/home_screens/game_list_screen/game_list_screen.dart';
import 'package:record_game_app/screens/home_screens/rehearsal_list_screen/rehearsal_list_screen.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up/sign_up_model.dart';
import 'package:record_game_app/states/loading_state.dart';

import 'favorite_games_screen/favorite_games_screen.dart';

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _loadingStateModel = useProvider(loadingStateProvider.notifier);
    final _signUpModel = useProvider(signUpModelProvider);

    Future(() async {
      if (!_signUpModel.isFetchedUserData) {
        _loadingStateModel.startLoading();
        await _signUpModel.getUserData();
        _loadingStateModel.endLoading();
      }
    });

    return Stack(
      children: [
        CupertinoTabScaffold(
          tabBar: CupertinoTabBar(items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '試合',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '試技会',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded),
              label: 'お気に入り',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'アカウント',
            ),
          ]),
          tabBuilder: (context, index) {
            if (index == 0) {
              return CupertinoTabView(
                builder: (context) =>
                    CupertinoPageScaffold(child: GameListScreen()),
              );
            } else if (index == 1) {
              return CupertinoTabView(
                builder: (context) =>
                    CupertinoPageScaffold(child: RehearsalListScreen()),
              );
            } else if (index == 2) {
              return CupertinoTabView(
                builder: (context) =>
                    CupertinoPageScaffold(child: FavoriteGamesScreen()),
              );
            } else if (index == 3) {
              return CupertinoTabView(
                builder: (context) =>
                    CupertinoPageScaffold(child: AccountScreen()),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
