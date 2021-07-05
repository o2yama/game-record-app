import 'package:flutter/material.dart';
import 'package:record_game_app/common/widgets/text_raised_button.dart';

class WaitEmailVerifyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('認証メール送信中...')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('。。。に認証メールを送りました。'),
              Text('メール内のリンクをタップするとメール認証が完了します。'),
              SizedBox(height: 40),
              Text('メールが届かない場合は'),
              TextRaisedButton(
                text: '認証メール再送信',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
