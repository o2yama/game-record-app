import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/widgets/large_image/large_image_state.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';

class LargeImageScreen extends HookWidget {
  const LargeImageScreen({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final _appUser = useProvider(appUserStateProvider);
    final _isLarge = useProvider(largeImageStateProvider);
    final largeImageModel = useProvider(largeImageStateProvider.notifier);

    return _appUser.imageUrl != null && _isLarge
        ? Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => largeImageModel.toSmall,
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
