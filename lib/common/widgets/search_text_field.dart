import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black38),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
