import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/restart_widget.dart';
import 'package:record_game_app/common/widgets/loading_screen.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up/sign_up_model.dart';
import 'package:record_game_app/states/loading_state.dart';

class AccountScreen extends HookWidget {
  AccountScreen({Key? key}) : super(key: key);

  Widget accountTile(
      BuildContext context, String name, String email, File? userImage) {
    return SizedBox(
      height: 70,
      child: ListTile(
        onTap: () {
          //todo:アカウント情報の変更
        },
        leading: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: userImage != null
              ? CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(userImage.path),
                  backgroundColor: Colors.grey,
                )
              : const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('images/account.png'),
                  backgroundColor: Colors.grey,
                ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.headline5),
            Text(email != '' ? email : 'ログインしてください',
                style: const TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = useProvider<bool>(loadingStateProvider);
    final _signUpModel = useProvider(signUpModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('アカウント')),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 8),
              accountTile(
                context,
                _signUpModel.name,
                '__appUserModelのemail渡す',
                _signUpModel.userImage,
              ),
              const Divider(color: Colors.black54),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () async {
                  context.read(loadingStateProvider.notifier).startLoading();
                  await _signUpModel.signOut();
                  context.read(loadingStateProvider.notifier).endLoading();
                  RestartWidget.restartApp(context);
                },
                style:
                    TextButton.styleFrom(side: BorderSide.none, elevation: 0),
                child: const Text('サインアウト'),
              ),
            ]),
          ),
          _isLoading ? LoadingScreen() : Container(),
        ],
      ),
    );
  }
}
