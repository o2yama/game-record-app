import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/widgets/loading_screen.dart';
import 'package:record_game_app/domain/game/game.dart';
import 'package:record_game_app/screens/create_new_game/create_new_game_screen.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up/sign_up_model.dart';
import 'package:record_game_app/screens/loading_state.dart';
import '../../team_list_screen/team_list_screen.dart';

final _searchRehearsalController = TextEditingController();

class RehearsalListScreen extends HookWidget {
  const RehearsalListScreen({Key? key}) : super(key: key);

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
                controller: _searchRehearsalController,
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
            final textLength = _searchRehearsalController.text.length - 1;
            _searchRehearsalController.text =
                _searchRehearsalController.text.substring(0, textLength);
          },
          icon: const Icon(Icons.backspace, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _rehearsalsListView(BuildContext context) {
    return Expanded(
      child: ListView(),
    );
  }

  Widget _gameTile(BuildContext context, Game game) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${game.heldAt!.month}/${game.heldAt!.day}',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      title: Text(game.gameTitle, style: Theme.of(context).textTheme.headline6),
      onTap: () {
        Navigator.push<Widget>(
            context,
            MaterialPageRoute(
                builder: (context) => TeamListScreen(game: game)));
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
                            builder: (context) => const CreateNewGameScreen()));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
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
                _isLoading ? const LoadingScreen() : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RehearsalListView extends HookWidget {
  const RehearsalListView({Key? key}) : super(key: key);

  Widget _adWidget() {
    return SizedBox(
      height: 50,
      child: Container(
        color: Colors.pink,
      ),
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
            controller: _searchRehearsalController,
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

  Widget _matchTile(BuildContext context, Game game) {
    return ListTile(
      onTap: () => Navigator.push<Widget>(
          context,
          MaterialPageRoute(
            builder: (context) => TeamListScreen(game: game),
          )),
      leading: Text(
        '${game.heldAt!.month}/${game.heldAt!.day}',
        textAlign: TextAlign.center,
      ),
      title: Text(game.gameTitle, style: Theme.of(context).textTheme.headline6),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
