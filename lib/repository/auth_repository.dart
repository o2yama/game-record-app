import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository._();
  static final instance = AuthRepository._();
  factory AuthRepository() {
    return AuthRepository();
  }

  final _auth = FirebaseAuth.instance;
  User? user;

  Future<void> createUser(String email, password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
      await sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw AuthException(_convertErrorMessage(e.code));
    } catch (e) {
      print(e);
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

  Future<void> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_convertErrorMessage(e.code));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
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

class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
