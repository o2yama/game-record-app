import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'auth_repository.dart';

class UserRepository {
  factory UserRepository() => UserRepository();
  UserRepository._();
  static final instance = UserRepository._();

  AuthRepository get authRepository => AuthRepository.instance;

  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<AppUser> createUserInDB(String name, File? userImage) async {
    var imageUrl = '';
    try {
      if (userImage != null) {
        final ref =
            _storage.ref().child('/users/${authRepository.authUser!.uid}');
        final uploadTask = ref.putFile(userImage);
        await uploadTask.whenComplete(() async {
          imageUrl = await ref.getDownloadURL();
        });
      }
    } on Exception catch (e) {
      print(e);
      final error = ArgumentError('画像のアップロードに失敗しました。');
      throw error;
    }

    final appUser = const AppUser().copyWith(
      userId: authRepository.authUser!.uid,
      email: authRepository.authUser!.email!,
      name: name,
      imageUrl: imageUrl,
    );
    await _db.collection('users').doc(appUser.userId).set(appUser.toJson());
    return appUser;
  }

  Future<AppUser?> getUserData() async {
    await authRepository.getAuthUserData();
    if (authRepository.authUser != null) {
      final query =
          await _db.collection('users').doc(authRepository.authUser!.uid).get();
      if (query.exists) {
        final existData = query.data()!;
        final appUser = AppUser.fromJson(existData).copyWith();
        return appUser;
      } else {
        print('appUser null: $query');
        return null;
      }
    } else {
      print('authUser: ${authRepository.authUser}');
      return null;
    }
  }
}
