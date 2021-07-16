import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/repository/auth_repository.dart';

final loginModelProvider = ChangeNotifierProvider((ref) => LoginModel());

class LoginModel extends ChangeNotifier {
  AuthRepository get authRepository => AuthRepository.instance;

  Future<void> login(String email, String password) async {
    if (!Validator().validEmail(email)) {
      throw Exception('有効なメールアドレスを入力してください。');
    } else if (!Validator().validPassword(password)) {
      throw Exception('パスワードは半角英数字7文字以上です。');
    } else {
      await authRepository.signIn(email, password);
    }
  }
}
