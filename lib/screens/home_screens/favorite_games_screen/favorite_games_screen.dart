import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:record_game_app/common/widgets/search_text_field.dart';

final favoriteSearchController = TextEditingController();

class FavoriteGamesScreen extends HookWidget {
  const FavoriteGamesScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute<Widget>(
        builder: (_) => const FavoriteGamesScreen());
  }

  Widget _searchField(BuildContext context) {
    return SearchTextField(
      controller: favoriteSearchController,
      hintText: '試合名、チェック名で検索',
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(title: const Text('お気に入り')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              _searchField(context),
            ],
          ),
        ),
      ),
    );
  }
}
