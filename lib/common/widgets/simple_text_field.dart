import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black38),
              // suffixIcon: TextFieldClearButton(controller: controller),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
