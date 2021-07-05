import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/loading_state.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/screens/login_sign_up/email_field.dart';
import 'package:record_game_app/screens/login_sign_up/password_field.dart';
import 'package:record_game_app/common/widgets/to_home_button.dart';
import 'package:record_game_app/repository/auth_repository.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up/sign_up_screen.dart';

class LoginScreen extends HookWidget {
  void _onLoginButtonPressed(BuildContext context) {
    if (!Validator().validEmail(emailController.text)) {
      Validator().showValidMessage('メールアドレスをご確認ください。');
    } else if (!Validator().validPassword(passwordController.text)) {
      Validator().showValidMessage('パスワードは半角英数字7文字以上です。');
    } else {
      context.read(loadingStateProvider.notifier).startLoading();
      try {
        AuthRepository.instance
            .signIn(emailController.text, passwordController.text);
      } on Exception catch (e) {
        final error = e.toString();
        print(error);
        showOkAlertDialog(
          context: context,
          title: '$error',
        );
      }
      context.read(loadingStateProvider.notifier).endLoading();
      // todo: ユーザーデータ取得(試合)
      // todo: controllerのclear
    }
  }

  //ユーザー登録がまだだった場合サインアップページへ
  Widget _toSignUpScreenButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil<Object>(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen()),
            (_) => false);
      },
      child:
          const Text('ユーザー登録がまだの方はこちら', style: TextStyle(color: Colors.blue)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = useProvider(loadingStateProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          leading: ToHomeScreenButton(),
          title: Text('ログイン'),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    EmailField(controller: emailController),
                    const SizedBox(height: 24),
                    PasswordField(controller: passwordController),
                    const SizedBox(height: 50),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                      ),
                      child: TextButton(
                        onPressed: () => _onLoginButtonPressed(context),
                        child: Text(
                          'ログイン',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _toSignUpScreenButton(context),
                    const SizedBox(height: 300),
                  ],
                ),
              ),
              _isLoading
                  ? Container(
                      color: Colors.grey.withOpacity(0.6),
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
