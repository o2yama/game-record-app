import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/widgets/text_field_clear_button.dart';
import 'package:record_game_app/screens/login_sign_up/text_visibility_state.dart';

TextEditingController passwordController = TextEditingController();

class PasswordField extends HookWidget {
  const PasswordField({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final _visibility = useProvider(textVisibilityProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: TextField(
            autofocus: false,
            controller: controller,
            obscureText: _visibility,
            decoration: InputDecoration(
              labelText: 'パスワード',
              hintText: '7文字以上',
              suffixIcon: TextFieldClearButton(controller: controller),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.visibility),
          onPressed: () {
            context.read(textVisibilityProvider.notifier).changeVisibility();
          },
        ),
      ],
    );
  }
}
