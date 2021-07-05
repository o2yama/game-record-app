import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/domain/app_user.dart';
import 'package:record_game_app/screens/home_screen.dart';

class WaitEmailVerifyScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _appUser = useProvider(appUserProvider);
    final _appUserModel = useProvider(appUserProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text('認証メール送信中...')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                '。。。に認証メールを送りました。',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'メール内のリンクをタップするとメール認証が完了します。',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await _appUserModel.getIsEmailVerified();
                  if (_appUserModel.isEmailVerified) {
                    await _appUserModel.createUserInDB();
                    print('$_appUser');
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false,
                    );
                  } else {
                    Validator().showValidMessage('認証が完了するまで、しばらくお待ちください。');
                  }
                },
                child: Text('メール認証完了'),
              ),
              SizedBox(height: 40),
              Text('メールが届かない場合は'),
              TextButton(
                onPressed: () => _appUserModel.sendEmailVerification(),
                child: Text('認証メール再送信'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
