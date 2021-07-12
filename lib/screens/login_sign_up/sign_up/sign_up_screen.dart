import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/common/widgets/loading_screen.dart';
import 'package:record_game_app/common/widgets/text_field_clear_button.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up/sign_up_model.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up/wait_email_verify_screen.dart';
import 'package:record_game_app/states/loading_state.dart';
import '../login/login_screen.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';

final userNameController = TextEditingController();

class SignUpScreen extends HookWidget {
  //authへの登録処理 => メール認証画面へ
  Future<void> _onResisterButtonPressed(BuildContext context) async {
    context.read(loadingStateProvider.notifier).startLoading();
    try {
      await context
          .read(signUpModelProvider)
          .createUserInAuth(emailController.text, passwordController.text);
      await Navigator.pushAndRemoveUntil<Widget>(
        context,
        MaterialPageRoute(
          builder: (context) => WaitEmailVerifyScreen(
            name: userNameController.text,
            userImage: null,
          ),
        ),
        (_) => false,
      );
    } on Exception catch (error) {
      Validator().showValidMessage(error.toString());
    }
    context.read(loadingStateProvider.notifier).endLoading();
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
    final _signUpModel = useProvider(signUpModelProvider);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RawMaterialButton(
              onPressed: () async {
                await _signUpModel.getImage();
              },
              child: _signUpModel.userImage != null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(_signUpModel.userImage!),
                      backgroundColor: Colors.grey,
                    )
                  : const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/account.png'),
                      backgroundColor: Colors.grey,
                    ),
            ),
            _signUpModel.userImage != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide.none,
                        elevation: 0,
                      ),
                      onPressed: _signUpModel.deleteImage,
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
    final _signUpModel = useProvider(signUpModelProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: userNameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'お名前',
            suffixIcon: TextFieldClearButton(controller: userNameController),
          ),
          onChanged: (String text) => _signUpModel.serUserName,
        ),
        const Text('※必須', style: TextStyle(color: Colors.red)),
      ],
    );
  }

  Widget _resisterButton(BuildContext context) {
    return TextButton(
      onPressed: () => _onResisterButtonPressed(context),
      child: Text(
        '登録',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _toLoginScreenButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(elevation: 0, side: BorderSide.none),
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
    final _isLoading = useProvider<bool>(loadingStateProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(title: const Text('ユーザー登録')),
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
          _isLoading ? LoadingScreen() : Container(),
        ]),
      ),
    );
  }
}
