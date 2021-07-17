import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:record_game_app/common/screen_size.dart';

class AdWidget extends StatelessWidget {
  const AdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSize(context).height(),
      child: Column(children: [
        const Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            height: 50,
            child: const Center(child: Text('広告')),
          ),
        ),
      ]),
    );
  }
}
