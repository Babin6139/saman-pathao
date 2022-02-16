import 'package:flutter/material.dart';

class MyColor {
  static Color color1 = Colors.red.shade400;
  static Color backColor = Colors.grey.shade300;
  static List<BoxShadow> shadow1 = [
    BoxShadow(
        color: Colors.grey.shade500,
        offset: Offset(4, 4),
        blurRadius: 15,
        spreadRadius: 1),
    BoxShadow(
        color: Colors.white30,
        offset: Offset(-4, -4),
        blurRadius: 15,
        spreadRadius: 1)
  ];
}
