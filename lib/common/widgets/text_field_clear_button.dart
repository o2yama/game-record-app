import 'package:flutter/material.dart';

class TextFieldClearButton extends StatelessWidget {
  const TextFieldClearButton({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.clear,
        color: Colors.white,
      ),
      onPressed: () {
        controller.clear();
      },
    );
  }
}
