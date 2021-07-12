import 'package:flutter/material.dart';
import 'package:record_game_app/common/widgets/text_field_clear_button.dart';

TextEditingController emailController = TextEditingController();

class EmailField extends StatelessWidget {
  EmailField({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'メールアドレス',
              hintText: 'example@gmail.com',
              suffixIcon: TextFieldClearButton(controller: controller),
            ),
          ),
        ),
      ],
    );
  }
}
