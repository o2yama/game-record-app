import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/repository/auth_repository.dart';
import 'package:record_game_app/repository/user_repository.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    @Default('') String userId,
    @Default('') String email,
    @Default('unknown') String name,
    String? imageUrl,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

final appUserStateProvider =
    StateNotifierProvider<AppUserState, AppUser>((ref) => AppUserState());

class AppUserState extends StateNotifier<AppUser> {
  AppUserState() : super(const AppUser());

  UserRepository get userRepository => UserRepository.instance;
  AuthRepository get authRepository => AuthRepository.instance;

  void get setAppUser => state;

  Future<AppUser?> getUserData() async {
    final appUser = await userRepository.getUserData();
    if (appUser != null) {
      state = appUser;
      return appUser;
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    state = const AppUser(
      userId: '',
      email: '',
      name: 'unknown',
      imageUrl: null,
    );
  }
}
