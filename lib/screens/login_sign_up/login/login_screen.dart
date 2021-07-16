import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/common/widgets/loading_screen.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/screens/home_screens/home_screen.dart';
import 'package:record_game_app/screens/login_sign_up/login/login_model.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up/sign_up_screen.dart';
import 'package:record_game_app/screens/login_sign_up/widgets/email_field.dart';
import 'package:record_game_app/screens/login_sign_up/widgets/password_field.dart';
import 'package:record_game_app/common/loading_state.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Route<Widget> route() {
    return MaterialPageRoute<Widget>(builder: (_) => const LoginScreen());
  }

  Future<void> _onLoginButtonPressed(BuildContext context) async {
    context.read(loadingStateProvider.notifier).startLoading();
    try {
      await context
          .read(loginModelProvider)
          .login(emailController.text, passwordController.text);
      await context.read(appUserStateProvider.notifier).getUserData();
      context.read(loadingStateProvider.notifier).endLoading();
      await Navigator.of(context)
          .pushAndRemoveUntil(HomeScreen.route(), (_) => false);
    } on Exception catch (e) {
      Validator().showValidMessage(e.toString());
      context.read(loadingStateProvider.notifier).endLoading();
    }
  }

  Widget _emailField(BuildContext context) {
    return EmailField(controller: emailController);
  }

  Widget _passwordField(BuildContext context) {
    return PasswordField(controller: passwordController);
  }

  //ユーザー登録がまだだった場合サインアップページへ
  Widget _toSignUpScreenButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(elevation: 0, side: BorderSide.none),
      onPressed: () {
        Navigator.of(context)
            .pushAndRemoveUntil<Widget>(SignUpScreen.route(), (_) => false);
      },
      child: const Text(
        'ユーザー登録がまだの方はこちら',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = useProvider(loadingStateProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ログイン'),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _emailField(context),
                  const SizedBox(height: 24),
                  _passwordField(context),
                  const SizedBox(height: 50),
                  TextButton(
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
                  const SizedBox(height: 30),
                  _toSignUpScreenButton(context),
                  const SizedBox(height: 300),
                ],
              ),
            ),
            _isLoading ? const LoadingScreen() : Container(),
          ]),
        ),
      ),
    );
  }
}
