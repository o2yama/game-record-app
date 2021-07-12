import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/widgets/loading_screen.dart';
import 'package:record_game_app/screens/create_new_game/create_new_game_screen.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up/sign_up_model.dart';
import 'package:record_game_app/states/loading_state.dart';
import '../../team_list_screen.dart';

final _searchController = TextEditingController();

class RehearsalListScreen extends HookWidget {
  Widget _searchField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'チェック名で検索',
                  hintStyle: TextStyle(color: Colors.black38),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            final textLength = _searchController.text.length - 1;
            _searchController.text =
                _searchController.text.substring(0, textLength);
          },
          icon: const Icon(Icons.backspace, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _rehearsalsListView(BuildContext context) {
    return Expanded(
      child: ListView(children: [
        _gameTile(context, 'インカレチェック１', DateTime.utc(2021, 8, 30)),
        _gameTile(context, 'インカレチェック２', DateTime.utc(2021, 8, 31)),
        _gameTile(context, '新人戦チェック', DateTime.utc(2021, 10, 1)),
      ]),
    );
  }

  Widget _gameTile(BuildContext context, String title, DateTime createdAt) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${createdAt.month}/${createdAt.day}',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      title: Text(title, style: Theme.of(context).textTheme.headline6),
      onTap: () {
        Navigator.push<Widget>(
            context,
            MaterialPageRoute(
                builder: (context) => TeamListScreen(gameTitle: title)));
      },
    );
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
                    : Navigator.push<Widget>(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNewGameScreen()));
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Column(children: [
                  const SizedBox(height: 8),
                  _searchField(context),
                  _rehearsalsListView(context),
                ]),
                _isLoading ? LoadingScreen() : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
