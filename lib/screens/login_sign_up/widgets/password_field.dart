import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/states/text_visibility_state.dart';

TextEditingController passwordController = TextEditingController();

class PasswordField extends HookWidget {
  PasswordField({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final _visibility = useProvider<bool>(textVisibilityProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: TextField(
            autofocus: false,
            controller: controller,
            obscureText: _visibility,
            decoration: const InputDecoration(
              labelText: 'パスワード',
              hintText: '7文字以上',
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.visibility),
          onPressed: () {
            context.read(textVisibilityProvider.notifier).changeVisibility();
          },
        ),
      ],
    );
  }
}