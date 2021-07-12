import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/screen_size.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/common/widgets/loading_screen.dart';
import 'package:record_game_app/repository/auth_repository.dart';
import 'package:record_game_app/screens/home_screens/home_screen.dart';
import 'package:record_game_app/screens/login_sign_up/sign_up/sign_up_model.dart';
import 'package:record_game_app/screens/loading_state.dart';

class WaitEmailVerifyScreen extends HookWidget {
  const WaitEmailVerifyScreen({Key? key}) : super(key: key);

  AuthRepository get authRepository => AuthRepository.instance;

  @override
  Widget build(BuildContext context) {
    final _signUpModel = useProvider(signUpModelProvider);
    final _isLoading = useProvider(loadingStateProvider);
    final _loadingModel = useProvider(loadingStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('認証メール送信中...'),
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _signUpModel.getIsEmailVerified();
          if (_signUpModel.isEmailVerified) {
            _loadingModel.startLoading();
            await _signUpModel.createUserInDB();
            _loadingModel.endLoading();
            await Navigator.pushAndRemoveUntil<Widget>(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false,
            );
          } else {
            Validator().showValidMessage('リンクをタップしてから、認証まで数秒かかることがあります。');
          }
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: ScreenSize(context).height(),
            width: ScreenSize(context).width(),
            child: Stack(children: [
              Padding(
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
                          _loadingModel.startLoading();
                          await _signUpModel.createUserInDB();
                          _loadingModel.endLoading();
                          await Navigator.pushAndRemoveUntil<Widget>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false,
                          );
                        } else {
                          Validator().showValidMessage(
                              'リンクをタップしてから、認証まで数秒かかることがあります。');
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
              _isLoading ? const LoadingScreen() : Container(),
            ]),
          ),
        ),
      ),
    );
  }
}
