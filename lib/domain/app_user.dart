import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:record_game_app/repository/auth_repository.dart';
import 'package:record_game_app/repository/user_repository.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    @Default('') String userId,
    @Default('') String email,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

final appUserProvider = StateNotifierProvider<AppUserStateNotifier, AppUser>(
  (ref) => AppUserStateNotifier(),
);

class AppUserStateNotifier extends StateNotifier<AppUser> {
  AppUserStateNotifier() : super(AppUser().copyWith());

  AuthRepository get authRepository => AuthRepository.instance;
  UserRepository get userRepository => UserRepository.instance;

  bool isEmailVerified = false;

  Future<void> sendEmailVerification() async {
    await authRepository.sendEmailVerification();
  }

  Future<void> getIsEmailVerified() async {
    isEmailVerified = await authRepository.getIsEmailVerified();
  }

  Future<void> createUserInDB() async {
    state = await userRepository.createUserInDB();
  }

  Future<void> getUserData() async {
    state = await userRepository.getUserData();
  }

  Future<void> signOut() async {
    await authRepository.signOut();
  }
}
