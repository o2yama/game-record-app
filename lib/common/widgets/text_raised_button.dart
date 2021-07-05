import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextRaisedButton extends StatelessWidget {
  TextRaisedButton({required this.text, required this.onPressed});

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: ElevatedButton(
        onPressed: () => onPressed,
        child: Text(
          '$text',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
