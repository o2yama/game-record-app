import 'package:firebase_auth/firebase_auth.dart';
import 'package:record_game_app/screens/login_sign_up/auth_exception.dart';

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
    } on FirebaseAuthException catch (e) {
      throw AuthException(_convertErrorMessage(e.code));
    } on Exception {
      throw AuthException('不明なエラーです');
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
    } on FirebaseAuthException catch (e) {
      throw AuthException(_convertErrorMessage(e.code));
    } on Exception {
      throw AuthException('不明なエラーです');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    authUser = null;
  }

  String _convertErrorMessage(String errorMassage) {
    switch (errorMassage) {
      case 'weak-password':
        return '安全なパスワードではありません';
      case 'email-already-in-use':
        return 'メールアドレスがすでに使われています';
      case 'invalid-email':
        return 'メールアドレスを正しい形式で入力してください';
      case 'operation-not-allowed':
        return '登録が許可されていません';
      case 'wrong-password':
        return 'パスワードが間違っています';
      case 'user-not-found':
        return 'ユーザーが見つかりません';
      case 'user-disabled':
        return 'ユーザーが無効です';
      default:
        return '不明なエラーです';
    }
  }
}
