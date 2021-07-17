import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:record_game_app/common/screen_size.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen(this.context, {Key? key}) : super(key: key);
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize(context).height(),
      width: ScreenSize(context).width(),
      color: Colors.grey.withOpacity(0.6),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
