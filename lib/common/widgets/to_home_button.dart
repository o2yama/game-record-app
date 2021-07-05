import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:record_game_app/screens/home_screen.dart';

class ToHomeScreenButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.clear, color: Colors.white),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
            fullscreenDialog: true,
          ),
          (route) => false,
        );
      },
    );
  }
}
