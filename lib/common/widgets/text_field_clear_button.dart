import 'package:flutter/material.dart';

class TextFieldClearButton extends StatelessWidget {
  const TextFieldClearButton({Key? key, required this.controller})
      : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.clear, color: Colors.grey),
      onPressed: controller.clear,
    );
  }
}
