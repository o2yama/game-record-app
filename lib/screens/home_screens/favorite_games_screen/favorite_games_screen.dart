import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final favoriteSearchController = TextEditingController();

class FavoriteGamesScreen extends HookWidget {
  Widget _searchField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                controller: favoriteSearchController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: '試合名、チェック名で検索',
                  hintStyle: TextStyle(color: Colors.black38),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            final textLength = favoriteSearchController.text.length - 1;
            favoriteSearchController.text =
                favoriteSearchController.text.substring(0, textLength);
          },
          icon: const Icon(Icons.backspace, color: Colors.grey),
        ),
      ],
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
