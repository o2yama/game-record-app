import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/screens/login_sign_up/text_visibility_state.dart';

TextEditingController passwordController = TextEditingController();

class PasswordField extends HookWidget {
  const PasswordField({Key? key, required this.controller}) : super(key: key);
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
          icon: const Icon(
            Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            context.read(textVisibilityProvider.notifier).changeVisibility();
          },
        ),
      ],
    );
  }
}
