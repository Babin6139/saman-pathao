import 'package:customer/utils/mycolor.dart';
import "package:flutter/material.dart";

class MyThemes {
  static lightTheme(BuildContext context) => ThemeData(
      appBarTheme: AppBarTheme(
          color: Colors.white,
          titleTextStyle: TextStyle(color: MyColor.color1),
          iconTheme: IconThemeData(color: Colors.black)));
}
