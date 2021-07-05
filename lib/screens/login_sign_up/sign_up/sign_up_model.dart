import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/domain/app_user.dart';
import 'package:record_game_app/repository/auth_repository.dart';
import 'package:record_game_app/repository/user_repository.dart';

final signUpModel = ChangeNotifierProvider.autoDispose((ref) => SignUpModel());

class SignUpModel extends ChangeNotifier {
  AuthRepository get authRepository => AuthRepository.instance;
  UserRepository get userRepository => UserRepository.instance;
  bool isEmailVerified = false;
  AppUser get appUser => userRepository.appUser;

  Future<void> sendEmailVerification() async {
    await authRepository.sendEmailVerification();
  }

  Future<void> getIsEmailVerified() async {
    isEmailVerified = await authRepository.getIsEmailVerified();
    notifyListeners();
  }

  Future<void> createUserInDB() async {
    await userRepository.createUserInDB();
  }
}
