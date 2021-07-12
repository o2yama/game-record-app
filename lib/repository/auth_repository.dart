import 'package:firebase_auth/firebase_auth.dart';
import 'package:record_game_app/repository/local_db_repository.dart';

class AuthRepository {
  factory AuthRepository() => AuthRepository();
  AuthRepository._();
  static final instance = AuthRepository._();

  final _auth = FirebaseAuth.instance;
  User? authUser;

  Future<void> createUserInAuth(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      authUser = result.user;
      await sendEmailVerification();
    } on Exception catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> sendEmailVerification() async {
    await _auth.currentUser!.sendEmailVerification();
  }

  Future<bool> getIsEmailVerified() async {
    final user = _auth.currentUser!;
    await user.reload();
    return user.emailVerified;
  }

  Future<void> getAuthUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      authUser = user;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      authUser = result.user;
      await LocalDbRepository.instance.doneSignIn();
    } on Exception catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    authUser = null;
  }
}
