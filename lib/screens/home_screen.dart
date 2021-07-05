import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_sign_up/sign_up_screen.dart';

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.backspace,
                color: Colors.white,
              ),
            ),
            IconButton(
                icon: Icon(Icons.login),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                        fullscreenDialog: true,
                      ));
                }),
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
