import 'package:shared_preferences/shared_preferences.dart';

class LocalDbRepository {
  factory LocalDbRepository() => LocalDbRepository();
  LocalDbRepository._();
  static final instance = LocalDbRepository._();

  Future<bool> getIsDoneSignIn() async {
    final pref = await SharedPreferences.getInstance();
    final isDone = pref.getBool('isDoneSignIn') ?? false;
    return isDone;
  }

  Future<void> doneSignIn() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isDoneSignIn', true);
  }

  Future<void> signOut() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isDoneSignIn', false);
  }
}
