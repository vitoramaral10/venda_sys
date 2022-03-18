import 'package:flutter/material.dart';

class Util {
  static void navigation(BuildContext context, Widget widget) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}
