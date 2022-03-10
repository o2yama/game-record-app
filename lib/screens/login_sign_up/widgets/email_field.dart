import 'package:flutter/material.dart';

TextEditingController emailController = TextEditingController();

class EmailField extends StatelessWidget {
  const EmailField({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'メールアドレス',
              hintText: 'example@gmail.com',
            ),
          ),
        ),
      ],
    );
  }
}
