import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/widgets/restart_widget.dart';
import 'package:record_game_app/common/widgets/loading_screen.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/common/loading_state.dart';

class AccountScreen extends HookWidget {
  const AccountScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute<Widget>(builder: (_) => const AccountScreen());
  }

  Widget accountTile(
      BuildContext context, String name, String email, String? imageUrl) {
    return SizedBox(
      height: 80,
      child: ListTile(
        onTap: () {
          //todo:アカウント情報の変更
        },
        leading: imageUrl!.isNotEmpty
            ? CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: Colors.grey,
              )
            : const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/account.png'),
                backgroundColor: Colors.grey,
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
    final _appUser = useProvider(appUserStateProvider);
    final _appUserModel = useProvider(appUserStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('アカウント')),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 8),
              accountTile(
                  context, _appUser.name, _appUser.email, _appUser.imageUrl),
              const Divider(color: Colors.black54),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () async {
                  context.read(loadingStateProvider.notifier).startLoading();
                  await _appUserModel.signOut();
                  context.read(loadingStateProvider.notifier).endLoading();
                  RestartWidget.restartApp(context);
                },
                style:
                    TextButton.styleFrom(side: BorderSide.none, elevation: 0),
                child: const Text('サインアウト'),
              ),
            ]),
          ),
          _isLoading ? const LoadingScreen() : Container(),
        ],
      ),
    );
  }
}
