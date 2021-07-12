import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/screen_size.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/repository/auth_repository.dart';
import 'package:record_game_app/repository/local_db_repository.dart';
import 'package:record_game_app/screens/home_screens/home_screen.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up/sign_up_model.dart';

class WaitEmailVerifyScreen extends HookWidget {
  WaitEmailVerifyScreen({required this.name, required this.userImage});

  AuthRepository get authRepository => AuthRepository.instance;

  final String name;
  final File? userImage;

  @override
  Widget build(BuildContext context) {
    final _signUpModel = useProvider(signUpModelProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('認証メール送信中...')),
      body: SingleChildScrollView(
        child: SizedBox(
          height: ScreenSize(context).height(),
          width: ScreenSize(context).width(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Text(
                  '${authRepository.authUser!.email}\nに認証メールを送りました。',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'メール内のリンクをタップすると\nメール認証が完了します。',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await _signUpModel.getIsEmailVerified();
                    if (_signUpModel.isEmailVerified) {
                      await _signUpModel.createUserInDB();
                      await Navigator.pushAndRemoveUntil<Widget>(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false,
                      );
                    } else {
                      Validator()
                          .showValidMessage('リンクをタップしてから、認証まで数秒かかることがあります。');
                    }
                  },
                  child: const Text('メール認証完了'),
                ),
                const SizedBox(height: 40),
                const Text('メールが届かない場合は'),
                TextButton(
                  style: TextButton.styleFrom(
                    side: BorderSide.none,
                    elevation: 0,
                  ),
                  onPressed: _signUpModel.sendEmailVerification,
                  child: const Text('認証メール再送信'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
