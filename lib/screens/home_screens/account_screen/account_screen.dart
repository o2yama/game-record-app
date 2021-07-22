import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/widgets/ad_widget.dart';
import 'package:record_game_app/common/widgets/large_image/large_image_state.dart';
import 'package:record_game_app/common/widgets/restart_widget.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_screen.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_state.dart';

class AccountScreen extends HookWidget {
  const AccountScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute<Widget>(builder: (_) => const AccountScreen());
  }

  Widget accountTile(BuildContext context, String name, String? imageUrl) {
    return SizedBox(
      height: 80,
      child: ListTile(
        onTap: () {
          //todo:アカウント情報の変更
        },
        leading: imageUrl!.isNotEmpty
            ? GestureDetector(
                onTap: () =>
                    context.read(largeImageStateProvider.notifier).toBig(),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(imageUrl),
                  backgroundColor: Colors.grey,
                ),
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
            Text(name, style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
    );
  }

  Widget _signOutButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await showDialog<Widget>(
          context: context,
          builder: (context) => Platform.isIOS
              ? CupertinoAlertDialog(
                  title: const Text('本当にサインアウトしてもよろしいですか？'),
                  content: const Text('このアカウントで再度サインインするには、'
                      'ご登録のメールアドレスと、パスワードが必要です。'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('キャンセル'),
                    ),
                    TextButton(
                      onPressed: () async {
                        context
                            .read(loadingStateProvider.notifier)
                            .startLoading();
                        await context
                            .read(appUserStateProvider.notifier)
                            .signOut();
                        context
                            .read(loadingStateProvider.notifier)
                            .endLoading();
                        RestartWidget.restartApp(context);
                      },
                      child: const Text('OK'),
                    )
                  ],
                )
              : AlertDialog(
                  title: const Text('本当にサインアウトしてもよろしいですか？'),
                  content: const Text('このアカウントで再度サインインするには、'
                      'ご登録のメールアドレスと、パスワードが必要です。'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('キャンセル'),
                    ),
                    TextButton(
                      onPressed: () async {
                        context
                            .read(loadingStateProvider.notifier)
                            .startLoading();
                        await context
                            .read(appUserStateProvider.notifier)
                            .signOut();
                        context
                            .read(loadingStateProvider.notifier)
                            .endLoading();
                        RestartWidget.restartApp(context);
                      },
                      child: const Text('OK'),
                    )
                  ],
                ),
        );
      },
      child: const Text('サインアウト'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = useProvider<bool>(loadingStateProvider);
    final _appUser = useProvider(appUserStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('アカウント')),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 8),
              accountTile(context, _appUser.name, _appUser.imageUrl),
              const Divider(color: Colors.black54),
              const SizedBox(height: 40),
              _signOutButton(context),
            ]),
          ),
          const AdWidget(),
          // LargeImageScreen(imageUrl: _appUser.imageUrl!),
          _isLoading ? LoadingScreen(context) : Container(),
        ],
      ),
    );
  }
}
