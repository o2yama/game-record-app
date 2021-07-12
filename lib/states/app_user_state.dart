import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/repository/auth_repository.dart';
import 'package:record_game_app/repository/user_repository.dart';

final appUserStateProvider =
    StateNotifierProvider<AppUserState, AppUser>((ref) => AppUserState());

class AppUserState extends StateNotifier<AppUser> {
  AppUserState() : super(const AppUser());

  AuthRepository get authRepository => AuthRepository.instance;
  UserRepository get userRepository => UserRepository.instance;
}
