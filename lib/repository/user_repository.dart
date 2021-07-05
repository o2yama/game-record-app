import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:record_game_app/domain/app_user.dart';
import 'auth_repository.dart';

class UserRepository {
  UserRepository._();
  static final instance = UserRepository._();

  factory UserRepository() {
    return UserRepository();
  }

  AuthRepository get authRepository => AuthRepository.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> isExistUser() async {
    final userQuery =
        await _db.collection('users').doc(authRepository.user!.uid).get();
    if (userQuery.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<AppUser> createUserInDB() async {
    final appUser = AppUser().copyWith(
      userId: authRepository.user!.uid,
      email: authRepository.user!.email!,
    );
    await _db.collection('users').doc(appUser.userId).set(appUser.toJson());
    return appUser;
  }

  Future<AppUser> getUserData() async {
    final query =
        await _db.collection('users').doc(authRepository.user!.uid).get();
    final appUser =
        AppUser.fromJson(Map.from(query.data() as Map<String, dynamic>));
    return appUser;
  }
}
