import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/common/Widgets/email_field.dart';
import 'package:record_game_app/common/Widgets/password_field.dart';
import 'package:record_game_app/common/loading_screen_controller.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/common/widgets/text_flat_button.dart';
import 'package:record_game_app/common/widgets/to_home_button.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up_model.dart';
import 'login_screen.dart';

class SignUpScreen extends ConsumerWidget {
  void _onResisterButtonPressed(BuildContext context) {
    if (!Validator().validEmail(emailController.text)) {
      Validator().showValidMessage('メールアドレスをご確認ください。');
    } else if (!Validator().validPassword(passwordController.text)) {
      Validator().showValidMessage('パスワードは半角英数字7文字以上です。');
    } else {
      context.read(loadingControllerProvider.notifier).startLoading();

      context.read(loadingControllerProvider.notifier).endLoading();
    }
  }

  //サインアップ済みの時はログインページへ
  Widget _toLoginScreenButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil<Object>(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (_) => false);
      },
      child: const Text('ユーザー登録済みの方はこちら', style: TextStyle(color: Colors.blue)),
    );
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _loadingController = watch(loadingControllerProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ユーザー登録'),
          leading: ToHomeScreenButton(),
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
                        text: '登録',
                        onPressed: () => _onResisterButtonPressed(context)),
                    const SizedBox(height: 30),
                    _toLoginScreenButton(context),
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
