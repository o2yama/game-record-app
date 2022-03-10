import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../screen_size.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize(context).height(),
      width: ScreenSize(context).width(),
      color: Colors.grey.withOpacity(0.6),
      child: Center(
        child: Platform.isIOS
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black.withOpacity(0.1),
                ),
                height: 100,
                width: 100,
                child: const CupertinoActivityIndicator(radius: 20),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
