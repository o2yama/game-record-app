import 'package:flutter/material.dart';
import 'package:record_game_app/common/Widgets/text_field_clear_button.dart';

class EmailField extends StatelessWidget {
  const EmailField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textAlignVertical: TextAlignVertical.top,
            autofocus: false,
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
