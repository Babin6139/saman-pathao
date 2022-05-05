import 'package:flutter/material.dart';

class MyColor {
  static Color color1 = Color.fromARGB(255, 133, 75, 177);
  static Color backColor = Color.fromARGB(255, 25, 115, 168);
  static Color cardColor = Color.fromARGB(255, 248, 249, 249);
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
