import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdWidget extends StatelessWidget {
  const AdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        height: 50,
        child: const Center(child: Text('広告')),
      ),
    );
  }
}
