import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TeamListScreen extends HookWidget {
  const TeamListScreen({Key? key, required this.gameTitle}) : super(key: key);
  final String gameTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gameTitle)),
      body: Container(),
    );
  }
}
