import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/repository/auth_repository.dart';
import 'package:record_game_app/repository/local_db_repository.dart';
import 'package:record_game_app/repository/user_repository.dart';

final signUpModelProvider = ChangeNotifierProvider((ref) => SignUpModel());

class SignUpModel extends ChangeNotifier {
  AuthRepository get authRepository => AuthRepository.instance;
  UserRepository get userRepository => UserRepository.instance;

  AppUser appUser = AppUser().copyWith();
  String userId = '';
  String name = '';
  File? userImage;
  bool isEmailVerified = false;
  bool isFetchedUserData = false;

  Future<void> getImage() async {
    final isPermitted = await Permission.photos.isGranted;
    if (!isPermitted) {
      final status = await Permission.photos.request();
      if (status.isDenied ||
          status.isPermanentlyDenied ||
          status.isRestricted) {
        return;
      }
    }
    final picker = ImagePicker();
    await picker
        .getImage(source: ImageSource.gallery, imageQuality: 1)
        .then((pickedFile) {
      if (pickedFile != null) {
        userImage = File(pickedFile.path);
      } else {
        print('no image selected');
      }
    });
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
      throw ArgumentError('メールアドレスが正しく入力されていません。');
    } else if (!Validator().validPassword(password)) {
      throw ArgumentError('パスワードは半角英数字7文字以上です。');
    } else if (name == '') {
      throw ArgumentError('名前を入力してください');
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
    final user = await userRepository.createUserInDB(name, userImage);
    if (userImage != null) {
      appUser = user.copyWith(
        userId: authRepository.authUser!.uid,
        email: authRepository.authUser!.email!,
        name: name,
        imageUrl: userImage!.absolute.path,
      );
    }
    await LocalDbRepository.instance.doneSignIn();
  }

  Future<void> getUserData() async {
    try {
      final appUser = await userRepository.getUserData();
      if (appUser != null) {
        this.appUser = appUser;
        print(this.appUser);
      }
      isFetchedUserData = true;
    } on Exception catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    await LocalDbRepository.instance.signOut();
    appUser = AppUser(userId: '', email: '', name: 'unknown', imageUrl: null);
  }
}
