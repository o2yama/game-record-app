import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/domain/app_user.dart';
import 'login_sign_up/sign_up/sign_up_screen.dart';

TextEditingController searchController = TextEditingController();

class HomeScreen extends HookWidget {
  Widget _adWidget() {
    return SizedBox(
      height: 50,
    );
  }

  Widget searchField(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
        child: TextField(
          controller: searchController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: '試合名、日付で検索',
            hintStyle: TextStyle(color: Colors.black38),
          ),
        ),
      ),
    );
  }

  Widget _gamesListView() {
    return Expanded(
      child: ListView(
        children: [],
      ),
    );
  }

  Widget _gameTile(String title, DateTime createdAt) {
    return ListTile(
      leading: Text('$createdAt'),
      title: Text('$title'),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final _appUser = useProvider(appUserProvider);
    final _appUserModel = useProvider(appUserProvider.notifier);

    Future(() async {
      if (_appUser.userId == '') {
        await _appUserModel.getUserData();
      }
    });
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                //todo:searchControllerの中身1文字削除
              },
              icon: Icon(Icons.backspace, color: Colors.white),
            ),
            _appUser.userId == ''
                ? IconButton(
                    icon: Icon(Icons.login),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                            fullscreenDialog: true,
                          ));
                    })
                : Container(),
          ],
          title: searchField(context),
        ),
        body: Column(
          children: [
            _gamesListView(),
            _adWidget(),
          ],
        ),
      ),
    );
  }
}
