import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/common/loading_screen_controller.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/common/widgets/text_flat_button.dart';
import 'package:record_game_app/common/widgets/email_field.dart';
import 'package:record_game_app/common/widgets/password_field.dart';
import 'package:record_game_app/common/widgets/to_home_button.dart';
import 'package:record_game_app/repository/auth_repository.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up_model.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up_screen.dart';

class LoginScreen extends ConsumerWidget {
  void _onLoginButtonPressed(BuildContext context) {
    if (!Validator().validEmail(emailController.text)) {
      Validator().showValidMessage('メールアドレスをご確認ください。');
    } else if (!Validator().validPassword(passwordController.text)) {
      Validator().showValidMessage('パスワードは半角英数字7文字以上です。');
    } else {
      context.read(loadingControllerProvider.notifier).startLoading();
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
      context.read(loadingControllerProvider.notifier).endLoading();
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
  Widget build(BuildContext context, ScopedReader watch) {
    final _loadingController = watch(loadingControllerProvider);

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
                    TextFlatButton(
                        text: 'ログイン',
                        onPressed: () => _onLoginButtonPressed(context)),
                    const SizedBox(height: 30),
                    _toSignUpScreenButton(context),
                    const SizedBox(height: 300),
                  ],
                ),
              ),
              _loadingController.isLoading
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
