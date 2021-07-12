import 'package:flutter/cupertino.dart';

class ScreenSize {
  ScreenSize(this.context);
  BuildContext context;

  double height() {
    return MediaQuery.of(context).size.height;
  }

  double width() {
    return MediaQuery.of(context).size.width;
  }
}
