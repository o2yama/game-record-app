import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/loading_state.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/common/widgets/to_home_button.dart';
import 'package:record_game_app/repository/auth_repository.dart';
import 'package:record_game_app/screens/login_sign_up/wait_email_verify_screen.dart';
import '../email_field.dart';
import '../login/login_screen.dart';
import '../password_field.dart';

class SignUpScreen extends HookWidget {
  AuthRepository get authRepository => AuthRepository.instance;

  //authへの登録処理
  Future<void> _onResisterButtonPressed(BuildContext context) async {
    if (!Validator().validEmail(emailController.text)) {
      Validator().showValidMessage('メールアドレスをご確認ください。');
    } else if (!Validator().validPassword(passwordController.text)) {
      Validator().showValidMessage('パスワードは半角英数字7文字以上です。');
    } else {
      print('valid text');
      context.read(loadingStateProvider.notifier).startLoading();
      try {
        await authRepository.createUser(
            emailController.text, passwordController.text);
      } on Exception catch (e) {
        final error = e.toString();
        print(error);
      }
      context.read(loadingStateProvider.notifier).endLoading();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WaitEmailVerifyScreen()),
          (_) => false);
    }
  }

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
  Widget build(BuildContext context) {
    final _isLoading = useProvider(loadingStateProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ユーザー登録'),
          leading: ToHomeScreenButton(),
        ),
        body: SingleChildScrollView(
          child: Consumer(builder: (context, watch, child) {
            return Expanded(
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
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                          child: TextButton(
                            onPressed: () => _onResisterButtonPressed(context),
                            child: Text(
                              '登録',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        _toLoginScreenButton(context),
                        const SizedBox(height: 300),
                      ],
                    ),
                  ),
                  _isLoading
                      ? Center(
                          child: Container(
                            color: Colors.grey.withOpacity(0.6),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
