import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/repository/auth_repository.dart';

final signUpModel = ChangeNotifierProvider((ref) => SignUpModel());

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class SignUpModel extends ChangeNotifier {
  AuthRepository get authRepository => AuthRepository.instance;

  Future<void> crateUser(BuildContext context) async {
    try {
      await authRepository.createUser(
          emailController.text, passwordController.text);
    } on Exception catch (e) {
      final error = e.toString();
      print(error);
    }
  }
}
