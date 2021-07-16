import 'package:flutter/material.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up/sign_up_screen.dart';

import 'login/login_screen.dart';

class SignUpLoginSelectScreen extends StatelessWidget {
  const SignUpLoginSelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/icon.png'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .pushAndRemoveUntil(SignUpScreen.route(), (_) => false),
                  child: const Text('新規登録'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        LoginScreen.route(), (route) => false);
                  },
                  child: const Text('ログイン'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
