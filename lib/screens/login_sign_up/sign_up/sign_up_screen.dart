import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/screen_size.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_screen.dart';
import 'package:record_game_app/screens/login_sign_up/login/login_screen.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up/sign_up_model.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_state.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up/wait_email_verify_screen.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';

final userNameController = TextEditingController();

class SignUpScreen extends HookWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static Route<Widget> route() {
    return MaterialPageRoute<Widget>(builder: (_) => const SignUpScreen());
  }

  //authへの登録処理 => メール認証画面へ
  Future<void> _onResisterButtonPressed(BuildContext context) async {
    context.read(loadingStateProvider.notifier).startLoading();
    try {
      await context
          .read(signUpModelProvider)
          .createUserInAuth(emailController.text, passwordController.text);
      context.read(loadingStateProvider.notifier).endLoading();
      await Navigator.of(context).pushAndRemoveUntil<Widget>(
        WaitEmailVerifyScreen.route(),
        (_) => false,
      );
    } on Exception catch (e) {
      Validator().showValidMessage(e.toString());
      context.read(loadingStateProvider.notifier).endLoading();
    }
  }

  Widget _emailField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EmailField(controller: emailController),
        const Text('※必須', style: TextStyle(color: Colors.red)),
      ],
    );
  }

  Widget _passWordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PasswordField(controller: passwordController),
        const Text('※必須', style: TextStyle(color: Colors.red)),
      ],
    );
  }

  Widget _userImageIcon(BuildContext context) {
    final model = useProvider(signUpModelProvider);
    return SizedBox(
      width: ScreenSize(context).width(),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RawMaterialButton(
              onPressed: () async => model.getImage(),
              child: model.userImage != null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(model.userImage!),
                      backgroundColor: Colors.grey,
                    )
                  : const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/account.png'),
                      backgroundColor: Colors.grey,
                    ),
            ),
            model.userImage != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextButton(
                      onPressed: model.deleteImage,
                      child: const Text('現在の写真の削除'),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text('アイコンタップで写真を登録できます。'),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _nameField(BuildContext context) {
    final model = useProvider(signUpModelProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: userNameController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(labelText: 'お名前'),
          onChanged: model.serUserName,
        ),
        const Text('※必須', style: TextStyle(color: Colors.red)),
      ],
    );
  }

  Widget _resisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onResisterButtonPressed(context),
      child: Text(
        '登録',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }

  Widget _toLoginScreenButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context)
            .pushAndRemoveUntil<Object>(LoginScreen.route(), (_) => false);
      },
      child: const Text('ユーザー登録済みの方はこちら', style: TextStyle(color: Colors.blue)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = useProvider<bool>(loadingStateProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ユーザー登録'),
          centerTitle: false,
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _emailField(context),
                  const SizedBox(height: 24),
                  _passWordField(context),
                  const SizedBox(height: 24),
                  _userImageIcon(context),
                  const SizedBox(height: 24),
                  _nameField(context),
                  const SizedBox(height: 50),
                  _resisterButton(context),
                  const SizedBox(height: 30),
                  _toLoginScreenButton(context),
                  const SizedBox(height: 300),
                ],
              ),
            ),
          ),
          _isLoading ? LoadingScreen(context) : Container(),
        ]),
      ),
    );
  }
}
