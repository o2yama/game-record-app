import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/repository/auth_repository.dart';
import 'package:record_game_app/repository/user_repository.dart';

final signUpModelProvider = ChangeNotifierProvider((ref) => SignUpModel());

class SignUpModel extends ChangeNotifier {
  AuthRepository get authRepository => AuthRepository.instance;
  UserRepository get userRepository => UserRepository.instance;

  AppUser appUser = const AppUser().copyWith();
  String name = '';
  File? userImage;
  bool isEmailVerified = false;

  Future<void> getImage() async {
    final picker = ImagePicker();
    await picker
        .getImage(source: ImageSource.gallery, imageQuality: 1)
        .then((pickedFile) {
      if (pickedFile != null) {
        userImage = File(pickedFile.path);
      }
    });
    notifyListeners();
  }

  void deleteImage() {
    userImage = null;
    notifyListeners();
  }

  void serUserName(String text) {
    name = text;
    notifyListeners();
  }

  Future<void> createUserInAuth(String email, String password) async {
    if (!Validator().validEmail(email)) {
      throw AuthException('メールアドレスが正しく入力されていません。');
    } else if (!Validator().validPassword(password)) {
      throw AuthException('パスワードは半角英数字7文字以上です。');
    } else if (name == '') {
      throw AuthException('名前を入力してください');
    } else {
      await authRepository.createUserInAuth(email, password);
    }
  }

  Future<void> sendEmailVerification() async {
    await authRepository.sendEmailVerification();
  }

  Future<void> getIsEmailVerified() async {
    isEmailVerified = await authRepository.getIsEmailVerified();
  }

  Future<void> createUserInDB() async {
    await userRepository.createUserInDB(name, userImage);
  }
}
